Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE387415C5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:55:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXVZ-0001Go-57; Wed, 28 Jun 2023 11:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVU-00012D-1k
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:55:00 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVQ-0000rh-CY
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:59 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so8535857e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967694; x=1690559694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3MorBisYatdNTxLHhZxLYxcsf3JxGTUN1u5OeO2Crs=;
 b=XQeUQGsWrfcU/kq+mw2nig47dEmOCbiNfeKlshLLYqv7AvLGS5v4shbm1soJP2gzyr
 mld1GqotrMjK99FuzMjjJQWqQIhHz5AQFGOMJjVJ5Z5jSG3S4NSZrwjGdL43YqT3JDY7
 p21rd9J5QiW94Ftvo6t3jncambgpyWc+FiEVSbmJfktfrdjHcT34+32BQ7JrSvngQ1Vj
 2BK7ZP4KV2/s6WP2/mtGfvOJuAYkknfNC8nfRT/Wlr1NGUKI3pOaXtsBOcvjPh51SSPk
 lZWvBOfsV5nzq3GKvNcIjSVICNF15gMH7pxrMy/mZOGyX8NuF0pgDjtAnHthhoRSGVqn
 nC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967694; x=1690559694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3MorBisYatdNTxLHhZxLYxcsf3JxGTUN1u5OeO2Crs=;
 b=IX+etjLQ0lI3GYVmqMlb8NHHpwRT4gPVVBnZrKzwVv2G78iD77encIWljCvbNraBVY
 Pp3l+fkHYxCPVW9MOoGX33VkTBCfCjMv62Qrk/GO6NrXVudH999ZQUng3hCDxgrRhOak
 m7RoWhh6RzYHe8b5cXLmCy7kxCjIiI95dRgTw/n3jdTYz8tWl7S6wr2q/FZ/jp0qifqe
 NBF/q5P2WBky/onNGtGGtQsadEBaWfoQ+/HE8Fc8z9sRdIcQXXLsJEyl2sumoulrGi3O
 0LkkYXjCYfUyJudzjsDKuNkM/LuCgPYglbjwxJYzj7k1kqxrLaRtjZwP7fBSiGKZeD0G
 MdAw==
X-Gm-Message-State: AC+VfDzW3MGgGvpYGjf/tePZF8RQU0xcyG3Ofee3SNUm9yQRdna2lgJ4
 859EQYefMXQOP4f4iZKKBuFdHK4gdlx57ua6PfI=
X-Google-Smtp-Source: ACHHUZ6eG8NbhBEC818ftDzDz5xoG6oCjzDM0gemhWgINFE7YjwSSzK3BxqfLKhs1y5MzJb5Ak3A7g==
X-Received: by 2002:a05:6512:39d1:b0:4fb:8afa:4dc9 with SMTP id
 k17-20020a05651239d100b004fb8afa4dc9mr3722430lfu.49.1687967693606; 
 Wed, 28 Jun 2023 08:54:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm8101078wrm.103.2023.06.28.08.54.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 17/30] accel: Rename 'cpu_state' -> 'cs'
Date: Wed, 28 Jun 2023 17:53:00 +0200
Message-Id: <20230628155313.71594-18-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Most of the codebase uses 'CPUState *cpu' or 'CPUState *cs'.
While 'cpu_state' is kind of explicit, it makes the code
harder to review. Simply rename as 'cs'.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230624174121.11508-16-philmd@linaro.org>
---
 target/i386/hvf/x86hvf.h |  18 +-
 target/i386/hvf/x86hvf.c | 372 +++++++++++++++++++--------------------
 2 files changed, 195 insertions(+), 195 deletions(-)

diff --git a/target/i386/hvf/x86hvf.h b/target/i386/hvf/x86hvf.h
index db6003d6bd..423a89b6ad 100644
--- a/target/i386/hvf/x86hvf.h
+++ b/target/i386/hvf/x86hvf.h
@@ -20,15 +20,15 @@
 #include "cpu.h"
 #include "x86_descr.h"
 
-int hvf_process_events(CPUState *);
-bool hvf_inject_interrupts(CPUState *);
-void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
+int hvf_process_events(CPUState *cs);
+bool hvf_inject_interrupts(CPUState *cs);
+void hvf_set_segment(CPUState *cs, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr);
 void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg);
