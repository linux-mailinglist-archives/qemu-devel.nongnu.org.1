Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF275A98142
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 09:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfL-0003Ca-4z; Wed, 23 Apr 2025 03:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uez-00039S-L1
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uex-0003Du-D8
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cl21NGghQLqZCX6woUJ4ZBCPtjaIbo7EPrRB3h/znF4=;
 b=K8qOH6eBevfCVLS2Aj4fpLUsXR2nu7q5agvCoWaqX1NF5/o1WMcCko7N2NZffkB6ZM7G4b
 fddRv1nUqUOxZl8Tn/qL837pmXXkAVng55n3hDcyP3J/34QqatSXl9GYdje1dMj+48drpd
 ySBgkEjxGvV3X5M6y3iArNhD/uASiuk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-Ins2K6-2OWuL0x6uhnhQZQ-1; Wed,
 23 Apr 2025 03:36:37 -0400
X-MC-Unique: Ins2K6-2OWuL0x6uhnhQZQ-1
X-Mimecast-MFC-AGG-ID: Ins2K6-2OWuL0x6uhnhQZQ_1745393796
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64BD51800263; Wed, 23 Apr 2025 07:36:36 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEB0D19560A3; Wed, 23 Apr 2025 07:36:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PULL 09/29] hw: add compat machines for 10.1
Date: Wed, 23 Apr 2025 09:35:49 +0200
Message-ID: <20250423073610.271585-10-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add 10.1 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250414094543.221241-1-cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f22b2e7fc75..bfe8643a27a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -761,6 +761,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_10_0[];
+extern const size_t hw_compat_10_0_len;
+
 extern GlobalProperty hw_compat_9_2[];
 extern const size_t hw_compat_9_2_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 103b54301f8..8677dc8950b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -215,6 +215,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_10_0[];
+extern const size_t pc_compat_10_0_len;
+
 extern GlobalProperty pc_compat_9_2[];
 extern const size_t pc_compat_9_2_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a96452f17a4..3e72adaa918 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3408,10 +3408,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_10_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+
 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    virt_machine_10_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)
+DEFINE_VIRT_MACHINE(10, 0)
 
 static void virt_machine_9_2_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63c6ef93d29..abfcedd4a5f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_10_0[] = {};
+const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
+
 GlobalProperty hw_compat_9_2[] = {
     {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
     { "virtio-balloon-pci", "vectors", "0" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 01d0581f62a..1b5d55e96d5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_10_0[] = {};
+const size_t pc_compat_10_0_len = G_N_ELEMENTS(pc_compat_10_0);
+
 GlobalProperty pc_compat_9_2[] = {};
 const size_t pc_compat_9_2_len = G_N_ELEMENTS(pc_compat_9_2);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6c91e2d2929..dbb59df64f7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -479,12 +479,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_machine_10_0_options(MachineClass *m)
+static void pc_i440fx_machine_10_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(10, 0);
+DEFINE_I440FX_MACHINE_AS_LATEST(10, 1);
+
+static void pc_i440fx_machine_10_0_options(MachineClass *m)
+{
+    pc_i440fx_machine_10_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    compat_props_add(m->compat_props, pc_compat_10_0, pc_compat_10_0_len);
+}
+
+DEFINE_I440FX_MACHINE(10, 0);
 
 static void pc_i440fx_machine_9_2_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index fd96d0345c7..c538b3d05b4 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -361,12 +361,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_10_0_options(MachineClass *m)
+static void pc_q35_machine_10_1_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(10, 0);
+DEFINE_Q35_MACHINE_AS_LATEST(10, 1);
+
+static void pc_q35_machine_10_0_options(MachineClass *m)
+{
+    pc_q35_machine_10_1_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_0, hw_compat_10_0_len);
+    compat_props_add(m->compat_props, pc_compat_10_0, pc_compat_10_0_len);
+}
+
+DEFINE_Q35_MACHINE(10, 0);
 
 static void pc_q35_machine_9_2_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index d967bdd7438..295a614e161 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -366,10 +366,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_10_1_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+
 static void virt_machine_10_0_options(MachineClass *mc)
 {
+    virt_machine_10_1_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 0)
+DEFINE_VIRT_MACHINE(10, 0)
 
 static void virt_machine_9_2_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b0a0f8c6895..6fef1d167ae 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4766,15 +4766,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-10.1
+ */
+static void spapr_machine_10_1_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(10, 1);
+
 /*
  * pseries-10.0
  */
 static void spapr_machine_10_0_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_10_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(10, 0);
+DEFINE_SPAPR_MACHINE(10, 0);
 
 /*
  * pseries-9.2
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 910dab08319..5af3c4f547a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -924,14 +924,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_10_1_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_10_1_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(10, 1);
+
 static void ccw_machine_10_0_instance_options(MachineState *machine)
 {
+    ccw_machine_10_1_instance_options(machine);
 }
 
 static void ccw_machine_10_0_class_options(MachineClass *mc)
 {
+    ccw_machine_10_1_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_0, hw_compat_10_0_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(10, 0);
+DEFINE_CCW_MACHINE(10, 0);
 
 static void ccw_machine_9_2_instance_options(MachineState *machine)
 {
-- 
2.49.0


