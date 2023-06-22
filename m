Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444ED73A5C8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMto-0000WI-9E; Thu, 22 Jun 2023 12:11:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMte-00086X-41
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMta-0002TL-15
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:57 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so5330822f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450251; x=1690042251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1vRGyzu8+XqKaMgtN/nMAkP8vtjVhpBIfkdPMVYyfg=;
 b=SzgUJ/3O2JDLimh3+Agd51LJmZaiaEI8ZFwaKFU+xUs5N8igbv+HWLrxj9PAtNvt2P
 tWlCEtAkV4Akr6+YlAN8K0+yYGd8sx7dWoQtnO9KdQzwhhCQld65/SzWP89kgi87B8eh
 lKMQC9nQ2o/IYRKSQG/yO9HtB3B5uhxSrJ9JhYdyhuNC01KDTA0mRGksU/fOnTci3VcF
 eTy0N5FdKs+2ao4NC9iyl73k4WTq5YyQZ/JcjaHtorbZwzW7L3xdvwCsUkTmug4AIfdv
 WLk3g3kHwPWZQJTJwWN7mJvQlvPyRQSzb5+sWK5ic1pU1dfvlbmGNaZyANDyv6I1Adx6
 w5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450251; x=1690042251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n1vRGyzu8+XqKaMgtN/nMAkP8vtjVhpBIfkdPMVYyfg=;
 b=DhCndOd/n/HYVzPZ3PNKYfDuIlCD7Ic9QUFOV5biTSLBqjfzegacgZ7gGbSAe0depe
 zc0NQRf2tKUcQ7EX++PoPOY4IkIcSr4jo5xh0+TCdhKECIlIvG9MvbjbJBLeutE3rMHU
 jNnIMG7sFiBzzO0G+zZCDmp6GSbYepxL6lfYSc9+pVqBOSpccH5ret6Kxo7DODdkyx92
 H+vJIqN7pnRagpx38FNlMahfWuxfH4D5wteiYTmM90CieTasM3UbVDPlieDlrO+9hQ79
 6GdLneF/Lor2Mz/5EkYPxzB461a61p0wBcPMhYCGxIPjfqZy6+3Rxsx6K3768hVJaynk
 IVhg==
X-Gm-Message-State: AC+VfDz6Ku74rW5FRK438zxB4XBSY8mDbidJlNEuRztsgfRt56ybCFCJ
 7o5JdcC+pgjKDwKrWhMzsnymbCcWBd4i96Zf5/ROaw==
X-Google-Smtp-Source: ACHHUZ6Zvkg+/2pI/zQv1tCUfVDDfB62uZn7snk8J9Qv86AyAfhXfm7jju4fWwybVTRViGAkVekuMA==
X-Received: by 2002:a5d:4cc2:0:b0:309:5068:9ebe with SMTP id
 c2-20020a5d4cc2000000b0030950689ebemr12061202wrt.50.1687450250976; 
 Thu, 22 Jun 2023 09:10:50 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 z17-20020a5d6551000000b00307bc4e39e5sm7314320wrv.117.2023.06.22.09.10.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:10:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 14/16] accel: Inline WHPX get_whpx_vcpu()
Date: Thu, 22 Jun 2023 18:08:21 +0200
Message-Id: <20230622160823.71851-15-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

No need for this helper to access the CPUState::accel field.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/whpx/whpx-all.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 107b731d3f..fdac13c7c1 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -256,15 +256,6 @@ static bool whpx_has_xsave(void)
     return whpx_xsave_cap.XsaveSupport;
 }
 
-/*
- * VP support
- */
-
-static AccelCPUState *get_whpx_vcpu(CPUState *cpu)
-{
-    return (AccelCPUState *)cpu->accel;
-}
-
 static WHV_X64_SEGMENT_REGISTER whpx_seg_q2h(const SegmentCache *qs, int v86,
                                              int r86)
 {
@@ -390,7 +381,7 @@ static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
 static void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_register_set vcxt;
@@ -609,7 +600,7 @@ static void whpx_get_xcrs(CPUState *cpu)
 static void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct whpx_register_set vcxt;
@@ -892,7 +883,7 @@ static const WHV_EMULATOR_CALLBACKS whpx_emu_callbacks = {
 static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     HRESULT hr;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     WHV_EMULATOR_STATUS emu_status;
 
     hr = whp_dispatch.WHvEmulatorTryMmioEmulation(
@@ -917,7 +908,7 @@ static int whpx_handle_portio(CPUState *cpu,
                               WHV_X64_IO_PORT_ACCESS_CONTEXT *ctx)
 {
     HRESULT hr;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     WHV_EMULATOR_STATUS emu_status;
 
     hr = whp_dispatch.WHvEmulatorTryIoEmulation(
@@ -1417,7 +1408,7 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
          * of QEMU, nor this port by calling WHvSetVirtualProcessorRegisters().
          * This is the most common case.
          */
-        AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+        AccelCPUState *vcpu = cpu->accel;
         return vcpu->exit_ctx.VpContext.Rip;
     } else {
         /*
@@ -1468,7 +1459,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     int irq;
@@ -1590,7 +1581,7 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
 
 static void whpx_vcpu_post_run(CPUState *cpu)
 {
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
 
@@ -1617,7 +1608,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
 
     if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
         !(env->hflags & HF_SMM_MASK)) {
@@ -1656,7 +1647,7 @@ static int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
     struct whpx_breakpoint *stepped_over_bp = NULL;
     WhpxStepMode exclusive_step_mode = WHPX_STEP_NONE;
     int ret;
@@ -2290,7 +2281,7 @@ int whpx_vcpu_exec(CPUState *cpu)
 void whpx_destroy_vcpu(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = get_whpx_vcpu(cpu);
+    AccelCPUState *vcpu = cpu->accel;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-- 
2.38.1


