Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE8A7E1648
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjUB-0003R0-EI; Sun, 05 Nov 2023 15:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU9-0003PU-7Q
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:41 -0500
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU7-0002Ab-KE
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:40 -0500
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a956887c20so160798739f.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215158; x=1699819958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKj41VweZhjCF7fzIbibfC9ijUJvX4oDkwTltCV+TME=;
 b=K3CQE2wvFSRpvj1EZTY1UPGO9PeYcdRnw8QlZIs52tSwgcpcZZvswiBuBUCY87ju3M
 ivLSKhjK7iVpiuCEFOe95K0jRvzUurMonjFzW5DOf14m50s+GN+kD3QmSY67Uy4CErgR
 /pwgY2/umcxAW1RqBCh5o0Q957IWc7SDeyVeQClINMksO7CAN+tU3l02/W9P8CvjlDMb
 t3nSvpW2M8u13y5p5OZ6wIe43QfZSKKOu+NqLsP5nCq1T8GfD4r/v0En0b1xNnmb4+n/
 O8OsaFtiRarqXY/vOXMrfP9nzzW6Fjv2IvamA0fabEhWt1/sS/Dg5QbpDZQOUc9gOdvc
 tBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215158; x=1699819958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DKj41VweZhjCF7fzIbibfC9ijUJvX4oDkwTltCV+TME=;
 b=aX8c09phHQcAdZpdULRVIIvafhp8peEYPDiGtorTdOIAlFDnt6rebnf16BhzRuancL
 cGJPeMZHic718PqZmGx7OiTzc578iPlH09J4bnGy+TGKbUZZ2lbyZQYdkyTyJJKqvOme
 d+x4UREg8hOMXfUCjQIyLFyDBtXgfFRjmMLIvcqWWb6apfedv8e2JtnLGTaJu3X0YlwN
 9Bt46B63FUC2ghQGrWYpOCx2dEwQIty0ULRPcZ4a+49CWmVeZVsLta6lUxPxXx0h+SJK
 yCU52w3AHqYEGjGicwFx8UXcq5UgSOatZ5MIP6wVPn2wfeXgvfl1B6P8BLB0XBCOeH/B
 rq4A==
X-Gm-Message-State: AOJu0YzNRj3kf3cZQdk/nirv2ZIk7Q+uWHFdYdRTXW0xCFWNYHtZIUaY
 7gI5y8Gf2/9ce53eosmNWxAYBB5lh1PyVN4wV6k=
X-Google-Smtp-Source: AGHT+IEW5G3ItXzj7A2reyTnTB+/038x2br1u+Xe2gbDvXI3pmqYJgIUubjv1Ft9+XkyS0XoxJgZ0w==
X-Received: by 2002:a05:6602:1607:b0:7a9:afab:b984 with SMTP id
 x7-20020a056602160700b007a9afabb984mr33204503iow.17.1699215158442; 
 Sun, 05 Nov 2023 12:12:38 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 17/21] target/sparc: Record entire jump condition in
 DisasContext
Date: Sun,  5 Nov 2023 12:12:18 -0800
Message-Id: <20231105201222.202395-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd32.google.com
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

Use the original condition instead of consuming cpu_cond,
which will now only be live along exception paths.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 0bbe4cff3b..5c9a3d45fa 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -146,6 +146,12 @@ static TCGv_i64 cpu_fpr[TARGET_DPREGS];
 # define env64_field_offsetof(X)  ({ qemu_build_not_reached(); 0; })
 #endif
 
+typedef struct DisasCompare {
+    TCGCond cond;
+    TCGv c1;
+    int c2;
+} DisasCompare;
+
 typedef struct DisasDelayException {
     struct DisasDelayException *next;
     TCGLabel *lab;
@@ -159,7 +165,11 @@ typedef struct DisasContext {
     DisasContextBase base;
     target_ulong pc;    /* current Program Counter: integer or DYNAMIC_PC */
     target_ulong npc;   /* next PC: integer or DYNAMIC_PC or JUMP_PC */
-    target_ulong jump_pc[2]; /* used when JUMP_PC pc value is used */
+
+    /* Used when JUMP_PC value is used. */
+    DisasCompare jump;
+    target_ulong jump_pc[2];
+
     int mem_idx;
     bool fpu_enabled;
     bool address_mask_32bit;
@@ -178,12 +188,6 @@ typedef struct DisasContext {
     DisasDelayException *delay_excp_list;
 } DisasContext;
 
-typedef struct {
-    TCGCond cond;
-    TCGv c1;
-    int c2;
-} DisasCompare;
-
 // This function uses non-native bit order
 #define GET_FIELD(X, FROM, TO)                                  \
     ((X) >> (31 - (TO)) & ((1 << ((TO) - (FROM) + 1)) - 1))
@@ -912,9 +916,9 @@ static void gen_generic_branch(DisasContext *dc)
 {
     TCGv npc0 = tcg_constant_tl(dc->jump_pc[0]);
     TCGv npc1 = tcg_constant_tl(dc->jump_pc[1]);
-    TCGv zero = tcg_constant_tl(0);
+    TCGv c2 = tcg_constant_tl(dc->jump.c2);
 
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_npc, cpu_cond, zero, npc0, npc1);
+    tcg_gen_movcond_tl(dc->jump.cond, cpu_npc, dc->jump.c1, c2, npc0, npc1);
 }
 
 /* call this function before using the condition register as it may
@@ -2347,7 +2351,7 @@ static bool advance_pc(DisasContext *dc)
         case JUMP_PC:
             /* we can do a static jump */
             l1 = gen_new_label();
-            tcg_gen_brcondi_tl(TCG_COND_NE, cpu_cond, 0, l1);
+            tcg_gen_brcondi_tl(dc->jump.cond, dc->jump.c1, dc->jump.c2, l1);
 
             /* jump not taken */
             gen_goto_tb(dc, 1, dc->jump_pc[1], dc->jump_pc[1] + 4);
@@ -2434,9 +2438,10 @@ static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
             }
         } else {
             dc->pc = npc;
+            dc->npc = JUMP_PC;
+            dc->jump = *cmp;
             dc->jump_pc[0] = dest;
             dc->jump_pc[1] = npc + 4;
-            dc->npc = JUMP_PC;
 
             /* The condition for cpu_cond is always NE -- normalize. */
             if (cmp->cond == TCG_COND_NE) {
-- 
2.34.1


