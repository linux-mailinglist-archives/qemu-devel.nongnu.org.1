Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059AB77361E
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 03:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTBwn-0002a3-NA; Mon, 07 Aug 2023 21:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwl-0002Zb-8N
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:43 -0400
Received: from hognose1.porkbun.com ([35.82.102.206])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1qTBwj-0003cx-S7
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 21:55:43 -0400
Received: from cslab-raptor.. (unknown [166.111.226.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 (Authenticated sender: c@jia.je)
 by hognose1.porkbun.com (Postfix) with ESMTPSA id 4AEC543F41;
 Tue,  8 Aug 2023 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=default;
 t=1691459739; bh=obuLz7T+DJJfHSC2AfeF3OJZGiGRB02ZTzRCAiLBi3s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RV96lvcSR4D3TUC4xt66mxlvZIQErvhzM+btIYGxg+QaVtFM070tAC0+zC+BMkCEY
 CmUR94Vsq9mBHqRM+uxTAAe3gUagu17bmYnWF1ALFZphkn6whZNdqpcqVTFkJDn7Xd
 XroPjOg8S5oBkmlElJmI2NuSJdtyWvL3+vuVRn+4=
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, yijun@loongson.cn, shenjinyang@loongson.cn,
 gaosong@loongson.cn, i.qemu@xen0n.name, Jiajie Chen <c@jia.je>
Subject: [PATCH v4 01/11] target/loongarch: Add macro to check current arch
Date: Tue,  8 Aug 2023 09:54:27 +0800
Message-ID: <20230808015506.1705140-2-c@jia.je>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808015506.1705140-1-c@jia.je>
References: <20230808015506.1705140-1-c@jia.je>
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

Add macro to check if the current cpucfg[1].arch equals to 1(LA32) or
2(LA64).

Signed-off-by: Jiajie Chen <c@jia.je>
---
 target/loongarch/cpu.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index fa371ca8ba..bf0da8d5b4 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -132,6 +132,13 @@ FIELD(CPUCFG1, HP, 24, 1)
 FIELD(CPUCFG1, IOCSR_BRD, 25, 1)
 FIELD(CPUCFG1, MSG_INT, 26, 1)
 
+/* cpucfg[1].arch */
+#define CPUCFG1_ARCH_LA32        1
+#define CPUCFG1_ARCH_LA64        2
+
+#define LOONGARCH_CPUCFG_ARCH(env, mode) \
+  (FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_##mode)
+
 /* cpucfg[2] bits */
 FIELD(CPUCFG2, FP, 0, 1)
 FIELD(CPUCFG2, FP_SP, 1, 1)
-- 
2.41.0


