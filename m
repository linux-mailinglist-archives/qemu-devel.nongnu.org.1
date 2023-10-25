Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD817D7886
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:28:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnID-0001rH-8G; Wed, 25 Oct 2023 19:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI9-0001iq-JB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnI7-0005J4-T7
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6N69hZKBR7s/GlHVtWXS5lie4mi2ng7NjiM/ZccHU/4=;
 b=ij9l23oJ23HyK/JCESPEcF3LIM2UaJh6J4ea2mPvBA0plQ/YWq2jVsptKFkisI4i2ZNHKS
 41XSbNsr3b7XKNig+B+VspGnaL2BfpuQiQHj611MENu1yAKMft4vZiBWT0o1jwe4CS9U14
 xB1p2FE2EVRBgf29YL6Hljd0OsanVCs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-4jTgxCLDPXW5fX7pr4g-fQ-1; Wed, 25 Oct 2023 19:27:58 -0400
X-MC-Unique: 4jTgxCLDPXW5fX7pr4g-fQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-778999c5f1dso41788785a.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276477; x=1698881277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6N69hZKBR7s/GlHVtWXS5lie4mi2ng7NjiM/ZccHU/4=;
 b=BEjaSnpm79bxwn4aINiBAfhNe+Y0BfhQd0ED3Eo/dQN132JZFjsit5PgPP8Ixc8yyT
 0hJWMaHYBv+tIrc2epR36FJdOG4YXQs1gPqEtsBUO558X+rxHSIfdfAW8GoPtGqd334E
 CzY/2CECcfV9u31U97Wr0C0zyUETO9FW2RsBYYCF5G5oQPz81ilqY7nD99Q+6A0fkVP+
 ogxwSWwBJ1q9TKuxOxrg07BietyVwXWn7blOC7fYbkNubpWRDjhmaerF6IUF3pTTXG7w
 d6XfAqAwCACvH6ZhC0cKA36zhKdcVTr2DmcUZ3j16etltcqfPlgxSzf7VA7XjZ+ncquB
 IB+g==
X-Gm-Message-State: AOJu0YznpnOkqG6fmntFMOFGFJqZENfF6gKnvOOwpK51Ms4NGSXdiNRj
 HZsb0uYsHDYLbp1xKCF8CEJ+rFIVqSX4vDiu11sm+G5eEiQQtcg8tWj3uZpyQQaRIXgvieF+xUM
 Au43vqfJomp5oWYQQWbOA7uYmjnVtGsgu+AOnHysNnsKamy9BWW14vQ0dj49p32PexGSbruWo6p
 8=
X-Received: by 2002:a05:620a:2b9a:b0:77a:59c:d849 with SMTP id
 dz26-20020a05620a2b9a00b0077a059cd849mr76642qkb.33.1698276477271; 
 Wed, 25 Oct 2023 16:27:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFv6PuimlhaqSMESg5NvImMvGMiQeGp8aENn0Pubu7SsL0GEv++XpM44XxGdpK3JGz88P8gSw==
X-Received: by 2002:a05:620a:2b9a:b0:77a:59c:d849 with SMTP id
 dz26-20020a05620a2b9a00b0077a059cd849mr76628qkb.33.1698276476846; 
 Wed, 25 Oct 2023 16:27:56 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a05620a001100b0077703f31496sm4572661qki.92.2023.10.25.16.27.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] kvm: i386: require KVM_CAP_SET_VCPU_EVENTS and
 KVM_CAP_X86_ROBUST_SINGLESTEP
Date: Thu, 26 Oct 2023 01:27:13 +0200
Message-ID: <20231025232718.89428-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c      |  9 ----
 include/sysemu/kvm.h     |  1 -
 include/sysemu/kvm_int.h |  1 -
 target/i386/kvm/kvm.c    | 92 +---------------------------------------
 4 files changed, 2 insertions(+), 101 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index aeda902b3e9..e39a810a4e9 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2524,10 +2524,6 @@ static int kvm_init(MachineState *ms)
 #ifdef KVM_CAP_VCPU_EVENTS
     s->vcpu_events = kvm_check_extension(s, KVM_CAP_VCPU_EVENTS);
 #endif
-
-    s->robust_singlestep =
-        kvm_check_extension(s, KVM_CAP_X86_ROBUST_SINGLESTEP);
-
     s->max_nested_state_len = kvm_check_extension(s, KVM_CAP_NESTED_STATE);
 
     s->irq_set_ioctl = KVM_IRQ_LINE;
@@ -3143,11 +3139,6 @@ int kvm_has_vcpu_events(void)
     return kvm_state->vcpu_events;
 }
 
