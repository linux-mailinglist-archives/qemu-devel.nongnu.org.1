Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A997415E5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXVI-0000a0-MF; Wed, 28 Jun 2023 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVE-0000He-Se
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:44 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXVC-0000ZE-V7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fa9850bfd9so775965e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967681; x=1690559681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFYz0OS825kpDpTGwXL4mcxjaEDKoUioeDWOeGz5uxc=;
 b=MOIXWhBc9QP0b//b9fI6LQJqPPIx3KwtvNMim7xf0maGeDMYJ90S2iaPR3SYKwHoIG
 fT2bByzY8CsO3cf1z26H5HOx54ZhDg9H5N19fO6wkHx8LVCgpWbpGqMCJzyiZ2bmwpRT
 opvMfdASJoiXq5xlQtQNjcQ6yCmXz/4Z7dzV6Yi9UFOk50tyQNmugtY5PjtY1vWzWmOk
 2J2DiYAtTZP8eBETddasC1MkMvrwC08fKf1uKMpCbgT5ghVwO7jMmOnWCgwbGYqUyBLa
 IJ6y5IkzJdtm/FrZ0Q9E58eapuz5VkgD3th3fz2oUSBeVuiZlGzQueh5qEc6SmYJfbPD
 U+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967681; x=1690559681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFYz0OS825kpDpTGwXL4mcxjaEDKoUioeDWOeGz5uxc=;
 b=hEFUW5wRaG18ZvabklQrgWeYdcFZ+AhZE0AxUVFyR2KxzW3gvIzgNM3TkrwTxSGMNp
 pRYiW31h3sXPUmlHGAE/mxNb8jg43Hkj5KyJJH8kNCfa9/F+UpcCsL7xzkiVEEKMyFo2
 ScA5XkA+v2sJNVKiqlmfoHC56zatUQTlIOt+cBM8Odfoq2b8qTtah2+pOUXpd4F3oXzI
 tfppaMNyjkTFUnvLAO51+MKjWjyr0YyaywNGhGcZJh+WwLkSuViFZzmEFNfz6p+u9PtY
 mQouO+Nv2SK0urUC3orh21xEyrM4K+4g7CmyxLWvng4Y26aqiLAsecdfONqLilTHWVHY
 vojA==
X-Gm-Message-State: AC+VfDyrE6LtDoM0z2F+MSTLi57Hmp1GKqufWGBzDeyl79ZyUYtusWgN
 2njk/6FomwziNVvL1OTRmSDOamdKAj8L9PYPtU0=
X-Google-Smtp-Source: ACHHUZ6hxJQ0EX2GaA97Zr8krt4rYxtNaFqCGr4VWUcYcU8o9lvFkPhVVEIXlO2mxBSphgWwxXzT4A==
X-Received: by 2002:a1c:6a0e:0:b0:3fb:b1af:a455 with SMTP id
 f14-20020a1c6a0e000000b003fbb1afa455mr1629943wmc.5.1687967681265; 
 Wed, 28 Jun 2023 08:54:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bc8ca000000b003fbad1b4904sm2908298wml.0.2023.06.28.08.54.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/30] accel: Rename WHPX 'struct whpx_vcpu' -> AccelCPUState
Date: Wed, 28 Jun 2023 17:52:58 +0200
Message-Id: <20230628155313.71594-16-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We want all accelerators to share the same opaque pointer in
CPUState. Rename WHPX 'whpx_vcpu' as 'AccelCPUState'; use
the typedef.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230624174121.11508-14-philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 63be5fbdad..185f2a2820 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -229,7 +229,7 @@ typedef enum WhpxStepMode {
     WHPX_STEP_EXCLUSIVE,
 } WhpxStepMode;
 
-struct whpx_vcpu {
+struct AccelCPUState {
     WHV_EMULATOR_HANDLE emulator;
     bool window_registered;
     bool interruptable;
@@ -260,9 +260,9 @@ static bool whpx_has_xsave(void)
  * VP support
  */
 
-static struct whpx_vcpu *get_whpx_vcpu(CPUState *cpu)
+static AccelCPUState *get_whpx_vcpu(CPUState *cpu)
 {
-    return (struct whpx_vcpu *)cpu->accel;
+    return (AccelCPUState *)cpu->accel;
 }
 
 static WHV_X64_SEGMENT_REGISTER whpx_seg_q2h(const SegmentCache *qs, int v86,
@@ -390,7 +390,7 @@ static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
 static void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_register_set vcxt;
@@ -609,7 +609,7 @@ static void whpx_get_xcrs(CPUState *cpu)
 static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_register_set vcxt;
@@ -892,7 +892,7 @@ static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     HRESULT hr;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
     hr = whp_dispatch.WHvEmulatorTryMmioEmulation(
@@ -917,7 +917,7 @@ static int whpx_handle_portio(CPUState *cpu,
                               WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx)
 {
     HRESULT hr;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     WHV_EMULATOR_STATUS emu_status;
 
     hr = whp_dispatch.WHvEmulatorTryIoEmulation(
@@ -1417,7 +1417,7 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
          * of QEMU, nor this port by calling WHvSetVirtualProcessorRegisters().
          * This is the most common case.
          */
-        struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+        AccelCPUState *vcpu = get_whpx_vcpu(cpu);
         return vcpu->exit_ctx.VpContext.Rip;
     } else {
         /*
@@ -1468,7 +1468,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
@@ -1590,7 +1590,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
 static void whpx_vcpu_post_run(CPUState *cpu)
 {
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
 
@@ -1617,7 +1617,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
 
     if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
@@ -1656,7 +1656,7 @@ static int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
     struct whpx_breakpoint *stepped_over_bp = NULL;
     WhpxStepMode exclusive_step_mode = WHPX_STEP_NONE;
     int ret;
@@ -2154,7 +2154,7 @@ int whpx_init_vcpu(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = NULL;
+    AccelCPUState *vcpu = NULL;
     Error *local_error = NULL;
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -2177,7 +2177,7 @@ int whpx_init_vcpu(CPUState *cpu)
         }
     }
 
-    vcpu = g_new0(struct whpx_vcpu, 1);
+    vcpu = g_new0(AccelCPUState, 1);
 
     hr = whp_dispatch.WHvEmulatorCreateEmulator(
         &whpx_emu_callbacks,
@@ -2290,7 +2290,7 @@ int whpx_vcpu_exec(CPUState *cpu)
 void whpx_destroy_vcpu(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    struct whpx_vcpu *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-- 
2.38.1


