Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B00B57D7883
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnIB-0001oL-Er; Wed, 25 Oct 2023 19:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI8-0001iO-Ta
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI7-0005Ih-9M
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GdZ68mbYRCX/mChbYRdJIewnmOXbTjCnA/qf/1jADtk=;
 b=JLwpLCErs1GRHK0OBPa59pOsLamLYYOF8W1KxTRTfnFDW3WmBrdNvlffmQoF+RFsNIMllh
 VgvENgVestn+AG2vLsxbCdGy2VFETvp0z2iqzgmiA0VzHXxOjadAW9adpct7ulZNL1jQM4
 KhKWCmefAy50emwD3t9BVXDxM/Y+C4s=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-vlC_mJgeNOyz50hIEEwIrw-1; Wed, 25 Oct 2023 19:27:56 -0400
X-MC-Unique: vlC_mJgeNOyz50hIEEwIrw-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66d38d57f49so5169256d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276476; x=1698881276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GdZ68mbYRCX/mChbYRdJIewnmOXbTjCnA/qf/1jADtk=;
 b=c9g77qjMef5GGUXnH+hZ6hb2wCKA141w3UJi9Gvr9OjP7xHnUXJbVxD8IYDyXKj7y0
 2P1oxtTChbNKv/xE7YRL4rLVzQlj2s+NWh584PIkrwO8GbxlOcL8fWEqeH2+bLLFaFZL
 YX1SFATLICK28vOFkNtyicaOjGW0fDr16fNO8cSDWoERAQqHHaSFPocJ9xgtHnjkTwnn
 oXdhcQi9D6ukS60dI+LwbKgL5QexDuu6yaZMr+dZ/UPDcvfpl6koy/sF39Bt+BZJ7gT0
 7EYsah9MZ5tThwPpbkB12tO2Z2GsxFj4CWKsmcmtFCKaeCqLPFqjFdbDOINQnzf8p21l
 JA8g==
X-Gm-Message-State: AOJu0YzNc/GmbfK+otYKlv4JzeD0vhNCsOjfRmyRdQNuH90L1LdCC5sZ
 Nid1VOa/bVVL1hBKUprAnct68D1BwQ67ngqcQhfXCLKMULcfI/7s8aO8NkOBUTWOV1dXZh4X8yd
 638HxbMWheph43mKI1ZB+g79hlsAQHx7Q+BLNOHReWL4rKrD0nYGRWUa0V58ZDJdc/6AmyB8h8e
 k=
X-Received: by 2002:a0c:f041:0:b0:66d:9c7e:469a with SMTP id
 b1-20020a0cf041000000b0066d9c7e469amr13407936qvl.10.1698276475774; 
 Wed, 25 Oct 2023 16:27:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjHqtdsdVgpJxAsunYtPv8w7if0AD0261nKzHr/ToTuLI12DB/jUsb3Lbj7T6tj2v+xCIJ9A==
X-Received: by 2002:a0c:f041:0:b0:66d:9c7e:469a with SMTP id
 b1-20020a0cf041000000b0066d9c7e469amr13407924qvl.10.1698276475392; 
 Wed, 25 Oct 2023 16:27:55 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 s8-20020ad44388000000b0066d11743b3esm4744823qvr.34.2023.10.25.16.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/24] kvm: i386: require KVM_CAP_XSAVE
Date: Thu, 26 Oct 2023 01:27:12 +0200
Message-ID: <20231025232718.89428-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This was introduced in KVM in Linux 2.6.36, and could already be used at
the time to save/restore FPU data even on older processor.  We can require
it unconditionally and stop using KVM_GET/SET_FPU.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 70 ++-----------------------------------------
 1 file changed, 2 insertions(+), 68 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index b8fb74d7f17..513a90f6307 100644
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