-void hvf_put_xsave(CPUState *cpu_state);
-void hvf_put_msrs(CPUState *cpu_state);
-void hvf_get_xsave(CPUState *cpu_state);
-void hvf_get_msrs(CPUState *cpu_state);
-void vmx_clear_int_window_exiting(CPUState *cpu);
-void vmx_update_tpr(CPUState *cpu);
+void hvf_put_xsave(CPUState *cs);
+void hvf_put_msrs(CPUState *cs);
+void hvf_get_xsave(CPUState *cs);
+void hvf_get_msrs(CPUState *cs);
+void vmx_clear_int_window_exiting(CPUState *cs);
+void vmx_update_tpr(CPUState *cs);
 #endif
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 69d4fb8cf5..92dfd26a01 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -32,14 +32,14 @@
 #include <Hypervisor/hv.h>
 #include <Hypervisor/hv_vmx.h>
 
-void hvf_set_segment(struct CPUState *cpu, struct vmx_segment *vmx_seg,
+void hvf_set_segment(CPUState *cs, struct vmx_segment *vmx_seg,
                      SegmentCache *qseg, bool is_tr)
 {
     vmx_seg->sel = qseg->selector;
     vmx_seg->base = qseg->base;
     vmx_seg->limit = qseg->limit;
 
-    if (!qseg->selector && !x86_is_real(cpu) && !is_tr) {
+    if (!qseg->selector && !x86_is_real(cs) && !is_tr) {
         /* the TR register is usable after processor reset despite
          * having a null selector */
         vmx_seg->ar = 1 << 16;
@@ -70,279 +70,279 @@ void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg)
                   (((vmx_seg->ar >> 15) & 1) << DESC_G_SHIFT);
 }
 
-void hvf_put_xsave(CPUState *cpu_state)
+void hvf_put_xsave(CPUState *cs)
 {
-    void *xsave = X86_CPU(cpu_state)->env.xsave_buf;
-    uint32_t xsave_len = X86_CPU(cpu_state)->env.xsave_buf_len;
+    void *xsave = X86_CPU(cs)->env.xsave_buf;
+    uint32_t xsave_len = X86_CPU(cs)->env.xsave_buf_len;
 
-    x86_cpu_xsave_all_areas(X86_CPU(cpu_state), xsave, xsave_len);
+    x86_cpu_xsave_all_areas(X86_CPU(cs), xsave, xsave_len);
 
-    if (hv_vcpu_write_fpstate(cpu_state->hvf->fd, xsave, xsave_len)) {
+    if (hv_vcpu_write_fpstate(cs->hvf->fd, xsave, xsave_len)) {
         abort();
     }
 }
 
-static void hvf_put_segments(CPUState *cpu_state)
+static void hvf_put_segments(CPUState *cs)
 {
-    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    CPUX86State *env = &X86_CPU(cs)->env;
     struct vmx_segment seg;
     
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_IDTR_LIMIT, env->idt.limit);
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_IDTR_BASE, env->idt.base);
+    wvmcs(cs->hvf->fd, VMCS_GUEST_IDTR_LIMIT, env->idt.limit);
+    wvmcs(cs->hvf->fd, VMCS_GUEST_IDTR_BASE, env->idt.base);
 
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_GDTR_LIMIT, env->gdt.limit);
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_GDTR_BASE, env->gdt.base);
+    wvmcs(cs->hvf->fd, VMCS_GUEST_GDTR_LIMIT, env->gdt.limit);
+    wvmcs(cs->hvf->fd, VMCS_GUEST_GDTR_BASE, env->gdt.base);
 
-    /* wvmcs(cpu_state->hvf->fd, VMCS_GUEST_CR2, env->cr[2]); */
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_CR3, env->cr[3]);
-    vmx_update_tpr(cpu_state);
-    wvmcs(cpu_state->hvf->fd, VMCS_GUEST_IA32_EFER, env->efer);
+    /* wvmcs(cs->hvf->fd, VMCS_GUEST_CR2, env->cr[2]); */
+    wvmcs(cs->hvf->fd, VMCS_GUEST_CR3, env->cr[3]);
+    vmx_update_tpr(cs);
+    wvmcs(cs->hvf->fd, VMCS_GUEST_IA32_EFER, env->efer);
 
