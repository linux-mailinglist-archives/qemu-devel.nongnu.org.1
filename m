Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7857415BF
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 17:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXUm-0006FG-Ci; Wed, 28 Jun 2023 11:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUd-0006Em-8O
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:07 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEXUa-00087M-Kp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 11:54:06 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso8581200e87.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 08:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687967641; x=1690559641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+f7MRtwey3NUARcAobPWO2z1fprt2xwbgmS9mbLdSA8=;
 b=GNnCqERqsw4ed63RjfBghcU0FawaBg8OgTlwMNj0W1r4TX3J3+pwUlJYuksUHQZLlS
 +93Z6Zfy0pB1N0iDQ1wWQ45xm/7/r5pYCXNOO1yccGe1CEedU8tM18qdr+PgREZmQPxd
 xCrmh+9F97V2ozBpd/nje20NGH3Q7her2x7VmEuZeRYd0/Ew2e24GXTzmPKkkkEMf9gq
 cK7IqY+oAk/oDTd8ukckUlSkYEKBRHPK9mmtaICltHhQLA8cewybZhCGoKP+OCqHgOkh
 k/XGAhi2d0tv82stDDf1ZOiy6Q9lTPZ50ImUQhLMdB5Y2PH6sQuZoDbKHuN2pdjNErnx
 YOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687967641; x=1690559641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+f7MRtwey3NUARcAobPWO2z1fprt2xwbgmS9mbLdSA8=;
 b=ItbZF4bG95g155Ju6V1QcBw7xt8zhRwFJJWDz6HkphCLvUkbDJJsY/RLQ8LHSlVsK5
 sDMjofSijG8aMzvBs5t5cyEignTcFTPSvSdxUcrgRjdVYgIqx/Yh/P9uo0bl+v6WDI3r
 AAaLYeA2Im4gyL6SMjE540WY3u0YoxRIAJbgQQTB9ccSSsnUicbDwn3blbl4Fpl8JZ1k
 pRxGLxsWgIifqnxHuQ7IT5rugkvkA5S494Dj6fmnjrf1H8mw/yqC21NmjDCO6EwqonAl
 VL/J4u/7n1lauE+LR0yvmpgSJn+rgGO+Q7e7/AnP9gPLUZfT5zl8T0Q6GvSnMXeSWSoD
 +FOA==
X-Gm-Message-State: AC+VfDyNm2c2ZuefBeeLTmepD/ZK/YZGtPj+I9k5U6JwAFkQai8f9z89
 wpJmw4g51+2AkRm9veZwom2WbqslVWAE8QK5UlE=
X-Google-Smtp-Source: ACHHUZ6cNubXF1cfTK8oSP2aJ9KdmpzsEKDUG1bz1qJpSfOa+pcynDHnWNJEEnMMOujNhmzcEvZSRg==
X-Received: by 2002:a05:6512:3246:b0:4fb:8926:b12f with SMTP id
 c6-20020a056512324600b004fb8926b12fmr2779346lfr.26.1687967641171; 
 Wed, 28 Jun 2023 08:54:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 u20-20020a05600c211400b003fbb618f7adsm72266wml.15.2023.06.28.08.53.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Jun 2023 08:54:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 08/30] accel: Rename 'hax_vcpu' as 'accel' in CPUState
Date: Wed, 28 Jun 2023 17:52:51 +0200
Message-Id: <20230628155313.71594-9-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230628155313.71594-1-philmd@linaro.org>
References: <20230628155313.71594-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
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

All accelerators will share a single opaque context
in CPUState. Start by renaming 'hax_vcpu' as 'accel'.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230624174121.11508-7-philmd@linaro.org>
---
 include/hw/core/cpu.h           |  2 +-
 target/i386/hax/hax-accel-ops.c |  2 +-
 target/i386/hax/hax-all.c       | 18 +++++++++---------
 target/i386/nvmm/nvmm-all.c     |  6 +++---
 target/i386/whpx/whpx-all.c     |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index eda0230a02..63c25ce106 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -443,7 +443,7 @@ struct CPUState {
     /* Used for user-only emulation of prctl(PR_SET_UNALIGN). */
     bool prctl_unalign_sigbus;
 
-    struct hax_vcpu_state *hax_vcpu;
+    struct hax_vcpu_state *accel;
 
     struct hvf_vcpu_state *hvf;
 
diff --git a/target/i386/hax/hax-accel-ops.c b/target/i386/hax/hax-accel-ops.c
index 0157a628a3..a8512efcd5 100644
--- a/target/i386/hax/hax-accel-ops.c
+++ b/target/i386/hax/hax-accel-ops.c
@@ -71,7 +71,7 @@ static void hax_start_vcpu_thread(CPUState *cpu)
              cpu->cpu_index);
     qemu_thread_create(cpu->thread, thread_name, hax_cpu_thread_fn,
                        cpu, QEMU_THREAD_JOINABLE);
-    assert(cpu->hax_vcpu);
+    assert(cpu->accel);
 #ifdef _WIN32
     cpu->hThread = qemu_thread_get_handle(cpu->thread);
 #endif
