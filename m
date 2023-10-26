Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE77D793E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:20:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2z-0007Lb-Ok; Wed, 25 Oct 2023 20:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2v-0007Gh-I5
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2r-0004w5-JR
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:21 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso294899b3a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279376; x=1698884176; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5V/MzDPCPtSl5p/d34/PgkVJsUATuXtmCOJbzl0yEFY=;
 b=ReP/tdTawWVX0Oj/2MovUjQSPcYasaBEXdYuTy8+wJ8A1GgsUtPoCP5QQ3uX6qxjoG
 jFbCSy72mZeBCN18p/q1K2uq+fcXlQHtdM2IEBRQxQIR5fiX9S4ALpTjzfHDHbB5P2gt
 BN7Uls2FsxD8fSmp+rWpMkIjb99qpVwUzfvgH9kwwZKUGIXn7B0US7ADezTuEIrRXYHT
 WllX3l0TNsOUKEhkqzNdFeWZ5ekFYRm9AT0v84/VrdmaXKd1Q/PtTzwYyCc4kMpp3+dT
 TtrcouAdLS0LvyXyN6cyH4m9JnHPQk6PsC4neS5Y7PdO1tE/z6FD2bpvVt9O90SrqlWz
 4CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279376; x=1698884176;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5V/MzDPCPtSl5p/d34/PgkVJsUATuXtmCOJbzl0yEFY=;
 b=n10ByJeTNWi/FoFBfMveGyu+sat0+dqujaD+yPeVdhCryGRID6iqC97knhgWejEdTF
 tjaDXTJlF5VP3PRhjkPpcWGNm7C9i0I0xwzvJ15MgeoHci4VQLL7ZLR/5YuutUc3gTir
 OLnCGe2SI1dqfgu/eudurVR4kbe2uVXFq+d47NPPkBtXsB86egHfSaGOOMfVkcR0bs0M
 lOSOmDJSPXCW8g/O6XRt87y8cKZ7yfEP5wMZIzMKgsJ6Jkk1X9wdSdCu+dqZDEex8B1n
 folv9fQEwut/SkTGri9K/cXzlEsAkGsQPAxiKVheGsn9YVodaQdM4lARtvk1L2fGqkMq
 jc6A==
X-Gm-Message-State: AOJu0YxQb03o8S1rFgUvEsZzMtGXFEgtItHz7SbgLzqkuC3Y+bbHeemN
 +7i8tQp9b70h5ezfWTNc0lfF0edWgPJWB7kHs/4=
X-Google-Smtp-Source: AGHT+IHRVVIFFpSO5oULV52pZ/2MhoAJWdL2M2PevJ1aSfnCa95YYB/wN0ALH6rgBpBv6HEBRtkP1w==
X-Received: by 2002:a17:902:f550:b0:1ca:7086:60f7 with SMTP id
 h16-20020a170902f55000b001ca708660f7mr18868027plf.28.1698279376220; 
 Wed, 25 Oct 2023 17:16:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:16:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 20/94] target/sparc: Move SETHI to decodetree
Date: Wed, 25 Oct 2023 17:14:18 -0700
Message-Id: <20231026001542.1141412-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
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


