Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4EC73CC3B
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7HZ-0007ml-Ec; Sat, 24 Jun 2023 13:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7HX-0007gH-GN
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:43 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7HV-0007Bk-MK
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:42:43 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso244484866b.2
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628559; x=1690220559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6yG7uyZQhQuE8IRVfm1616U0ICNkMM4p4uOU/m5IL/M=;
 b=dxyHvFLOjiM5qIEukAG2xMl1n86ITsN2iybJyGEigjKJVlhy51cYS87u2DPnXQ31pC
 gHAkCCHkCYY16GPiyHKQbc3JgGIWt8KVZKMQ11bQMxI8wmbkhpXTrhSRIis7MvSzXzGA
 QqIQX7YU8zRGusA6i+PUsjOKGUGI5MyD+m9fQnHJoKgoqtbykvuvRgFuKcOrXiZ5wK82
 d4+FrbU+wLhVnWAPZm65aY66PB+II/Npxd/kMcikCaDIXW9+qED/83zvrvxZ25rk5SV9
 YL9Y823LfrKqEK09lhq7IjRqf8oiJ0Vir5S+qOmXMiSNmRx8hZhk6ngn/jDc60j75Spz
 ZjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628559; x=1690220559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6yG7uyZQhQuE8IRVfm1616U0ICNkMM4p4uOU/m5IL/M=;
 b=gQ2CFH5IXc3wTpECairfd1ap9S++xk8liWdc5bCQ9ykJbdIu9OUCCRQJuBbUr5ML4t
 2mP5NP0/AAj3ItxqS7QESxokKG32QaUQWa4wAPVvnwx620a3tgEXOKGjDyWx+0kLa4mM
 idzRCh3p2RArWTTVmiQnW1Gck6uMSZI1ENxPAUciH0D+vtz4JBMiPaT3aFBEiZgAlW10
 E07M75KYdDG0ByPLiikrt1OwaaHKx/JNY1GAjXYX/kbNEP6MCVJP6Z5GbgVhWTd13YlS
 mpwUi3Iuo9NBBbXQ+rkdUiiRv8P2MyCcB1gU5vWVXDBHQT5uLmOCF0mdYG+9/42uVxnR
 bfHQ==
X-Gm-Message-State: AC+VfDz3ud9+FiCQWjxiTCHREOyQXnKLuO7vxWee5nSuWdtx3MSCEQcS
 eKz7hDaC2FadyYZR1z8ruIoZi9Q3htijEPrSRGU=
X-Google-Smtp-Source: ACHHUZ60zeHeS0keOdxvMmlIP6tQPqVFwiu+Q/14meF2x41zpcQ/taPA6Be68P7WOGnSc/Te+Ujdng==
X-Received: by 2002:a17:907:360e:b0:96a:4ea0:a1e7 with SMTP id
 bk14-20020a170907360e00b0096a4ea0a1e7mr23798201ejc.50.1687628559647; 
 Sat, 24 Jun 2023 10:42:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a170906948e00b009886aaeb722sm1109079ejx.137.2023.06.24.10.42.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:42:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 10/16] accel: Rename NVMM 'struct qemu_vcpu' ->
 AccelCPUState
Date: Sat, 24 Jun 2023 19:41:15 +0200
Message-Id: <20230624174121.11508-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

We want all accelerators to share the same opaque pointer in
CPUState. Rename NVMM 'qemu_vcpu' as 'AccelCPUState'; directly
use the typedef, remove unnecessary casts.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 90e9e0a5b2..e5ee4af084 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -26,7 +26,7 @@
 
 #include <nvmm.h>
 