diff --git a/target/i386/hax/hax-all.c b/target/i386/hax/hax-all.c
index 38a4323a3c..3865ff9419 100644
--- a/target/i386/hax/hax-all.c
+++ b/target/i386/hax/hax-all.c
@@ -62,7 +62,7 @@ int valid_hax_tunnel_size(uint16_t size)
 
 hax_fd hax_vcpu_get_fd(CPUArchState *env)
 {
-    struct hax_vcpu_state *vcpu = env_cpu(env)->hax_vcpu;
+    struct hax_vcpu_state *vcpu = env_cpu(env)->accel;
     if (!vcpu) {
         return HAX_INVALID_FD;
     }
@@ -188,7 +188,7 @@ int hax_vcpu_create(int id)
 
 int hax_vcpu_destroy(CPUState *cpu)
 {
-    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_vcpu_state *vcpu = cpu->accel;
 
     if (!hax_global.vm) {
         fprintf(stderr, "vcpu %x destroy failed, vm is null\n", vcpu->vcpu_id);
@@ -209,7 +209,7 @@ int hax_vcpu_destroy(CPUState *cpu)
     CloseHandle(cpu->hThread);
 #endif
     g_free(vcpu);
-    cpu->hax_vcpu = NULL;
+    cpu->accel = NULL;
     return 0;
 }
 
@@ -223,7 +223,7 @@ int hax_init_vcpu(CPUState *cpu)
         exit(-1);
     }
 
-    cpu->hax_vcpu = hax_global.vm->vcpus[cpu->cpu_index];
+    cpu->accel = hax_global.vm->vcpus[cpu->cpu_index];
     cpu->vcpu_dirty = true;
     qemu_register_reset(hax_reset_vcpu_state, cpu->env_ptr);
 
@@ -415,7 +415,7 @@ static int hax_handle_io(CPUArchState *env, uint32_t df, uint16_t port,
 static int hax_vcpu_interrupt(CPUArchState *env)
 {
     CPUState *cpu = env_cpu(env);
-    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_vcpu_state *vcpu = cpu->accel;
     struct hax_tunnel *ht = vcpu->tunnel;
 
     /*
@@ -447,7 +447,7 @@ static int hax_vcpu_interrupt(CPUArchState *env)
 
 void hax_raise_event(CPUState *cpu)
 {
-    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_vcpu_state *vcpu = cpu->accel;
 
     if (!vcpu) {
         return;
@@ -468,7 +468,7 @@ static int hax_vcpu_hax_exec(CPUArchState *env)
     int ret = 0;
     CPUState *cpu = env_cpu(env);
     X86CPU *x86_cpu = X86_CPU(cpu);
-    struct hax_vcpu_state *vcpu = cpu->hax_vcpu;
+    struct hax_vcpu_state *vcpu = cpu->accel;
     struct hax_tunnel *ht = vcpu->tunnel;
 
     if (!hax_enabled()) {
@@ -1114,8 +1114,8 @@ void hax_reset_vcpu_state(void *opaque)
 {
     CPUState *cpu;
     for (cpu = first_cpu; cpu != NULL; cpu = CPU_NEXT(cpu)) {
-        cpu->hax_vcpu->tunnel->user_event_pending = 0;
-        cpu->hax_vcpu->tunnel->ready_for_interrupt_injection = 0;
+        cpu->accel->tunnel->user_event_pending = 0;
+        cpu->accel->tunnel->ready_for_interrupt_injection = 0;
     }
 }
 
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index b75738ee9c..cf4f0af24b 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -52,7 +52,7 @@ static struct qemu_machine qemu_mach;
 static struct qemu_vcpu *
 get_qemu_vcpu(CPUState *cpu)
 {
-    return (struct qemu_vcpu *)cpu->hax_vcpu;
+    return (struct qemu_vcpu *)cpu->accel;
 }
 
 static struct nvmm_machine *
@@ -995,7 +995,7 @@ nvmm_init_vcpu(CPUState *cpu)
     }
 
     cpu->vcpu_dirty = true;
-    cpu->hax_vcpu = (struct hax_vcpu_state *)qcpu;
+    cpu->accel = (struct hax_vcpu_state *)qcpu;
 
     return 0;
 }
@@ -1030,7 +1030,7 @@ nvmm_destroy_vcpu(CPUState *cpu)
     struct qemu_vcpu *qcpu = get_qemu_vcpu(cpu);
 
     nvmm_vcpu_destroy(mach, &qcpu->vcpu);
-    g_free(cpu->hax_vcpu);
+    g_free(cpu->accel);
 }
 
 /* -------------------------------------------------------------------------- */
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 7fa68d49e5..98dfa5cfc2 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -262,7 +262,7 @@ static bool whpx_has_xsave(void)
 
 static struct whpx_vcpu *get_whpx_vcpu(CPUState *cpu)
 {
-    return (struct whpx_vcpu *)cpu->hax_vcpu;
+    return (struct whpx_vcpu *)cpu->accel;
 }
 
 static WHV_X64_SEGMENT_REGISTER whpx_seg_q2h(const SegmentCache *qs, int v86,
@@ -2258,7 +2258,7 @@ int whpx_init_vcpu(CPUState *cpu)
 
     vcpu->interruptable = true;
     cpu->vcpu_dirty = true;
-    cpu->hax_vcpu = (struct hax_vcpu_state *)vcpu;
+    cpu->accel = (struct hax_vcpu_state *)vcpu;
     max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
     qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
 
@@ -2300,7 +2300,7 @@ void whpx_destroy_vcpu(CPUState *cpu)
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-    g_free(cpu->hax_vcpu);
+    g_free(cpu->accel);
     return;
 }
 
-- 
2.38.1


