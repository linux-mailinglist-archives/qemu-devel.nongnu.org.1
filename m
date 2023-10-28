Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C454A7DA617
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 11:17:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwfQm-0004bc-Vd; Sat, 28 Oct 2023 05:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQe-0004YM-TA
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1qwfQd-0007Lh-1l
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 05:16:24 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so8181705a12.1
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698484581; x=1699089381; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u5GMr+5sSi8Dki015LfIdiYa+ARvYPPeJg2I3MJ1Pjw=;
 b=FnAS98+OImNnNEaqfzBPWy00yGBPKl+8tsPPq0aZQo3gxpF+7oaUTc8o9qaFHsNPqP
 co5teYMDIp5eTuMsEYv89M4g+MV8bSXPW1ZEmYf9Ibz5ZQn0Puh++hhK8LnJl/8RnULE
 WSkdFsqdWG6rdydgZHJzaE2fb7Gkl9K5hMmVskAAL0/H3SMFCRaCzmGKLrcVDkKjtpsa
 QO+AUoOEUFmV1PDrg37s/v9ZSU38Lp3Pi/sLwr4GZ1/OGyCwFrkQia4CN0JsmIMVJ8eS
 H7+bPIgWkKNlfbgR0p8Rx1ZZnRa80/lGKIGHzl0pjS3mwcsONR6pW+J7jABfZm9Ukhy0
 rWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698484581; x=1699089381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u5GMr+5sSi8Dki015LfIdiYa+ARvYPPeJg2I3MJ1Pjw=;
 b=dXMTuXvhlmMXNxFtebr0nvPkLrEfXkKs4EnhEiP68CxRlhr35cEVvZo5gTT0IZfrJy
 MgGf9dWacuAkmzLCH2gTqIJDXM79qJX8/Uf3ZU8IuFjnynud2MqAgLB3qqyTZBaeEd18
 ZLVo4WC9EzNrZiwpcj47AHQFyQlwHaOClyacRRgibJn9aZknHabeF0HmwZjcj+pV/SL/
 Ly5pNLoX9WYQcceqbPThFK7IrlAWM2kGRjYMHShvdj4QTVoiwL5Gwh9T3sxuNJYmaA/J
 1mYf/3jgM2hnAJ8TFDIlBBTzOotQZ6MOTQPPp4Iz0IyytPSFE7sJFRmWUSjfgDmCrBDY
 ZkyQ==
X-Gm-Message-State: AOJu0YzGBlTsTSYI2BHDubT96G81s0pCc9asEKlJyQdMvLTSE5rmAT+O
 9z//5xQ53RNP+qaNdq9zCh1TSgShYTc=
X-Google-Smtp-Source: AGHT+IFWVpQ+i6sO+Y7sTRNaLE+gRJaGs+Tv4y+kp7zK42hVPnWOHHEVpP6m2wEUbIPkvGZxkrKFpw==
X-Received: by 2002:a50:cc49:0:b0:52c:f73:3567 with SMTP id
 n9-20020a50cc49000000b0052c0f733567mr8037582edi.13.1698484580702; 
 Sat, 28 Oct 2023 02:16:20 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-089-012-044-170.89.12.pool.telefonica.de. [89.12.44.170])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a50c357000000b00542df4a03d0sm571444edb.16.2023.10.28.02.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 02:16:19 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 5/5] hw/isa/vt82c686: Implement software-based SMI
 triggering
Date: Sat, 28 Oct 2023 11:16:06 +0200
Message-ID: <20231028091606.23700-6-shentey@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231028091606.23700-1-shentey@gmail.com>
References: <20231028091606.23700-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
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

If enabled, SMIs can be triggered via software by writing to an IO-mapped port.
SMIs usually trigger execution of BIOS code. If appropriate values are written
to the port, the BIOS transitions the system into or out of ACPI mode.

Note that APMState implements Intel-specific behavior where there are two IO
ports which are mapped at fixed addresses. In VIA, there is only one such port
which is located inside a relocatable IO-mapped region. Hence, there is no point
in reusing APMState.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/isa/vt82c686.c | 95 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index e8ec63dea9..361b3bed0a 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -27,7 +27,6 @@
 #include "hw/timer/i8254.h"
 #include "hw/rtc/mc146818rtc.h"
 #include "migration/vmstate.h"
-#include "hw/isa/apm.h"
 #include "hw/acpi/acpi.h"
 #include "hw/i2c/pm_smbus.h"
 #include "qapi/error.h"
@@ -42,6 +41,16 @@
 #define TYPE_VIA_PM "via-pm"
 OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
 
+#define VIA_PM_IO_GBLEN 0x2a
+#define VIA_PM_IO_GBLEN_SW_SMI_EN (1 << 6)
+
+#define VIA_PM_IO_GBLCTL 0x2c
+#define VIA_PM_IO_GBLCTL_SMI_EN 1
+#define VIA_PM_IO_GBLCTL_SMIIG (1 << 4)
+#define VIA_PM_IO_GBLCTL_INSMI (1 << 8)
+
+#define VIA_PM_IO_SMI_CMD 0x2f
+
 #define VIA_PM_GPE_LEN 4
 
 #define VIA_PM_SCI_SELECT_OFS 0x42
@@ -49,14 +58,19 @@ OBJECT_DECLARE_SIMPLE_TYPE(ViaPMState, VIA_PM)
 
 struct ViaPMState {
     PCIDevice dev;
+
     MemoryRegion io;
     ACPIREGS ar;
-    APMState apm;
+    uint16_t gbl_en;
+    uint16_t gbl_ctl;
+    uint8_t smi_cmd;
+
     PMSMBus smb;
 
     Notifier powerdown_notifier;
 
     qemu_irq sci_irq;
+    qemu_irq smi_irq;
 };
 
 static void pm_io_space_update(ViaPMState *s)
