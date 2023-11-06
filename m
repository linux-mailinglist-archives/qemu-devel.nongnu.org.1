Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC00C7E1AD0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:12:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzta0-0004x8-FZ; Mon, 06 Nov 2023 01:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZT-0004WO-PI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZQ-0001Pc-V9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:50 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1cc4f777ab9so27984455ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253927; x=1699858727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJ6CZhu5tcffV29jXxlTZV88XpkNHe98VEK8gTKIg2E=;
 b=ySIIMZM1Iw+SrlvMOei746rLXZZkpZEpDT/+xbatWP+tDa2kmF6KhoaN9EZ1PPwmAP
 szcqYC1qIksyMXXb7UCDyHiouWcztGYPbp8BnI9YvJyT7qKPSYnfMHPczcKTo2Us5Ewp
 PAnjnhE3iZxlgcjuR46f0eb8k+JpEZIUvvrK1ZzSNBoSg74qPg3fkhYUPgO9j+GmkA39
 nZAMiDCZ3n9Kt3QF4pRYNnmODh1ibZzT+2RaH+8nq+0BacaHWobIwQTw7Txy/eG+5M2E
 xELnZ02erI2IYFk6rRiijtsHKCSdzplm8y4kes7BRqU5BfZ+PZ0h6Gg09iITF4A7D4c0
 efhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253927; x=1699858727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJ6CZhu5tcffV29jXxlTZV88XpkNHe98VEK8gTKIg2E=;
 b=vQN4zmy2QjqzGhY3RdTW7Q7yXZHcsR+h3w4KcqdqdDs3KUS6ssx0yTStXVGTkSZNKj
 ZVJq9u4NAfozgRVMXdftgTVaeNWhp9ZTGnMT91HmTEJJtJ3aDKfLS3BzVOJ6M//V3W+m
 hl7TQyLYCaJrdazKbI2KqdTjbcPGNQ3kclpfu5JR+0yYIC53mFYy3V0d7E6ELXKuwo6m
 SDTU0l3BDf1ZWrspHRveoRZaUL95J0fjeiNQLQSiINaSk47a98ks+n0LJVP/ubq/4EeJ
 LJg+fZ9OJLL/oZ0awn8UcDvFMFo6evpjdOXPQFmZo/vTn9ljAr9EycmOZmBcU9Zz2sow
 wvCA==
X-Gm-Message-State: AOJu0YyzBYdENzBtXj5dH6LxENd7rs27TJCg+ZgKF3aAr1DLExscrsKz
 nb1HLfLusFJ7efUpcIc6mPftc+Aqd9UKBWna7Rs=
X-Google-Smtp-Source: AGHT+IHWAEPN+dRYFYrM+Nr1SOqkySrzIPP03QnSDO9WtH5bim8nOTEb3VoFC3+67sK4GSfAoseBuQ==
X-Received: by 2002:a17:902:f9ce:b0:1ca:a07b:36d with SMTP id
 kz14-20020a170902f9ce00b001caa07b036dmr23225862plb.48.1699253927656; 
 Sun, 05 Nov 2023 22:58:47 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 21/71] hw/acpi: Constify VMState
Date: Sun,  5 Nov 2023 22:57:37 -0800
Message-Id: <20231106065827.543129-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/acpi/cpu.c                  |  4 ++--
 hw/acpi/erst.c                 |  2 +-
 hw/acpi/generic_event_device.c | 12 ++++++------
 hw/acpi/ich9.c                 | 12 ++++++------
 hw/acpi/ich9_tco.c             |  2 +-
 hw/acpi/memory_hotplug.c       |  4 ++--
 hw/acpi/pcihp.c                |  2 +-
 hw/acpi/piix4.c                | 12 ++++++------
 hw/acpi/vmgenid.c              |  2 +-
 9 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 011d2c6c2d..2d81c1e790 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -297,7 +297,7 @@ static const VMStateDescription vmstate_cpuhp_sts = {
     .name = "CPU hotplug device state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
         VMSTATE_BOOL(is_removing, AcpiCpuStatus),
         VMSTATE_UINT32(ost_event, AcpiCpuStatus),
@@ -310,7 +310,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
     .name = "CPU hotplug state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(selector, CPUHotplugState),
         VMSTATE_UINT8(command, CPUHotplugState),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, CPUHotplugState, dev_count,
diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index 35007d8017..71b477f490 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -932,7 +932,7 @@ static const VMStateDescription erst_vmstate  = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = erst_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(operation, ERSTDeviceState),
         VMSTATE_UINT8(busy_status, ERSTDeviceState),
         VMSTATE_UINT8(command_status, ERSTDeviceState),
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index a3d31631fe..2d6e91b124 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -312,7 +312,7 @@ static const VMStateDescription vmstate_memhp_state = {
     .name = "acpi-ged/memhp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(memhp_state, AcpiGedState),
         VMSTATE_END_OF_LIST()
     }
@@ -322,7 +322,7 @@ static const VMStateDescription vmstate_ged_state = {
     .name = "acpi-ged-state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sel, GEDState),
         VMSTATE_END_OF_LIST()
     }
@@ -332,7 +332,7 @@ static const VMStateDescription vmstate_ghes = {
     .name = "acpi-ghes",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields     = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
         VMSTATE_END_OF_LIST()
     },
@@ -349,7 +349,7 @@ static const VMStateDescription vmstate_ghes_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = ghes_needed,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
                        vmstate_ghes, AcpiGhesState),
         VMSTATE_END_OF_LIST()
