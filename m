Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112B8B38BF3
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Aug 2025 00:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urOD8-0006ib-5i; Wed, 27 Aug 2025 18:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOD3-0006gY-KL
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:38 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lb.workbox@gmail.com>)
 id 1urOCz-0007eR-74
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 18:01:37 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45a1b05a59fso2185965e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756332091; x=1756936891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYvs69YvaoQ23YnMzPDPvXYRbNh+Cz2sFGn5seOfGC8=;
 b=AXlj1aAHoOEgfuaIqX7Q+5H8nA82YSTHc743mYB3R11kHGgmr/AVBMh9f4BPnL4+38
 6Iqzi8qgo5yxdVlj+BYcuM65/zwSwBam9mn8Gl8ZTTZbE0uuT/i38BRplhy3jTrplfeI
 MA4TMtK09WpBq/fnFD9j7kHWocm8HE9y9eeOjuSXB1x/weztfrOnTAcHy3pA+m1FaC7d
 RmVj4UTG07IPsvWRPhXU4/PRUz/dC8cieIAvsn3TiNJcaBhOhIze/cIfZFljhzvGSaQ7
 8in1LJXLkWW7JICCxwIDvXiCmAhxuF3RRlYy6r7qMvBfmiwZrEx8juliO/MnkR1bqCHn
 Ojbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756332091; x=1756936891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYvs69YvaoQ23YnMzPDPvXYRbNh+Cz2sFGn5seOfGC8=;
 b=ecIv1BiTXLwXh0TWLesg5uOJTiGJzr4Ssxenv/NFIMgAyjhQ2IENA7kYqThFxyzq+C
 MbzrQvmNBjkuRSy/hbm7OdBr4ZPLgkhESKO8Zq7ravpZ2iRP9om20A/fm84Bv7uJxkUW
 HAJ0cCIYf4S0y/LPHzjxNo8w/yIz4ck9faEZNbjch9jfpJhjZl0bkwOggJEjYOn+PKrO
 O+kIAWVDGaaxUp2zg6VhbonRZLI7Fp1+h5+t7aRV1A/D+Cme433RqkPgykUmE1Ftjhjn
 WWTY8DW1YFq6w4pad0v68x0oB/h0K+TqLbrm8asXDMOElVzePEMz75dqBNDigU7Ez//b
 jYcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRAcyj5U4wnh9Uqd3aRqYmuRRpRuTj7mrGHBylO+T2qtYsfl8cMeU3WVtRkKI1AWsbu1QY2AZK8n7j@nongnu.org
X-Gm-Message-State: AOJu0YwgUvGXkXbjSUfl8z0uzNPHgGksZeUe8058tohO8NX7mg00/qyz
 87vUHiSY49BwkTcuLn0Sa/U0b+ZfKTyU4RXaiOA5NL/KS1qOb78Nn+i8
X-Gm-Gg: ASbGncsrqzHbz9W8TkWmhixP3wTjGPcnxR4iG59JPG+Jf3+Lhyzu+RfAezHT0rSpvhh
 LmY8KdBnwauBlPQ4v4ZeIPsIvL15dmzHQ4VzbDuMOrGm/C7i9Zl0hFUZPmnix8uLvieDLBRRCxH
 yBmAyeWvr64JIWbKctEh1tEfP2hbGhqzsHRWMX3bsCzzFJiL+VyI6HRV9gBjRFk72KQI/PWI0Aw
 G7z/NmFD4FKBlrjxBOl9uepeEiTmBEbIFtm52lQYtjpJhETd5gOfrPq6ELscyJoKbXdKDPqX9N1
 /sANA2ZUGa37ZeB3ed/vzO3oCJ1wXW+HnvTm8EPD1pbKIDMt6qzaRdaIhvnhJ/ksQitkrYefd2w
 CHW+hZo0T3Gp2KDzSpHCCxyo79TvM+4F0TVKZncWluEe9Njf9e+GFbb7N5EgIut9z2cIUXTk7GT
 gqXI0zo4I+Nw==
X-Google-Smtp-Source: AGHT+IFKnzjaoZxpMwHKdxszAdzpHDrj0fZxftK3pyg37QZpuONjY7GuuIPrbllH8iDgXlaoU/VWkA==
X-Received: by 2002:a05:600c:4f03:b0:458:a7b5:9f6c with SMTP id
 5b1f17b1804b1-45b5ec68358mr122273245e9.11.1756332091008; 
 Wed, 27 Aug 2025 15:01:31 -0700 (PDT)
Received: from localhost.localdomain (46-116-237-160.bb.netvision.net.il.
 [46.116.237.160]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b797ce2b8sm4116755e9.12.2025.08.27.15.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 15:01:30 -0700 (PDT)
From: Leonid Bloch <lb.workbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Leonid Bloch <lb.workbox@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] hw/acpi: Introduce the QEMU Battery
Date: Thu, 28 Aug 2025 01:00:48 +0300
Message-ID: <20250827220054.37268-3-lb.workbox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250827220054.37268-1-lb.workbox@gmail.com>
References: <20250827220054.37268-1-lb.workbox@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=lb.workbox@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The battery device communicates battery state to the guest via ACPI.
It supports two modes of operation:

1. QMP control mode (default): Battery state is controlled programmatically
   via QMP commands, making the device deterministic and migration-safe.

2. Host mirroring mode (optional): The device reflects the host's battery
   state from sysfs. Probing occurs on guest ACPI requests and at timed
   intervals (default 2 seconds, configurable via 'probe_interval' property
   in milliseconds). State changes trigger ACPI notifications to the guest.

