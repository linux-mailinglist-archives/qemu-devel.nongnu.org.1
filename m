Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8270786B9F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6Zu-0003cN-6f; Thu, 24 Aug 2023 05:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6Zp-0003Rs-Rc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6Zk-0003Nc-Gc
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:29 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Axueq_IedkP3kbAA--.46178S3;
 Thu, 24 Aug 2023 17:24:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S8; 
 Thu, 24 Aug 2023 17:24:14 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/31] target/loongarch: Add function to check current arch
Date: Thu, 24 Aug 2023 17:23:44 +0800
Message-Id: <20230824092409.1492470-7-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S8
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

From: Jiajie Chen <c@jia.je>

Add is_la64 function to check if the current cpucfg[1].arch equals to
2(LA64).

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20230817093121.1053890-2-gaosong@loongson.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230821125959.28666-7-philmd@linaro.org>
---
 target/loongarch/cpu.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index c50b3a5ef3..3235ad081f 100644
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
@@ -421,6 +426,11 @@ static inline int cpu_mmu_index(CPULoongArchState *env, bool ifetch)
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
2.39.1