@@ -360,11 +360,11 @@ static const VMStateDescription vmstate_acpi_ged = {
     .name = "acpi-ged",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ged_state, AcpiGedState, 1, vmstate_ged_state, GEDState),
         VMSTATE_END_OF_LIST(),
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
         &vmstate_ghes_state,
         NULL
diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 25e2c7243e..573d032e8e 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -164,7 +164,7 @@ static const VMStateDescription vmstate_memhp_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_test_use_memhp,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
     }
@@ -181,7 +181,7 @@ static const VMStateDescription vmstate_tco_io_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_test_use_tco,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(tco_regs, ICH9LPCPMRegs, 1, vmstate_tco_io_sts,
                        TCOIORegs),
         VMSTATE_END_OF_LIST()
@@ -208,7 +208,7 @@ static const VMStateDescription vmstate_cpuhp_state = {
     .minimum_version_id = 1,
     .needed = vmstate_test_use_cpuhp,
     .pre_load = vmstate_cpuhp_pre_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
     }
@@ -226,7 +226,7 @@ static const VMStateDescription vmstate_pcihp_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_test_use_pcihp,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_HOTPLUG(acpi_pci_hotplug,
                             ICH9LPCPMRegs,
                             NULL, NULL),
@@ -239,7 +239,7 @@ const VMStateDescription vmstate_ich9_pm = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = ich9_pm_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(acpi_regs.pm1.evt.sts, ICH9LPCPMRegs),
         VMSTATE_UINT16(acpi_regs.pm1.evt.en, ICH9LPCPMRegs),
         VMSTATE_UINT16(acpi_regs.pm1.cnt.cnt, ICH9LPCPMRegs),
@@ -251,7 +251,7 @@ const VMStateDescription vmstate_ich9_pm = {
         VMSTATE_UINT32(smi_sts, ICH9LPCPMRegs),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_memhp_state,
         &vmstate_tco_io_state,
         &vmstate_cpuhp_state,
diff --git a/hw/acpi/ich9_tco.c b/hw/acpi/ich9_tco.c
index 1540f4fd46..81606219f7 100644
--- a/hw/acpi/ich9_tco.c
+++ b/hw/acpi/ich9_tco.c
@@ -254,7 +254,7 @@ const VMStateDescription vmstate_tco_io_sts = {
     .name = "tco io device status",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(tco.rld, TCOIORegs),
         VMSTATE_UINT8(tco.din, TCOIORegs),
         VMSTATE_UINT8(tco.dout, TCOIORegs),
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 0b883df813..de6f974ebb 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -317,7 +317,7 @@ static const VMStateDescription vmstate_memhp_sts = {
     .name = "memory hotplug device state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(is_enabled, MemStatus),
         VMSTATE_BOOL(is_inserting, MemStatus),
         VMSTATE_UINT32(ost_event, MemStatus),
@@ -330,7 +330,7 @@ const VMStateDescription vmstate_memory_hotplug = {
     .name = "memory hotplug state",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(selector, MemHotplugState),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(devs, MemHotplugState, dev_count,
                                              vmstate_memhp_sts, MemStatus),
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index 4f75c873e2..5f79c9016b 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -517,7 +517,7 @@ const VMStateDescription vmstate_acpi_pcihp_pci_status = {
     .name = "acpi_pcihp_pci_status",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(up, AcpiPciHpPciStatus),
         VMSTATE_UINT32(down, AcpiPciHpPciStatus),
         VMSTATE_END_OF_LIST()
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index dd523d2e4c..debe1adb84 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -147,7 +147,7 @@ static const VMStateDescription vmstate_gpe = {
     .name = "gpe",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_GPE_ARRAY(sts, ACPIGPE),
         VMSTATE_GPE_ARRAY(en, ACPIGPE),
         VMSTATE_END_OF_LIST()
@@ -158,7 +158,7 @@ static const VMStateDescription vmstate_pci_status = {
     .name = "pci_status",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(up, struct AcpiPciHpPciStatus),
         VMSTATE_UINT32(down, struct AcpiPciHpPciStatus),
         VMSTATE_END_OF_LIST()
@@ -189,7 +189,7 @@ static const VMStateDescription vmstate_memhp_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = vmstate_test_use_memhp,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_MEMORY_HOTPLUG(acpi_memory_hotplug, PIIX4PMState),
         VMSTATE_END_OF_LIST()
     }
@@ -214,7 +214,7 @@ static const VMStateDescription vmstate_cpuhp_state = {
     .minimum_version_id = 1,
     .needed = vmstate_test_use_cpuhp,
     .pre_load = vmstate_cpuhp_pre_load,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, PIIX4PMState),
         VMSTATE_END_OF_LIST()
     }
@@ -247,7 +247,7 @@ static const VMStateDescription vmstate_acpi = {
     .version_id = 3,
     .minimum_version_id = 3,
     .post_load = vmstate_acpi_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.evt.sts, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
@@ -269,7 +269,7 @@ static const VMStateDescription vmstate_acpi = {
                             vmstate_test_migrate_acpi_index),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
          &vmstate_memhp_state,
          &vmstate_cpuhp_state,
          NULL
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index a39315c1b3..e63c8af4c3 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -178,7 +178,7 @@ static const VMStateDescription vmstate_vmgenid = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = vmgenid_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(vmgenid_addr_le, VmGenIdState, sizeof(uint64_t)),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