Properties:
- 'use-qmp': Enable QMP control mode (default: true)
- 'enable-sysfs': Enable host battery mirroring (default: false)
- 'probe_interval': Probe interval in ms for sysfs mode (default: 2000)
- 'sysfs_path': Override default sysfs path /sys/class/power_supply/

The device implements the ACPI_DEV_AML_IF interface to generate its
own AML code, placing the BAT0 device directly under \_SB scope as
per ACPI specification.

QMP commands:
- battery-set-state: Set battery state (present, charging, capacity, rate)
- query-battery: Query current battery state

This allows testing without host battery access and provides a stable
interface for virtualization management systems.

Signed-off-by: Leonid Bloch <lb.workbox@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 MAINTAINERS                          |   6 +
 docs/specs/battery.rst               | 225 ++++++++
 docs/specs/index.rst                 |   1 +
 hw/acpi/Kconfig                      |   4 +
 hw/acpi/battery.c                    | 735 +++++++++++++++++++++++++++
 hw/acpi/meson.build                  |   1 +
 hw/acpi/trace-events                 |   5 +
 hw/i386/Kconfig                      |   1 +
 hw/i386/acpi-build.c                 |   1 +
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/battery.h            |  33 ++
 qapi/acpi.json                       |  73 +++
 12 files changed, 1086 insertions(+)
 create mode 100644 docs/specs/battery.rst
 create mode 100644 hw/acpi/battery.c
 create mode 100644 include/hw/acpi/battery.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a64b5b849b..eb71a4a4b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2928,6 +2928,12 @@ F: hw/vmapple/*
 F: include/hw/vmapple/*
 F: docs/system/arm/vmapple.rst
 
+Battery
+M: Leonid Bloch <lb.workbox@gmail.com>
+S: Maintained
+F: hw/acpi/battery.*
+F: docs/specs/battery.rst
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/docs/specs/battery.rst b/docs/specs/battery.rst
new file mode 100644
index 0000000000..e426b91ea5
--- /dev/null
+++ b/docs/specs/battery.rst
@@ -0,0 +1,225 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==============
+Battery Device
+==============
+
+The battery device provides battery state information to the guest. It supports
+two operating modes:
+
+1. **QMP Control Mode** (default): Battery state is controlled via QMP commands,
+   providing deterministic control for testing and migration safety.
+2. **Sysfs Mode**: Battery state mirrors the host's physical battery, useful
+   for desktop virtualization where the guest should see the host's battery.
+
+Configuration
+-------------
+
+The battery device is created as an ISA device using ``-device battery``.
+
+Operating Modes
+~~~~~~~~~~~~~~~
+
+**QMP Control Mode** (``use-qmp=true``, default)
+  Battery state is controlled via QMP commands. This mode is recommended for:
+
+  * Production environments requiring migration support
+  * Testing with predictable battery states
+  * Environments without host battery access
+  * Security-sensitive deployments
+
+**Sysfs Mode** (``enable-sysfs=true``)
+  Battery mirrors the host's physical battery. This mode is useful for:
+
+  * Desktop virtualization on laptops
+  * Development and testing with real battery behavior
+
+  Note: Sysfs mode reads host files and runs timers, which may impact
+  security and migration. Use with caution in production.
+
+Properties
+~~~~~~~~~~
+
+``ioport`` (default: 0x530)
+  I/O port base address for the battery device registers.
+
+``use-qmp`` (default: true)
+  Enable QMP control mode. When true, battery state is controlled via
+  QMP commands. Cannot be used together with ``enable-sysfs=true``.
+
+``enable-sysfs`` (default: false)
+  Enable sysfs mode to mirror the host's battery. Cannot be used together
+  with ``use-qmp=true``.
+
+``probe_interval`` (default: 2000)
+  Time interval between periodic probes in milliseconds (sysfs mode only).
+  A zero value disables the periodic probes, and makes the battery state
+  updates occur on guest requests only.
+
+``sysfs_path`` (default: auto-detected)
+  Path to the host's battery sysfs directory (sysfs mode only). If not
+  specified, the device will automatically detect the battery from
+  ``/sys/class/power_supply/``. This property allows overriding the default
+  path if:
+
+  * The sysfs path differs from the standard location
+  * A different battery needs to be probed
+  * A "fake" host battery is to be provided for testing
+
+Host Battery Detection
+----------------------
+
+The host's battery information is taken from the sysfs battery data,
+located in::
+
+  /sys/class/power_supply/[device of type "Battery"]
+
+The device automatically scans for the first available battery device
+with type "Battery" in the power_supply directory.
+
+ACPI Interface
+--------------
+
+The battery device exposes itself as an ACPI battery device with:
+
+* **_HID**: ``PNP0C0A`` (Control Method Battery)
+* **Device path**: ``\_SB.BAT0``
+
+The device implements standard ACPI battery methods:
+
+``_STA`` (Status)
+  Returns the battery presence status.
+
+``_BIF`` (Battery Information)
+  Returns static battery information including design capacity,
+  technology, and model information.
+
+``_BST`` (Battery Status)
+  Returns dynamic battery status including current state
+  (charging/discharging), present rate, and remaining capacity.
+
+I/O Interface
+-------------
+
+The battery device exposes 12 bytes of I/O space at the configured
+I/O port address with the following layout:
+
+* **Bytes 0-3**: Battery state (DWORD)
+
+  * 1 = Discharging
+  * 2 = Charging
+
+* **Bytes 4-7**: Battery rate (DWORD)
+
+  Current charge/discharge rate normalized to design capacity.
+
+* **Bytes 8-11**: Battery charge (DWORD)
+
+  Current battery charge level normalized to design capacity.
+
+All values are normalized where the design capacity equals 10000 units.
+Unknown values are represented as 0xFFFFFFFF.
+
+ACPI Notifications
+------------------
+
+The battery device generates ACPI notifications through GPE events:
+
+* **GPE._E07**: Device Check (0x01) - Battery insertion/removal
+* **GPE._E08**: Status Change (0x80) - Battery state change
+* **GPE._E09**: Information Change (0x81) - Battery information update
+
+QMP Commands
+------------
+
+When using QMP control mode (default), the following commands are available:
+
+``battery-set-state``
+  Set the battery state. Parameters:
+
+  * ``present``: Whether the battery is present (boolean)
+  * ``charging``: Whether the battery is charging (boolean)
+  * ``discharging``: Whether the battery is discharging (boolean)
+  * ``charge-percent``: Battery charge percentage 0-100 (integer)
+  * ``rate``: Charge/discharge rate in mW (optional integer)
+
+  Example::
+
+    -> { "execute": "battery-set-state",
+         "arguments": { "state": {
+           "present": true,
+           "charging": true,
+           "discharging": false,
+           "charge-percent": 85,
+           "rate": 500
+         }}}
+    <- { "return": {} }
+
+``query-battery``
+  Query the current battery state. Returns the same fields as above.
+
+  Example::
+
+    -> { "execute": "query-battery" }
+    <- { "return": {
+           "present": true,
+           "charging": true,
+           "discharging": false,
+           "charge-percent": 85,
+           "rate": 500,
+           "design-capacity": 10000
+         }}
+
+Examples
+--------
+
+QMP control mode (default - recommended)::
+
+  # Start with QMP control
+  qemu-system-x86_64 -device battery -qmp tcp:localhost:4444,server,wait=off
+
+  # From another terminal, set battery state via QMP:
+  echo '{"execute":"qmp_capabilities"}
+        {"execute":"battery-set-state",
+         "arguments":{"state":{"present":true,"charging":false,
+                               "discharging":true,"charge-percent":42,
+                               "rate":500}}}' | \
+  nc -N localhost 4444
+
+Sysfs mode (mirror host battery)::
+
+  # Enable sysfs mode to mirror host battery
+  qemu-system-x86_64 -device battery,use-qmp=false,enable-sysfs=true
+
+  # Custom probe interval (5 seconds)
+  qemu-system-x86_64 -device battery,use-qmp=false,enable-sysfs=true,probe_interval=5000
+
+  # Specific battery path
+  qemu-system-x86_64 -device battery,use-qmp=false,enable-sysfs=true,sysfs_path=/sys/class/power_supply/BAT1
+
+Testing with fake battery::
+
+  # Create fake battery files for testing
+  mkdir -p /tmp/fake_battery
+  echo "Battery" > /tmp/fake_battery/type
+  echo "Discharging" > /tmp/fake_battery/status
+  echo "50" > /tmp/fake_battery/capacity
+  echo "1500000" > /tmp/fake_battery/energy_now    # Current energy in μWh
+  echo "3000000" > /tmp/fake_battery/energy_full   # Full capacity in μWh
+  echo "500000" > /tmp/fake_battery/power_now      # Current power in μW
+
+  # Use fake battery in sysfs mode
+  qemu-system-x86_64 -device battery,use-qmp=false,enable-sysfs=true,sysfs_path=/tmp/fake_battery
+
+  # Update battery state while VM is running (from another terminal)
+  # Change to 75% charging:
+  echo "Charging" > /tmp/fake_battery/status
+  echo "75" > /tmp/fake_battery/capacity
+  echo "2250000" > /tmp/fake_battery/energy_now    # 75% of 3000000
+  echo "500000" > /tmp/fake_battery/power_now      # Charging rate (500 mW)
+
+  # Change to 25% discharging:
+  echo "Discharging" > /tmp/fake_battery/status
+  echo "25" > /tmp/fake_battery/capacity
+  echo "750000" > /tmp/fake_battery/energy_now     # 25% of 3000000
+  echo "300000" > /tmp/fake_battery/power_now      # Discharge rate (300 mW)
diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index f19d73c9f6..616e8228cc 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -22,6 +22,7 @@ guest hardware that is specific to QEMU.
    acpi_pci_hotplug
    acpi_nvdimm
    acpi_erst
+   battery
    sev-guest-firmware
    fw_cfg
    fsi
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 1d4e9f0845..64403378bd 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -83,3 +83,7 @@ config ACPI_ERST
 config ACPI_CXL
     bool
     depends on ACPI
+
+config BATTERY
+    bool
+    depends on ACPI
diff --git a/hw/acpi/battery.c b/hw/acpi/battery.c
new file mode 100644
index 0000000000..5ab3ab7472
--- /dev/null
+++ b/hw/acpi/battery.c
@@ -0,0 +1,735 @@
+/*
+ * QEMU emulated battery device.
+ *
+ * Copyright (c) 2019 Janus Technologies, Inc. (http://janustech.com)
+ *
+ * Authors:
+ *     Leonid Bloch <lb.workbox@gmail.com>
+ *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+ *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "trace.h"
+#include "hw/isa/isa.h"
+#include "hw/acpi/acpi.h"
+#include "hw/nvram/fw_cfg.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "hw/qdev-properties.h"
+#include "migration/vmstate.h"
+#include "hw/acpi/acpi_aml_interface.h"
+#include "qapi/qapi-commands-acpi.h"
+
+#include "hw/acpi/battery.h"
+
+#define BATTERY_DEVICE(obj) OBJECT_CHECK(BatteryState, (obj), TYPE_BATTERY)
+
+#define BATTERY_DISCHARGING  0x01  /* ACPI _BST bit 0 */
+#define BATTERY_CHARGING     0x02  /* ACPI _BST bit 1 */
+#define BATTERY_CRITICAL     0x04  /* ACPI _BST bit 2 */
+
+#define SYSFS_PATH       "/sys/class/power_supply"
+#define BATTERY_TYPE     "Battery"
+
+#define MAX_ALLOWED_STATE_LENGTH  32  /* For convinience when comparing */
+
+#define NORMALIZE_BY_FULL(val, full) \
+    ((full == 0) ? BATTERY_VAL_UNKNOWN \
+     : (uint32_t)(val * BATTERY_FULL_CAP / full))
+
+typedef union bat_metric {
+    uint32_t val;
+    uint8_t acc[4];
+} bat_metric;
+
+typedef struct BatteryState {
+    ISADevice dev;
+    MemoryRegion io;
+    uint16_t ioport;
+    bat_metric state;
+    bat_metric rate;
+    bat_metric charge;
+    uint32_t charge_full;
+    int units;  /* 0 - mWh, 1 - mAh */
+    bool use_qmp_control;
+    bool qmp_present;
+    bool qmp_charging;
+    bool qmp_discharging;
+    int qmp_charge_percent;
+    int qmp_rate;
+    bool enable_sysfs;
+
+    QEMUTimer *probe_state_timer;
+    uint64_t probe_state_interval;
+
+    char *bat_path;
+} BatteryState;
+
+/* Access addresses */
+enum acc_addr {
+    bsta_addr0, bsta_addr1, bsta_addr2, bsta_addr3,
+    brte_addr0, brte_addr1, brte_addr2, brte_addr3,
+    bcrg_addr0, bcrg_addr1, bcrg_addr2, bcrg_addr3
+};
+
+/* Files used when the units are:      mWh             mAh      */
+static const char *full_file[] = { "energy_full", "charge_full" };
+static const char *now_file[]  = { "energy_now",  "charge_now"  };
+static const char *rate_file[] = { "power_now",   "current_now" };
+
+static const char *stat_file = "status";
+static const char *type_file = "type";
+
+static const char *discharging_states[] = { "Discharging", "Not charging" };
+static const char *charging_states[] = { "Charging", "Full", "Unknown" };
+
+static inline bool battery_file_accessible(char *path, const char *file)
+{
+    char full_path[PATH_MAX];
+    int path_len;
+
+    path_len = snprintf(full_path, PATH_MAX, "%s/%s", path, file);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        return false;
+    }
+    if (access(full_path, R_OK) == 0) {
+        return true;
+    }
+    return false;
+}
+
+static inline int battery_select_file(char *path, const char **file)
+{
+    if (battery_file_accessible(path, file[0])) {
+        return 0;
+    } else if (battery_file_accessible(path, file[1])) {
+        return 1;
+    } else {
+        return -1;
+    }
+}
+
+static void battery_get_full_charge(BatteryState *s, Error **errp)
+{
+    char file_path[PATH_MAX];
+    int path_len;
+    uint32_t val;
+    FILE *ff;
+
+    path_len = snprintf(file_path, PATH_MAX, "%s/%s", s->bat_path,
+                        full_file[s->units]);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        error_setg(errp, "Full capacity file path is inaccessible.");
+        return;
+    }
+
+    ff = fopen(file_path, "r");
+    if (ff == NULL) {
+        error_setg_errno(errp, errno, "Could not read the full charge file.");
+        return;
+    }
+
+    if (fscanf(ff, "%u", &val) != 1) {
+        error_setg(errp, "Full capacity undetermined.");
+        return;
+    } else {
+        s->charge_full = val;
+    }
+    fclose(ff);
+}
+
+static inline bool battery_is_discharging(char *val)
+{
+    static const int discharging_len = ARRAY_SIZE(discharging_states);
+    int i;
+
+    for (i = 0; i < discharging_len; i++) {
+        if (!strncmp(val, discharging_states[i], MAX_ALLOWED_STATE_LENGTH)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static inline bool battery_is_charging(char *val)
+{
+    static const int charging_len = ARRAY_SIZE(charging_states);
+    int i;
+
+    for (i = 0; i < charging_len; i++) {
+        if (!strncmp(val, charging_states[i], MAX_ALLOWED_STATE_LENGTH)) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void battery_get_state(BatteryState *s)
+{
+    char file_path[PATH_MAX];
+    int path_len;
+    char val[MAX_ALLOWED_STATE_LENGTH];
+    FILE *ff;
+
+    path_len = snprintf(file_path, PATH_MAX, "%s/%s", s->bat_path, stat_file);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        warn_report("Could not read the battery state.");
+        return;
+    }
+
+    ff = fopen(file_path, "r");
+    if (ff == NULL) {
+        warn_report("Could not read the battery state.");
+        return;
+    }
+
+    if (fgets(val, MAX_ALLOWED_STATE_LENGTH, ff) == NULL) {
+        warn_report("Battery state unreadable.");
+    } else {
+        val[strcspn(val, "\n")] = 0;
+        if (battery_is_discharging(val)) {
+            s->state.val = BATTERY_DISCHARGING;
+        } else if (battery_is_charging(val)) {
+            s->state.val = BATTERY_CHARGING;
+        } else {
+            s->state.val = 0;
+            warn_report("Battery state undetermined.");
+        }
+    }
+    fclose(ff);
+}
+
+static void battery_get_rate(BatteryState *s)
+{
+    char file_path[PATH_MAX];
+    int path_len;
+    uint64_t val;
+    FILE *ff;
+
+    path_len = snprintf(file_path, PATH_MAX, "%s/%s", s->bat_path,
+                        rate_file[s->units]);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        warn_report("Could not read the battery rate.");
+        s->rate.val = BATTERY_VAL_UNKNOWN;
+        return;
+    }
+
+    ff = fopen(file_path, "r");
+    if (ff == NULL) {
+        warn_report("Could not read the battery rate.");
+        s->rate.val = BATTERY_VAL_UNKNOWN;
+        return;
+    }
+
+    if (fscanf(ff, "%lu", &val) != 1) {
+        warn_report("Battery rate undetermined.");
+        s->rate.val = BATTERY_VAL_UNKNOWN;
+    } else {
+        s->rate.val = NORMALIZE_BY_FULL(val, s->charge_full);
+    }
+    fclose(ff);
+}
+
+static void battery_get_charge(BatteryState *s)
+{
+    char file_path[PATH_MAX];
+    int path_len;
+    uint64_t val;
+    FILE *ff;
+
+    path_len = snprintf(file_path, PATH_MAX, "%s/%s", s->bat_path,
+                        now_file[s->units]);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        warn_report("Could not read the battery charge.");
+        s->charge.val = BATTERY_VAL_UNKNOWN;
+        return;
+    }
+
+    ff = fopen(file_path, "r");
+    if (ff == NULL) {
+        warn_report("Could not read the battery charge.");
+        s->charge.val = BATTERY_VAL_UNKNOWN;
+        return;
+    }
+
+    if (fscanf(ff, "%lu", &val) != 1) {
+        warn_report("Battery charge undetermined.");
+        s->charge.val = BATTERY_VAL_UNKNOWN;
+    } else {
+        s->charge.val = NORMALIZE_BY_FULL(val, s->charge_full);
+    }
+    fclose(ff);
+}
+
+static void battery_get_dynamic_status(BatteryState *s)
+{
+    if (s->use_qmp_control) {
+        s->state.val = 0;
+        if (s->qmp_present) {
+            if (s->qmp_charging) {
+                s->state.val |= BATTERY_CHARGING;
+            }
+            if (s->qmp_discharging) {
+                s->state.val |= BATTERY_DISCHARGING;
+            }
+        }
+        s->rate.val = s->qmp_rate;
+        s->charge.val = (s->qmp_charge_percent * BATTERY_FULL_CAP) / 100;
+    } else if (s->enable_sysfs) {
+        battery_get_state(s);
+        battery_get_rate(s);
+        battery_get_charge(s);
+    } else {
+        s->state.val = 0;
+        s->rate.val = 0;
+        s->charge.val = 0;
+    }
+
+    trace_battery_get_dynamic_status(s->state.val, s->rate.val, s->charge.val);
+}
+
+static void battery_probe_state(void *opaque)
+{
+    BatteryState *s = opaque;
+
+    uint32_t state_before = s->state.val;
+    uint32_t rate_before = s->rate.val;
+    uint32_t charge_before = s->charge.val;
+
+    battery_get_dynamic_status(s);
+
+    if (state_before != s->state.val || rate_before != s->rate.val ||
+        charge_before != s->charge.val) {
+        Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+        switch (charge_before) {
+        case 0:
+            break;  /* Avoid marking initiation as an update */
+        default:
+            acpi_send_event(DEVICE(obj), ACPI_BATTERY_CHANGE_STATUS);
+        }
+    }
+    timer_mod(s->probe_state_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+              s->probe_state_interval);
+}
+
+static void battery_probe_state_timer_init(BatteryState *s)
+{
+    if (s->enable_sysfs && s->probe_state_interval > 0) {
+        s->probe_state_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                            battery_probe_state, s);
+        timer_mod(s->probe_state_timer, qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
+                  s->probe_state_interval);
+    }
+}
+
+static bool battery_verify_sysfs(BatteryState *s, char *path)
+{
+    int units;
+    FILE *ff;
+    char type_path[PATH_MAX];
+    int path_len;
+    char val[MAX_ALLOWED_STATE_LENGTH];
+
+    path_len = snprintf(type_path, PATH_MAX, "%s/%s", path, type_file);
+    if (path_len < 0 || path_len >= PATH_MAX) {
+        return false;
+    }
+    ff = fopen(type_path, "r");
+    if (ff == NULL) {
+        return false;
+    }
+
+    if (fgets(val, MAX_ALLOWED_STATE_LENGTH, ff) == NULL) {
+        fclose(ff);
+        return false;
+    } else {
+        val[strcspn(val, "\n")] = 0;
+        if (strncmp(val, BATTERY_TYPE, MAX_ALLOWED_STATE_LENGTH)) {
+            fclose(ff);
+            return false;
+        }
+    }
+    fclose(ff);
+
+    units = battery_select_file(path, full_file);
+
+    if (units < 0) {
+        return false;
+    } else {
+        s->units = units;
+    }
+
+    return (battery_file_accessible(path, now_file[s->units])
+            & battery_file_accessible(path, rate_file[s->units])
+            & battery_file_accessible(path, stat_file));
+}
+
+static bool get_battery_path(DeviceState *dev)
+{
+    BatteryState *s = BATTERY_DEVICE(dev);
+    DIR *dir;
+    struct dirent *ent;
+    char bp[PATH_MAX];
+    int path_len;
+
+    if (s->bat_path) {
+        return battery_verify_sysfs(s, s->bat_path);
+    }
+
+    dir = opendir(SYSFS_PATH);
+    if (dir == NULL) {
+        return false;
+    }
+
+    ent = readdir(dir);
+    while (ent != NULL) {
+        if (ent->d_name[0] != '.') {
+            path_len = snprintf(bp, PATH_MAX, "%s/%s", SYSFS_PATH,
+                                ent->d_name);
+            if (path_len < 0 || path_len >= PATH_MAX) {
+                return false;
+            }
+            if (battery_verify_sysfs(s, bp)) {
+                qdev_prop_set_string(dev, BATTERY_PATH_PROP, bp);
+                closedir(dir);
+                return true;
+            }
+        }
+        ent = readdir(dir);
+    }
+    closedir(dir);
+
+    return false;
+}
+
+static void battery_realize(DeviceState *dev, Error **errp)
+{
+    ISADevice *d = ISA_DEVICE(dev);
+    BatteryState *s = BATTERY_DEVICE(dev);
+    FWCfgState *fw_cfg = fw_cfg_find();
+    uint16_t *battery_port;
+    char err_details[0x20] = {};
+
+    trace_battery_realize();
+
+    if (s->use_qmp_control && s->enable_sysfs) {
+        error_setg(errp, "Cannot enable both QMP control and sysfs mode");
+        return;
+    }
+
+    /* Initialize QMP state to sensible defaults when in QMP mode */
+    if (s->use_qmp_control) {
+        s->qmp_present = true;
+        s->qmp_charging = false;
+        s->qmp_discharging = true;
+        s->qmp_charge_percent = 50;
+        s->qmp_rate = 1000;  /* 1000 mW discharge rate */
+    }
+
+    if (s->enable_sysfs) {
+        if (!s->bat_path) {
+            strcpy(err_details, " Try using 'sysfs_path='");
+        }
+
+        if (!get_battery_path(dev)) {
+            error_setg(errp, "Battery sysfs path not found or unreadable.%s",
+                       err_details);
+            return;
+        }
+        battery_get_full_charge(s, errp);
+    } else {
+        s->charge_full = BATTERY_FULL_CAP;
+    }
+
+    isa_register_ioport(d, &s->io, s->ioport);
+
+    battery_probe_state_timer_init(s);
+
+    if (!fw_cfg) {
+        return;
+    }
+
+    battery_port = g_malloc(sizeof(*battery_port));
+    *battery_port = cpu_to_le16(s->ioport);
+    fw_cfg_add_file(fw_cfg, "etc/battery-port", battery_port,
+                    sizeof(*battery_port));
+}
+
+static const Property battery_device_properties[] = {
+    DEFINE_PROP_UINT16(BATTERY_IOPORT_PROP, BatteryState, ioport, 0x530),
+    DEFINE_PROP_BOOL("use-qmp", BatteryState, use_qmp_control, true),
+    DEFINE_PROP_BOOL("enable-sysfs", BatteryState, enable_sysfs, false),
+    DEFINE_PROP_UINT64(BATTERY_PROBE_STATE_INTERVAL, BatteryState,
+                       probe_state_interval, 2000),
+    DEFINE_PROP_STRING(BATTERY_PATH_PROP, BatteryState, bat_path),
+};
+
+static const VMStateDescription battery_vmstate = {
+    .name = "battery",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT16(ioport, BatteryState),
+        VMSTATE_UINT64(probe_state_interval, BatteryState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void build_battery_aml(AcpiDevAmlIf *adev, Aml *scope)
+{
+    Aml *dev, *field, *method, *pkg;
+    Aml *bat_state, *bat_rate, *bat_charge;
+    Aml *sb_scope;
+    BatteryState *s = BATTERY_DEVICE(adev);
+
+    bat_state  = aml_local(0);
+    bat_rate   = aml_local(1);
+    bat_charge = aml_local(2);
+
+    sb_scope = aml_scope("\\_SB");
+    dev = aml_device("BAT0");
+    aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C0A")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x1F)));
+    aml_append(dev, method);
+
+    aml_append(dev, aml_operation_region("DBST", AML_SYSTEM_IO,
+                                         aml_int(s->ioport),
+                                         BATTERY_LEN));
+    field = aml_field("DBST", AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
+    aml_append(field, aml_named_field("BSTA", 32));
+    aml_append(field, aml_named_field("BRTE", 32));
+    aml_append(field, aml_named_field("BCRG", 32));
+    aml_append(dev, field);
+
+    method = aml_method("_BIF", 0, AML_NOTSERIALIZED);
+    pkg = aml_package(13);
+    /* Power Unit */
+    aml_append(pkg, aml_int(0));             /* mW */
+    /* Design Capacity */
+    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
+    /* Last Full Charge Capacity */
+    aml_append(pkg, aml_int(BATTERY_FULL_CAP));
+    /* Battery Technology */
+    aml_append(pkg, aml_int(1));             /* Secondary */
+    /* Design Voltage */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    /* Design Capacity of Warning */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_WARNING));
+    /* Design Capacity of Low */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_OF_LOW));
+    /* Battery Capacity Granularity 1 */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
+    /* Battery Capacity Granularity 2 */
+    aml_append(pkg, aml_int(BATTERY_CAPACITY_GRANULARITY));
+    /* Model Number */
+    aml_append(pkg, aml_string("QBAT001"));  /* Model Number */
+    /* Serial Number */
+    aml_append(pkg, aml_string("SN00000"));  /* Serial Number */
+    /* Battery Type */
+    aml_append(pkg, aml_string("Virtual"));  /* Battery Type */
+    /* OEM Information */
+    aml_append(pkg, aml_string("QEMU"));     /* OEM Information */
+    aml_append(method, aml_return(pkg));
+    aml_append(dev, method);
+
+    pkg = aml_package(4);
+    /* Battery State */
+    aml_append(pkg, aml_int(0));
+    /* Battery Present Rate */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    /* Battery Remaining Capacity */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    /* Battery Present Voltage */
+    aml_append(pkg, aml_int(BATTERY_VAL_UNKNOWN));
+    aml_append(dev, aml_name_decl("DBPR", pkg));
+
+    method = aml_method("_BST", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_store(aml_name("BSTA"), bat_state));
+    aml_append(method, aml_store(aml_name("BRTE"), bat_rate));
+    aml_append(method, aml_store(aml_name("BCRG"), bat_charge));
+    aml_append(method, aml_store(bat_state,
+                                 aml_index(aml_name("DBPR"), aml_int(0))));
+    aml_append(method, aml_store(bat_rate,
+                                 aml_index(aml_name("DBPR"), aml_int(1))));
+    aml_append(method, aml_store(bat_charge,
+                                 aml_index(aml_name("DBPR"), aml_int(2))));
+    aml_append(method, aml_return(aml_name("DBPR")));
+    aml_append(dev, method);
+
+    aml_append(sb_scope, dev);
+    aml_append(scope, sb_scope);
+
+    /* Device Check */
+    method = aml_method("\\_GPE._E07", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x01)));
+    aml_append(scope, method);
+
+    /* Status Change */
+    method = aml_method("\\_GPE._E08", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x80)));
+    aml_append(scope, method);
+
+    /* Information Change */
+    method = aml_method("\\_GPE._E09", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.BAT0"), aml_int(0x81)));
+    aml_append(scope, method);
+}
+
+static void battery_class_init(ObjectClass *class, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(class);
+    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(class);
+
+    dc->realize = battery_realize;
+    device_class_set_props(dc, battery_device_properties);
+    dc->vmsd = &battery_vmstate;
+    adevc->build_dev_aml = build_battery_aml;
+}
+
+static uint64_t battery_ioport_read(void *opaque, hwaddr addr, unsigned size)
+{
+    BatteryState *s = opaque;
+
+    battery_get_dynamic_status(s);
+
+    switch (addr) {
+    case bsta_addr0:
+        return s->state.acc[0];
+    case bsta_addr1:
+        return s->state.acc[1];
+    case bsta_addr2:
+        return s->state.acc[2];
+    case bsta_addr3:
+        return s->state.acc[3];
+    case brte_addr0:
+        return s->rate.acc[0];
+    case brte_addr1:
+        return s->rate.acc[1];
+    case brte_addr2:
+        return s->rate.acc[2];
+    case brte_addr3:
+        return s->rate.acc[3];
+    case bcrg_addr0:
+        return s->charge.acc[0];
+    case bcrg_addr1:
+        return s->charge.acc[1];
+    case bcrg_addr2:
+        return s->charge.acc[2];
+    case bcrg_addr3:
+        return s->charge.acc[3];
+    default:
+        warn_report("Battery: guest read unknown value.");
+        trace_battery_ioport_read_unknown();
+        return 0;
+    }
+}
+
+static const MemoryRegionOps battery_ops = {
+    .read = battery_ioport_read,
+    .impl = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+static void battery_instance_init(Object *obj)
+{
+    BatteryState *s = BATTERY_DEVICE(obj);
+
+    memory_region_init_io(&s->io, obj, &battery_ops, s, "battery",
+                          BATTERY_LEN);
+}
+
+static const TypeInfo battery_info = {
+    .name          = TYPE_BATTERY,
+    .parent        = TYPE_ISA_DEVICE,
+    .instance_size = sizeof(BatteryState),
+    .class_init    = battery_class_init,
+    .instance_init = battery_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_ACPI_DEV_AML_IF },
+        { },
+    },
+};
+
+static BatteryState *find_battery_device(void)
+{
+    Object *o = object_resolve_path_type("", TYPE_BATTERY, NULL);
+    if (!o) {
+        return NULL;
+    }
+    return BATTERY_DEVICE(o);
+}
+
+void qmp_battery_set_state(BatteryInfo *state, Error **errp)
+{
+    BatteryState *s = find_battery_device();
+
+    if (!s) {
+        error_setg(errp, "No battery device found");
+        return;
+    }
+
+    s->qmp_present = state->present;
+    s->qmp_charging = state->charging;
+    s->qmp_discharging = state->discharging;
+    s->qmp_charge_percent = state->charge_percent;
+
+    if (state->has_rate) {
+        s->qmp_rate = state->rate;
+    }
+
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        acpi_send_event(DEVICE(obj), ACPI_BATTERY_CHANGE_STATUS);
+    }
+}
+
+BatteryInfo *qmp_query_battery(Error **errp)
+{
+    BatteryState *s = find_battery_device();
+    BatteryInfo *ret;
+
+    if (!s) {
+        error_setg(errp, "No battery device found");
+        return NULL;
+    }
+
+    ret = g_new0(BatteryInfo, 1);
+
+    if (s->use_qmp_control) {
+        ret->present = s->qmp_present;
+        ret->charging = s->qmp_charging;
+        ret->discharging = s->qmp_discharging;
+        ret->charge_percent = s->qmp_charge_percent;
+        ret->has_rate = true;
+        ret->rate = s->qmp_rate;
+    } else {
+        battery_get_dynamic_status(s);
+        ret->present = true;
+        ret->charging = !!(s->state.val & BATTERY_CHARGING);
+        ret->discharging = !!(s->state.val & BATTERY_DISCHARGING);
+        ret->charge_percent = (s->charge.val * 100) / BATTERY_FULL_CAP;
+        ret->has_rate = true;
+        ret->rate = s->rate.val;
+    }
+
+    ret->has_remaining_capacity = false;
+    ret->has_design_capacity = true;
+    ret->design_capacity = BATTERY_FULL_CAP;
+
+    return ret;
+}
+
+static void battery_register_types(void)
+{
+    type_register_static(&battery_info);
+}
+
+type_init(battery_register_types)
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 73f02b9691..10379a7b2c 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -31,6 +31,7 @@ acpi_ss.add(when: 'CONFIG_PC', if_false: files('acpi-x86-stub.c'))
 if have_tpm
   acpi_ss.add(files('tpm.c'))
 endif
