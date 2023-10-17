Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FDE7CBB85
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdmN-00083d-BK; Tue, 17 Oct 2023 02:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlb-0007tJ-FV
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdlZ-0001rw-TE
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:41:23 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6b6f4c118b7so2568193b3a.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697524880; x=1698129680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pp3zoEZUHKvoEOLikeNp6Ks+ZDD3//5iYusnkVex7j0=;
 b=TA+UqEda9LB/Abdxjs3VryDZpFN7YBAwP761/ev9nKdOF0rt79Bp1vvWfLih/3Y7WI
 lNj7Cv5izN3i3kavuIUNMRPUKh86O423O0mEvgNcV2WAl0OcRgvwyaSTV+p8elbqJrjs
 BFGI056IJ8VwtyrJ3M9hTke5Zg5kkTe5X6+jMZLngzB9iN5ax+oUjG8xoRz57VvOEQZs
 tPI5JW7XVihNgceL414v1BCGlbCU0GPy/VuixX799eqqFfJtzrQWm/1GC+zEO0FElnck
 Zy2V0lQBXGpYordOC+Jc5kGm6abGvh33EkZQY87eNnzgVB37qJg/eq0YF/POuAwCjuic
 L/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697524880; x=1698129680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pp3zoEZUHKvoEOLikeNp6Ks+ZDD3//5iYusnkVex7j0=;
 b=VKo94HTOkHb2oawvqfRY+8dkYzbULU5McYUVM5q4ginOa2AhGWn0Um9KzaDxXTWlGO
 nsB52Fjnasn8dRPNJSG0Rk6w7aR1d1O3YgOACDWxze5aEvEEQzVzYjYnwd8GJDxv82ge
 +VnwzjwuCqZt+TG/fbcxXH6XavsA+Zh2u9YsAIDfQeVWXQGNlyovKPXlxrk9p6bHDqS3
 +Qm7Imbg60H8GckMQ3LBuU0v8aohfx9IisYFgTbav6+wpFeQ6J3nvB+t7KXagaNftpiX
 L02vJdF+3cxErGLQWcbg7YJ0loy8k5+XxjeHWHU8HlU5hFPXnaIOqfiH/b31y+8B6wYV
 AgLQ==
X-Gm-Message-State: AOJu0YwnJz1VycBYdt1kEmlLycpBwCA5m76lLQgRemzpKXvrQS/a1mhV
 iPkD8WLcEca4KC/OZ9HyMLxcURGDaTg8QkKU+kM=
X-Google-Smtp-Source: AGHT+IGg8WMwRAt5YuANUDsVRg0rlTSm1eQzbR20R1d0G7D/m2UZiRwBa6MB2DwH8oi2jqE0Jvcipw==
X-Received: by 2002:a05:6a20:a21d:b0:157:54fd:5c26 with SMTP id
 u29-20020a056a20a21d00b0015754fd5c26mr995720pzk.38.1697524880624; 
 Mon, 16 Oct 2023 23:41:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 x18-20020a17090300d200b001b891259eddsm685682plc.197.2023.10.16.23.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 13/20] target/sparc: Merge gen_branch2 into advance_pc
Date: Mon, 16 Oct 2023 23:41:02 -0700
Message-Id: <20231017064109.681935-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017064109.681935-1-richard.henderson@linaro.org>
References: <20231017064109.681935-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The function had only one caller.  Canonicalize the cpu_cond
test to TCG_COND_NE, the "natural" sense of its value.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 74a0972bda..4c52425702 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -846,19 +846,6 @@ static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
     tcg_gen_xori_tl(dst, dst, 0x1);
 }
 
-static void gen_branch2(DisasContext *dc, target_ulong pc1,
-                        target_ulong pc2, TCGv r_cond)
-{
-    TCGLabel *l1 = gen_new_label();
-
-    tcg_gen_brcondi_tl(TCG_COND_EQ, r_cond, 0, l1);
-
-    gen_goto_tb(dc, 0, pc1, pc1 + 4);
-
-    gen_set_label(l1);
-    gen_goto_tb(dc, 1, pc2, pc2 + 4);
-}
-
 static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
@@ -2260,6 +2247,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
+    TCGLabel *l1;
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case DYNAMIC_PC:
@@ -2267,11 +2256,22 @@ static bool advance_pc(DisasContext *dc)
             dc->pc = dc->npc;
             gen_op_next_insn();
             break;
+
         case JUMP_PC:
             /* we can do a static jump */
-            gen_branch2(dc, dc->jump_pc[0], dc->jump_pc[1], cpu_cond);
+            l1 = gen_new_label();
+            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_cond, 0, l1);
+
+            /* jump not taken */
+            gen_goto_tb(dc, 1, dc->jump_pc[1], dc->jump_pc[1] + 4);
+
+            /* jump taken */
+            gen_set_label(l1);
+            gen_goto_tb(dc, 0, dc->jump_pc[0], dc->jump_pc[0] + 4);
+
             dc->base.is_jmp = DISAS_NORETURN;
             break;
+
         default:
             g_assert_not_reached();
         }
-- 
2.34.1


