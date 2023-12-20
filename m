Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FFD819B89
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt4u-0002Su-KJ; Wed, 20 Dec 2023 04:41:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4n-0002S3-Ey
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt4l-0005gr-CO
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AWHmYzEswJm1Xpxp/38vTBU78Y2WoW+XkHR936aq36U=;
 b=f1ZeQ0tayzmE1gtrNWhwSO8JrKqEq6oJtJAuf4q0Brep/y7XPuYSdnbXnx5KV5cBpzFEM3
 nFdfQ1ZD0srcfsMZc50DVgVQJO8kHuDTNI6G0sfvETnlUOP2RV6LBtR1aJ2KgLjTcKzTjx
 pXV/vK/mZY57jSVqVAoaMYMunBkwdus=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-WNrQw5WSPkOIkNRE11QLxA-1; Wed, 20 Dec 2023 04:41:10 -0500
X-MC-Unique: WNrQw5WSPkOIkNRE11QLxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D1D863062;
 Wed, 20 Dec 2023 09:41:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDD122166B31;
 Wed, 20 Dec 2023 09:41:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Gavin Shan <gshan@redhat.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 01/19] hw: Add compat machines for 9.0
Date: Wed, 20 Dec 2023 10:40:47 +0100
Message-ID: <20231220094105.6588-2-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Cornelia Huck <cohuck@redhat.com>

Add 9.0 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20231120094259.1191804-1-cohuck@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Acked-by: Eric Farman <farman@linux.ibm.com>  # s390x
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 17 ++++++++++++++---
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 80 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index da85f86efb..8af165f4dc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -419,6 +419,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_8_2[];
+extern const size_t hw_compat_8_2_len;
+
 extern GlobalProperty hw_compat_8_1[];
 extern const size_t hw_compat_8_1_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a10ceeabbf..916af29f7c 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -210,6 +210,9 @@ void pc_madt_cpu_entry(int uid, const CPUArchIdList *apic_ids,
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_8_2[];
+extern const size_t pc_compat_8_2_len;
+
 extern GlobalProperty pc_compat_8_1[];
 extern const size_t pc_compat_8_1_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index be2856c018..efd503d45e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3180,10 +3180,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_9_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(9, 0)
+
 static void virt_machine_8_2_options(MachineClass *mc)
 {
+    virt_machine_9_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(8, 2)
+DEFINE_VIRT_MACHINE(8, 2)
 
 static void virt_machine_8_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0c17398141..2699bcba53 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -32,6 +32,9 @@
 #include "hw/virtio/virtio-net.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_8_2[] = {};
+const size_t hw_compat_8_2_len = G_N_ELEMENTS(hw_compat_8_2);
+
 GlobalProperty hw_compat_8_1[] = {
     { TYPE_PCI_BRIDGE, "x-pci-express-writeable-slt-bug", "true" },
     { "ramfb", "x-migrate", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 29b9964733..496498df3a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_8_2[] = {};
+const size_t pc_compat_8_2_len = G_N_ELEMENTS(pc_compat_8_2);
+
 GlobalProperty pc_compat_8_1[] = {};
 const size_t pc_compat_8_1_len = G_N_ELEMENTS(pc_compat_8_1);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index eace854335..042c13cdbc 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -545,13 +545,26 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_8_2_machine_options(MachineClass *m)
+static void pc_i440fx_9_0_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
+DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0", NULL,
+                      pc_i440fx_9_0_machine_options);
+
+static void pc_i440fx_8_2_machine_options(MachineClass *m)
+{
+    pc_i440fx_9_0_machine_options(m);
+    m->alias = NULL;
+    m->is_default = false;
+
+    compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+}
+
 DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2", NULL,
                       pc_i440fx_8_2_machine_options);
 
@@ -560,8 +573,6 @@ static void pc_i440fx_8_1_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     pc_i440fx_8_2_machine_options(m);
-    m->alias = NULL;
-    m->is_default = false;
     pcmc->broken_32bit_mem_addr_check = true;
 
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4f3e5412f6..f43d5142b8 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -383,12 +383,23 @@ static void pc_q35_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
 }
 
-static void pc_q35_8_2_machine_options(MachineClass *m)
+static void pc_q35_9_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
+DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
+                   pc_q35_9_0_machine_options);
+
+static void pc_q35_8_2_machine_options(MachineClass *m)
+{
+    pc_q35_9_0_machine_options(m);
+    m->alias = NULL;
+    compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
+    compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
+}
+
 DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
                    pc_q35_8_2_machine_options);
 
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 2e49e262ee..e2792ef46d 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -346,10 +346,17 @@ type_init(virt_machine_register_types)
     } \
     type_init(machvirt_machine_##major##_##minor##_init);
 
+static void virt_machine_9_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE(9, 0, true)
+
 static void virt_machine_8_2_options(MachineClass *mc)
 {
+    virt_machine_9_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_VIRT_MACHINE(8, 2, true)
+DEFINE_VIRT_MACHINE(8, 2, false)
 
 static void virt_machine_8_1_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index df09aa9d6a..9b6c1c129f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4785,15 +4785,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
     }                                                                \
     type_init(spapr_machine_register_##suffix)
 
+/*
+ * pseries-9.0
+ */
+static void spapr_machine_9_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(9_0, "9.0", true);
+
 /*
  * pseries-8.2
  */
 static void spapr_machine_8_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_9_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
 
-DEFINE_SPAPR_MACHINE(8_2, "8.2", true);
+DEFINE_SPAPR_MACHINE(8_2, "8.2", false);
 
 /*
  * pseries-8.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7262725d2e..1169e20b94 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -855,14 +855,26 @@ bool css_migration_enabled(void)
     }                                                                         \
     type_init(ccw_machine_register_##suffix)
 
+static void ccw_machine_9_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_9_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(9_0, "9.0", true);
+
 static void ccw_machine_8_2_instance_options(MachineState *machine)
 {
+    ccw_machine_9_0_instance_options(machine);
 }
 
 static void ccw_machine_8_2_class_options(MachineClass *mc)
 {
+    ccw_machine_9_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_8_2, hw_compat_8_2_len);
 }
-DEFINE_CCW_MACHINE(8_2, "8.2", true);
+DEFINE_CCW_MACHINE(8_2, "8.2", false);
 
 static void ccw_machine_8_1_instance_options(MachineState *machine)
 {
-- 
2.43.0


