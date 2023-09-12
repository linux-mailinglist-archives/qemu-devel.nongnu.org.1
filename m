Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779C79D064
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1lr-0004Hj-UY; Tue, 12 Sep 2023 07:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lm-0004Ek-UB
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lk-00034h-H5
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694518883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R+AXdugpygRqETZw9VM7gPmkfP77TivheukRBqVWdEU=;
 b=UkdZUMVlm/30eUE2ZZqmm+rFMrAGmBM87hYgEzjKQVD2QxO8sQtMEmzHNSjBHLo/K0NhbM
 GcC8C6j+cP4dI6Xr1fC241ujH5Sc1dqKCp0f1Ctz9zuzg/9+KKXk27kUhyPSM2suR7pa6U
 ol7QGb1fgOEDrlrHjI3/Vm+Ha6B552Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-WujEzt1vMPen8bLiGJwHSw-1; Tue, 12 Sep 2023 07:41:20 -0400
X-MC-Unique: WujEzt1vMPen8bLiGJwHSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AFF029AB412;
 Tue, 12 Sep 2023 11:41:20 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D2C31054FC0;
 Tue, 12 Sep 2023 11:41:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Steffen Eiden <seiden@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: [PULL 5/7] target/s390x: AP-passthrough for PV guests
Date: Tue, 12 Sep 2023 13:41:10 +0200
Message-ID: <20230912114112.296428-6-thuth@redhat.com>
In-Reply-To: <20230912114112.296428-1-thuth@redhat.com>
References: <20230912114112.296428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Steffen Eiden <seiden@linux.ibm.com>

Enabling AP-passthrough(AP-pt) for PV-guest by using the new CPU
features for PV-AP-pt of KVM.

As usual QEMU first checks which CPU features are available and then
sets them if available and selected by user. An additional check is done
to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
as well. Note that KVM itself does not enforce this restriction.

Reviewed-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Message-ID: <20230823142219.1046522-6-seiden@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/cpu_features.h         |  1 +
 target/s390x/cpu_features_def.h.inc |  4 ++
 target/s390x/cpu_models.c           |  2 +
 target/s390x/gen-features.c         |  2 +
 target/s390x/kvm/kvm.c              | 70 +++++++++++++++++++++++++++++
 5 files changed, 79 insertions(+)

diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 87463f064d..a9bd68a2e1 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -43,6 +43,7 @@ typedef enum {
     S390_FEAT_TYPE_KDSA,
     S390_FEAT_TYPE_SORTL,
     S390_FEAT_TYPE_DFLTCC,
+    S390_FEAT_TYPE_UV_FEAT_GUEST,
 } S390FeatType;
 
 /* Definition of a CPU feature */
diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index e3cfe63735..e68da9b8ff 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
 DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
 DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
 DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
+
+/* Features exposed via the UV-CALL instruction */
+DEF_FEAT(UV_FEAT_AP, "appv", UV_FEAT_GUEST, 4, "AP instructions installed for secure guests")
+DEF_FEAT(UV_FEAT_AP_INTR, "appvi", UV_FEAT_GUEST, 5, "AP instructions interruption support for secure guests")
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 91ce896491..98f14c09c2 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -483,6 +483,8 @@ static void check_consistency(const S390CPUModel *model)
         { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
         { S390_FEAT_NNPA, S390_FEAT_VECTOR },
         { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
+        { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
+        { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
     };
     int i;
 
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 1e3b7c0dc9..2b2bfc3736 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -576,6 +576,8 @@ static uint16_t full_GEN16_GA1[] = {
     S390_FEAT_RDP,
     S390_FEAT_PAI,
     S390_FEAT_PAIE,
+    S390_FEAT_UV_FEAT_AP,
+    S390_FEAT_UV_FEAT_AP_INTR,
 };
 
 
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index f034b06abc..bc5c56a305 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -2299,6 +2299,42 @@ static bool ap_enabled(const S390FeatBitmap features)
     return test_bit(S390_FEAT_AP, features);
 }
 
+static bool uv_feat_supported(void)
+{
+    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_MODEL,
+                             KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST);
+}
+
+static int query_uv_feat_guest(S390FeatBitmap features)
+{
+    struct kvm_s390_vm_cpu_uv_feat prop = {};
+    struct kvm_device_attr attr = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST,
+        .addr = (uint64_t) &prop,
+    };
+    int rc;
+
+    /* AP support check is currently the only user of the UV feature test */
+    if (!(uv_feat_supported() && ap_available())) {
+        return 0;
+    }
+
+    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
+    if (rc) {
+        return  rc;
+    }
+
+    if (prop.ap) {
+        set_bit(S390_FEAT_UV_FEAT_AP, features);
+    }
+    if (prop.ap_intr) {
+        set_bit(S390_FEAT_UV_FEAT_AP_INTR, features);
+    }
+
+    return 0;
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2493,11 +2529,38 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         set_bit(S390_FEAT_DIAG_318, model->features);
     }
 
+    /* Test for Ultravisor features that influence secure guest behavior */
+    query_uv_feat_guest(model->features);
+
     /* strip of features that are not part of the maximum model */
     bitmap_and(model->features, model->features, model->def->full_feat,
                S390_FEAT_MAX);
 }
 
+static int configure_uv_feat_guest(const S390FeatBitmap features)
+{
+    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
+    struct kvm_device_attr attribute = {
+        .group = KVM_S390_VM_CPU_MODEL,
+        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
+        .addr = (__u64) &uv_feat,
+    };
+
+    /* AP support check is currently the only user of the UV feature test */
+    if (!(uv_feat_supported() && ap_enabled(features))) {
+        return 0;
+    }
+
+    if (test_bit(S390_FEAT_UV_FEAT_AP, features)) {
+        uv_feat.ap = 1;
+    }
+    if (test_bit(S390_FEAT_UV_FEAT_AP_INTR, features)) {
+        uv_feat.ap_intr = 1;
+    }
+
+    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
+}
+
 static void kvm_s390_configure_apie(bool interpret)
 {
     uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
@@ -2561,6 +2624,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
     if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
+
+    /* configure UV-features for the guest indicated via query / test_bit */
+    rc = configure_uv_feat_guest(model->features);
+    if (rc) {
+        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
+        return;
+    }
 }
 
 void kvm_s390_restart_interrupt(S390CPU *cpu)
-- 
2.41.0