+acpi_ss.add(when: 'CONFIG_BATTERY', if_true: files('battery.c'))
 system_ss.add(when: 'CONFIG_ACPI', if_false: files('acpi-stub.c', 'aml-build-stub.c', 'ghes-stub.c', 'acpi_interface.c'))
 system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c'))
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index edc93e703c..dd3e815482 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -87,3 +87,8 @@ acpi_nvdimm_read_io_port(void) "Alert: we never read _DSM IO Port"
 acpi_nvdimm_dsm_mem_addr(uint64_t dsm_mem_addr) "dsm memory address 0x%" PRIx64
 acpi_nvdimm_dsm_info(uint32_t revision, uint32_t handle, uint32_t function) "Revision 0x%" PRIx32 " Handle 0x%" PRIx32 " Function 0x%" PRIx32
 acpi_nvdimm_invalid_revision(uint32_t revision) "Revision 0x%" PRIx32 " is not supported, expect 0x1"
+
+# battery.c
+battery_realize(void) "Battery device realize entry"
+battery_get_dynamic_status(uint32_t state, uint32_t rate, uint32_t charge) "Battery read state: 0x%"PRIx32", rate: %"PRIu32", charge: %"PRIu32
+battery_ioport_read_unknown(void) "Battery read unknown"
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 3a0e2b8ebb..2c878fd112 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -39,6 +39,7 @@ config PC
     imply VIRTIO_VGA
     imply NVDIMM
     imply FDC_ISA
