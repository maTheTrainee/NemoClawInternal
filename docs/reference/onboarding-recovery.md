---
title:
  page: "Recover After sudo Onboarding"
  nav: "sudo Onboarding Recovery"
description: "Recover a NemoClaw sandbox when onboarding succeeds under sudo but the normal user cannot see the sandbox."
keywords: ["nemoclaw sudo onboarding", "nemoclaw sandbox registry", "nemoclaw onboarding recovery"]
topics: ["generative_ai", "ai_agents"]
tags: ["openclaw", "openshell", "troubleshooting", "nemoclaw"]
content:
  type: reference
  difficulty: intermediate
  audience: ["developer", "engineer"]
status: published
---

<!--
  SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  SPDX-License-Identifier: Apache-2.0
-->

# Recover After `sudo` Onboarding

This page documents a recovery flow for a recurring failure mode where `nemoclaw onboard` only succeeds under `sudo`, but the normal user still cannot access the created sandbox afterward.

## Symptoms

After onboarding finishes, the live sandbox exists, but NemoClaw behaves as if no sandbox was created.

Typical symptoms:

- `openshell sandbox list` shows `nemoclaw` as `Ready`
- `openshell status` shows the gateway as `Connected`
- `nemoclaw list` prints `No sandboxes registered`
- `nemoclaw nemoclaw connect` fails with `Unknown command: nemoclaw`

## Root Cause

This is a split-state problem between OpenShell and NemoClaw.

When onboarding is forced through `sudo`, OpenShell can see the gateway configuration under root, but the normal user's NemoClaw sandbox registry is not updated correctly.

NemoClaw only accepts commands such as:

```console
$ nemoclaw <name> connect
$ nemoclaw <name> status
```

if `<name>` already exists in:

```text
~/.nemoclaw/sandboxes.json
```

If the sandbox exists in OpenShell but is missing from that local registry file, NemoClaw treats the sandbox name as an unknown command.

## Verify That This Is the Issue

Run:

```console
$ openshell sandbox list
$ openshell status
$ nemoclaw list
```

If OpenShell shows the sandbox and gateway as healthy, but `nemoclaw list` shows no registered sandboxes, follow the recovery steps below.

## Recommended Recovery

Install a shell helper that runs the workaround end-to-end:

```fish
function nemoclaw-onboard-fix --description "Run NemoClaw onboarding via sudo and sync sandbox registry back to the current user"
    set -l user_home $HOME
    set -l user_name (id -un)
    set -l user_group (id -gn)
    set -l user_path "$user_home/.local/bin:$user_home/.npm-global/bin:/usr/local/bin:$PATH"

    sudo mkdir -p /root/.config/openshell
    or return $status

    sudo cp -r $user_home/.config/openshell/gateways /root/.config/openshell/
    or return $status

    sudo cp $user_home/.config/openshell/active_gateway /root/.config/openshell/
    or return $status

    sudo bash -lc "export PATH='$user_path'; nemoclaw onboard"
    or return $status

    if sudo test -f /root/.nemoclaw/sandboxes.json
        mkdir -p $user_home/.nemoclaw
        or return $status

        sudo cp /root/.nemoclaw/sandboxes.json $user_home/.nemoclaw/
        or return $status

        sudo chown $user_name:$user_group $user_home/.nemoclaw/sandboxes.json
        or return $status
    end

    nemoclaw list
end
```

Save this as:

```text
~/.config/fish/functions/nemoclaw-onboard-fix.fish
```

Then run:

```fish
nemoclaw-onboard-fix
```

## Manual Recovery

If you do not want to use a shell helper, run the same recovery manually:

```console
$ sudo mkdir -p /root/.config/openshell
$ sudo cp -r ~/.config/openshell/gateways /root/.config/openshell/
$ sudo cp ~/.config/openshell/active_gateway /root/.config/openshell/
$ sudo bash -lc 'export PATH="/home/$USER/.local/bin:/home/$USER/.npm-global/bin:/usr/local/bin:$PATH"; nemoclaw onboard'
$ sudo cp /root/.nemoclaw/sandboxes.json /home/$USER/.nemoclaw/
$ sudo chown $USER:$USER /home/$USER/.nemoclaw/sandboxes.json
$ nemoclaw list
```

## Recover When Onboarding Already Finished

If onboarding already completed and only the local registry is missing, you only need to resync the registry file:

```console
$ sudo cp /root/.nemoclaw/sandboxes.json /home/$USER/.nemoclaw/
$ sudo chown $USER:$USER /home/$USER/.nemoclaw/sandboxes.json
$ nemoclaw list
```

Then verify:

```console
$ nemoclaw nemoclaw status
$ nemoclaw nemoclaw connect
```

## Expected Healthy State

The following commands should all succeed:

```console
$ openshell status
$ openshell sandbox list
$ nemoclaw list
$ nemoclaw nemoclaw status
```

Expected results:

- OpenShell gateway `nemoclaw` is `Connected`
- sandbox `nemoclaw` is `Ready`
- `nemoclaw list` shows `nemoclaw`
- `nemoclaw nemoclaw status` succeeds