-    macvm_set_cr4(cpu_state->hvf->fd, env->cr[4]);
-    macvm_set_cr0(cpu_state->hvf->fd, env->cr[0]);
+    macvm_set_cr4(cs->hvf->fd, env->cr[4]);
+    macvm_set_cr0(cs->hvf->fd, env->cr[0]);
 
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_CS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_CS);
+    hvf_set_segment(cs, &seg, &env->segs[R_CS], false);
+    vmx_write_segment_descriptor(cs, &seg, R_CS);
     
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_DS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_DS);
+    hvf_set_segment(cs, &seg, &env->segs[R_DS], false);
+    vmx_write_segment_descriptor(cs, &seg, R_DS);
 
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_ES], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_ES);
+    hvf_set_segment(cs, &seg, &env->segs[R_ES], false);
+    vmx_write_segment_descriptor(cs, &seg, R_ES);
 
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_SS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_SS);
+    hvf_set_segment(cs, &seg, &env->segs[R_SS], false);
+    vmx_write_segment_descriptor(cs, &seg, R_SS);
 
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_FS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_FS);
+    hvf_set_segment(cs, &seg, &env->segs[R_FS], false);
+    vmx_write_segment_descriptor(cs, &seg, R_FS);
 
-    hvf_set_segment(cpu_state, &seg, &env->segs[R_GS], false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_GS);
+    hvf_set_segment(cs, &seg, &env->segs[R_GS], false);
+    vmx_write_segment_descriptor(cs, &seg, R_GS);
 
-    hvf_set_segment(cpu_state, &seg, &env->tr, true);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_TR);
+    hvf_set_segment(cs, &seg, &env->tr, true);
+    vmx_write_segment_descriptor(cs, &seg, R_TR);
 
-    hvf_set_segment(cpu_state, &seg, &env->ldt, false);
-    vmx_write_segment_descriptor(cpu_state, &seg, R_LDTR);
+    hvf_set_segment(cs, &seg, &env->ldt, false);
+    vmx_write_segment_descriptor(cs, &seg, R_LDTR);
 }
     
-void hvf_put_msrs(CPUState *cpu_state)
+void hvf_put_msrs(CPUState *cs)
 {
-    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    CPUX86State *env = &X86_CPU(cs)->env;
 
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_CS,
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_IA32_SYSENTER_CS,
                       env->sysenter_cs);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_ESP,
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_IA32_SYSENTER_ESP,
                       env->sysenter_esp);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_EIP,
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_IA32_SYSENTER_EIP,
                       env->sysenter_eip);
 
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_STAR, env->star);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_STAR, env->star);
 
 #ifdef TARGET_X86_64
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_CSTAR, env->cstar);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_KERNELGSBASE, env->kernelgsbase);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_FMASK, env->fmask);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_LSTAR, env->lstar);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_CSTAR, env->cstar);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_KERNELGSBASE, env->kernelgsbase);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_FMASK, env->fmask);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_LSTAR, env->lstar);
 #endif
 
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_GSBASE, env->segs[R_GS].base);
-    hv_vcpu_write_msr(cpu_state->hvf->fd, MSR_FSBASE, env->segs[R_FS].base);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_GSBASE, env->segs[R_GS].base);
+    hv_vcpu_write_msr(cs->hvf->fd, MSR_FSBASE, env->segs[R_FS].base);
 }
 
 
