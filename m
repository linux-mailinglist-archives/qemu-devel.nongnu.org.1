Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2D7BF199
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq3Yb-0006AC-Uz; Mon, 09 Oct 2023 23:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qq3YZ-00069K-M6
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qq3YV-0005u7-SD
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxjuvfxiRltIUwAA--.24961S3;
 Tue, 10 Oct 2023 11:37:03 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxP93cxiRl4NgdAA--.64991S4; 
 Tue, 10 Oct 2023 11:37:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, laurent@vivier.e,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, laurent@vivier.eu
Subject: [PATCH v1 2/6] target/loongarch: Add set_vec_extctx to set LSX/LASX
 instructions extctx_flags
Date: Tue, 10 Oct 2023 11:36:57 +0800
Message-Id: <20231010033701.385725-3-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231010033701.385725-1-gaosong@loongson.cn>
References: <20231010033701.385725-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxP93cxiRl4NgdAA--.64991S4
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
---
 target/loongarch/insn_trans/trans_vec.c.inc | 12 ++++++++++++
 target/loongarch/internals.h                |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/target/loongarch/insn_trans/trans_vec.c.inc b/target/loongarch/insn_trans/trans_vec.c.inc
index 98f856bb29..aef16ef44a 100644
--- a/target/loongarch/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/insn_trans/trans_vec.c.inc
@@ -23,8 +23,20 @@ static bool check_vec(DisasContext *ctx, uint32_t oprsz)
 
 #else
 
+static void set_vec_extctx(DisasContext *ctx, uint32_t oprsz)
+{
+    if (oprsz == 16) {
+        ctx->extctx_flags |= EXTCTX_FLAGS_LSX;
+    }
+
+    if (oprsz == 32) {
+        ctx->extctx_flags |= EXTCTX_FLAGS_LASX;
+    }
+}
+
 static bool check_vec(DisasContext *ctx, uint32_t oprsz)
 {
+    set_vec_extctx(ctx, oprsz);
     return true;
 }
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 01d98ac2fc..2efba9b859 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -22,6 +22,8 @@
 #define LOONGARCH_HGLOBAL_SHIFT     12
 
 #define EXTCTX_FLAGS_FPU  0b01
+#define EXTCTX_FLAGS_LSX  0b10
+#define EXTCTX_FLAGS_LASX 0b100
 
 void loongarch_translate_init(void);
 
-- 
2.25.1


