Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF072F213
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:38:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FFr-0006DN-FP; Tue, 13 Jun 2023 21:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEz-0004PI-Vr
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:06 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FEx-0004y8-I8
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:24:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6664a9f0b10so91736b3a.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705839; x=1689297839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/m13RDh9IQJltO5V0f1/iK9VcvlRAwtkyrWsJK4nZcI=;
 b=UAjEjWJNAKuph+8RqGH0PHjjwvyGei9jgPha2S/WT4o6sNkfPTMoZ2JcMUUZYsdSjm
 LDeQ6FJwkaG21JprdcLnwkpTyHeNyXYJ5YeJsiIy8FFtNa4xV2NVGt3DipJBCA1maid4
 9oQg7Yew7xqf+xSqBKikDdo+FndLRFtdMg6YTUBR3gHcEQrT0dX7aKwCbn7SB32u71di
 Y3Fv8sYcRy5UZ8oLZAdu+McryDqogs8vWKY8c/uQFKm2vOTBFr12vqIxeU8sNNhzK0NV
 mPTsoKj/cmFn/WGN34zTXpi5OPa5Z2OdbBTLofUTD4EZI7lKMVMMWZhSrVMbFY4MkYwH
 vegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705839; x=1689297839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/m13RDh9IQJltO5V0f1/iK9VcvlRAwtkyrWsJK4nZcI=;
 b=gQWAqtM+ykKGZjgZ0ZFB+bHy9fpQ/1kmZctbMJY8rqUh+hR149oj1Xv50GMymUIqee
 JHWHFCzdYEWNbYqXaGDRPhGJt59Pg9obIkvuaTUIdNKQRbn60hobJ8SE4yZRZH1efhCu
 4E931zoHmuzzJWUsdrb6BxJ0c2YDa4lRjaGKjML6vMkIXIMjFIEpljRnSfyWLVMStGtQ
 34IRu8M1jD+QGkYqGvgcqeeRbeaHLUuCGVfw7TupYoOPyM9sB5AkqpI1ZrWFBJH/SYqV
 /b5/dPJYY53Mt762Q1KVwyaQUCnBii7sUtBEkyehRAuZZpEJKh2Rx9921GXqCiArCXmX
 QDxQ==
X-Gm-Message-State: AC+VfDwda5F1YNwjvRPQr6GH8GgOZQ5UYbr/kJHrTAHzyvLyDYtvs+U0
 mcNEGD0KNtsUfoi868SASmadS4QET3HsNg==
X-Google-Smtp-Source: ACHHUZ658CXtUESFxAp4IzCkQFjL9/Amp2pWHiBeEKs+PF7veHxt5epGx8pewfh/lIkipx/urAYMFQ==
X-Received: by 2002:a05:6a00:3981:b0:663:8c28:61d7 with SMTP id
 fi1-20020a056a00398100b006638c2861d7mr478094pfb.32.1686705839657; 
 Tue, 13 Jun 2023 18:23:59 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:23:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Weiwei Li <liweiwei@iscas.ac.cn>,
 Junqiang Wang <wangjunqiang@iscas.ac.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 51/60] target/riscv: Remove pc_succ_insn from DisasContext
Date: Wed, 14 Jun 2023 11:20:08 +1000
Message-Id: <20230614012017.3100663-52-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Weiwei Li <liweiwei@iscas.ac.cn>

pc_succ_insn is no longer useful after the introduce of cur_insn_len
and all pc related value use diff value instead of absolute value.

Signed-off-by: Weiwei Li <liweiwei@iscas.ac.cn>
Signed-off-by: Junqiang Wang <wangjunqiang@iscas.ac.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230526072124.298466-8-liweiwei@iscas.ac.cn>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index bd2da9b079..8a33da811e 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -59,8 +59,6 @@ typedef enum {
 
 typedef struct DisasContext {
     DisasContextBase base;
-    /* pc_succ_insn points to the instruction following base.pc_next */
-    target_ulong pc_succ_insn;
     target_ulong cur_insn_len;
     target_ulong pc_save;
     target_ulong priv_ver;
@@ -1149,7 +1147,6 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
     /* Check for compressed insn */
     if (ctx->cur_insn_len == 2) {
         ctx->opcode = opcode;
-        ctx->pc_succ_insn = ctx->base.pc_next + 2;
         /*
          * The Zca extension is added as way to refer to instructions in the C
          * extension that do not include the floating-point loads and stores
@@ -1164,7 +1161,6 @@ static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t opcode)
                              translator_lduw(env, &ctx->base,
                                              ctx->base.pc_next + 2));
         ctx->opcode = opcode32;
-        ctx->pc_succ_insn = ctx->base.pc_next + 4;
 
         for (size_t i = 0; i < ARRAY_SIZE(decoders); ++i) {
             if (decoders[i].guard_func(ctx) &&
@@ -1185,7 +1181,6 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     uint32_t tb_flags = ctx->base.tb->flags;
 
     ctx->pc_save = ctx->base.pc_first;
-    ctx->pc_succ_insn = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
     ctx->mem_idx = FIELD_EX32(tb_flags, TB_FLAGS, MEM_IDX);
     ctx->mstatus_fs = FIELD_EX32(tb_flags, TB_FLAGS, FS);
@@ -1238,7 +1233,7 @@ static void riscv_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 
     ctx->ol = ctx->xl;
     decode_opc(env, ctx, opcode16);
-    ctx->base.pc_next = ctx->pc_succ_insn;
+    ctx->base.pc_next += ctx->cur_insn_len;
 
     /* Only the first insn within a TB is allowed to cross a page boundary. */
     if (ctx->base.is_jmp == DISAS_NEXT) {
-- 
2.40.1


