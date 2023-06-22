Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB0F73A5B8
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:10:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMtL-0007AI-VW; Thu, 22 Jun 2023 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMsz-0006VU-AF
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMsu-0001T3-Pr
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:10:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31121494630so8422845f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450211; x=1690042211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKJxOwJmFtwOPAoIICT6M4A+Kzh99mIVYxe/d/9G77Y=;
 b=eg02hjlfgcDaH24aEbjvIFOFqry3t+y3ca6mONxnjQGWPL1Jdtwu4KdzlrO2pncUEm
 v2uAXFNtaqYiIggOc18WWF8JNx7doFAbVKyL4i5VvjAKuJTrn61jQREqSGuH7wbxPOHB
 SQl9lpmkdOY2I8TmvPTRmSHTV/xdmaBelLgPfNn9zpSA2OubeWfB677UATrlvOYIbcR5
 Xd77M5NfRhzJ8nLGIWLXvPckfbvl62BDfMBhKFdJDV8OUDdGPmWJ81CYWWuuNJVbGqz8
 ykGAHRraJs8kr5Nc/YT6E4MagkrdbYLZbwKyQ84h9/BoPe+M9i29JT/WKZ3nt6qAzCaS
 onVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450211; x=1690042211;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DKJxOwJmFtwOPAoIICT6M4A+Kzh99mIVYxe/d/9G77Y=;
 b=fLuH78Lc4lQbBN8zlLUi7c8kC+2Xe31uT3fP3LytFC1vlOxDKJaDRMr9ja6JXIE7IX
 6Q5dvAtSfC4Inv7dK6PJ2whFqdKrCBiXn4rL+58nxJfDzUhQbBmrx8I/Cl9I5dM6CVPM
 RqS+H2mmSKSezNvzDbpHoNh8rndn8doBJrj8+SnVpd5sqvf6Noi4QV7r2O2XXnwm1Gmp
 b0W40znF7tn5VlB2oYU6UvQv5U9sNcpKYtQr9vqqLB0mVf3BztdnuFbDkcVTTriH6zNd
 dVvAARdpM/puAq+Kdf4s/38EeiynuxfmHLogdFj5soE0nOvL7a1tVVrhT9vfcGinN/WH
 2UsQ==
X-Gm-Message-State: AC+VfDx8EmqXjWWqaBXN/N0OwRRkmb8RM4g2lbFpkXnDSG7BaMSDCm6G
 zc8xxHbiFqrxSHpUBzmLIf900HYrJFgUi2hcvRYj/Q==
X-Google-Smtp-Source: ACHHUZ4UJwkfw8UWBY57D2hqCgPl1JN/hvtysVX8WTPHmCC0zEYaJGE4bKrnhQf98VbpMbWrM/7XNw==
X-Received: by 2002:a5d:5751:0:b0:30f:c943:f925 with SMTP id
 q17-20020a5d5751000000b0030fc943f925mr15315373wrw.49.1687450210926; 
 Thu, 22 Jun 2023 09:10:10 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 p1-20020adfcc81000000b0030ada01ca78sm7404978wrj.10.2023.06.22.09.10.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:10:10 -0700 (PDT)
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
Subject: [PATCH v2 10/16] accel: Rename NVMM 'struct qemu_vcpu' ->
 AccelCPUState
Date: Thu, 22 Jun 2023 18:08:17 +0200
Message-Id: <20230622160823.71851-11-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
 target/i386/nvmm/nvmm-all.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 0588a328ae..e5ee4af084 100644
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
@@ -991,7 +991,7 @@ nvmm_init_vcpu(CPUState *cpu)
     }
 
     cpu->vcpu_dirty = true;
-    cpu->accel = (struct AccelCPUState *)qcpu;
+    cpu->accel = qcpu;
 
     return 0;
 }
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


