Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91780A055A3
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 09:46:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVRhC-00064k-IY; Wed, 08 Jan 2025 03:45:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRh7-00064K-Ur
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tVRh6-0001mn-DD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 03:45:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736325939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3JuZPzn6SxBb46LiYPAQ36Ib3s6oLALdBT8nB+bznxE=;
 b=Pe/njE9NvWrifmp4qtp4IeZd4h5vsHpAWhULZjzi9Fq9cVC2sojJ952HFEzrUfxBwk1wX/
 NnF/eEKHY3V5WJmBqBW1MhZkvj8cBpS+/RIcqwCDsAhJCnhz4v6JohT/x/SGtUr6EJalgR
 gm42Dpgro/+s/PFa12LrRkv8D5EPWZU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-sFucDOs1Na-puv8gsbESdA-1; Wed,
 08 Jan 2025 03:45:36 -0500
X-MC-Unique: sFucDOs1Na-puv8gsbESdA-1
X-Mimecast-MFC-AGG-ID: sFucDOs1Na-puv8gsbESdA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD76B19560BB; Wed,  8 Jan 2025 08:45:35 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-228.str.redhat.com
 [10.33.192.228])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5653219560AB; Wed,  8 Jan 2025 08:45:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 09/14] hw/s390x: Remove the cpu_model_allowed flag and related
 code
Date: Wed,  8 Jan 2025 09:45:06 +0100
Message-ID: <20250108084511.238458-10-thuth@redhat.com>
In-Reply-To: <20250108084511.238458-1-thuth@redhat.com>
References: <20250108084511.238458-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Now that the last machine type that disabled cpu_model_allowed has
been removed, we can also remove the cpu_model_allowed flag itself
and all the related conditional code.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Message-ID: <20250103144232.520383-9-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/s390x/s390-virtio-ccw.h |  3 ---
 hw/s390x/s390-virtio-ccw.c         |  9 +--------
 target/s390x/kvm/kvm.c             | 10 ++--------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index 4559dbf1bd..686d9497d2 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -53,13 +53,10 @@ struct S390CcwMachineClass {
     MachineClass parent_class;
 
     /*< public >*/
-    bool cpu_model_allowed;
     bool hpage_1m_allowed;
     int max_threads;
 };
 
-/* cpu model allowed by the machine */
-bool cpu_model_allowed(void);
 /* 1M huge page mappings allowed by the machine */
 bool hpage_1m_allowed(void);
 
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a1e9c1f6e8..08562e45a8 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -727,8 +727,7 @@ static S390CcwMachineClass *current_mc;
  *
  * Attention! Do *not* add additional new wrappers for CPU features via this
  * mechanism anymore. CPU features should be handled via the CPU models,
- * i.e. checking with cpu_model_allowed() during CPU initialization and
- * s390_has_feat() later should be sufficient.
+ * i.e. checking with s390_has_feat() should be sufficient.
  */
 static S390CcwMachineClass *get_machine_class(void)
 {
@@ -744,11 +743,6 @@ static S390CcwMachineClass *get_machine_class(void)
     return current_mc;
 }
 
-bool cpu_model_allowed(void)
-{
-    return get_machine_class()->cpu_model_allowed;
-}
-
 bool hpage_1m_allowed(void)
 {
     return get_machine_class()->hpage_1m_allowed;
@@ -786,7 +780,6 @@ static void ccw_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     S390CcwMachineClass *s390mc = S390_CCW_MACHINE_CLASS(mc);
 
-    s390mc->cpu_model_allowed = true;
     s390mc->hpage_1m_allowed = true;
     s390mc->max_threads = 1;
     mc->init = ccw_init;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 540b474398..4d56e653dd 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -374,12 +374,10 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     kvm_vm_enable_cap(s, KVM_CAP_S390_VECTOR_REGISTERS, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_USER_STSI, 0);
     kvm_vm_enable_cap(s, KVM_CAP_S390_CPU_TOPOLOGY, 0);
+    kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0);
     if (kvm_vm_enable_cap(s, KVM_CAP_S390_RI, 0) == 0) {
         cap_ri = 1;
     }
-    if (cpu_model_allowed()) {
-        kvm_vm_enable_cap(s, KVM_CAP_S390_GS, 0);
-    }
 
     /*
      * The migration interface for ais was introduced with kernel 4.13
@@ -387,7 +385,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      * support is considered necessary, we only try to enable this for
      * newer machine types if KVM_CAP_S390_AIS_MIGRATION is available.
      */
-    if (cpu_model_allowed() && kvm_kernel_irqchip_allowed() &&
+    if (kvm_kernel_irqchip_allowed() &&
         kvm_check_extension(s, KVM_CAP_S390_AIS_MIGRATION)) {
         kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0);
     }
@@ -2352,10 +2350,6 @@ static int configure_cpu_feat(const S390FeatBitmap features)
 
 bool kvm_s390_cpu_models_supported(void)
 {
-    if (!cpu_model_allowed()) {
-        /* compatibility machines interfere with the cpu model */
-        return false;
-    }
     return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_MODEL,
                              KVM_S390_VM_CPU_MACHINE) &&
            kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_MODEL,
-- 
2.47.1


