Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7217C4C9F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 10:07:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqUEC-0004to-BF; Wed, 11 Oct 2023 04:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqUE7-0004so-4m
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qqUE5-0003Vx-8U
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697011552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n4J/+9Wr6WPOw2kS0zMKBUc3iDJPQPMHeox9rULp10s=;
 b=H0AdaagHXW+vLWTpjIq3p12TYWrwQwmwIz0SPVdKLzMQu3BlxFvzY4Q2JntbV1VEprvP+/
 enKEs7GDChaHhVa/lkKFXOEMtc1HVZwTbD2XIDU7U29TMSHJuJJI9zDPJeBgvyEOc6vHy9
 cBxcZ60PF/I6CcRyHcT27nM0YApY4ak=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-l8Kcka4NOFmKz7REYMjysg-1; Wed, 11 Oct 2023 04:05:43 -0400
X-MC-Unique: l8Kcka4NOFmKz7REYMjysg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FDE41DD35C3;
 Wed, 11 Oct 2023 08:05:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 45BC7215670B;
 Wed, 11 Oct 2023 08:05:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>
Subject: [PATCH v3 2/2] target/s390x/kvm: Simplify the GPRs, ACRs,
 CRs and prefix synchronization code
Date: Wed, 11 Oct 2023 10:05:38 +0200
Message-ID: <20231011080538.796999-3-thuth@redhat.com>
In-Reply-To: <20231011080538.796999-1-thuth@redhat.com>
References: <20231011080538.796999-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

KVM_SYNC_GPRS, KVM_SYNC_ACRS, KVM_SYNC_CRS and KVM_SYNC_PREFIX are
available since kernel 3.10. Since we already require at least kernel
3.15 in the s390x KVM code, we can also assume that the KVM_CAP_SYNC_REGS
sync code is always possible for these registers, and remove the
related checks and fallbacks via KVM_SET_REGS and KVM_GET_REGS.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/s390x/kvm/kvm.c | 106 ++++++++++-------------------------------
 1 file changed, 24 insertions(+), 82 deletions(-)

diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index b3e2eaa2eb..dc76f63d94 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -138,7 +138,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
 };
 
-static int cap_sync_regs;
 static int cap_async_pf;
 static int cap_mem_op;
 static int cap_mem_op_extension;
@@ -359,7 +358,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return -1;
     }
 
-    cap_sync_regs = true;
     cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
     cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
     cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);
@@ -466,37 +464,28 @@ void kvm_s390_reset_vcpu_normal(S390CPU *cpu)
 
 static int can_sync_regs(CPUState *cs, int regs)
 {
-    return cap_sync_regs && (cs->kvm_run->kvm_valid_regs & regs) == regs;
+    return (cs->kvm_run->kvm_valid_regs & regs) == regs;
 }
 
+#define KVM_SYNC_REQUIRED_REGS (KVM_SYNC_GPRS | KVM_SYNC_ACRS | \
+                                KVM_SYNC_CRS | KVM_SYNC_PREFIX)
+
 int kvm_arch_put_registers(CPUState *cs, int level)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    struct kvm_sregs sregs;
-    struct kvm_regs regs;
     struct kvm_fpu fpu = {};
     int r;
     int i;
 
+    g_assert(can_sync_regs(cs, KVM_SYNC_REQUIRED_REGS));
+
     /* always save the PSW  and the GPRS*/
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
-    }
+    memcpy(cs->kvm_run->s.regs.gprs, env->regs, sizeof(cs->kvm_run->s.regs.gprs));
+    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_GPRS;
 
     if (can_sync_regs(cs, KVM_SYNC_VRS)) {
         for (i = 0; i < 32; i++) {
@@ -529,6 +518,15 @@ int kvm_arch_put_registers(CPUState *cs, int level)
         return 0;
     }
 
+    /*
+     * Access registers, control registers and the prefix - these are
+     * always available via kvm_sync_regs in the kernels that we support
+     */
+    memcpy(cs->kvm_run->s.regs.acrs, env->aregs, sizeof(cs->kvm_run->s.regs.acrs));
+    memcpy(cs->kvm_run->s.regs.crs, env->cregs, sizeof(cs->kvm_run->s.regs.crs));
+    cs->kvm_run->s.regs.prefix = env->psa;
+    cs->kvm_run->kvm_dirty_regs |= KVM_SYNC_ACRS | KVM_SYNC_CRS | KVM_SYNC_PREFIX;
+
     if (can_sync_regs(cs, KVM_SYNC_ARCH0)) {
         cs->kvm_run->s.regs.cputm = env->cputm;
         cs->kvm_run->s.regs.ckc = env->ckc;
@@ -575,25 +573,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
@@ -615,13 +594,6 @@ int kvm_arch_put_registers(CPUState *cs, int level)
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
 
@@ -629,8 +601,6 @@ int kvm_arch_get_registers(CPUState *cs)
 {
     S390CPU *cpu = S390_CPU(cs);
     CPUS390XState *env = &cpu->env;
-    struct kvm_sregs sregs;
-    struct kvm_regs regs;
     struct kvm_fpu fpu;
     int i, r;
 
@@ -638,37 +608,14 @@ int kvm_arch_get_registers(CPUState *cs)
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
-    }
+    /* the GPRS, ACRS and CRS */
+    g_assert(can_sync_regs(cs, KVM_SYNC_REQUIRED_REGS));
+    memcpy(env->regs, cs->kvm_run->s.regs.gprs, sizeof(env->regs));
+    memcpy(env->aregs, cs->kvm_run->s.regs.acrs, sizeof(env->aregs));
+    memcpy(env->cregs, cs->kvm_run->s.regs.crs, sizeof(env->cregs));
 
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
@@ -693,11 +640,6 @@ int kvm_arch_get_registers(CPUState *cs)
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
2.41.0


