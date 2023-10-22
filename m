Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EC7D2132
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRWI-0000Zf-Q1; Sun, 22 Oct 2023 02:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW7-0000ZF-VB
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:51 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW6-0001ZI-AB
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:51 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3b2ea7cca04so1666161b6e.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954449; x=1698559249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lzvcZe31/ZJG4v0X6So+um8Fp3Qd2Uum0t8sUDXqISw=;
 b=RsUzBz2Ff73UXvVsmHgKRhskMz0jtH86ikcLh4K2qG7TUEot931YrBEl7WuLmfoEt4
 /LtfkBjnTchRRJe+b/QenMDJ20Qz80l+PFo0d9a+S0/qdO4vZznv+ugF+c38EPVJwUWD
 Q4VzkWGeH/opR4o0St+ADvdFsx+f32JHlqWsRGdsCG80YsZeWGgMhU14k57Z4poIKhl9
 2KjxYg618Hc3YD3iYm1a1lrLwatYcxzkpZPvjd+VgbJkGE5od3i2xgI+c9M0QFyLYjPA
 5e8vIabUR7NM5iPRZcH8Z4BIJx/810Mic33BADgOLTekf6mxB0kkZEi9RjmlPBZmoAvq
 X43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954449; x=1698559249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lzvcZe31/ZJG4v0X6So+um8Fp3Qd2Uum0t8sUDXqISw=;
 b=XTbDgD/8qBBeFgF3IvqL6LtNfA/F/CdztP2KRPrGocExkAIUesMvyeEm2iM989VPJa
 vujQEcn/WZtG/59AjWyrgpOgaGoS8uIIA+kVDRnH0OuDNzKgfDvUsGc+jmMnGBMZAn7I
 zPBsyJjt2KPFuP42MrtuWQ6ngDc7yUjnL4ydG0UEBFue6FnfWgCrv9toIbqoKTPb2vQW
 m95qs4sHpfzRRLCgq919JSuBIkiCtZYP9LMKtOWjyOfbrtwHG9m7si8ribjT9wc9Q/49
 Tl14bvWjYGetlJ/k2BOnIxpv/LdRP61Erh2K3oeAE1wEJo8duh3hNeGnR/BAFOD8Chx4
 pH5w==
X-Gm-Message-State: AOJu0YxazHzRQYkIOLf2qHuYtSCgJLO71eTGvXqlaZKUZHgmUkBvnAOb
 rLZJjBXuX4Mi5V9ysLlG+vkqus63/44ODZXHz4c=
X-Google-Smtp-Source: AGHT+IHc+eKfp4NM/zqnM6vNf2NsgUVPaYvutyv5tZo3FC1whLNSLhE9JWhAfMurF83hzM8zSkcbeQ==
X-Received: by 2002:a05:6808:1818:b0:3b2:e60d:27f6 with SMTP id
 bh24-20020a056808181800b003b2e60d27f6mr7704571oib.29.1697954448958; 
 Sat, 21 Oct 2023 23:00:48 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 19/90] target/sparc: Move SETHI to decodetree
Date: Sat, 21 Oct 2023 22:59:20 -0700
Message-Id: <20231022060031.490251-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/insns.decode |  6 +++++
 target/sparc/translate.c  | 50 ++++++++++++---------------------------
 2 files changed, 21 insertions(+), 35 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 9ab3f2eb82..f6f5401b10 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,6 +3,10 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+##
+## Major Opcodes 00 and 01 -- branches, call, and sethi.
+##
+
 &bcc    i a cond cc
 BPcc    00 a:1 cond:4   001 cc:1 0 - i:s19                 &bcc
 Bicc    00 a:1 cond:4   010          i:s22                 &bcc cc=0
@@ -14,4 +18,6 @@ BPr     00 a:1 0 cond:3 011 ..     - rs1:5 ..............  i=%d16
 
 NCP     00 -   ----     111 ----------------------         # CBcc
 
+SETHI   00 rd:5         100 i:22
+
 CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index d12f2b4b87..cdd929282a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2873,6 +2873,10 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+/*
+ * Major opcodes 00 and 01 -- branches, call, and sethi
+ */
+
 static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
 {
     if (annul) {
@@ -3029,6 +3033,15 @@ static bool trans_NCP(DisasContext *dc, arg_NCP *a)
 #endif
 }
 
+static bool trans_SETHI(DisasContext *dc, arg_SETHI *a)
+{
+    /* Special-case %g0 because that's the canonical nop.  */
+    if (a->rd) {
+        gen_store_gpr(dc, a->rd, tcg_constant_tl((uint32_t)a->i << 10));
+    }
+    return advance_pc(dc);
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3049,41 +3062,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
     rd = GET_FIELD(insn, 2, 6);
 
     switch (opc) {
-    case 0:                     /* branches/sethi */
-        {
-            unsigned int xop = GET_FIELD(insn, 7, 9);
-            switch (xop) {
-#ifdef TARGET_SPARC64
-            case 0x1:           /* V9 BPcc */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x3:           /* V9 BPr */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x5:           /* V9 FBPcc */
-                g_assert_not_reached(); /* in decodetree */
-#else
-            case 0x7:           /* CBN+x */
-                g_assert_not_reached(); /* in decodetree */
-#endif
-            case 0x2:           /* BN+x */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x6:           /* FBN+x */
-                g_assert_not_reached(); /* in decodetree */
-            case 0x4:           /* SETHI */
-                /* Special-case %g0 because that's the canonical nop.  */
-                if (rd) {
-                    uint32_t value = GET_FIELD(insn, 10, 31);
-                    TCGv t = gen_dest_gpr(dc, rd);
-                    tcg_gen_movi_tl(t, value << 10);
-                    gen_store_gpr(dc, rd, t);
-                }
-                break;
-            case 0x0:           /* UNIMPL */
-            default:
-                goto illegal_insn;
-            }
-            break;
-        }
-        break;
+    case 0:
+        goto illegal_insn; /* in decodetree */
     case 1:
         g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
-- 
2.34.1


