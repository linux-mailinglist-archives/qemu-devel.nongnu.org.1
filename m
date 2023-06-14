Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097C72FF52
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:02:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q7j-0002iN-HG; Wed, 14 Jun 2023 09:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1q9KQb-0002C1-G3
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:56:25 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <c@jia.je>) id 1q9KQZ-0004PW-Kg
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 02:56:25 -0400
X-GND-Sasl: c@jia.je
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jia.je; s=gm1;
 t=1686725779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=9o4m1BpX4P9b7JSMXRvUjNvvXUje8lOxH95OaEmqIiM=;
 b=MWb9f2ZDjxbkJJPxJHjKLLVyGh46lvNBpV0cNbdqi06W2+5+Ty0mAQpDde1Cs8kZ1bZIQI
 LSOWePsmUwVe2OSJOqKMSC4jQRN/3Tej5aEBrmQ25jHkhh0cnNTgB4EAYynrqxCdJVH6cL
 G080QvlV4ee3UJTD90GbD94kCaqIrK2gLby9hsamD71PTTymZl6uVHNyT5AYsBZUI5HsuS
 v3zVazfg91nVvIkYqqBY8sKChg9tclVAVPYgXyTBP9aJCsCWihKYTZDLkrRxvlHnwgP2gd
 M+BWr6B5S5mXr5PfcDp/xswFMM7xkW0zLpJF8R11Uc942mfXb3SlLelaUqzasw==
X-GND-Sasl: c@jia.je
X-GND-Sasl: c@jia.je
X-GND-Sasl: c@jia.je
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E5DF40004;
 Wed, 14 Jun 2023 06:56:16 +0000 (UTC)
From: Jiajie Chen <c@jia.je>
To: qemu-devel@nongnu.org
Cc: Jiajie Chen <c@jia.je>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Subject: [PATCH] target/loongarch: Fix CSR.DMW0-3.VSEG check
Date: Wed, 14 Jun 2023 14:55:56 +0800
Message-Id: <20230614065556.2397513-1-c@jia.je>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=217.70.183.194; envelope-from=c@jia.je;
 helo=relay2-d.mail.gandi.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Jun 2023 09:01:16 -0400
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

The previous code checks whether the highest 16 bits of virtual address
equal to that of CSR.DMW0-3. This is incorrect according to the spec,
and is corrected to compare only the highest four bits instead.

Signed-off-by: Jiajie Chen <c@jia.je>
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
2.30.2


