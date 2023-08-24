Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60350786BC8
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:28:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6al-00053k-J4; Thu, 24 Aug 2023 05:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6aM-0004Fw-HN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6aH-0003jc-C7
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:25:01 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxbevIIedkmXkbAA--.53866S3;
 Thu, 24 Aug 2023 17:24:24 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S29; 
 Thu, 24 Aug 2023 17:24:23 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	richard.henderson@linaro.org
Subject: [PULL 27/31] target/loongarch: Add avail_IOCSR to check iocsr
 instructions
Date: Thu, 24 Aug 2023 17:24:05 +0800
Message-Id: <20230824092409.1492470-28-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S29
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

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230822032724.1353391-16-gaosong@loongson.cn>
Message-Id: <20230822072219.35719-1-philmd@linaro.org>
---
 .../loongarch/insn_trans/trans_privileged.c.inc  | 16 ++++++++--------
 target/loongarch/translate.h                     |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_privileged.c.inc b/target/loongarch/insn_trans/trans_privileged.c.inc
index 099cd871f0..4cb701b4b5 100644
--- a/target/loongarch/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/insn_trans/trans_privileged.c.inc
@@ -312,14 +312,14 @@ static bool gen_iocsrwr(DisasContext *ctx, arg_rr *a,
     return true;
 }
 
-TRANS(iocsrrd_b, ALL, gen_iocsrrd, gen_helper_iocsrrd_b)
-TRANS(iocsrrd_h, ALL, gen_iocsrrd, gen_helper_iocsrrd_h)
-TRANS(iocsrrd_w, ALL, gen_iocsrrd, gen_helper_iocsrrd_w)
-TRANS(iocsrrd_d, ALL, gen_iocsrrd, gen_helper_iocsrrd_d)
-TRANS(iocsrwr_b, ALL, gen_iocsrwr, gen_helper_iocsrwr_b)
-TRANS(iocsrwr_h, ALL, gen_iocsrwr, gen_helper_iocsrwr_h)
-TRANS(iocsrwr_w, ALL, gen_iocsrwr, gen_helper_iocsrwr_w)
-TRANS(iocsrwr_d, ALL, gen_iocsrwr, gen_helper_iocsrwr_d)
+TRANS(iocsrrd_b, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_b)
+TRANS(iocsrrd_h, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_h)
+TRANS(iocsrrd_w, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_w)
+TRANS(iocsrrd_d, IOCSR, gen_iocsrrd, gen_helper_iocsrrd_d)
+TRANS(iocsrwr_b, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_b)
+TRANS(iocsrwr_h, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_h)
+TRANS(iocsrwr_w, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_w)
+TRANS(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
 
 static void check_mmu_idx(DisasContext *ctx)
 {
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index db46e9aa0f..89b49a859e 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -23,7 +23,7 @@
 #define avail_LSPW(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
 #define avail_LAM(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
 #define avail_LSX(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSX))
-
+#define avail_IOCSR(C) (FIELD_EX32((C)->cpucfg1, CPUCFG1, IOCSR))
 
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
-- 
2.39.1


