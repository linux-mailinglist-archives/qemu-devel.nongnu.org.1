Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37410785732
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 13:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYmJM-0001VU-8y; Wed, 23 Aug 2023 07:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJF-0001Tf-R0
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:46:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qYmJ7-0001OG-T7
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 07:45:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692791152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J3Nck2u3A4F4LecG/luR7cDRcfzib6aECdxmdEZ2d5Q=;
 b=R4HBIYtYjzWnwRiKwiFtsN0HjRaR0xRtl/5T1niX/JSoOXwYih4UhCXe4+IJd6SthEY+f4
 P+3DoeQc6ug7olsIjB1RxMoE5TJsP6gE3SmJkgoF56MBxQe9pQOcfNGeYQ8hob6FdfMuqx
 mIhvwqWp9xYL7YxLzzxG/tyD38s2JmU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-re_27quVOTOW5FOAAqvJlw-1; Wed, 23 Aug 2023 07:45:49 -0400
X-MC-Unique: re_27quVOTOW5FOAAqvJlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C671853061;
 Wed, 23 Aug 2023 11:45:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B63C0C15BAE;
 Wed, 23 Aug 2023 11:45:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Laurent Vivier <laurent@vivier.eu>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 01/12] hw: Add compat machines for 8.2
Date: Wed, 23 Aug 2023 13:45:33 +0200
Message-Id: <20230823114544.216520-2-thuth@redhat.com>
In-Reply-To: <20230823114544.216520-1-thuth@redhat.com>
References: <20230823114544.216520-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Add 8.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20230718142235.135319-1-cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 16 +++++++++++++---
 hw/i386/pc_q35.c           | 14 ++++++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 79 insertions(+), 10 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ed83360198..3b541ffd24 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -390,6 +390,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_8_1[];
+extern const size_t hw_compat_8_1_len;
+
 extern GlobalProperty hw_compat_8_0[];
 extern const size_t hw_compat_8_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d54e8b1101..0fabece236 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -200,6 +200,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_8_1[];
+extern const size_t pc_compat_8_1_len;
+
 extern GlobalProperty pc_compat_8_0[];
 extern const size_t pc_compat_8_0_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 7d9dbc2663..2a560271b5 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3170,10 +3170,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_8_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(8, 2)
+
 static void virt_machine_8_1_options(MachineClass *mc)
 {
+    virt_machine_8_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(8, 1)
+DEFINE_VIRT_MACHINE(8, 1)
 
 static void virt_machine_8_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index f0d35c6401..da699cf4e1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-pci.h"
 
+GlobalProperty hw_compat_8_1[] = {};
+const size_t hw_compat_8_1_len = G_N_ELEMENTS(hw_compat_8_1);
+
 GlobalProperty hw_compat_8_0[] = {
     { "migration", "multifd-flush-after-each-section", "on"},
     { TYPE_PCI_DEVICE, "x-pcie-ari-nextfn-1", "on" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3109d5e0e0..54838c0c41 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -114,6 +114,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_8_1[] = {};
+const size_t pc_compat_8_1_len = G_N_ELEMENTS(pc_compat_8_1);
+
 GlobalProperty pc_compat_8_0[] = {
     { "virtio-mem", "unplugged-inaccessible", "auto" },
 };
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index ac72e8f5be..ce1ac95274 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -504,13 +504,25 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_i440fx_8_1_machine_options(MachineClass *m)
+static void pc_i440fx_8_2_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
+DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
+                      pc_i440fx_8_2_machine_options);
+
+static void pc_i440fx_8_1_machine_options(MachineClass *m)
+{
+    pc_i440fx_8_2_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+    compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
+    compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
+}
+
 DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1", NULL,
                       pc_i440fx_8_1_machine_options);
 
@@ -519,8 +531,6 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_8_1_machine_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index dc27a9e223..37c4814bed 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -379,12 +379,23 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_q35_8_1_machine_options(MachineClass *m)
+static void pc_q35_8_2_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
+                   pc_q35_8_2_machine_options);
+
+static void pc_q35_8_1_machine_options(MachineClass *m)
+{
+    pc_q35_8_2_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
+    compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
+}
+
 DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
                    pc_q35_8_1_machine_options);
 
@@ -393,7 +404,6 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_q35_8_1_machine_options(m);
-    m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index de91726cf9..2dd3c99894 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -347,10 +347,17 @@ type_init(virt_machine_register_types)
     } \
     type_init(machvirt_machine_##major##_##minor##_init);
 
+static void virt_machine_8_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE(8, 2, true)
+
 static void virt_machine_8_1_options(MachineClass *mc)
 {
+    virt_machine_8_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
-DEFINE_VIRT_MACHINE(8, 1, true)
+DEFINE_VIRT_MACHINE(8, 1, false)
 
 static void virt_machine_8_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1c8b8d57a7..622fea8256 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4752,15 +4752,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-8.2
+ */
+static void spapr_machine_8_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(8_2, "8.2", true);
+
 /*
  * pseries-8.1
  */
 static void spapr_machine_8_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_8_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_1, "8.1", true);
+DEFINE_SPAPR_MACHINE(8_1, "8.1", false);
 
 /*
  * pseries-8.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 4516d73ff5..c52a1fcf67 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -828,14 +828,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_8_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_8_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(8_2, "8.2", true);
+
 static void ccw_machine_8_1_instance_options(MachineState *machine)
 {
+    ccw_machine_8_2_instance_options(machine);
 }
 
 static void ccw_machine_8_1_class_options(MachineClass *mc)
 {
+    ccw_machine_8_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_1, hw_compat_8_1_len);
 }
-DEFINE_CCW_MACHINE(8_1, "8.1", true);
+DEFINE_CCW_MACHINE(8_1, "8.1", false);
 
 static void ccw_machine_8_0_instance_options(MachineState *machine)
 {
-- 
2.39.3


