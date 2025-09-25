Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A590CB9DA66
	for <lists+qemu-devel@lfdr.de>; Thu, 25 Sep 2025 08:36:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1fYn-0008QU-OW; Thu, 25 Sep 2025 02:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v1fYV-000839-VS
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:34:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v1fXh-0000U5-3r
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 02:33:40 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxmdEx4tRo2msOAA--.31328S3;
 Thu, 25 Sep 2025 14:33:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBxpeQq4tRoj+iuAA--.30453S11;
 Thu, 25 Sep 2025 14:33:21 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 09/11] target/loongarch: Add CSR_ESTAT.bit15 and CSR_ECFG.bit15
 for msg interrupts.
Date: Thu, 25 Sep 2025 14:09:34 +0800
Message-Id: <20250925060936.898618-10-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250925060936.898618-1-gaosong@loongson.cn>
References: <20250925060936.898618-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeQq4tRoj+iuAA--.30453S11
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

Add CSR_ESTAT.bit15 and CSR_ECFG.bit15 for DINTC irq.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20250916122109.749813-10-gaosong@loongson.cn>
---
 target/loongarch/cpu-csr.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu-csr.h b/target/loongarch/cpu-csr.h
index 4792677086..f296eb8d06 100644
--- a/target/loongarch/cpu-csr.h
+++ b/target/loongarch/cpu-csr.h
@@ -34,11 +34,13 @@ FIELD(CSR_MISC, ALCL, 12, 4)
 FIELD(CSR_MISC, DWPL, 16, 3)
 
 #define LOONGARCH_CSR_ECFG           0x4 /* Exception config */
-FIELD(CSR_ECFG, LIE, 0, 13)
+FIELD(CSR_ECFG, LIE, 0, 15)        /* bit 15 is msg interrupt enabled */
+FIELD(CSR_ECFG, MSGINT, 14, 1)
 FIELD(CSR_ECFG, VS, 16, 3)
 
 #define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
-FIELD(CSR_ESTAT, IS, 0, 13)
+FIELD(CSR_ESTAT, IS, 0, 15)        /* bit 15 is msg interrupt enabled */
+FIELD(CSR_ESTAT, MSGINT, 14, 1)
 FIELD(CSR_ESTAT, ECODE, 16, 6)
 FIELD(CSR_ESTAT, ESUBCODE, 22, 9)
 
-- 
2.47.0


