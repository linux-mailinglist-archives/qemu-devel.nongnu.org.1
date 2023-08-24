Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36920786BAD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:25:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6ar-00063w-Pj; Thu, 24 Aug 2023 05:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qZ6a6-000422-5v
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qZ6a3-0003aU-6S
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:24:45 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8CxruvDIedkbXkbAA--.53482S3;
 Thu, 24 Aug 2023 17:24:19 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxJ826IedkJjhiAA--.40637S19; 
 Thu, 24 Aug 2023 17:24:19 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, richard.henderson@linaro.org, Jiajie Chen <c@jia.je>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/31] target/loongarch: Truncate high 32 bits of address in
 VA32 mode
Date: Thu, 24 Aug 2023 17:23:55 +0800
Message-Id: <20230824092409.1492470-18-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230824092409.1492470-1-gaosong@loongson.cn>
References: <20230824092409.1492470-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxJ826IedkJjhiAA--.40637S19
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

When running in VA32 mode(!LA64 or VA32L[1-3] matching PLV), virtual
address is truncated to 32 bits before address mapping.

Signed-off-by: Jiajie Chen <c@jia.je>
Co-authored-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-6-gaosong@loongson.cn>
Message-Id: <20230822071405.35386-10-philmd@linaro.org>
---
 target/loongarch/cpu.h       |  6 +++++-
 target/loongarch/translate.c | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index e1562695e8..25a0ef7e41 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -445,7 +445,11 @@ static inline bool is_va32(CPULoongArchState *env)
 
 static inline void set_pc(CPULoongArchState *env, uint64_t value)
 {
-    env->pc = value;
+    if (is_va32(env)) {
+        env->pc = (uint32_t)value;
+    } else {
+        env->pc = value;
+    }
 }
 
 /*
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 8b26555a27..9a23ec786d 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -86,6 +86,10 @@ void generate_exception(DisasContext *ctx, int excp)
 
 static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
 {
+    if (ctx->va32) {
+        dest = (uint32_t) dest;
+    }
+
     if (translator_use_goto_tb(&ctx->base, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(cpu_pc, dest);
@@ -212,11 +216,17 @@ static TCGv make_address_x(DisasContext *ctx, TCGv base, TCGv addend)
 {
     TCGv temp = NULL;
 
-    if (addend) {
+    if (addend || ctx->va32) {
         temp = tcg_temp_new();
+    }
+    if (addend) {
         tcg_gen_add_tl(temp, base, addend);
         base = temp;
     }
+    if (ctx->va32) {
+        tcg_gen_ext32u_tl(temp, base);
+        base = temp;
+    }
     return base;
 }
 
@@ -262,6 +272,10 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
     }
 
     ctx->base.pc_next += 4;
+
+    if (ctx->va32) {
+        ctx->base.pc_next = (uint32_t)ctx->base.pc_next;
+    }
 }
 
 static void loongarch_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
-- 
2.39.1