-int kvm_has_robust_singlestep(void)
-{
-    return kvm_state->robust_singlestep;
-}
-
 int kvm_max_nested_state_length(void)
 {
     return kvm_state->max_nested_state_len;
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 02c031d1f29..80b69d88f6e 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -192,7 +192,6 @@ unsigned int kvm_get_max_memslots(void);
 unsigned int kvm_get_free_memslots(void);
 bool kvm_has_sync_mmu(void);
 int kvm_has_vcpu_events(void);
-int kvm_has_robust_singlestep(void);
 int kvm_max_nested_state_length(void);
 int kvm_has_gsi_routing(void);
 
diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
index 151ecc84233..fd846394be1 100644
--- a/include/sysemu/kvm_int.h
+++ b/include/sysemu/kvm_int.h
@@ -78,7 +78,6 @@ struct KVMState
     struct kvm_coalesced_mmio_ring *coalesced_mmio_ring;
     bool coalesced_flush_in_progress;
     int vcpu_events;
-    int robust_singlestep;
 #ifdef KVM_CAP_SET_GUEST_DEBUG
     QTAILQ_HEAD(, kvm_sw_breakpoint) kvm_sw_breakpoints;
 #endif
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 513a90f6307..4a244174a0f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -95,6 +95,8 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_INFO(IRQ_ROUTING),
     KVM_CAP_INFO(DEBUGREGS),
     KVM_CAP_INFO(XSAVE),
+    KVM_CAP_INFO(VCPU_EVENTS),
+    KVM_CAP_INFO(X86_ROBUST_SINGLESTEP),
     KVM_CAP_LAST_INFO
 };
 
@@ -690,15 +692,6 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     emit_hypervisor_memory_failure(MEMORY_FAILURE_ACTION_IGNORE, false);
 }
 
-static void kvm_reset_exception(CPUX86State *env)
-{
-    env->exception_nr = -1;
-    env->exception_pending = 0;
-    env->exception_injected = 0;
-    env->exception_has_payload = false;
-    env->exception_payload = 0;
-}
-
 static void kvm_queue_exception(CPUX86State *env,
                                 int32_t exception_nr,
                                 uint8_t exception_has_payload,
@@ -731,38 +724,6 @@ static void kvm_queue_exception(CPUX86State *env,
     }
 }
 
-static int kvm_inject_mce_oldstyle(X86CPU *cpu)
-{
-    CPUX86State *env = &cpu->env;
-
-    if (!kvm_has_vcpu_events() && env->exception_nr == EXCP12_MCHK) {
-        unsigned int bank, bank_num = env->mcg_cap & 0xff;
-        struct kvm_x86_mce mce;
-
-        kvm_reset_exception(env);
-
-        /*
-         * There must be at least one bank in use if an MCE is pending.
-         * Find it and use its values for the event injection.
-         */
-        for (bank = 0; bank < bank_num; bank++) {
-            if (env->mce_banks[bank * 4 + 1] & MCI_STATUS_VAL) {
-                break;
-            }
-        }
-        assert(bank < bank_num);
-
-        mce.bank = bank;
-        mce.status = env->mce_banks[bank * 4 + 1];
-        mce.mcg_status = env->mcg_status;
-        mce.addr = env->mce_banks[bank * 4 + 2];
-        mce.misc = env->mce_banks[bank * 4 + 3];
-
-        return kvm_vcpu_ioctl(CPU(cpu), KVM_X86_SET_MCE, &mce);
-    }
-    return 0;
-}
-
 static void cpu_update_state(void *opaque, bool running, RunState state)
 {
     CPUX86State *env = opaque;
@@ -4359,10 +4320,6 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
     CPUX86State *env = &cpu->env;
     struct kvm_vcpu_events events = {};
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     events.flags = 0;
 
     if (has_exception_payload) {
@@ -4430,10 +4387,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     struct kvm_vcpu_events events;
     int ret;
 
-    if (!kvm_has_vcpu_events()) {
-        return 0;
-    }
-
     memset(&events, 0, sizeof(events));
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_VCPU_EVENTS, &events);
     if (ret < 0) {
@@ -4499,37 +4452,6 @@ static int kvm_get_vcpu_events(X86CPU *cpu)
     return 0;
 }
 
-static int kvm_guest_debug_workarounds(X86CPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-    CPUX86State *env = &cpu->env;
-    int ret = 0;
-    unsigned long reinject_trap = 0;
-
-    if (!kvm_has_vcpu_events()) {
-        if (env->exception_nr == EXCP01_DB) {
-            reinject_trap = KVM_GUESTDBG_INJECT_DB;
-        } else if (env->exception_injected == EXCP03_INT3) {
-            reinject_trap = KVM_GUESTDBG_INJECT_BP;
-        }
-        kvm_reset_exception(env);
-    }
-
-    /*
-     * Kernels before KVM_CAP_X86_ROBUST_SINGLESTEP overwrote flags.TF
-     * injected via SET_GUEST_DEBUG while updating GP regs. Work around this
-     * by updating the debug state once again if single-stepping is on.
-     * Another reason to call kvm_update_guest_debug here is a pending debug
-     * trap raise by the guest. On kernels without SET_VCPU_EVENTS we have to
-     * reinject them via SET_GUEST_DEBUG.
-     */
-    if (reinject_trap ||
-        (!kvm_has_robust_singlestep() && cs->singlestep_enabled)) {
-        ret = kvm_update_guest_debug(cs, reinject_trap);
-    }
-    return ret;
-}
-
 static int kvm_put_debugregs(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
@@ -4702,11 +4624,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-    /* must be before kvm_put_msrs */
-    ret = kvm_inject_mce_oldstyle(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
     ret = kvm_put_msrs(x86_cpu, level);
     if (ret < 0) {
         return ret;
@@ -4730,11 +4647,6 @@ int kvm_arch_put_registers(CPUState *cpu, int level)
     if (ret < 0) {
         return ret;
     }
-    /* must be last */
-    ret = kvm_guest_debug_workarounds(x86_cpu);
-    if (ret < 0) {
-        return ret;
-    }
     return 0;
 }
 
-- 
2.41.0


