Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEEA7B9A57
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 05:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoFHz-0006CT-Fw; Wed, 04 Oct 2023 23:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHu-00063V-Rg
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoFHt-0000Im-07
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 23:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696477472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twDnxCIZ4gi16W+P0IcrGb7JEdH581l09+veM2VEhWI=;
 b=gnPGvwXB3ury0H95Cb2WWNBaORF3bX944sIHiutJ3xbL58eRQlY1CfMnSAskauoAYQtUaW
 +uWb7VbBBERyQcM0NFiDe5QeV93ButZ8LYKFC/IpHShyn2IilWTyeXYxIazd4A+EM1SpMj
 PffNnzkSBgxATbnyalAwIhldNiJqFQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-GIh3zxCbMo69qXWQeTB-kg-1; Wed, 04 Oct 2023 23:44:20 -0400
X-MC-Unique: GIh3zxCbMo69qXWQeTB-kg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso410420f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 20:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696477459; x=1697082259;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=twDnxCIZ4gi16W+P0IcrGb7JEdH581l09+veM2VEhWI=;
 b=pghG4s1/LAZ54p4mjOxQ/MHkXrPzXAabKyuXn+E+Zo9TXSLtBksW1+VKSGCiz75KS6
 q0Qz9HMk7v/I7H4/REM0Lz6kw9sfs54IwNrUrtsXBrarqW9GoyPbtmnwYco/02Hz7ycx
 dPeObsbJLZut3K0UnWltCf5c3B98pz2G+0KNrCTznDaGA19c8zGqyMnClQ5LUpKmXdnG
 ae985J7AB7Zu2uisjZO74hWkIaR8yBGk6glaPu2kl83qnZThLmcqSgpgxmnIbjPVmz0U
 lxdvF8d8Hv2V7ET5Hrov0/4Xv96zpIUeGTLAeIYR+QgYZYTwmcdBtyignflCzD5HNMFD
 M7WA==
X-Gm-Message-State: AOJu0Yy0QGt4o7C50WdRlh8cd9qAtUer3ZCW3/UBgUWL3IEKAT48UNZ3
 KV7U0S2wf4D3yvJ1mqs7S96rLli7RkezlSPK8oV/l1uPN2nLLImjhiuudEOmXyPY4BBFSYLal+M
 6Up6h3YjPdX+xpmd1nBFaQxs8+oGQ0yWk4jZ8L1NQWozIkb8R35GsESx3O1GqIWOBAVaQ
X-Received: by 2002:a5d:4b11:0:b0:31f:ecb2:1bed with SMTP id
 v17-20020a5d4b11000000b0031fecb21bedmr3921944wrq.15.1696477459201; 
 Wed, 04 Oct 2023 20:44:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHc/rkCUq2U7Xy2UyZcVw/gmmHEZpa+WgG4TKbw8mrmyM5l/vDeMi5GqrjL4XWm6WwrAI8YvQ==
X-Received: by 2002:a5d:4b11:0:b0:31f:ecb2:1bed with SMTP id
 v17-20020a5d4b11000000b0031fecb21bedmr3921927wrq.15.1696477458857; 
 Wed, 04 Oct 2023 20:44:18 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 k12-20020a5d628c000000b003233a31a467sm635337wru.34.2023.10.04.20.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 20:44:18 -0700 (PDT)
Date: Wed, 4 Oct 2023 23:44:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL v2 27/53] hw/acpi/acpi_dev_interface: Remove now unused
 madt_cpu virtual method
Message-ID: <c461f3e3820f2a033e7eed08689060328b31dcbf.1696477105.git.mst@redhat.com>
References: <cover.1696477105.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1696477105.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

This virtual method was always set to the x86-specific pc_madt_cpu_entry(),
even in piix4 which is also used in MIPS. The previous changes use
pc_madt_cpu_entry() otherwise, so madt_cpu can be dropped.

Since pc_madt_cpu_entry() is now only used in x86-specific code, the stub
in hw/acpi/acpi-x86-stub can be removed as well.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230908084234.17642-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/acpi_dev_interface.h | 2 --
 hw/acpi/acpi-x86-stub.c              | 6 ------
 hw/acpi/piix4.c                      | 2 --
 hw/i386/generic_event_device_x86.c   | 9 ---------
 hw/isa/lpc_ich9.c                    | 1 -
 5 files changed, 20 deletions(-)

diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index a1648220ff..ca92928124 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -52,7 +52,5 @@ struct AcpiDeviceIfClass {
     /* <public> */
     void (*ospm_status)(AcpiDeviceIf *adev, ACPIOSTInfoList ***list);
     void (*send_event)(AcpiDeviceIf *adev, AcpiEventStatusBits ev);
-    void (*madt_cpu)(int uid, const CPUArchIdList *apic_ids, GArray *entry,
-                     bool force_enabled);
 };
 #endif
diff --git a/hw/acpi/acpi-x86-stub.c b/hw/acpi/acpi-x86-stub.c
index d0d399d26b..9662a594ad 100644
--- a/hw/acpi/acpi-x86-stub.c
+++ b/hw/acpi/acpi-x86-stub.c
@@ -1,12 +1,6 @@
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/i386/acpi-build.h"
 
-void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
-                       GArray *entry, bool force_enabled)
-{
-}
-
 Object *acpi_get_i386_pci_host(void)
 {
        return NULL;
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 63d2113b86..a7892c444c 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -20,7 +20,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/i386/pc.h"
 #include "hw/irq.h"
 #include "hw/isa/apm.h"
 #include "hw/i2c/pm_smbus.h"
@@ -654,7 +653,6 @@ static void piix4_pm_class_init(ObjectClass *klass, void *data)
     hc->is_hotpluggable_bus = piix4_is_hotpluggable_bus;
     adevc->ospm_status = piix4_ospm_status;
     adevc->send_event = piix4_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
 }
 
 static const TypeInfo piix4_pm_info = {
diff --git a/hw/i386/generic_event_device_x86.c b/hw/i386/generic_event_device_x86.c
index e26fb02a2e..8fc233e1f1 100644
--- a/hw/i386/generic_event_device_x86.c
+++ b/hw/i386/generic_event_device_x86.c
@@ -8,19 +8,10 @@
 
 #include "qemu/osdep.h"
 #include "hw/acpi/generic_event_device.h"
-#include "hw/i386/pc.h"
-
-static void acpi_ged_x86_class_init(ObjectClass *class, void *data)
-{
-    AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_CLASS(class);
-
-    adevc->madt_cpu = pc_madt_cpu_entry;
-}
 
 static const TypeInfo acpi_ged_x86_info = {
     .name          = TYPE_ACPI_GED_X86,
     .parent        = TYPE_ACPI_GED,
-    .class_init    = acpi_ged_x86_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index bce487ac4e..3f59980aa0 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -891,7 +891,6 @@ static void ich9_lpc_class_init(ObjectClass *klass, void *data)
     hc->is_hotpluggable_bus = ich9_pm_is_hotpluggable_bus;
     adevc->ospm_status = ich9_pm_ospm_status;
     adevc->send_event = ich9_send_gpe;
-    adevc->madt_cpu = pc_madt_cpu_entry;
     amldevc->build_dev_aml = build_ich9_isa_aml;
 }
 
-- 
MST