+    imply BATTERY
     select I8259
     select I8254
     select PCKBD
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 423c4959fe..790b16e582 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1248,6 +1248,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
         aml_append(sb_scope, dev);
     }
+
     aml_append(dsdt, sb_scope);
 
     if (pm->pcihp_bridge_en || pm->pcihp_root_en) {
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 68d9d15f50..3064ef6734 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -13,6 +13,7 @@ typedef enum {
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
     ACPI_VMGENID_CHANGE_STATUS = 32,
     ACPI_POWER_DOWN_STATUS = 64,
+    ACPI_BATTERY_CHANGE_STATUS = 128,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/battery.h b/include/hw/acpi/battery.h
new file mode 100644
index 0000000000..5c5e83abfa
--- /dev/null
+++ b/include/hw/acpi/battery.h
@@ -0,0 +1,33 @@
+/*
+ * QEMU emulated battery device.
+ *
+ * Copyright (c) 2019 Janus Technologies, Inc. (http://janustech.com)
+ *
+ * Authors:
+ *     Leonid Bloch <lb.workbox@gmail.com>
+ *     Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
+ *     Dmitry Fleytman <dmitry.fleytman@gmail.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef HW_ACPI_BATTERY_H
+#define HW_ACPI_BATTERY_H
+
+#define TYPE_BATTERY                  "battery"
+#define BATTERY_IOPORT_PROP           "ioport"
+#define BATTERY_PATH_PROP             "sysfs_path"
+#define BATTERY_PROBE_STATE_INTERVAL  "probe_interval"
+
+#define BATTERY_FULL_CAP     10000  /* mWh */
+
+#define BATTERY_CAPACITY_OF_WARNING   (BATTERY_FULL_CAP /  10)  /* 10% */
+#define BATTERY_CAPACITY_OF_LOW       (BATTERY_FULL_CAP /  25)  /* 4%  */
+#define BATTERY_CAPACITY_GRANULARITY  (BATTERY_FULL_CAP / 100)  /* 1%  */
+
+#define BATTERY_VAL_UNKNOWN  0xFFFFFFFF
+
+#define BATTERY_LEN          0x0C
+
+#endif
diff --git a/qapi/acpi.json b/qapi/acpi.json
index 906b3687a5..d1ad663bfd 100644
--- a/qapi/acpi.json
+++ b/qapi/acpi.json
@@ -142,3 +142,76 @@
 ##
 { 'event': 'ACPI_DEVICE_OST',
      'data': { 'info': 'ACPIOSTInfo' } }
+
+##
+# @BatteryInfo:
+#
+# Battery state information
+#
+# @present: whether the battery is present
+#
+# @charging: whether the battery is charging
+#
+# @discharging: whether the battery is discharging
+#
+# @charge-percent: battery charge percentage (0-100)
+#
+# @rate: charge/discharge rate in mW (optional)
+#
+# @remaining-capacity: remaining capacity in mWh (optional)
+#
+# @design-capacity: design capacity in mWh (optional)
+#
+# Since: 10.2
+##
+{ 'struct': 'BatteryInfo',
+  'data': { 'present': 'bool',
+            'charging': 'bool',
+            'discharging': 'bool',
+            'charge-percent': 'int',
+            '*rate': 'int',
+            '*remaining-capacity': 'int',
+            '*design-capacity': 'int' } }
+
+##
+# @battery-set-state:
+#
+# Set the state of the emulated battery device
+#
+# @state: new battery state
+#
+
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "battery-set-state",
+#          "arguments": { "state": { "present": true,
+#                                    "charging": true,
+#                                    "discharging": false,
+#                                    "charge-percent": 85 } } }
+#     <- { "return": {} }
+##
+{ 'command': 'battery-set-state',
+  'data': { 'state': 'BatteryInfo' } }
+
+##
+# @query-battery:
+#
+# Query the current state of the emulated battery device
+#
+# Returns: current battery state
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-battery" }
+#     <- { "return": { "present": true,
+#                      "charging": true,
+#                      "discharging": false,
+#                      "charge-percent": 85 } }
+##
+{ 'command': 'query-battery',
+  'returns': 'BatteryInfo' }
-- 
2.51.0


