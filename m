Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D187E1FC0
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:16:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxPj-0007kg-37; Mon, 06 Nov 2023 06:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPd-0007dH-SB
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:57 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxPW-0003ss-P1
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:04:57 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4079ed65582so32850625e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268689; x=1699873489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5wOkrsA8z2Hole9awlJYsNuk4oh7gPmhIjtphAMJsw8=;
 b=psKUUSqMM8ZoFWJVSptQ91bZmUqMy3eKvQR+vkfVVJASMZ6TX7ck1cwxyW1w1TVK/O
 C5vHfnjkObntjoWCbljkPBfte8X0jRh43QG3Urah8dHg6i1JN21OtMfyCQveCVteLvDh
 qKsejHokN32O7+BVs09cpsjkRS1JDpr2zW8Phi29nBymILPmRSVArK+spZZFqqFvsWAh
 wgWCf6RnzItfbC9oaFMUVfq5PlqarUxBbzEdOHKJE14YVD9XgRVbZ6Msy3/ux60eFFUA
 oTtIbjn85np/qpSAdrsKrJe2i8Qu+oa5mvMeVjP/IbsO4dq7NG/uJmz2qkFJK8QvimnA
 IvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268689; x=1699873489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5wOkrsA8z2Hole9awlJYsNuk4oh7gPmhIjtphAMJsw8=;
 b=aJW4BS77hYLytJvzbsK+s37M0z4rDFKFvIAq3qVWcmAAa/rNTxD1vVhrJIAbRwynjo
 kykzegQfFFYitRX6t9oHPI2a6KuG4Gwa7F2xfoiCyazbJmCntmfIZyJ/FXVrH64VaiIy
 CpnuvDzlVXp+13tL+HCdP4/0nNLOKtk5EmK3axakRsVqcbesu0SLDHWI7E0Yahi/qyll
 cF7jI3xENJsEWCyZL2DCSOTnV1g1aEd/8EUs8ZjidJ/ysWRAIAgvjeqpzEDs3akGRk41
 +VYXeL8hJUXB9C18FN63igU3Jf8gPywPvf+T07XS26yeVsOIaPVYlrvAIVLBQiCB4+xS
 GaLw==
X-Gm-Message-State: AOJu0YzbHV4bKxfBh/BCGOACZH7fuYnpJ1W79IvwB2GERZPOMPHRkPJ1
 reWZFcBP0Fw+F9HAWU71iKzTKi/zZKo2fq+9/iU=
X-Google-Smtp-Source: AGHT+IECfFst9YsrR74+b52RmZLy9M9KXPMfA+PoNFzuGn/ZVvte53NMfTf9ib4YmQOSoxKMcxtfzw==
X-Received: by 2002:a05:6000:18a9:b0:32f:9a39:777f with SMTP id
 b9-20020a05600018a900b0032f9a39777fmr15067192wri.62.1699268689108; 
 Mon, 06 Nov 2023 03:04:49 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a5d6402000000b0032d9caeab0fsm9209526wru.77.2023.11.06.03.04.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:04:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/60] target/arm: Move internal declarations from 'cpu-qom.h'
 to 'cpu.h'
Date: Mon,  6 Nov 2023 12:02:42 +0100
Message-ID: <20231106110336.358-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

These definitions and declarations are only used by
target/arm/, no need to expose them to generic hw/.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231013140116.255-4-philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <c48c9829-3dfa-79cf-3042-454fda0d00dc@linaro.org>
---
 target/arm/cpu-qom.h   | 28 ----------------------------
 target/arm/cpu.h       | 22 ++++++++++++++++++++++
 target/arm/internals.h |  6 ++++++
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/target/arm/cpu-qom.h b/target/arm/cpu-qom.h
index dfb9d5b827..35c3b0924e 100644
--- a/target/arm/cpu-qom.h
+++ b/target/arm/cpu-qom.h
@@ -35,9 +35,6 @@ typedef struct ARMCPUInfo {
     void (*class_init)(ObjectClass *oc, void *data);
 } ARMCPUInfo;
 
