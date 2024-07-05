Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56C4928074
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jul 2024 04:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPYoA-0007tA-Dp; Thu, 04 Jul 2024 22:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sPYo2-0007sh-Lh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:36:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sPYnw-0001QC-Bh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 22:36:11 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxrfAUXIdmGyQBAA--.3679S3;
 Fri, 05 Jul 2024 10:36:04 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx68YQXIdm5s07AA--.6986S3; 
 Fri, 05 Jul 2024 10:36:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	philmd@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v2 2/2] target/loongarch: Fix cpu_reset set wrong CSR_CRMD
Date: Fri,  5 Jul 2024 10:18:39 +0800
Message-Id: <20240705021839.1004374-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240705021839.1004374-1-gaosong@loongson.cn>
References: <20240705021839.1004374-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx68YQXIdm5s07AA--.6986S3
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

After cpu_reset, DATF in CSR_CRMD is 0, DATM is 0.
See the manual[1] 6.4.

  [1]: https://github.com/loongson/LoongArch-Documentation/releases/download/2023.04.20/LoongArch-Vol1-v1.10-EN.pdf

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 55d468af3c..763cde41c3 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -523,13 +523,13 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
     env->fcsr0 = 0x0;
 
     int n;
-    /* Set csr registers value after reset */
+    /* Set csr registers value after reset, see the manual 6.4. */
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PLV, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, IE, 0);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DA, 1);
     env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, PG, 0);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 1);
-    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 1);
+    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATF, 0);
+    env->CSR_CRMD = FIELD_DP64(env->CSR_CRMD, CSR_CRMD, DATM, 0);
 
     env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, FPE, 0);
     env->CSR_EUEN = FIELD_DP64(env->CSR_EUEN, CSR_EUEN, SXE, 0);
-- 
2.33.0


