Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB52773774
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:14:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD9c-0004Ev-OH; Mon, 07 Aug 2023 23:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8u-0001fL-Vt
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:23 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTD8e-0000Kv-5U
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:12:20 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6bb07d274feso4244544a34.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691464323; x=1692069123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmotEscJTq84Ab7ZtBPgGyq95MOlwaj6T0nGog5dLQg=;
 b=ei4t0ZwicPFQzScsHhMe8LIs28nac0bRAwtBskP7xnTQ+Qwjf7r4r3Uhd539TsP9yu
 XP/RUJiYVMgZihgX9pR9BA0UnKoB7mML4g3sieJiyD1gW9oc7rgqH1DGYJRujtcYpTs9
 a1YPZ7o6KCzz2S0VPB2Yv9YtOWkaRe02sYOj/piIc6uOSHvji+/ENO/EFwLgVGEyIY5a
 WdyZ+KhOpn5YrFJ3HpV14c70yRo22Xck7COEn7fUAuDLLiGa9cRYBv+r6SATyJlZRVbF
 9kTBDu4t5XCe1ehp6xrtGJ8K5KJ99cLdVCJ/o+7KGk5vWH9aRqPfsDi1paaElgS8uncf
 zzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464323; x=1692069123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmotEscJTq84Ab7ZtBPgGyq95MOlwaj6T0nGog5dLQg=;
 b=kAOpC0GL4ut+Lmcz7G52XYZKnSnEBmR1UOAf/P2tb8KZtIw56Pll+i4RWHyZ/DclzL
 gNgvRaZit1FlyE2IUEqC+5HI5Ml/EIvjqZHHZfIF4t7hGvASOhL9vtJApz46oUUnudTc
 UmTHEkN3vUCIyYfxwywsWQ/j0XTDtK3MvNbFUhYDNYRcysQMO4t8Xw1M+r9bItg2Sq9h
 gppq8qXakQG/NnsWg95ffu14K8sgUOJDdtLUqZ0W4TDWqC5doQ4NjukhOs74OZxG4BBM
 dkVRrD2BhuEBIbfLmUs1UGdIw/G2mmdWWrOCx0kEwBSaNYedxbiqc8n2mp7sZr5DurPW
 UY7A==
X-Gm-Message-State: AOJu0Yw0nRdM2UfS5Zt9VDzZUoD5j5YhU+x8qa7UKMT4mtKw0YFne7wM
 2sDTWYwR+l2tZo3il+BW3Wvk0pMDENdDEoKsEU8=
X-Google-Smtp-Source: AGHT+IFH6i1MPwBBxLPbtoRzH1bfs54Mx94DeqFraUwBEb2TF8feOLfF4D9FYAuLTOsmDQMoHkZFaA==
X-Received: by 2002:a05:6358:2920:b0:134:c1eb:8744 with SMTP id
 y32-20020a056358292000b00134c1eb8744mr7904903rwb.9.1691464322492; 
 Mon, 07 Aug 2023 20:12:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 g64-20020a636b43000000b0055bf96b11d9sm5639087pgc.89.2023.08.07.20.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:12:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH 20/24] tcg/i386: Add cf parameter to tcg_out_cmp
Date: Mon,  7 Aug 2023 20:11:39 -0700
Message-Id: <20230808031143.50925-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808031143.50925-1-richard.henderson@linaro.org>
References: <20230808031143.50925-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

Add the parameter to avoid TEST and pass along to tgen_arithi.
All current users pass false.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index b88fc14afd..56549ff2a0 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1418,15 +1418,15 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
     }
 }
 
-static void tcg_out_cmp(TCGContext *s, TCGArg arg1, TCGArg arg2,
-                        int const_arg2, int rexw)
+static void tcg_out_cmp(TCGContext *s, int rexw, TCGArg arg1, TCGArg arg2,
+                        int const_arg2, bool cf)
 {
     if (const_arg2) {
-        if (arg2 == 0) {
+        if (arg2 == 0 && !cf) {
             /* test r, r */
             tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
         } else {
-            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
+            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, cf);
         }
     } else {
         tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
@@ -1437,7 +1437,7 @@ static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *label, bool small)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+    tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, false);
     tcg_out_jxx(s, tcg_cond_to_jcc[cond], label, small);
 }
 
@@ -1528,7 +1528,7 @@ static void tcg_out_setcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGArg dest, TCGArg arg1, TCGArg arg2,
                             int const_arg2)
 {
-    tcg_out_cmp(s, arg1, arg2, const_arg2, rexw);
+    tcg_out_cmp(s, rexw, arg1, arg2, const_arg2, false);
     tcg_out_modrm(s, OPC_SETCC | tcg_cond_to_jcc[cond], 0, dest);
     tcg_out_ext8u(s, dest, dest);
 }
@@ -1594,7 +1594,7 @@ static void tcg_out_movcond(TCGContext *s, int rexw, TCGCond cond,
                             TCGReg dest, TCGReg c1, TCGArg c2, int const_c2,
                             TCGReg v1)
 {
-    tcg_out_cmp(s, c1, c2, const_c2, rexw);
+    tcg_out_cmp(s, rexw, c1, c2, const_c2, false);
     tcg_out_cmov(s, cond, rexw, dest, v1);
 }
 
@@ -1637,7 +1637,7 @@ static void tcg_out_clz(TCGContext *s, int rexw, TCGReg dest, TCGReg arg1,
         tgen_arithi(s, ARITH_XOR + rexw, dest, rexw ? 63 : 31, 0);
 
         /* Since we have destroyed the flags from BSR, we have to re-test.  */
-        tcg_out_cmp(s, arg1, 0, 1, rexw);
+        tcg_out_cmp(s, rexw, arg1, 0, 1, false);
         tcg_out_cmov(s, TCG_COND_EQ, rexw, dest, arg2);
     }
 }
-- 
2.34.1