-void arm_cpu_register(const ARMCPUInfo *info);
-void aarch64_cpu_register(const ARMCPUInfo *info);
-
 /**
  * ARMCPUClass:
  * @parent_realize: The parent class' realize handler.
@@ -63,29 +60,4 @@ struct AArch64CPUClass {
     ARMCPUClass parent_class;
 };
 
-void register_cp_regs_for_features(ARMCPU *cpu);
-void init_cpreg_list(ARMCPU *cpu);
-
-/* Callback functions for the generic timer's timers. */
-void arm_gt_ptimer_cb(void *opaque);
-void arm_gt_vtimer_cb(void *opaque);
-void arm_gt_htimer_cb(void *opaque);
-void arm_gt_stimer_cb(void *opaque);
-void arm_gt_hvtimer_cb(void *opaque);
-
-#define ARM_AFF0_SHIFT 0
-#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
-#define ARM_AFF1_SHIFT 8
-#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
-#define ARM_AFF2_SHIFT 16
-#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
-#define ARM_AFF3_SHIFT 32
-#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
-#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
-
-#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK)
-#define ARM64_AFFINITY_MASK \
-    (ARM_AFF0_MASK|ARM_AFF1_MASK|ARM_AFF2_MASK|ARM_AFF3_MASK)
-#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
-
 #endif
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2f7ab22169..4a86c8f831 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1116,11 +1116,33 @@ struct ArchCPU {
     uint64_t gt_cntfrq_hz;
 };
 
+/* Callback functions for the generic timer's timers. */
+void arm_gt_ptimer_cb(void *opaque);
+void arm_gt_vtimer_cb(void *opaque);
+void arm_gt_htimer_cb(void *opaque);
+void arm_gt_stimer_cb(void *opaque);
+void arm_gt_hvtimer_cb(void *opaque);
+
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu);
 void gt_rme_post_el_change(ARMCPU *cpu, void *opaque);
 
 void arm_cpu_post_init(Object *obj);
 
+#define ARM_AFF0_SHIFT 0
+#define ARM_AFF0_MASK  (0xFFULL << ARM_AFF0_SHIFT)
+#define ARM_AFF1_SHIFT 8
+#define ARM_AFF1_MASK  (0xFFULL << ARM_AFF1_SHIFT)
+#define ARM_AFF2_SHIFT 16
+#define ARM_AFF2_MASK  (0xFFULL << ARM_AFF2_SHIFT)
+#define ARM_AFF3_SHIFT 32
+#define ARM_AFF3_MASK  (0xFFULL << ARM_AFF3_SHIFT)
+#define ARM_DEFAULT_CPUS_PER_CLUSTER 8
+
+#define ARM32_AFFINITY_MASK (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK)
+#define ARM64_AFFINITY_MASK \
+    (ARM_AFF0_MASK | ARM_AFF1_MASK | ARM_AFF2_MASK | ARM_AFF3_MASK)
+#define ARM64_AFFINITY_INVALID (~ARM64_AFFINITY_MASK)
+
 uint64_t arm_cpu_mp_affinity(int idx, uint8_t clustersz);
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c837506e44..143d57c0fe 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -183,6 +183,12 @@ static inline int r14_bank_number(int mode)
     return (mode == ARM_CPU_MODE_HYP) ? BANK_USRSYS : bank_number(mode);
 }
 
+void arm_cpu_register(const ARMCPUInfo *info);
+void aarch64_cpu_register(const ARMCPUInfo *info);
+
+void register_cp_regs_for_features(ARMCPU *cpu);
+void init_cpreg_list(ARMCPU *cpu);
+
 void arm_cpu_register_gdb_regs_for_features(ARMCPU *cpu);
 void arm_translate_init(void);
 
-- 
2.41.0