@@ -90,7 +104,7 @@ static int vmstate_acpi_post_load(void *opaque, int version_id)
 
 static const VMStateDescription vmstate_acpi = {
     .name = "vt82c686b_pm",
-    .version_id = 1,
+    .version_id = 2,
     .minimum_version_id = 1,
     .post_load = vmstate_acpi_post_load,
     .fields = (VMStateField[]) {
@@ -98,9 +112,11 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_UINT16(ar.pm1.evt.sts, ViaPMState),
         VMSTATE_UINT16(ar.pm1.evt.en, ViaPMState),
         VMSTATE_UINT16(ar.pm1.cnt.cnt, ViaPMState),
-        VMSTATE_STRUCT(apm, ViaPMState, 0, vmstate_apm, APMState),
         VMSTATE_TIMER_PTR(ar.tmr.timer, ViaPMState),
         VMSTATE_INT64(ar.tmr.overflow_time, ViaPMState),
+        VMSTATE_UINT16(gbl_en, ViaPMState),
+        VMSTATE_UINT16(gbl_ctl, ViaPMState),
+        VMSTATE_UINT8(smi_cmd, ViaPMState),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -128,15 +144,75 @@ static void pm_write_config(PCIDevice *d, uint32_t addr, uint32_t val, int len)
     }
 }
 
+static void via_pm_apm_ctrl_changed(ViaPMState *s, uint8_t val)
+{
+    s->smi_cmd = val;
+
+    if (s->gbl_en & VIA_PM_IO_GBLEN_SW_SMI_EN
+        && s->gbl_ctl & VIA_PM_IO_GBLCTL_SMI_EN
+        && !(s->gbl_ctl & VIA_PM_IO_GBLCTL_SMIIG
+             && s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI)) {
+        s->gbl_ctl |= VIA_PM_IO_GBLCTL_INSMI;
+
+        if (s->smi_irq) {
+            qemu_irq_raise(s->smi_irq);
+        }
+    }
+}
+
 static void pm_io_write(void *op, hwaddr addr, uint64_t data, unsigned size)
 {
+    ViaPMState *s = op;
+
     trace_via_pm_io_write(addr, data, size);
+
+    switch (addr) {
+    case VIA_PM_IO_GBLEN:
+        s->gbl_en = (s->gbl_en & 0xff00) | data;
+        break;
+    case VIA_PM_IO_GBLEN + 1:
+        s->gbl_en = (s->gbl_en & 0x00ff) | (data << 8);
+        break;
+    case VIA_PM_IO_GBLCTL:
+        s->gbl_ctl = (s->gbl_ctl & 0xff00) | data;
+        break;
+    case VIA_PM_IO_GBLCTL + 1:
+        data <<= 8;
+        data &= ~(s->gbl_ctl & VIA_PM_IO_GBLCTL_INSMI);
+        s->gbl_ctl = (s->gbl_ctl & 0x00ff) | data;
+        break;
+    case VIA_PM_IO_SMI_CMD:
+        via_pm_apm_ctrl_changed(s, data);
+        break;
+    }
 }
 
 static uint64_t pm_io_read(void *op, hwaddr addr, unsigned size)
 {
-    trace_via_pm_io_read(addr, 0, size);
-    return 0;
+    ViaPMState *s = op;
+    uint64_t data = 0;
+
+    switch (addr) {
+    case VIA_PM_IO_GBLEN:
+        data = s->gbl_en & 0xff;
+        break;
+    case VIA_PM_IO_GBLEN + 1:
+        data = s->gbl_en >> 8;
+        break;
+    case VIA_PM_IO_GBLCTL:
+        data = s->gbl_ctl & 0xff;
+        break;
+    case VIA_PM_IO_GBLCTL + 1:
+        data = (s->gbl_ctl >> 8) & 0xd;
+        break;
+    case VIA_PM_IO_SMI_CMD:
+        data = s->smi_cmd;
+        break;
+    }
+
+    trace_via_pm_io_read(addr, data, size);
+
+    return data;
 }
 
 static const MemoryRegionOps pm_io_ops = {
@@ -166,6 +242,10 @@ static void via_pm_reset(DeviceState *d)
     /* SMBus IO base */
     pci_set_long(s->dev.config + 0x90, 1);
 
+    s->gbl_en = 0;
+    s->gbl_ctl = VIA_PM_IO_GBLCTL_SMIIG;
+    s->smi_cmd = 0;
+
     acpi_pm1_evt_reset(&s->ar);
     acpi_pm1_cnt_reset(&s->ar);
     acpi_pm_tmr_reset(&s->ar);
@@ -194,8 +274,6 @@ static void via_pm_realize(PCIDevice *dev, Error **errp)
     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->smb.io);
     memory_region_set_enabled(&s->smb.io, false);
 
-    apm_init(dev, &s->apm, NULL, s);
-
     memory_region_init_io(&s->io, OBJECT(dev), &pm_io_ops, s, "via-pm", 128);
     memory_region_add_subregion(pci_address_space_io(dev), 0, &s->io);
     memory_region_set_enabled(&s->io, false);
@@ -214,6 +292,7 @@ static void via_pm_init(Object *obj)
     ViaPMState *s = VIA_PM(obj);
 
     qdev_init_gpio_out_named(DEVICE(obj), &s->sci_irq, "sci", 1);
+    qdev_init_gpio_out_named(DEVICE(obj), &s->smi_irq, "smi-irq", 1);
 }
 
 typedef struct via_pm_init_info {
-- 
2.42.0


