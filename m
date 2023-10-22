Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9057A7D2160
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW4-0000Vc-5a; Sun, 22 Oct 2023 02:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW1-0000UQ-P7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRW0-0001Wy-00
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so1741093b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954442; x=1698559242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kh4UR/x6NVS8OMj/epOA+pEm4qe7LB7jB8T5mbBYeEw=;
 b=TFHTqxyXoBvkBd3cX23jmhkXeiLslFau7llcqZWqwTvsJcQLD7KhrGPVM/0Bs7Vren
 vT+I75F5f5Zs6Xt4Y2lAyeCN1oaPHxyVXR+G9xi5mOrtKfSFob1JYQ9pve++49gD8DL9
 tpsDMGG/kVKhJQUe546tEoa/XWYvwKk3SLnMv/rQHG8B8YoTBXjI+0jtxyvJHqZNuCSR
 uI89KLvjULpMrNc/Fqh7nmTNwJs7ICaZIIkhorcf1C/36CLHiDIEd0iTOb60/MpiWcaa
 YmahZBL+w8D3cmWH77fwMPHPE9appLhPt7BlPG4IQAoCK3oE4VwCGnXsDvcSOHgizwHn
 OBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954442; x=1698559242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kh4UR/x6NVS8OMj/epOA+pEm4qe7LB7jB8T5mbBYeEw=;
 b=IVFBHDEvxdHXtaVDJ+nf25Zsg7HsvO+v664wzjP4glmXjkX5byWZGULEfOTY2WTYDl
 gxI838Dc+qz3RcHmHzlNU9TaCrhnHi4lYk4lyMCNRaf5YJCuer1Zp+sq40L9Bax/CrIs
 TB2kGW/ED48L7Qhrhs51eWOmEIgKaLMXZQv437LoaD1dEcknoUjp4iCwxGAQL5IzXRDX
 9IJgMhog3Ijs4bez1q9V/LhvGTqZWuQptDftIEGxT4ZAxQGKKmmrWfHR5vI1RWlPJaLX
 t5Z2W1sFjT9vMBSwaiZ+DQtGwnLObbsSVrC5/PG/GGva42wHngsGPFsUDFEBXgfWhnVn
 nXNQ==
X-Gm-Message-State: AOJu0YzeyK6tevC1lhjJ5L2HLfrbHVWgjsHleHefroEPawflowFHPoYJ
 72ZZaEnBlSq4Y7pMJpbJ40YrFp5hl181SHBS9ZI=
X-Google-Smtp-Source: AGHT+IG0kSVUWvCkIWMQpq9O9q1+NSFoxi9feisN0HXjsZJmPpOBWJfZAW/re8ZTSAcrFAaWjstjlw==
X-Received: by 2002:a17:903:2310:b0:1c1:e7b2:27ad with SMTP id
 d16-20020a170903231000b001c1e7b227admr4860226plh.60.1697954442353; 
 Sat, 21 Oct 2023 23:00:42 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 11/90] target/sparc: Move CALL to decodetree
Date: Sat, 21 Oct 2023 22:59:12 -0700
Message-Id: <20231022060031.490251-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/sparc/insns.decode |  1 +
 target/sparc/translate.c  | 34 +++++++++++++++++-----------------
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5811a679db..a5f5d2681e 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -3,3 +3,4 @@
 # Sparc instruction decode definitions.
 # Copyright (c) 2023 Richard Henderson <rth@twiddle.net>
 
+CALL    01 i:s30
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 9eb2b7e52f..7ef4c6d4f7 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -285,6 +285,11 @@ static void gen_address_mask(DisasContext *dc, TCGv addr)
     }
 }
 
+static target_ulong address_mask_i(DisasContext *dc, target_ulong addr)
+{
+    return AM_CHECK(dc) ? (uint32_t)addr : addr;
+}
+
 static TCGv gen_load_gpr(DisasContext *dc, int reg)
 {
     if (reg > 0) {
@@ -3041,6 +3046,16 @@ static bool advance_pc(DisasContext *dc)
     return true;
 }
 
+static bool trans_CALL(DisasContext *dc, arg_CALL *a)
+{
+    target_long target = address_mask_i(dc, dc->pc + a->i * 4);
+
+    gen_store_gpr(dc, 15, tcg_constant_tl(dc->pc));
+    gen_mov_pc_npc(dc);
+    dc->npc = target;
+    return true;
+}
+
 #define CHECK_IU_FEATURE(dc, FEATURE)                      \
     if (!((dc)->def->features & CPU_FEATURE_ ## FEATURE))  \
         goto illegal_insn;
@@ -3146,23 +3161,8 @@ static void disas_sparc_legacy(DisasContext *dc, unsigned int insn)
             break;
         }
         break;
-    case 1:                     /*CALL*/
-        {
-            target_long target = GET_FIELDs(insn, 2, 31) << 2;
-            TCGv o7 = gen_dest_gpr(dc, 15);
-
-            tcg_gen_movi_tl(o7, dc->pc);
-            gen_store_gpr(dc, 15, o7);
-            target += dc->pc;
-            gen_mov_pc_npc(dc);
-#ifdef TARGET_SPARC64
-            if (unlikely(AM_CHECK(dc))) {
-                target &= 0xffffffffULL;
-            }
-#endif
-            dc->npc = target;
-        }
-        goto jmp_insn;
+    case 1:
+        g_assert_not_reached(); /* in decodetree */
     case 2:                     /* FPU & Logical Operations */
         {
             unsigned int xop = GET_FIELD(insn, 7, 12);
-- 
2.34.1