-void hvf_get_xsave(CPUState *cpu_state)
+void hvf_get_xsave(CPUState *cs)
 {
-    void *xsave = X86_CPU(cpu_state)->env.xsave_buf;
-    uint32_t xsave_len = X86_CPU(cpu_state)->env.xsave_buf_len;
+    void *xsave = X86_CPU(cs)->env.xsave_buf;
+    uint32_t xsave_len = X86_CPU(cs)->env.xsave_buf_len;
 
-    if (hv_vcpu_read_fpstate(cpu_state->hvf->fd, xsave, xsave_len)) {
+    if (hv_vcpu_read_fpstate(cs->hvf->fd, xsave, xsave_len)) {
         abort();
     }
 
-    x86_cpu_xrstor_all_areas(X86_CPU(cpu_state), xsave, xsave_len);
+    x86_cpu_xrstor_all_areas(X86_CPU(cs), xsave, xsave_len);
 }
 
-static void hvf_get_segments(CPUState *cpu_state)
+static void hvf_get_segments(CPUState *cs)
 {
-    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    CPUX86State *env = &X86_CPU(cs)->env;
 
     struct vmx_segment seg;
 
     env->interrupt_injected = -1;
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_CS);
+    vmx_read_segment_descriptor(cs, &seg, R_CS);
     hvf_get_segment(&env->segs[R_CS], &seg);
     
-    vmx_read_segment_descriptor(cpu_state, &seg, R_DS);
+    vmx_read_segment_descriptor(cs, &seg, R_DS);
     hvf_get_segment(&env->segs[R_DS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_ES);
+    vmx_read_segment_descriptor(cs, &seg, R_ES);
     hvf_get_segment(&env->segs[R_ES], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_FS);
+    vmx_read_segment_descriptor(cs, &seg, R_FS);
     hvf_get_segment(&env->segs[R_FS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_GS);
+    vmx_read_segment_descriptor(cs, &seg, R_GS);
     hvf_get_segment(&env->segs[R_GS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_SS);
+    vmx_read_segment_descriptor(cs, &seg, R_SS);
     hvf_get_segment(&env->segs[R_SS], &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_TR);
+    vmx_read_segment_descriptor(cs, &seg, R_TR);
     hvf_get_segment(&env->tr, &seg);
 
-    vmx_read_segment_descriptor(cpu_state, &seg, R_LDTR);
+    vmx_read_segment_descriptor(cs, &seg, R_LDTR);
     hvf_get_segment(&env->ldt, &seg);
 
-    env->idt.limit = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_IDTR_LIMIT);
-    env->idt.base = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_IDTR_BASE);
-    env->gdt.limit = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_GDTR_LIMIT);
-    env->gdt.base = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_GDTR_BASE);
+    env->idt.limit = rvmcs(cs->hvf->fd, VMCS_GUEST_IDTR_LIMIT);
+    env->idt.base = rvmcs(cs->hvf->fd, VMCS_GUEST_IDTR_BASE);
+    env->gdt.limit = rvmcs(cs->hvf->fd, VMCS_GUEST_GDTR_LIMIT);
+    env->gdt.base = rvmcs(cs->hvf->fd, VMCS_GUEST_GDTR_BASE);
 
-    env->cr[0] = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_CR0);
+    env->cr[0] = rvmcs(cs->hvf->fd, VMCS_GUEST_CR0);
     env->cr[2] = 0;
-    env->cr[3] = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_CR3);
-    env->cr[4] = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_CR4);
+    env->cr[3] = rvmcs(cs->hvf->fd, VMCS_GUEST_CR3);
+    env->cr[4] = rvmcs(cs->hvf->fd, VMCS_GUEST_CR4);
     
-    env->efer = rvmcs(cpu_state->hvf->fd, VMCS_GUEST_IA32_EFER);
+    env->efer = rvmcs(cs->hvf->fd, VMCS_GUEST_IA32_EFER);
 }
 
-void hvf_get_msrs(CPUState *cpu_state)
+void hvf_get_msrs(CPUState *cs)
 {
-    CPUX86State *env = &X86_CPU(cpu_state)->env;
+    CPUX86State *env = &X86_CPU(cs)->env;
     uint64_t tmp;
     
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_CS, &tmp);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_IA32_SYSENTER_CS, &tmp);
     env->sysenter_cs = tmp;
     
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_ESP, &tmp);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_IA32_SYSENTER_ESP, &tmp);
     env->sysenter_esp = tmp;
 
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_IA32_SYSENTER_EIP, &tmp);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_IA32_SYSENTER_EIP, &tmp);
     env->sysenter_eip = tmp;
 
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_STAR, &env->star);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_STAR, &env->star);
 
 #ifdef TARGET_X86_64
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_CSTAR, &env->cstar);
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_KERNELGSBASE, &env->kernelgsbase);
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_FMASK, &env->fmask);
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_LSTAR, &env->lstar);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_CSTAR, &env->cstar);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_KERNELGSBASE, &env->kernelgsbase);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_FMASK, &env->fmask);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_LSTAR, &env->lstar);
 #endif
 
-    hv_vcpu_read_msr(cpu_state->hvf->fd, MSR_IA32_APICBASE, &tmp);
+    hv_vcpu_read_msr(cs->hvf->fd, MSR_IA32_APICBASE, &tmp);
     
-    env->tsc = rdtscp() + rvmcs(cpu_state->hvf->fd, VMCS_TSC_OFFSET);
+    env->tsc = rdtscp() + rvmcs(cs->hvf->fd, VMCS_TSC_OFFSET);
 }
 
