Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5677CE316
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:41:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Yf-0001EH-FJ; Wed, 18 Oct 2023 12:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YW-00015m-Ff
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:38:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YU-0007PD-4I
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CveuO4yQ9evvGjnDfztuEGseRr4CnPjVKEaq7EdVTys=;
 b=cclnuuwkiuVSraWYH+hCWvmXD2/ZcHoqVraYp/N2N2bIjf8dJUo3xGCU4DO/ISA/n43KgD
 x9lARs8EpYgvAP8P1Y0Qj2h6vwrUMVHO2sk4/dbegV5Nu9quv53JvQm74bpjb/vdbR0w3O
 7Re/YCnyUbBbVHEL90m7vnELp4vplmI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Y48A-eGMPeqi4Ok4B61DDQ-1; Wed, 18 Oct 2023 12:37:56 -0400
X-MC-Unique: Y48A-eGMPeqi4Ok4B61DDQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso516437466b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647074; x=1698251874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CveuO4yQ9evvGjnDfztuEGseRr4CnPjVKEaq7EdVTys=;
 b=T6YA8ddOrfa8iTHMppxLQD/am/DFsKDjvd3ZqJ5pFyQVrft5HalytDO1CyT5P6jtVL
 54Od0ft/ahy/SBq3KImyaxSMZpSOtuxnSN9FfX0ilJe6EIUSZV/XQzHWqzBO3ndJv7KH
 A41ouWmd7Iow5rxhOhieXwm8z93OmpAKgoeiVaoZ4zNcvbz9I8qQOYAiGRcRb/w3qheJ
 l9p8EVFmdUo0JISTEY0+zi00uu0bvry8odQmurbPwJ8gcN+ZWLHb59nr7lNlShOF6Rc5
 /gypzEP35wr8i9q3CO++jlAfUmVmrgjTKw5oaE5jFlkL0PsS/C3a60rSyhRag0JHzDmf
 +ThA==
X-Gm-Message-State: AOJu0YynrkJk+fenRapCaPPO6lqGgOURGAEfeH8Nu6sXNny+Ao9tYAOe
 No9fYHJ+J/3YH0Vsn4nj5rpqgjqgaHnxqj+vyJrOex3dSJBpdSaD+G06oThPljdOW6oOxIiO6Dv
 V9Ef8Z4SO4pfysPxZC20aglC96vd29zRdVx7Etv8SjQ9BISW/9chDwa/843DEs/VCSp6HkTFtSm
 o=
X-Received: by 2002:a17:907:2ce2:b0:9b2:a7db:9662 with SMTP id
 hz2-20020a1709072ce200b009b2a7db9662mr4334449ejc.12.1697647074446; 
 Wed, 18 Oct 2023 09:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7HyIjRgKM3PmSVghq70NMlO0Oe9R6ZMDbbUhTQ+R2RhN4ZmjN9jtrHsczkIMTMjflgZLApw==
X-Received: by 2002:a17:907:2ce2:b0:9b2:a7db:9662 with SMTP id
 hz2-20020a1709072ce200b009b2a7db9662mr4334434ejc.12.1697647074056; 
 Wed, 18 Oct 2023 09:37:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 q27-20020a1709066b1b00b0099b8234a9fesm2027804ejr.1.2023.10.18.09.37.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/17] kvm: i386: require KVM_CAP_XSAVE
Date: Wed, 18 Oct 2023 18:37:23 +0200
Message-ID: <20231018163728.363879-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

This was introduced in KVM in Linux 2.6.36, and could already be used at
the time to save/restore FPU data even on older processor.  We can require
it unconditionally and stop using KVM_GET/SET_FPU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 70 ++-----------------------------------------
 1 file changed, 2 insertions(+), 68 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 86af39c437a..f6622684024 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -94,6 +94,7 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(SIGNAL_MSI),
     KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_INFO(DEBUGREGS),
+    KVM_CAP_INFO(XSAVE),
     KVM_CAP_LAST_INFO
 };
 
@@ -137,7 +138,6 @@ static uint32_t has_architectural_pmu_version;
 static uint32_t num_architectural_pmu_gp_counters;
 static uint32_t num_architectural_pmu_fixed_counters;
 
