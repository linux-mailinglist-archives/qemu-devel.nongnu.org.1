Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8964732CAF
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 12:03:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA6HV-0007I9-0T; Fri, 16 Jun 2023 06:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA6HR-0007GG-0b
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:09 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA6HM-0000du-VG
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 06:02:08 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxW+oaM4xkSu8FAA--.12706S3;
 Fri, 16 Jun 2023 18:02:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxFOQWM4xkSygdAA--.17116S7; 
 Fri, 16 Jun 2023 18:02:01 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	Jiajie Chen <c@jia.je>
Subject: [PULL 5/5] target/loongarch: Fix CSR.DMW0-3.VSEG check
Date: Fri, 16 Jun 2023 18:01:58 +0800
Message-Id: <20230616100158.1845239-6-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230616100158.1845239-1-gaosong@loongson.cn>
References: <20230616100158.1845239-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxFOQWM4xkSygdAA--.17116S7
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
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The previous code checks whether the highest 16 bits of virtual address
equal to that of CSR.DMW0-3. This is incorrect according to the spec,
and is corrected to compare only the highest four bits instead.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20230614065556.2397513-1-c@jia.je>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/tlb_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
index cce1db1e0a..6e00190547 100644
--- a/target/loongarch/tlb_helper.c
+++ b/target/loongarch/tlb_helper.c
@@ -185,10 +185,10 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
     }
 
     plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
-    base_v = address >> TARGET_VIRT_ADDR_SPACE_BITS;
+    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
     /* Check direct map window */
     for (int i = 0; i < 4; i++) {
-        base_c = env->CSR_DMW[i] >> TARGET_VIRT_ADDR_SPACE_BITS;
+        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
         if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
             *physical = dmw_va2pa(address);
             *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
-- 
2.39.1


