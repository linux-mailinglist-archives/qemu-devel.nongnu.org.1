Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1767081D6
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6Y-0004I8-Mp; Thu, 18 May 2023 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6U-0004Dz-0b
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:34 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6N-00081t-Tr
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f4ad71b00eso12795475e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414279; x=1687006279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qKdYxX6AGGIMH+Ujyu/x5WcZet6ovGbUI7+N7ydiBEM=;
 b=JgzWMLQdofTeXfc6H0zjC9o6PWM4osQ2fAMqZCXSe51+y8c7htKugE+hQ69qCi0qSL
 S3s3vQkLg7GeeBRQPdiy3XH037cWWVt0F13rT7/ZhMHx2bFAYwQlJDoAKo8wHC0pxFXt
 0Zn2ufQd4GFOsNdd/oZbBXZVrtIv0RGSfuX1cXOpKJGNs1AT+X0eMluNs3eiLvyDVQIW
 wjGQi6qY3240/HDvh5uv763r1LX6q8HRxFkT59nUUigrd55NCww6GTfi+OyLf1GFX9KV
 NNVo1NL4GsvOkryODwKPHqKIzo/NBRWBO1hV3gkV47KelRblE5qNTfYz9snFRtAY2wd5
 eb0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414279; x=1687006279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKdYxX6AGGIMH+Ujyu/x5WcZet6ovGbUI7+N7ydiBEM=;
 b=jh6m98/x8Zm5CVtscxvZUfbKGPdZ4dqjo5FxqTbhiX07nh39jn6R0EwABZpzDKXX7c
 tRt06ggECds0W/EYsEIDC5iFkG3mykP8GWzlEuKIV9jr9D45/Ti+nryWl7BZuq5J32Hy
 Ns4Dnltj+5wL3IfPzDza/35Y7v45dHJDOeloFc5LDKHNt3WeKP97TKxmw0ZQku6p3jQP
 LQh5b78CYkO6+yrScViggGL4xbFUxXbQqy39q2nMwoOYhWKyX5Aj1F/fECLUbxVqYUip
 XvneB5igBerEpjCMzcxXLgGp4IFhxff7GZWUsgt7dEJXszRWpEXAsgfghPxGwd7YUQtA
 AawA==
X-Gm-Message-State: AC+VfDz7KhbGZcjuLon3590rjNN9Qf5GuG/BM7rfpZMDqt+nXM8LVfZI
 NP1ed7elgAWJEWO4JwVrIzMDWXtNOvXPrymL4wI=
X-Google-Smtp-Source: ACHHUZ4rJLc0v/FxkgdVrV2iJoUE0iTdKUXLv5RwPGWami8P606tF/SUosCZmkL7YywFSttv8KTmrA==
X-Received: by 2002:a5d:428d:0:b0:306:37bf:ca5a with SMTP id
 k13-20020a5d428d000000b0030637bfca5amr1392742wrq.47.1684414279027; 
 Thu, 18 May 2023 05:51:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] target/arm: Convert BR, BLR, RET to decodetree
Date: Thu, 18 May 2023 13:51:01 +0100
Message-Id: <20230518125107.146421-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Convert the simple (non-pointer-auth) BR, BLR and RET insns
to decodetree.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230512144106.3608981-18-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  5 ++++
 target/arm/tcg/translate-a64.c | 55 ++++++++++++++++++++++++++++++----
 2 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 5b9e275b5f8..690dc107d41 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -19,6 +19,7 @@
 # This file is processed by scripts/decodetree.py
 #
 
+&r               rn
 &ri              rd imm
 &rri_sf          rd rn imm sf
 &i               imm
@@ -126,3 +127,7 @@ CBZ             sf:1 011010 nz:1 ................... rt:5 &cbz imm=%imm19
 TBZ             . 011011 nz:1 ..... .............. rt:5 &tbz  imm=%imm14 bitpos=%imm31_19
 
 B_cond          0101010 0 ................... 0 cond:4 imm=%imm19
+
+BR              1101011 0000 11111 000000 rn:5 00000 &r
+BLR             1101011 0001 11111 000000 rn:5 00000 &r
+RET             1101011 0010 11111 000000 rn:5 00000 &r
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a7ab89fdc8c..3af16e60b50 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1388,6 +1388,53 @@ static bool trans_B_cond(DisasContext *s, arg_B_cond *a)
     return true;
 }
 
+static void set_btype_for_br(DisasContext *s, int rn)
+{
+    if (dc_isar_feature(aa64_bti, s)) {
+        /* BR to {x16,x17} or !guard -> 1, else 3.  */
+        set_btype(s, rn == 16 || rn == 17 || !s->guarded_page ? 1 : 3);
+    }
+}
+
+static void set_btype_for_blr(DisasContext *s)
+{
+    if (dc_isar_feature(aa64_bti, s)) {
+        /* BLR sets BTYPE to 2, regardless of source guarded page.  */
+        set_btype(s, 2);
+    }
+}
+
+static bool trans_BR(DisasContext *s, arg_r *a)
+{
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    set_btype_for_br(s, a->rn);
+    s->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+static bool trans_BLR(DisasContext *s, arg_r *a)
+{
+    TCGv_i64 dst = cpu_reg(s, a->rn);
+    TCGv_i64 lr = cpu_reg(s, 30);
+    if (dst == lr) {
+        TCGv_i64 tmp = tcg_temp_new_i64();
+        tcg_gen_mov_i64(tmp, dst);
+        dst = tmp;
+    }
+    gen_pc_plus_diff(s, lr, curr_insn_len(s));
+    gen_a64_set_pc(s, dst);
+    set_btype_for_blr(s);
+    s->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
+static bool trans_RET(DisasContext *s, arg_r *a)
+{
+    gen_a64_set_pc(s, cpu_reg(s, a->rn));
+    s->base.is_jmp = DISAS_JUMP;
+    return true;
+}
+
 /* HINT instruction group, including various allocated HINTs */
 static void handle_hint(DisasContext *s, uint32_t insn,
                         unsigned int op1, unsigned int op2, unsigned int crm)
@@ -2186,12 +2233,8 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         btype_mod = opc;
         switch (op3) {
         case 0:
-            /* BR, BLR, RET */
-            if (op4 != 0) {
-                goto do_unallocated;
-            }
-            dst = cpu_reg(s, rn);
-            break;
+            /* BR, BLR, RET : handled in decodetree */
+            goto do_unallocated;
 
         case 2:
         case 3:
-- 
2.34.1


