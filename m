Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71817E1641
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU7-0003O3-S4; Sun, 05 Nov 2023 15:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU6-0003Nn-7W
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:38 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU4-00029w-NJ
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:37 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ba54c3ed97so3975345b3a.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215155; x=1699819955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHJ3cfI2sXHgMNE5o/c/XelGrRA35h8Xfg71kYgqG0o=;
 b=XWVmnAhCaHBvZ5KNmspNnmOUlSg+qpYuyfqgvXKmKU4mIWGH8lue6ehFZAVm3KlPAW
 iDpYQbtgpOYyqYwxomPpj6QHdtn8+8nPSX5SWGrWHfqvH150gMq0TSTvjwdwvEJRA0tj
 cmYLjaMzFopLzx5mhm460wOyeDUSWReghSQP+Bt8DKtVX6Nz3VgYrfbmXJSHHJlVDgmq
 /sI+zrpI6lZuEe9ut11zNnjFDMO3CP/Qw4nCzpb/Di3QhEtITPGjUqnI/NFeG2h5EVpf
 T3y3tVSKXrVnNaiYFpYNn4JdUOJBN/AL3YuTsap7T8hBIX5CJpAKg5kVxym36tOKO9gH
 51EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215155; x=1699819955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHJ3cfI2sXHgMNE5o/c/XelGrRA35h8Xfg71kYgqG0o=;
 b=azauj3NtlcbL0Xu047qL1xkUBmWvKoHqWu9eqZiWqziVg/vJBDaKrk52HRr19SQUkx
 zsvgI7bWbp8pztQZwruqL1Ni0GJiM8jOdEnUOnY9uFLgqAAN/0gSkDTQVlWL3yzQs5SC
 EqZPUWKyU+LCwd4q7IspFjy2cj5bhAtqCytS5Byb4KfWfuinvgRfPMaw+yeLvXRcUsqo
 KRixifdWfv5gfhMHfCdO7lzmHRdb10Ea+76ngyhrVp+38kLUkYa71HAKrgRV2sGSkU/K
 PUsBC30pETQvwwaNjr1yNgP5gje5ifjYI9JPwv8IE5mQkqgRCTEBG1fv7AYmPYNFLjhm
 Su8g==
X-Gm-Message-State: AOJu0YwiE9Z2M4FMWv+7xDxF2eVhehR9l1b/QkFuxYkgM2/SXxSqGEqX
 w1xMySOwUW8NDPPaUaE59xEw61KvMVazUep7ESQ=
X-Google-Smtp-Source: AGHT+IH4lMEqMIC3izXUxuM2mi3v//t+36T7EDvD0BNp/nAUr6xr4avsIqIDZburFF8qdO3EYrNSIw==
X-Received: by 2002:a05:6a00:b8e:b0:68a:5395:7aa5 with SMTP id
 g14-20020a056a000b8e00b0068a53957aa5mr31996329pfj.17.1699215154931; 
 Sun, 05 Nov 2023 12:12:34 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 13/21] target/sparc: Merge gen_branch2 into advance_pc
Date: Sun,  5 Nov 2023 12:12:14 -0800
Message-Id: <20231105201222.202395-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The function had only one caller.  Canonicalize the cpu_cond
test to TCG_COND_NE, the "natural" sense of its value.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 2e7deb5e33..e134ba8821 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -908,19 +908,6 @@ static void gen_op_eval_fbo(TCGv dst, TCGv src, unsigned int fcc_offset)
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
@@ -2352,6 +2339,8 @@ static int extract_qfpreg(DisasContext *dc, int x)
 /* Default case for non jump instructions. */
 static bool advance_pc(DisasContext *dc)
 {
+    TCGLabel *l1;
+
     if (dc->npc & 3) {
         switch (dc->npc) {
         case DYNAMIC_PC:
@@ -2359,11 +2348,22 @@ static bool advance_pc(DisasContext *dc)
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


