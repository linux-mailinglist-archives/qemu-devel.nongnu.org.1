Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D53D57BF19A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 05:38:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq3Yc-0006BM-Th; Mon, 09 Oct 2023 23:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qq3YZ-00069J-MC
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:15 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qq3YT-0005u9-ST
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 23:37:14 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8AxDOvexiRlsIUwAA--.22616S3;
 Tue, 10 Oct 2023 11:37:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxP93cxiRl4NgdAA--.64991S3; 
 Tue, 10 Oct 2023 11:37:02 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@redhat.com, laurent@vivier.e,
 maobibo@loongson.cn, yangxiaojuan@loongson.cn, laurent@vivier.eu
Subject: [PATCH v1 1/6] target/loongarch: Add env->extctx_flags for user-mode
 setup extcontext
Date: Tue, 10 Oct 2023 11:36:56 +0800
Message-Id: <20231010033701.385725-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231010033701.385725-1-gaosong@loongson.cn>
References: <20231010033701.385725-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxP93cxiRl4NgdAA--.64991S3
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

extctx_flags only for user-mode,  and the default value is
EXTCTX_FLAGS_FPU, We only need save/restore fpu context,
After a LSX or LASX instruction is execed, the value change to
EXTCTX_FLAGS_LSX/LASX, and we need save/restore lsx/lasx
context. So if the binary no LSX/LASX instruction We only need
save/restore fpu context.

Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 target/loongarch/cpu.c       | 2 ++
 target/loongarch/cpu.h       | 2 ++
 target/loongarch/internals.h | 2 ++
 target/loongarch/translate.c | 3 +++
 target/loongarch/translate.h | 1 +
 5 files changed, 10 insertions(+)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 2bea7ca5d5..32dd1b624b 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -546,6 +546,8 @@ static void loongarch_cpu_reset_hold(Object *obj)
     memset(env->tlb, 0, sizeof(env->tlb));
 #endif
 
+    env->extctx_flags = EXTCTX_FLAGS_FPU;
+
     restore_fp_status(env);
     cs->exception_index = -1;
 }
diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 40e70a8119..7a94963e5f 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -295,6 +295,8 @@ typedef struct CPUArchState {
     uint64_t lladdr; /* LL virtual address compared against SC */
     uint64_t llval;
 
+    uint64_t extctx_flags; /* Use for user-mode setup extcontext */
+
     /* LoongArch CSRs */
     uint64_t CSR_CRMD;
     uint64_t CSR_PRMD;
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index c492863cc5..01d98ac2fc 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -21,6 +21,8 @@
 /* Global bit for huge page */
 #define LOONGARCH_HGLOBAL_SHIFT     12
 
+#define EXTCTX_FLAGS_FPU  0b01
+
 void loongarch_translate_init(void);
 
 void loongarch_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 21f4db6fbd..9b82295542 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -147,6 +147,8 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
 
     ctx->cpucfg1 = env->cpucfg[1];
     ctx->cpucfg2 = env->cpucfg[2];
+
+    ctx->extctx_flags = env->extctx_flags;
 }
 
 static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
@@ -294,6 +296,7 @@ static void loongarch_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         generate_exception(ctx, EXCCODE_INE);
     }
 
+    env->extctx_flags |= ctx->extctx_flags;
     ctx->base.pc_next += 4;
 
     if (ctx->va32) {
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index 195f53573a..3bf1a1df86 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -40,6 +40,7 @@ typedef enum {
 typedef struct DisasContext {
     DisasContextBase base;
     target_ulong page_start;
+    uint64_t extctx_flags;
     uint32_t opcode;
     uint16_t mem_idx;
     uint16_t plv;
-- 
2.25.1


