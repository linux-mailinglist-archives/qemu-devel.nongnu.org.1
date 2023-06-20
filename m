Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E0737558
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:49:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIq-0000SU-9y; Tue, 20 Jun 2023 15:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7S-0004D0-KX
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:19 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7B-0006aX-Mt
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:03 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b597fd6bc8so659920a34.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281960; x=1689873960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=salVN4/DwfM12DBpbogZGFIHGYUuCVTErT2SvlIft0k=;
 b=Npq/CriQstxHUhO/i5mR5+HGoDQNPQzbcY9pWCUOt6XZxM3ZfkAirPjDbaN6bhBFqz
 0B57bAb8TWqmKG2fVE0TEncN2U8WdI67hI6wLsMwIXL1x7wvlXAq2dNk3aYsmCIUzb8F
 XQN1JXvtNMmFehEicfBmmwVUINHP3UdMhytnfMepedzsKGcW7eKA2AQQpNKIrzNgKbIV
 TxasJg/QNt1+ePkwwhODNk8wDVDcvNU1xUaC5d43F89RdP3a96XjQFhtP4yzLOcV5z7w
 5Fl5kyD/dNjoGxI/sfOTcrzdgrHQjzt8B5REFZ+KQ6Rqt1CSQZac5Z3EFDe0iVJjAPu0
 32Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281960; x=1689873960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=salVN4/DwfM12DBpbogZGFIHGYUuCVTErT2SvlIft0k=;
 b=EzK3HwDTY49bvL+mcT5Rsc5Ya1M2S7A4eqOt6TeLrx/rrk8xWl8+EVakKwWa51DUwH
 e+nLJli8/q1LomE+QedxnzllIFGwRFhKa6eJ8jC+9yKTh+/8lpnXOuxo6BdahUDhU/gZ
 FvcH9H5cvTdUcKASPzqWzjVJoE+hrwfHipwVcqpK1D+PNhpPhydiFiSJJglNZmHw9eII
 YCe3wQQyaUb7ygi5GKBqlR/zWyDYsjKVwIHzri0YKX6yq4qdTEVeoMtcn1i/GEWCY332
 X3J1BUKdQLmw0M6nRX1DQg7w7/b1LETmArZAgpeq03enrDypNwETiAciLWaNT3S/QMgM
 eIEg==
X-Gm-Message-State: AC+VfDyDhzvJZB7pbSsdWUQWKawo7zxqG2axvW05ASq0XPziMhAADhO9
 KDlz3M/zexQqLDrjR+uR87HKCqQGoCYaqw==
X-Google-Smtp-Source: ACHHUZ77nN0ksHRtMX5b4gsTJcyM0fnyBlToU62+FIET+BcL7Oc2T0GrXQc+TYltsjJ/0F5bObH8UA==
X-Received: by 2002:a05:6358:9fa9:b0:129:c9f4:a716 with SMTP id
 fy41-20020a0563589fa900b00129c9f4a716mr3820592rwb.30.1687281959749; 
 Tue, 20 Jun 2023 10:25:59 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.25.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:25:59 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v1 03/23] q35/acpi/xen: Provide ACPI PCI hotplug interface for
 Xen on Q35
Date: Tue, 20 Jun 2023 13:24:37 -0400
Message-Id: <5e066d5cfb355656a8704f4d07ba697507613568.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=jupham125@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:54 -0400
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

This patch allows to use ACPI PCI hotplug functionality for Xen on Q35.
All added code depends on xen_enabled(), so no functionality change for
non-Xen usage.

We need to call the acpi_set_pci_info function from ich9_pm_init as well,
so it was made globally visible again (as it was before).

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/acpi/ich9.c          | 10 ++++++++++
 hw/acpi/pcihp.c         |  2 +-
 include/hw/acpi/pcihp.h |  2 ++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/ich9.c b/hw/acpi/ich9.c
index 25e2c7243e..1c236be1c7 100644
--- a/hw/acpi/ich9.c
+++ b/hw/acpi/ich9.c
@@ -39,6 +39,8 @@
 #include "hw/southbridge/ich9.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/xen/xen.h"
+#include "sysemu/xen.h"
 
 //#define DEBUG
 
@@ -67,6 +69,10 @@ static void ich9_gpe_writeb(void *opaque, hwaddr addr, uint64_t val,
     ICH9LPCPMRegs *pm = opaque;
     acpi_gpe_ioport_writeb(&pm->acpi_regs, addr, val);
     acpi_update_sci(&pm->acpi_regs, pm->irq);
+
+    if (xen_enabled()) {
+        acpi_pcihp_reset(&pm->acpi_pci_hotplug);
+    }
 }
 
 static const MemoryRegionOps ich9_gpe_ops = {
@@ -332,6 +338,10 @@ void ich9_pm_init(PCIDevice *lpc_pci, ICH9LPCPMRegs *pm, qemu_irq sci_irq)
     pm->powerdown_notifier.notify = pm_powerdown_req;
     qemu_register_powerdown_notifier(&pm->powerdown_notifier);
 
+    if (xen_enabled()) {
+            acpi_set_pci_info(true);
+    }
+
     legacy_acpi_cpu_hotplug_init(pci_address_space_io(lpc_pci),
         OBJECT(lpc_pci), &pm->gpe_cpu, ICH9_CPU_HOTPLUG_IO_BASE);
 
diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
index f4e39d7a9c..5b065d670c 100644
--- a/hw/acpi/pcihp.c
+++ b/hw/acpi/pcihp.c
@@ -99,7 +99,7 @@ static void *acpi_set_bsel(PCIBus *bus, void *opaque)
     return info;
 }
 
-static void acpi_set_pci_info(bool has_bridge_hotplug)
+void acpi_set_pci_info(bool has_bridge_hotplug)
 {
     static bool bsel_is_set;
     Object *host = acpi_get_i386_pci_host();
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ef59810c17..d35a517c9e 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -72,6 +72,8 @@ void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
 /* Called on reset */
 void acpi_pcihp_reset(AcpiPciHpState *s);
 
+void acpi_set_pci_info(bool has_bridge_hotplug);
+
 void build_append_pcihp_slots(Aml *parent_scope, PCIBus *bus);
 
 extern const VMStateDescription vmstate_acpi_pcihp_pci_status;
-- 
2.34.1


