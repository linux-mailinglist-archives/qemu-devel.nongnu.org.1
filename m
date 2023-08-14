Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6976C77C05A
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 21:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVctP-0006tx-5U; Mon, 14 Aug 2023 15:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVctN-0006te-DI
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qVctL-000315-L9
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 15:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692039974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1FRmMzzlevhT337L3BaneiXPl8xNqyvPQT8IIfZW2Cs=;
 b=C/dCc9R8uunC7ph1Ezo1etHW6yTmTELyHjkHlI03290yoEpcOpdoRk2iR2XrYfD7/Yzdir
 vIGkUC//WuBMSnn+aKIuXzmCwBzZb5xWUUiMHJtD+7g+EfB1Uf+cS2yoNdogEo4r5jEZsK
 Jmu/mg/KMmx3Hhr9m7dBhgNCyvhsFdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-q1t63h3_MBmMqUgJsu4D0Q-1; Mon, 14 Aug 2023 15:06:10 -0400
X-MC-Unique: q1t63h3_MBmMqUgJsu4D0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 743BA80557C;
 Mon, 14 Aug 2023 19:06:10 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1EE44021B9;
 Mon, 14 Aug 2023 19:06:08 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-devel@nongnu.org,
	David Hildenbrand <david@redhat.com>
Subject: [PATCH for-8.2] target/s390x/kvm: Simplify the GPRs, ACRs,
 CRs and prefix synchronization code
Date: Mon, 14 Aug 2023 21:06:04 +0200
Message-Id: <20230814190604.907982-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

KVM_SYNC_GPRS, KVM_SYNC_ACRS, KVM_SYNC_CRS and KVM_SYNC_PREFIX are
available since kernel 3.10. Since we already require at least kernel
3.15 in the s390x KVM code, we can assume that the KVM_CAP_SYNC_REGS
sync code is always possible for these registers, and remove the
related checks and fallbacks via KVM_SET_REGS and KVM_GET_REGS.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 119 ++++++++++++-----------------------------
 1 file changed, 34 insertions(+), 85 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index a9e5880349..ff415f7b30 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -148,7 +148,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static int cap_sync_regs;
 static int cap_async_pf;
 static int cap_mem_op;
 static int cap_mem_op_extension;
@@ -342,21 +341,28 @@ static void ccw_machine_class_foreach(ObjectClass *oc, void *opaque)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    int required_caps[] = {
+        KVM_CAP_DEVICE_CTRL,
+        KVM_CAP_SYNC_REGS,
+    };
+
+    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
+        if (!kvm_check_extension(s, required_caps[i])) {
+            error_report("KVM is missing capability #%d - "
+                         "please use kernel 3.15 or newer", required_caps[i]);
+            return -1;
+        }
+    }
+
     object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
                          false, NULL);
 
-    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
-        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
-                     "please use kernel 3.15 or newer");
-        return -1;
-    }
     if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
         error_report("KVM is missing capability KVM_CAP_S390_COW - "
                      "unsupported environment");
         return -1;
     }
 
-    cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);
@@ -463,15 +469,15 @@ void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
 
 static int can_sync_regs(CPUState *cs, int regs)
 {
-    return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
+    return (cs->kvm_run->kvm_valid_regs & regs) == regs;
 }
 
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
+    const int required_syncs = KVM_SYNC_GPRS | KVM_SYNC_ACRS |
+                               KVM_SYNC_CRS | KVM_SYNC_PREFIX;
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    struct kvm_sregs sregs;
-    struct kvm_regs regs;
     struct kvm_fpu fpu = {};
     int r;
     int i;
@@ -480,21 +486,16 @@ int kvm_arch_put_registers(CPUState *cs, int level)
     cs->kvm_run->psw_addr = env->psw.addr;
     cs->kvm_run->psw_mask = env->psw.mask;
 
