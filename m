Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1756D8201E8
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLZ-0007My-5z; Fri, 29 Dec 2023 16:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLX-0007KG-ME
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:47 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLV-0006wW-Im
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:47 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204fdd685fdso1195753fac.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885084; x=1704489884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DOvF0AY7fePCXN1tebEvp8pAm4Tzy5l1IurRZ4G7S50=;
 b=eWAN8nYnA20J0T9XM41axANm8UuSAMqF/qdNqRPSgIZEmojg2X1nToKaOL2o2cXLK5
 162LqkSJxcYk/Lbk2yJLRYZt//rMobDKVTN8Fe3qeUjSeXQNoWLM8BhlrfqfWMBAik/B
 pAWPDtD+x38HvZeeoNM87gwkmOsd9Hon3AGMe4FrYH4YHZu0/AcecfWPlY0lgIs7cdhX
 UvfpksQGtok26SxXx6dCuvwxKMVhe/xO5G98U2odMADQLtbse2iKi2vZ327g73h8jvxh
 +bslHfa8vaFFWfLRR4+h+ExXqYRAeiW6pJQSLRF21xlmBBqbH83HLSAotzUamzhVBW9c
 x6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885084; x=1704489884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOvF0AY7fePCXN1tebEvp8pAm4Tzy5l1IurRZ4G7S50=;
 b=IZSOssp8L+IETWMZ5saCTlamj+uHyZRUhoDENC617RJ+5kZtIPSBqFHWIkmOM5Rbh5
 +bxXpp4yzi54gq+DkQH0AhAd9OwCZPnE0O2oMoRXwve2uIqYRQTnDXRYCBleKggKwCfJ
 C7ZOCGp6TTsZPKn+dx0CZkFKiP2L47Y1aICBSU3gGhW5+MDUPQ741YRotH4bW7Bho2Ta
 rDTfje+u6nWkvAT/wRL8JPI0/zGzDHjUonbtwzvmAho8g5nRgFFFOuBjzKzYjBemkCrI
 FLlpAJywpHuDxSamlQUgljfMGnJOVpx0rK9HNWN8Yqt860E4ci62fAr20dKP3O92wpob
 fSQw==
X-Gm-Message-State: AOJu0YyVRScj/mNakeHP0iKQgx6hjhMSfpglHI5NWRcdsyG5Yga8deTJ
 5+QjTQurNKkatzwR7/NCjuHAySR+Ogvab4HelUyJFmoXS+McAg==
X-Google-Smtp-Source: AGHT+IFkVhAFfpP+NGG0u6RRrQiNkqnDOfnfxgS2ZDrsVMxCPF155m7D0TSgoWOqmMSDcjVXFe3qNQ==
X-Received: by 2002:a05:6870:c0cf:b0:1fb:75c:3ff0 with SMTP id
 e15-20020a056870c0cf00b001fb075c3ff0mr14672724oad.80.1703885084153; 
 Fri, 29 Dec 2023 13:24:44 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/71] hw/acpi: Constify VMState
Date: Sat, 30 Dec 2023 08:22:56 +1100
Message-Id: <20231229212346.147149-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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
Message-Id: <20231221031652.119827-22-richard.henderson@linaro.org>
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
index ba751dc60e..b2f1b13630 100644
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