-int hvf_put_registers(CPUState *cpu_state)
+int hvf_put_registers(CPUState *cs)
 {
-    X86CPU *x86cpu = X86_CPU(cpu_state);
+    X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
 
-    wreg(cpu_state->hvf->fd, HV_X86_RAX, env->regs[R_EAX]);
-    wreg(cpu_state->hvf->fd, HV_X86_RBX, env->regs[R_EBX]);
-    wreg(cpu_state->hvf->fd, HV_X86_RCX, env->regs[R_ECX]);
-    wreg(cpu_state->hvf->fd, HV_X86_RDX, env->regs[R_EDX]);
-    wreg(cpu_state->hvf->fd, HV_X86_RBP, env->regs[R_EBP]);
-    wreg(cpu_state->hvf->fd, HV_X86_RSP, env->regs[R_ESP]);
-    wreg(cpu_state->hvf->fd, HV_X86_RSI, env->regs[R_ESI]);
-    wreg(cpu_state->hvf->fd, HV_X86_RDI, env->regs[R_EDI]);
-    wreg(cpu_state->hvf->fd, HV_X86_R8, env->regs[8]);
-    wreg(cpu_state->hvf->fd, HV_X86_R9, env->regs[9]);
-    wreg(cpu_state->hvf->fd, HV_X86_R10, env->regs[10]);
-    wreg(cpu_state->hvf->fd, HV_X86_R11, env->regs[11]);
-    wreg(cpu_state->hvf->fd, HV_X86_R12, env->regs[12]);
-    wreg(cpu_state->hvf->fd, HV_X86_R13, env->regs[13]);
-    wreg(cpu_state->hvf->fd, HV_X86_R14, env->regs[14]);
-    wreg(cpu_state->hvf->fd, HV_X86_R15, env->regs[15]);
-    wreg(cpu_state->hvf->fd, HV_X86_RFLAGS, env->eflags);
-    wreg(cpu_state->hvf->fd, HV_X86_RIP, env->eip);
+    wreg(cs->hvf->fd, HV_X86_RAX, env->regs[R_EAX]);
+    wreg(cs->hvf->fd, HV_X86_RBX, env->regs[R_EBX]);
+    wreg(cs->hvf->fd, HV_X86_RCX, env->regs[R_ECX]);
+    wreg(cs->hvf->fd, HV_X86_RDX, env->regs[R_EDX]);
+    wreg(cs->hvf->fd, HV_X86_RBP, env->regs[R_EBP]);
+    wreg(cs->hvf->fd, HV_X86_RSP, env->regs[R_ESP]);
+    wreg(cs->hvf->fd, HV_X86_RSI, env->regs[R_ESI]);
+    wreg(cs->hvf->fd, HV_X86_RDI, env->regs[R_EDI]);
+    wreg(cs->hvf->fd, HV_X86_R8, env->regs[8]);
+    wreg(cs->hvf->fd, HV_X86_R9, env->regs[9]);
+    wreg(cs->hvf->fd, HV_X86_R10, env->regs[10]);
+    wreg(cs->hvf->fd, HV_X86_R11, env->regs[11]);
+    wreg(cs->hvf->fd, HV_X86_R12, env->regs[12]);
+    wreg(cs->hvf->fd, HV_X86_R13, env->regs[13]);
+    wreg(cs->hvf->fd, HV_X86_R14, env->regs[14]);
+    wreg(cs->hvf->fd, HV_X86_R15, env->regs[15]);
+    wreg(cs->hvf->fd, HV_X86_RFLAGS, env->eflags);
+    wreg(cs->hvf->fd, HV_X86_RIP, env->eip);
    
-    wreg(cpu_state->hvf->fd, HV_X86_XCR0, env->xcr0);
+    wreg(cs->hvf->fd, HV_X86_XCR0, env->xcr0);
     
-    hvf_put_xsave(cpu_state);
+    hvf_put_xsave(cs);
     
-    hvf_put_segments(cpu_state);
+    hvf_put_segments(cs);
     
-    hvf_put_msrs(cpu_state);
+    hvf_put_msrs(cs);
     
-    wreg(cpu_state->hvf->fd, HV_X86_DR0, env->dr[0]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR1, env->dr[1]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR2, env->dr[2]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR3, env->dr[3]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR4, env->dr[4]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR5, env->dr[5]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR6, env->dr[6]);
-    wreg(cpu_state->hvf->fd, HV_X86_DR7, env->dr[7]);
+    wreg(cs->hvf->fd, HV_X86_DR0, env->dr[0]);
+    wreg(cs->hvf->fd, HV_X86_DR1, env->dr[1]);
+    wreg(cs->hvf->fd, HV_X86_DR2, env->dr[2]);
+    wreg(cs->hvf->fd, HV_X86_DR3, env->dr[3]);
+    wreg(cs->hvf->fd, HV_X86_DR4, env->dr[4]);
+    wreg(cs->hvf->fd, HV_X86_DR5, env->dr[5]);
+    wreg(cs->hvf->fd, HV_X86_DR6, env->dr[6]);
+    wreg(cs->hvf->fd, HV_X86_DR7, env->dr[7]);
     
     return 0;
 }
 