-    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
-        for (i = 0; i < 16; i++) {
-            cs->kvm_run->s.regs.gprs[i] = env->regs[i];
-            cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
-        }
-    } else {
-        for (i = 0; i < 16; i++) {
-            regs.gprs[i] = env->regs[i];
-        }
-        r = kvm_vcpu_ioctl(cs, KVM_SET_REGS, &regs);
-        if (r < 0) {
-            return r;
-        }
+    g_assert((cs->kvm_run->kvm_valid_regs & required_syncs) == required_syncs);
+    cs->kvm_run->kvm_dirty_regs |= required_syncs;
+    for (i = 0; i < 16; i++) {
+        cs->kvm_run->s.regs.gprs[i] = env->regs[i];
+        cs->kvm_run->s.regs.acrs[i] = env->aregs[i];
+        cs->kvm_run->s.regs.crs[i] = env->cregs[i];
     }
 
+    cs->kvm_run->s.regs.prefix = env->psa;
+
     if (can_sync_regs(cs, KVM_SYNC_VRS)) {
         for (i = 0; i < 32; i++) {
             cs->kvm_run->s.regs.vrs[i][0] = env->vregs[i][0];
@@ -572,25 +573,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         }
     }
 
-    /* access registers and control registers*/
-    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
-        for (i = 0; i < 16; i++) {
-            cs->kvm_run->s.regs.acrs[i] = env->aregs[i];
-            cs->kvm_run->s.regs.crs[i] = env->cregs[i];
-        }
-        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ACRS;
-        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_CRS;
-    } else {
-        for (i = 0; i < 16; i++) {
-            sregs.acrs[i] = env->aregs[i];
-            sregs.crs[i] = env->cregs[i];
-        }
-        r = kvm_vcpu_ioctl(cs, KVM_SET_SREGS, &sregs);
-        if (r < 0) {
-            return r;
-        }
-    }
-
     if (can_sync_regs(cs, KVM_SYNC_GSCB)) {
         memcpy(cs->kvm_run->s.regs.gscb, env->gscb, 32);
         cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GSCB;
@@ -612,22 +594,15 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_DIAG318;
     }
 
-    /* Finally the prefix */
-    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
-        cs->kvm_run->s.regs.prefix = env->psa;
-        cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_PREFIX;
-    } else {
-        /* prefix is only supported via sync regs */
-    }
     return 0;
 }
 
 int kvm_arch_get_registers(CPUState *cs)
 {
+    const int required_syncs = KVM_SYNC_GPRS | KVM_SYNC_ACRS |
+                               KVM_SYNC_CRS | KVM_SYNC_PREFIX;
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    struct kvm_sregs sregs;
-    struct kvm_regs regs;
     struct kvm_fpu fpu;
     int i, r;
 
@@ -635,37 +610,16 @@ int kvm_arch_get_registers(CPUState *cs)
     env->psw.addr = cs->kvm_run->psw_addr;
     env->psw.mask = cs->kvm_run->psw_mask;
 
-    /* the GPRS */
-    if (can_sync_regs(cs, KVM_SYNC_GPRS)) {
-        for (i = 0; i < 16; i++) {
-            env->regs[i] = cs->kvm_run->s.regs.gprs[i];
-        }
-    } else {
-        r = kvm_vcpu_ioctl(cs, KVM_GET_REGS, &regs);
-        if (r < 0) {
-            return r;
-        }
-         for (i = 0; i < 16; i++) {
-            env->regs[i] = regs.gprs[i];
-        }
+    /* the GPRS, ACRS and CRS */
+    g_assert((cs->kvm_run->kvm_valid_regs & required_syncs) == required_syncs);
+    for (i = 0; i < 16; i++) {
+        env->regs[i] = cs->kvm_run->s.regs.gprs[i];
+        env->aregs[i] = cs->kvm_run->s.regs.acrs[i];
+        env->cregs[i] = cs->kvm_run->s.regs.crs[i];
     }
 
-    /* The ACRS and CRS */
-    if (can_sync_regs(cs, KVM_SYNC_ACRS | KVM_SYNC_CRS)) {
-        for (i = 0; i < 16; i++) {
-            env->aregs[i] = cs->kvm_run->s.regs.acrs[i];
-            env->cregs[i] = cs->kvm_run->s.regs.crs[i];
-        }
-    } else {
-        r = kvm_vcpu_ioctl(cs, KVM_GET_SREGS, &sregs);
-        if (r < 0) {
-            return r;
-        }
-         for (i = 0; i < 16; i++) {
-            env->aregs[i] = sregs.acrs[i];
-            env->cregs[i] = sregs.crs[i];
-        }
-    }
+    /* The prefix */
+    env->psa = cs->kvm_run->s.regs.prefix;
 
     /* Floating point and vector registers */
     if (can_sync_regs(cs, KVM_SYNC_VRS)) {
@@ -690,11 +644,6 @@ int kvm_arch_get_registers(CPUState *cs)
         env->fpc = fpu.fpc;
     }
 
-    /* The prefix */
-    if (can_sync_regs(cs, KVM_SYNC_PREFIX)) {
-        env->psa = cs->kvm_run->s.regs.prefix;
-    }
-
     if (can_sync_regs(cs, KVM_SYNC_ARCH0)) {
         env->cputm = cs->kvm_run->s.regs.cputm;
         env->ckc = cs->kvm_run->s.regs.ckc;
-- 
2.39.3