-static int has_xsave;
 static int has_xsave2;
 static int has_xcrs;
 static int has_pit_state2;
@@ -1714,10 +1714,8 @@ static void kvm_init_xsave(CPUX86State *env)
 {
     if (has_xsave2) {
         env->xsave_buf_len = QEMU_ALIGN_UP(has_xsave2, 4096);
-    } else if (has_xsave) {
-        env->xsave_buf_len = sizeof(struct kvm_xsave);
     } else {
-        return;
+        env->xsave_buf_len = sizeof(struct kvm_xsave);
     }
 
     env->xsave_buf = qemu_memalign(4096, env->xsave_buf_len);
@@ -2592,7 +2590,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         return ret;
     }
 
-    has_xsave = kvm_check_extension(s, KVM_CAP_XSAVE);
     has_xcrs = kvm_check_extension(s, KVM_CAP_XCRS);
     has_pit_state2 = kvm_check_extension(s, KVM_CAP_PIT_STATE2);
     has_sregs2 = kvm_check_extension(s, KVM_CAP_SREGS2) > 0;
@@ -2877,40 +2874,11 @@ static int kvm_getput_regs(X86CPU *cpu, int set)
     return ret;
 }
 
-static int kvm_put_fpu(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    struct kvm_fpu fpu;
-    int i;
-
-    memset(&fpu, 0, sizeof fpu);
-    fpu.fsw = env->fpus & ~(7 << 11);
-    fpu.fsw |= (env->fpstt & 7) << 11;
-    fpu.fcw = env->fpuc;
-    fpu.last_opcode = env->fpop;
-    fpu.last_ip = env->fpip;
-    fpu.last_dp = env->fpdp;
-    for (i = 0; i < 8; ++i) {
-        fpu.ftwx |= (!env->fptags[i]) << i;
-    }
-    memcpy(fpu.fpr, env->fpregs, sizeof env->fpregs);
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        stq_p(&fpu.xmm[i][0], env->xmm_regs[i].ZMM_Q(0));
-        stq_p(&fpu.xmm[i][8], env->xmm_regs[i].ZMM_Q(1));
-    }
-    fpu.mxcsr = env->mxcsr;
-
-    return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_FPU, &fpu);
-}
-
 static int kvm_put_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     void *xsave = env->xsave_buf;
 
-    if (!has_xsave) {
-        return kvm_put_fpu(cpu);
-    }
     x86_cpu_xsave_all_areas(cpu, xsave, env->xsave_buf_len);
 
     return kvm_vcpu_ioctl(CPU(cpu), KVM_SET_XSAVE, xsave);
@@ -3655,46 +3623,12 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
 }
 
 
-static int kvm_get_fpu(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-    struct kvm_fpu fpu;
-    int i, ret;
-
-    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_FPU, &fpu);
-    if (ret < 0) {
-        return ret;
-    }
-
-    env->fpstt = (fpu.fsw >> 11) & 7;
-    env->fpus = fpu.fsw;
-    env->fpuc = fpu.fcw;
-    env->fpop = fpu.last_opcode;
-    env->fpip = fpu.last_ip;
-    env->fpdp = fpu.last_dp;
-    for (i = 0; i < 8; ++i) {
-        env->fptags[i] = !((fpu.ftwx >> i) & 1);
-    }
-    memcpy(env->fpregs, fpu.fpr, sizeof env->fpregs);
-    for (i = 0; i < CPU_NB_REGS; i++) {
-        env->xmm_regs[i].ZMM_Q(0) = ldq_p(&fpu.xmm[i][0]);
-        env->xmm_regs[i].ZMM_Q(1) = ldq_p(&fpu.xmm[i][8]);
-    }
-    env->mxcsr = fpu.mxcsr;
-
-    return 0;
-}
-
 static int kvm_get_xsave(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     void *xsave = env->xsave_buf;
     int type, ret;
 
-    if (!has_xsave) {
-        return kvm_get_fpu(cpu);
-    }
-
     type = has_xsave2 ? KVM_GET_XSAVE2 : KVM_GET_XSAVE;
     ret = kvm_vcpu_ioctl(CPU(cpu), type, xsave);
     if (ret < 0) {
-- 
2.41.0


