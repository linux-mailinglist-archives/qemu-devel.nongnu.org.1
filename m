Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D754819084
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:17:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXC-00023e-DB; Tue, 19 Dec 2023 14:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX7-00021x-2u
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:37 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX3-0001tM-PY
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:36 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33674f60184so865053f8f.1
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013209; x=1703618009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/gf8/3mTDB0itjVLwlHBVzUhArBcmJcd155HpJsvLVw=;
 b=GL/Mvyql0n+t3AVzfBeIMaq68s4jsXYvGxyiDQWgjW85rqKvmJpeHODVt4WRtiBG07
 CO3cUnoHNVGpqumxW8mPLMqncVTrPj8E0ra6976aU/zHMqfckL+Qas92SXJKbFRHMDRR
 VK7Uj29MW8Id3ptNxMwBQH8/f74EdqfUc8/Hib3Mlla2vDwAeUpcrq4UnpN8FOVg3chc
 QZUP2zCseU/gLLf8a+aInD/6diBak6qefV17oHKBwnhjGfDIVpPSFII5G61r/47OOruZ
 I+8yz3zpaw9YjT7wrhRL9z8rmAjv3qTQwS3n/sxE1Wo3RrBh8XfVVgfwi6+TNbEO1kue
 ElVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013209; x=1703618009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gf8/3mTDB0itjVLwlHBVzUhArBcmJcd155HpJsvLVw=;
 b=TwWVRynNKHRWZiis+P2NK2haXqLyVvXJuYACruCxPcoizJtUtfxcbHObm+Oruwb4hb
 dTHYTMwxl8GBBGZ0Luj2fCbQpmyxn/SduNFkwjUoBpnkO+iweJ6cHjUt8xKfoA33nlpu
 ei/L2E5ZWJ8/5xS1wIlOR+TuC5MgqwxBHBkpLqPFnftlGtt92t5BGtniQnO4HHaw7yUM
 Vf8h+KTP/VJqr1qoPPHrelIgErQG68qyK1TZ5BGeHnEFMAlC45bUJwdLTkQ8DAfxsFXb
 Fb4eb7+QvQYDCXu13/CnGuf8XJp9H9+7IdosrTlu5iwVLNMWWC/kr/1UKK1boL89EPVN
 3FGQ==
X-Gm-Message-State: AOJu0Yy8kY3a8na8BDYR5KeA1tjD/utZYV9z/EPDPco+guKv8MP0i99X
 TfSP8KiWnzHf+p+nDBtwqp2vdXYgeBJcBH5S3ao=
X-Google-Smtp-Source: AGHT+IHHdECr/lMfo0tqbfiYh0DPweVnrowQRPvmE9SeDFG/qtELchrokRdbZ5pGRtiIc9n2nrvZPw==
X-Received: by 2002:a5d:5445:0:b0:336:5496:b5e6 with SMTP id
 w5-20020a5d5445000000b003365496b5e6mr3129483wrv.123.1703013209466; 
 Tue, 19 Dec 2023 11:13:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/43] target/arm/helper: Propagate MDCR_EL2.HPMN into
 PMCR_EL0.N
Date: Tue, 19 Dec 2023 19:13:06 +0000
Message-Id: <20231219191307.2895919-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

MDCR_EL2.HPMN allows an hypervisor to limit the number of PMU counters
available to EL1 and EL0 (to keep the others to itself). QEMU already
implements this split correctly, except for PMCR_EL0.N reads: the number
of counters read by EL1 or EL0 should be the one configured in
MDCR_EL2.HPMN.

Cc: qemu-stable@nongnu.org
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20231215144652.4193815-2-jean-philippe@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 436a43a4b7b..fc546df5c70 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1475,6 +1475,22 @@ static void pmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     pmu_op_finish(env);
 }
 
+static uint64_t pmcr_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    uint64_t pmcr = env->cp15.c9_pmcr;
+
+    /*
+     * If EL2 is implemented and enabled for the current security state, reads
+     * of PMCR.N from EL1 or EL0 return the value of MDCR_EL2.HPMN or HDCR.HPMN.
+     */
+    if (arm_current_el(env) <= 1 && arm_is_el2_enabled(env)) {
+        pmcr &= ~PMCRN_MASK;
+        pmcr |= (env->cp15.mdcr_el2 & MDCR_HPMN) << PMCRN_SHIFT;
+    }
+
+    return pmcr;
+}
+
 static void pmswinc_write(CPUARMState *env, const ARMCPRegInfo *ri,
                           uint64_t value)
 {
@@ -7158,8 +7174,9 @@ static void define_pmu_regs(ARMCPU *cpu)
         .fgt = FGT_PMCR_EL0,
         .type = ARM_CP_IO | ARM_CP_ALIAS,
         .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcr),
-        .accessfn = pmreg_access, .writefn = pmcr_write,
-        .raw_writefn = raw_write,
+        .accessfn = pmreg_access,
+        .readfn = pmcr_read, .raw_readfn = raw_read,
+        .writefn = pmcr_write, .raw_writefn = raw_write,
     };
     ARMCPRegInfo pmcr64 = {
         .name = "PMCR_EL0", .state = ARM_CP_STATE_AA64,
@@ -7169,6 +7186,7 @@ static void define_pmu_regs(ARMCPU *cpu)
         .type = ARM_CP_IO,
         .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcr),
         .resetvalue = cpu->isar.reset_pmcr_el0,
+        .readfn = pmcr_read, .raw_readfn = raw_read,
         .writefn = pmcr_write, .raw_writefn = raw_write,
     };
 
-- 
2.34.1


