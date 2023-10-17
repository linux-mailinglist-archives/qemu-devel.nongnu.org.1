Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D897CBAB1
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:14:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdKF-0000Lm-R2; Tue, 17 Oct 2023 02:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKD-0000FV-7b
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdKB-0003tC-IU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:13:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ca052ec63bso31300585ad.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523182; x=1698127982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Ww/eIka2fIiuMHxW6vTYf2n2OXLN4aKw8vXIwfDBzM=;
 b=f3ymxVJxjLmyii4XZrNIBBQzUe9WEGFLmso1yT1Xzn3tUZ79dDVnanCXUJLTadJJYA
 SxkinAmAgX2EMn/Hzj4v7nE7dcILidXMIkp63VdT82JNVP1Ce9nzTYL7lPbn49G3hB2U
 wc0dl2CbwOElKNT8bBqEB9f9OkjhAn/8qKhpaI2nnBOaV6xsfUhtxwizKmSTe8Uf9jDm
 Uy+seZM1oLMmk4N+GIdF6/OCC0dxpqphbR3xYrqhkHjid5kkmOa5vxDMRdGPlGqtPWRP
 JORR6Ts6hu2sSRlFyD40XP7rWAWBKTy+/zZEbQg6gzyglsUNaTeGLtiTKyOc3mJQJDNj
 KGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523182; x=1698127982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Ww/eIka2fIiuMHxW6vTYf2n2OXLN4aKw8vXIwfDBzM=;
 b=QMALcQhJKbWfsCJYcqqZ3gPfPqn6XAjcGsVvT3iQtXHaVlAyzbR6nx3BuEqw+/5Ddb
 YJ0YSS8rZYmdn7CuGjAF9EcrrwPFd7oO70Ia77GwWCOnm65rn2jstz1vEPwAr3REPnYv
 UPQkYxdUImFMEyBwwgoApQQ++2vKhSkIcB9CYIVedFsYRclgku5w5vaBa0xwgugldxIZ
 x3e/tgHgO8qJEJVA9RyoSYBT2v9++kzZFmavdxZaDjsfjW4jgkjwKGjs9QaueyfnMjnd
 9IFGXpW4AGpIZtcEW4xRwyh2CQtTCRdWJbTDqhJJ/SSVZLfFOJOJf5UadggXG73HXxn/
 ZZ+g==
X-Gm-Message-State: AOJu0YzxBO/Dem7j4uGDWfyUEmp2IgZTipnZjKZ8H+b8PG7fJ2cnVlik
 drO32Xs7LWm9rhjPa+S61RXr5l0KeqbSGMr/JcQ=
X-Google-Smtp-Source: AGHT+IGenCclhrFEy0ZRBnfPkUbfP9Q6+yNfisNaeRsy2d14BWViGVN/tJ+vKjTlHcukjgB247AQfg==
X-Received: by 2002:a17:902:e5c1:b0:1b9:e241:ad26 with SMTP id
 u1-20020a170902e5c100b001b9e241ad26mr1469930plf.9.1697523182048; 
 Mon, 16 Oct 2023 23:13:02 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 19/90] target/sparc: Move SETHI to decodetree
Date: Mon, 16 Oct 2023 23:11:33 -0700
Message-Id: <20231017061244.681584-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index 70bfbb41e9..b53127ecb7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2868,6 +2868,10 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+/*
+ * Major opcodes 00 and 01 -- branches, call, and sethi
+ */
+
 static bool advance_jump_uncond_never(DisasContext *dc, bool annul)
 {
     if (annul) {
@@ -3040,6 +3044,15 @@ static bool trans_NCP(DisasContext *dc, arg_NCP *a)
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
@@ -3060,41 +3073,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
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