-struct qemu_vcpu {
+struct AccelCPUState {
     struct nvmm_vcpu vcpu;
     uint8_t tpr;
     bool stop;
@@ -49,10 +49,10 @@ struct qemu_machine {
 static bool nvmm_allowed;
 static struct qemu_machine qemu_mach;
 
-static struct qemu_vcpu *
+static AccelCPUState *
 get_qemu_vcpu(CPUState *cpu)
 {
-    return (struct qemu_vcpu *)cpu->accel;
+    return cpu->accel;
 }
 
 static struct nvmm_machine *
@@ -86,7 +86,7 @@ nvmm_set_registers(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     struct nvmm_machine *mach = get_nvmm_mach();
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     struct nvmm_x64_state *state = vcpu->state;
     uint64_t bitmap;
@@ -223,7 +223,7 @@ nvmm_get_registers(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     struct nvmm_machine *mach = get_nvmm_mach();
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct nvmm_x64_state *state = vcpu->state;
@@ -347,7 +347,7 @@ static bool
 nvmm_can_take_int(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     struct nvmm_machine *mach = get_nvmm_mach();
 
@@ -372,7 +372,7 @@ nvmm_can_take_int(CPUState *cpu)
 static bool
 nvmm_can_take_nmi(CPUState *cpu)
 {
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
 
     /*
      * Contrary to INTs, NMIs always schedule an exit when they are
@@ -395,7 +395,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     struct nvmm_machine *mach = get_nvmm_mach();
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct nvmm_x64_state *state = vcpu->state;
@@ -478,7 +478,7 @@ nvmm_vcpu_pre_run(CPUState *cpu)
 static void
 nvmm_vcpu_post_run(CPUState *cpu, struct nvmm_vcpu_exit *exit)
 {
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     CPUX86State *env = cpu->env_ptr;
     X86CPU *x86_cpu = X86_CPU(cpu);
     uint64_t tpr;
@@ -565,7 +565,7 @@ static int
 nvmm_handle_rdmsr(struct nvmm_machine *mach, CPUState *cpu,
     struct nvmm_vcpu_exit *exit)
 {
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct nvmm_x64_state *state = vcpu->state;
@@ -610,7 +610,7 @@ static int
 nvmm_handle_wrmsr(struct nvmm_machine *mach, CPUState *cpu,
     struct nvmm_vcpu_exit *exit)
 {
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct nvmm_x64_state *state = vcpu->state;
@@ -686,7 +686,7 @@ nvmm_vcpu_loop(CPUState *cpu)
 {
     CPUX86State *env = cpu->env_ptr;
     struct nvmm_machine *mach = get_nvmm_mach();
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
     struct nvmm_vcpu *vcpu = &qcpu->vcpu;
     X86CPU *x86_cpu = X86_CPU(cpu);
     struct nvmm_vcpu_exit *exit = vcpu->exit;
@@ -892,7 +892,7 @@ static void
 nvmm_ipi_signal(int sigcpu)
 {
     if (current_cpu) {
-        struct qemu_vcpu *qcpu = get_qemu_vcpu(current_cpu);
+        AccelCPUState *qcpu = get_qemu_vcpu(current_cpu);
 #if NVMM_USER_VERSION >= 2
         struct nvmm_vcpu *vcpu = &qcpu->vcpu;
         nvmm_vcpu_stop(vcpu);
@@ -926,7 +926,7 @@ nvmm_init_vcpu(CPUState *cpu)
     struct nvmm_vcpu_conf_cpuid cpuid;
     struct nvmm_vcpu_conf_tpr tpr;
     Error *local_error = NULL;
-    struct qemu_vcpu *qcpu;
+    AccelCPUState *qcpu;
     int ret, err;
 
     nvmm_init_cpu_signals();
@@ -942,7 +942,7 @@ nvmm_init_vcpu(CPUState *cpu)
         }
     }
 
-    qcpu = g_malloc0(sizeof(*qcpu));
+    qcpu = g_new0(AccelCPUState, 1);
 
     ret = nvmm_vcpu_create(mach, cpu->cpu_index, &qcpu->vcpu);
     if (ret == -1) {
@@ -1023,7 +1023,7 @@ void
 nvmm_destroy_vcpu(CPUState *cpu)
 {
     struct nvmm_machine *mach = get_nvmm_mach();
-    struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
+    AccelCPUState *qcpu = get_qemu_vcpu(cpu);
 
     nvmm_vcpu_destroy(mach, &qcpu->vcpu);
     g_free(cpu->accel);
-- 
2.38.1