-int hvf_get_registers(CPUState *cpu_state)
+int hvf_get_registers(CPUState *cs)
 {
-    X86CPU *x86cpu = X86_CPU(cpu_state);
+    X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
 
-    env->regs[R_EAX] = rreg(cpu_state->hvf->fd, HV_X86_RAX);
-    env->regs[R_EBX] = rreg(cpu_state->hvf->fd, HV_X86_RBX);
-    env->regs[R_ECX] = rreg(cpu_state->hvf->fd, HV_X86_RCX);
-    env->regs[R_EDX] = rreg(cpu_state->hvf->fd, HV_X86_RDX);
-    env->regs[R_EBP] = rreg(cpu_state->hvf->fd, HV_X86_RBP);
-    env->regs[R_ESP] = rreg(cpu_state->hvf->fd, HV_X86_RSP);
-    env->regs[R_ESI] = rreg(cpu_state->hvf->fd, HV_X86_RSI);
-    env->regs[R_EDI] = rreg(cpu_state->hvf->fd, HV_X86_RDI);
-    env->regs[8] = rreg(cpu_state->hvf->fd, HV_X86_R8);
-    env->regs[9] = rreg(cpu_state->hvf->fd, HV_X86_R9);
-    env->regs[10] = rreg(cpu_state->hvf->fd, HV_X86_R10);
-    env->regs[11] = rreg(cpu_state->hvf->fd, HV_X86_R11);
-    env->regs[12] = rreg(cpu_state->hvf->fd, HV_X86_R12);
-    env->regs[13] = rreg(cpu_state->hvf->fd, HV_X86_R13);
-    env->regs[14] = rreg(cpu_state->hvf->fd, HV_X86_R14);
-    env->regs[15] = rreg(cpu_state->hvf->fd, HV_X86_R15);
+    env->regs[R_EAX] = rreg(cs->hvf->fd, HV_X86_RAX);
+    env->regs[R_EBX] = rreg(cs->hvf->fd, HV_X86_RBX);
+    env->regs[R_ECX] = rreg(cs->hvf->fd, HV_X86_RCX);
+    env->regs[R_EDX] = rreg(cs->hvf->fd, HV_X86_RDX);
+    env->regs[R_EBP] = rreg(cs->hvf->fd, HV_X86_RBP);
+    env->regs[R_ESP] = rreg(cs->hvf->fd, HV_X86_RSP);
+    env->regs[R_ESI] = rreg(cs->hvf->fd, HV_X86_RSI);
+    env->regs[R_EDI] = rreg(cs->hvf->fd, HV_X86_RDI);
+    env->regs[8] = rreg(cs->hvf->fd, HV_X86_R8);
+    env->regs[9] = rreg(cs->hvf->fd, HV_X86_R9);
+    env->regs[10] = rreg(cs->hvf->fd, HV_X86_R10);
+    env->regs[11] = rreg(cs->hvf->fd, HV_X86_R11);
+    env->regs[12] = rreg(cs->hvf->fd, HV_X86_R12);
+    env->regs[13] = rreg(cs->hvf->fd, HV_X86_R13);
+    env->regs[14] = rreg(cs->hvf->fd, HV_X86_R14);
+    env->regs[15] = rreg(cs->hvf->fd, HV_X86_R15);
     
-    env->eflags = rreg(cpu_state->hvf->fd, HV_X86_RFLAGS);
-    env->eip = rreg(cpu_state->hvf->fd, HV_X86_RIP);
+    env->eflags = rreg(cs->hvf->fd, HV_X86_RFLAGS);
+    env->eip = rreg(cs->hvf->fd, HV_X86_RIP);
    
-    hvf_get_xsave(cpu_state);
-    env->xcr0 = rreg(cpu_state->hvf->fd, HV_X86_XCR0);
+    hvf_get_xsave(cs);
+    env->xcr0 = rreg(cs->hvf->fd, HV_X86_XCR0);
     
-    hvf_get_segments(cpu_state);
-    hvf_get_msrs(cpu_state);
+    hvf_get_segments(cs);
+    hvf_get_msrs(cs);
     
-    env->dr[0] = rreg(cpu_state->hvf->fd, HV_X86_DR0);
-    env->dr[1] = rreg(cpu_state->hvf->fd, HV_X86_DR1);
-    env->dr[2] = rreg(cpu_state->hvf->fd, HV_X86_DR2);
-    env->dr[3] = rreg(cpu_state->hvf->fd, HV_X86_DR3);
-    env->dr[4] = rreg(cpu_state->hvf->fd, HV_X86_DR4);
-    env->dr[5] = rreg(cpu_state->hvf->fd, HV_X86_DR5);
-    env->dr[6] = rreg(cpu_state->hvf->fd, HV_X86_DR6);
-    env->dr[7] = rreg(cpu_state->hvf->fd, HV_X86_DR7);
+    env->dr[0] = rreg(cs->hvf->fd, HV_X86_DR0);
+    env->dr[1] = rreg(cs->hvf->fd, HV_X86_DR1);
+    env->dr[2] = rreg(cs->hvf->fd, HV_X86_DR2);
+    env->dr[3] = rreg(cs->hvf->fd, HV_X86_DR3);
+    env->dr[4] = rreg(cs->hvf->fd, HV_X86_DR4);
+    env->dr[5] = rreg(cs->hvf->fd, HV_X86_DR5);
+    env->dr[6] = rreg(cs->hvf->fd, HV_X86_DR6);
+    env->dr[7] = rreg(cs->hvf->fd, HV_X86_DR7);
     
     x86_update_hflags(env);
     return 0;
 }
 
