Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A0E79D073
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1lt-0004Hk-3s; Tue, 12 Sep 2023 07:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1ll-0004Ec-Fi
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lj-00034X-95
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694518882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRaLdIyS8WGiXkiSjzAHbk8J3wvCpw552BuwCUiUcFc=;
 b=A//IuSFdHcxZ0/JXr69JpwokeMmRrhWeElQYkbyB8PtxsskpynXyfWggcqqpIrpc8CFTbj
 m7X2aDNDdXOY7t8iuf2m5yFaVKXS3Vmtr592uvnWLPwEn/YSSm2pKLZbGFusMYEhBihHop
 TrFqN/unyHqiYskWU6LNH7HvkwVcSS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-31-jNFFy5YDMm-Ym9Eq8BKRZg-1; Tue, 12 Sep 2023 07:41:19 -0400
X-MC-Unique: jNFFy5YDMm-Ym9Eq8BKRZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFA01933867;
 Tue, 12 Sep 2023 11:41:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F36EE1054FC0;
 Tue, 12 Sep 2023 11:41:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Steffen Eiden <seiden@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
Subject: [PULL 4/7] target/s390x/kvm: Refactor AP functionalities
Date: Tue, 12 Sep 2023 13:41:09 +0200
Message-ID: <20230912114112.296428-5-thuth@redhat.com>
In-Reply-To: <20230912114112.296428-1-thuth@redhat.com>
References: <20230912114112.296428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

From: Steffen Eiden <seiden@linux.ibm.com>

kvm_s390_set_attr() is a misleading name as it only sets attributes for
the KVM_S390_VM_CRYPTO group. Therefore, rename it to
kvm_s390_set_crypto_attr().

Add new functions ap_available() and ap_enabled() to avoid code
duplication later.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Mueller <mimu@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
Message-ID: <20230823142219.1046522-5-seiden@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 852fbd0df7..f034b06abc 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -240,7 +240,7 @@ static void kvm_s390_enable_cmma(void)
     trace_kvm_enable_cmma(rc);
 }
 
-static void kvm_s390_set_attr(uint64_t attr)
+static void kvm_s390_set_crypto_attr(uint64_t attr)
 {
     struct kvm_device_attr attribute = {
         .group = KVM_S390_VM_CRYPTO,
@@ -265,7 +265,7 @@ static void kvm_s390_init_aes_kw(void)
     }
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-            kvm_s390_set_attr(attr);
+            kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -279,7 +279,7 @@ static void kvm_s390_init_dea_kw(void)
     }
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-            kvm_s390_set_attr(attr);
+            kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -2288,6 +2288,17 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
     return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
 }
 
+static bool ap_available(void)
+{
+    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
+                             KVM_S390_VM_CRYPTO_ENABLE_APIE);
+}
+
+static bool ap_enabled(const S390FeatBitmap features)
+{
+    return test_bit(S390_FEAT_AP, features);
+}
+
 static int kvm_to_feat[][2] = {
     { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
     { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
@@ -2467,8 +2478,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
         return;
     }
     /* for now, we can only provide the AP feature with HW support */
-    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
-        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
+    if (ap_available()) {
         set_bit(S390_FEAT_AP, model->features);
     }
 
@@ -2494,7 +2504,7 @@ static void kvm_s390_configure_apie(bool interpret)
                                 KVM_S390_VM_CRYPTO_DISABLE_APIE;
 
     if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
-        kvm_s390_set_attr(attr);
+        kvm_s390_set_crypto_attr(attr);
     }
 }
 
@@ -2548,7 +2558,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         kvm_s390_enable_cmma();
     }
 
-    if (test_bit(S390_FEAT_AP, model->features)) {
+    if (ap_enabled(model->features)) {
         kvm_s390_configure_apie(true);
     }
 }
-- 
2.41.0


