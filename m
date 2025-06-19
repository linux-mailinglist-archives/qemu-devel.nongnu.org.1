Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F44ADFB91
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Jun 2025 05:04:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uS5Yk-00078B-1A; Wed, 18 Jun 2025 23:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uS5Yi-00077g-9O
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uS5Yg-0006Cr-4H
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 23:03:24 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxQK_yfVNo0o4ZAQ--.23708S3;
 Thu, 19 Jun 2025 11:03:14 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCxrhu7fVNoIXkgAQ--.48014S11;
 Thu, 19 Jun 2025 11:03:10 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: maobibo@loongson.cn
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	jiaxun.yang@flygoat.com
Subject: [PATCH v2 9/9] target/loongarch: CSR_ECFG enable msg interrupt
Date: Thu, 19 Jun 2025 10:39:44 +0800
Message-Id: <20250619023944.1278716-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619023944.1278716-1-gaosong@loongson.cn>
References: <20250619023944.1278716-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxrhu7fVNoIXkgAQ--.48014S11
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

when loongarch cpu set irq is INT_AVEC, we need set CSR_ECFG MSGINT bit.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h | 5 +++--
 target/loongarch/cpu.c     | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 83f6cb081a..b1e251a72b 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -34,11 +34,12 @@ FIELD(CSR_MISC, ALCL, 12, 4)
 FIELD(CSR_MISC, DWPL, 16, 3)
 
 #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
-FIELD(CSR_ECFG, LIE, 0, 13)
+FIELD(CSR_ECFG, LIE, 0, 15)          /*bit 15 is msg interrupt enabled */
+FIELD(CSR_ECFG, MSGINT, 14, 1)
 FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
-FIELD(CSR_ESTAT, IS, 0, 13)
+FIELD(CSR_ESTAT, IS, 0, 15)          /*bit 15 is msg interrupt enabled */
 FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 28b23743f9..c5924bb94f 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -132,6 +132,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
         for (int i = 256; i >= 0; i--) {
             if (test_bit(i, &(env->CSR_MSGIS[i / 64]))) {
                 env->CSR_ESTAT = FIELD_DP64(env->CSR_ESTAT, CSR_ESTAT, MSGINT, 1);
+                env->CSR_ECFG = FIELD_DP64(env->CSR_ECFG, CSR_ECFG, MSGINT, 1);
             }
         }
     }
-- 
2.34.1