-static void vmx_set_int_window_exiting(CPUState *cpu)
+static void vmx_set_int_window_exiting(CPUState *cs)
 {
      uint64_t val;
-     val = rvmcs(cpu->hvf->fd, VMCS_PRI_PROC_BASED_CTLS);
-     wvmcs(cpu->hvf->fd, VMCS_PRI_PROC_BASED_CTLS, val |
+     val = rvmcs(cs->hvf->fd, VMCS_PRI_PROC_BASED_CTLS);
+     wvmcs(cs->hvf->fd, VMCS_PRI_PROC_BASED_CTLS, val |
              VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
 }
 
-void vmx_clear_int_window_exiting(CPUState *cpu)
+void vmx_clear_int_window_exiting(CPUState *cs)
 {
      uint64_t val;
-     val = rvmcs(cpu->hvf->fd, VMCS_PRI_PROC_BASED_CTLS);
-     wvmcs(cpu->hvf->fd, VMCS_PRI_PROC_BASED_CTLS, val &
+     val = rvmcs(cs->hvf->fd, VMCS_PRI_PROC_BASED_CTLS);
+     wvmcs(cs->hvf->fd, VMCS_PRI_PROC_BASED_CTLS, val &
              ~VMCS_PRI_PROC_BASED_CTLS_INT_WINDOW_EXITING);
 }
 
-bool hvf_inject_interrupts(CPUState *cpu_state)
+bool hvf_inject_interrupts(CPUState *cs)
 {
-    X86CPU *x86cpu = X86_CPU(cpu_state);
+    X86CPU *x86cpu = X86_CPU(cs);
     CPUX86State *env = &x86cpu->env;
 
     uint8_t vector;
@@ -372,89 +372,89 @@ bool hvf_inject_interrupts(CPUState *cpu_state)
     uint64_t info = 0;
     if (have_event) {
         info = vector | intr_type | VMCS_INTR_VALID;
-        uint64_t reason = rvmcs(cpu_state->hvf->fd, VMCS_EXIT_REASON);
+        uint64_t reason = rvmcs(cs->hvf->fd, VMCS_EXIT_REASON);
         if (env->nmi_injected && reason != EXIT_REASON_TASK_SWITCH) {
-            vmx_clear_nmi_blocking(cpu_state);
+            vmx_clear_nmi_blocking(cs);
         }
 
         if (!(env->hflags2 & HF2_NMI_MASK) || intr_type != VMCS_INTR_T_NMI) {
             info &= ~(1 << 12); /* clear undefined bit */
             if (intr_type == VMCS_INTR_T_SWINTR ||
                 intr_type == VMCS_INTR_T_SWEXCEPTION) {
-                wvmcs(cpu_state->hvf->fd, VMCS_ENTRY_INST_LENGTH, env->ins_len);
+                wvmcs(cs->hvf->fd, VMCS_ENTRY_INST_LENGTH, env->ins_len);
             }
             
             if (env->has_error_code) {
-                wvmcs(cpu_state->hvf->fd, VMCS_ENTRY_EXCEPTION_ERROR,
+                wvmcs(cs->hvf->fd, VMCS_ENTRY_EXCEPTION_ERROR,
                       env->error_code);
                 /* Indicate that VMCS_ENTRY_EXCEPTION_ERROR is valid */
                 info |= VMCS_INTR_DEL_ERRCODE;
             }
             /*printf("reinject  %lx err %d\n", info, err);*/
-            wvmcs(cpu_state->hvf->fd, VMCS_ENTRY_INTR_INFO, info);
+            wvmcs(cs->hvf->fd, VMCS_ENTRY_INTR_INFO, info);
         };
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_NMI) {
+    if (cs->interrupt_request & CPU_INTERRUPT_NMI) {
         if (!(env->hflags2 & HF2_NMI_MASK) && !(info & VMCS_INTR_VALID)) {
-            cpu_state->interrupt_request &= ~CPU_INTERRUPT_NMI;
+            cs->interrupt_request &= ~CPU_INTERRUPT_NMI;
             info = VMCS_INTR_VALID | VMCS_INTR_T_NMI | EXCP02_NMI;
-            wvmcs(cpu_state->hvf->fd, VMCS_ENTRY_INTR_INFO, info);
+            wvmcs(cs->hvf->fd, VMCS_ENTRY_INTR_INFO, info);
         } else {
-            vmx_set_nmi_window_exiting(cpu_state);
+            vmx_set_nmi_window_exiting(cs);
         }
     }
 
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
-        (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+        (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
         int line = cpu_get_pic_interrupt(&x86cpu->env);
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_HARD;
+        cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
         if (line >= 0) {
-            wvmcs(cpu_state->hvf->fd, VMCS_ENTRY_INTR_INFO, line |
+            wvmcs(cs->hvf->fd, VMCS_ENTRY_INTR_INFO, line |
                   VMCS_INTR_VALID | VMCS_INTR_T_HWINTR);
         }
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_HARD) {
-        vmx_set_int_window_exiting(cpu_state);
+    if (cs->interrupt_request & CPU_INTERRUPT_HARD) {
+        vmx_set_int_window_exiting(cs);
     }
-    return (cpu_state->interrupt_request
+    return (cs->interrupt_request
             & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR));
 }
 
-int hvf_process_events(CPUState *cpu_state)
+int hvf_process_events(CPUState *cs)
 {
-    X86CPU *cpu = X86_CPU(cpu_state);
+    X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
 
-    if (!cpu_state->vcpu_dirty) {
+    if (!cs->vcpu_dirty) {
         /* light weight sync for CPU_INTERRUPT_HARD and IF_MASK */
-        env->eflags = rreg(cpu_state->hvf->fd, HV_X86_RFLAGS);
+        env->eflags = rreg(cs->hvf->fd, HV_X86_RFLAGS);
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_INIT) {
-        cpu_synchronize_state(cpu_state);
+    if (cs->interrupt_request & CPU_INTERRUPT_INIT) {
+        cpu_synchronize_state(cs);
         do_cpu_init(cpu);
     }
 
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_POLL) {
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_POLL;
+    if (cs->interrupt_request & CPU_INTERRUPT_POLL) {
+        cs->interrupt_request &= ~CPU_INTERRUPT_POLL;
         apic_poll_irq(cpu->apic_state);
     }
-    if (((cpu_state->interrupt_request & CPU_INTERRUPT_HARD) &&
+    if (((cs->interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK)) ||
-        (cpu_state->interrupt_request & CPU_INTERRUPT_NMI)) {
-        cpu_state->halted = 0;
+        (cs->interrupt_request & CPU_INTERRUPT_NMI)) {
+        cs->halted = 0;
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_SIPI) {
-        cpu_synchronize_state(cpu_state);
+    if (cs->interrupt_request & CPU_INTERRUPT_SIPI) {
+        cpu_synchronize_state(cs);
         do_cpu_sipi(cpu);
     }
-    if (cpu_state->interrupt_request & CPU_INTERRUPT_TPR) {
-        cpu_state->interrupt_request &= ~CPU_INTERRUPT_TPR;
-        cpu_synchronize_state(cpu_state);
+    if (cs->interrupt_request & CPU_INTERRUPT_TPR) {
+        cs->interrupt_request &= ~CPU_INTERRUPT_TPR;
+        cpu_synchronize_state(cs);
         apic_handle_tpr_access_report(cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-    return cpu_state->halted;
+    return cs->halted;
 }
-- 
2.38.1


