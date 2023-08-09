Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4E5775573
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:34:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTedF-0003cs-Ms; Wed, 09 Aug 2023 04:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTedD-0003cC-8h
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:27 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTed8-0001mD-PS
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:33:25 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 3C11743FF0;
 Wed,  9 Aug 2023 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691570001; bh=eFMqNisW8Ayu7klAisHclOVQ1DVQQaPRqBxhYhEbAr4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NiNN0KqwNI1+EIi+fTF4McsTuF+bgYsyeobNcCdqIPAb0dOcasvHa+EJ3KODBJFER
 KVAfcDH6X5tWpbED2V/kSJkLMGA5Mlm1XhLgSdHdkTEjdbtWYD2mW0mkyxGIfheTn2
 +xg084d1uErdtfxVile+oSi397t21r8Sn9+FgHI4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH v5 01/11] target/loongarch: Add function to check current arch
Date: Wed,  9 Aug 2023 16:26:29 +0800
Message-ID: <20230809083258.1787464-2-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809083258.1787464-1-c@jia.je>
References: <20230809083258.1787464-1-c@jia.je>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=35.82.102.206; envelope-from=c@jia.je;
 helo=hognose1.porkbun.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add is_la64 function to check if the current cpucfg[1].arch equals to
2(LA64).

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..5a71d64a04 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -132,6 +132,11 @@ FIELD(CPUCFG1, HP, 24, 1)
 FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
 FIELD(CPUCFG1, MSG_INT, 26, 1)
 
+/* cpucfg[1].arch */
+#define CPUCFG1_ARCH_LA32R       0
+#define CPUCFG1_ARCH_LA32        1
+#define CPUCFG1_ARCH_LA64        2
+
 /* cpucfg[2] bits */
 FIELD(CPUCFG2, FP, 0, 1)
 FIELD(CPUCFG2, FP_SP, 1, 1)
@@ -420,6 +425,11 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
 #endif
 }
 
+static inline bool is_la64(CPULoongArchState *env)
+{
+    return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
+}
+
 /*
  * LoongArch CPUs hardware flags.
  */
-- 
2.41.0


