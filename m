Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 524437D62B8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:30:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIY-0000Ez-En; Wed, 25 Oct 2023 03:27:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIW-0000Dr-4u
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:24 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIU-0004gb-FB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:23 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-5a9bf4fbd3fso3957633a12.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218841; x=1698823641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUL+P8NrKSp/2wsdRODDHeKdHM6SlkUdqF+vGMepqTA=;
 b=OT0RRnfrRWQJuI7aaNBJw1KFQtLAj4/XvrNwnnLTdZUgpVahFcldFNZ0mgs5T2mjgn
 mGK7ejF5ZGZroZlE32plwYDLhXaBo57NzuFtv68XCd9Sx732ygroRrpLiCXYWP27KRMU
 z/dGwWiJRvXnqXOPi0QTnMrzCHS7MlLi0Z38AuROXUXIrcuipX4RTaDVvbybFHKKriL2
 csDxkPJHUXzev4tr4XF7uZ9+IqrdnLkW0iWF2fa/b+iIkfiN2AWUi11IBKCKi/OHFneW
 fCWoxJupq1W/JHbJIeL6gjJOUPntUBOxXHozY/ANt4hJA0QXCF1qn1CfrELkulcfhtow
 rktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218841; x=1698823641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KUL+P8NrKSp/2wsdRODDHeKdHM6SlkUdqF+vGMepqTA=;
 b=FTksomEIT7nVNat55+p0Pa5Td+qAKpNX1/Xrq4w/bk5vRaNTxlP935CAr366inO/hn
 PydtBJLa1w7PDUJEfLqsTdTNtLUnIl/E2BEmhU59o8LjIpVH2T3eVF43I1mFMCRlFC+O
 trRKOEVl7UKOMUaSPeQmwyWIn+PnpigEkYsPu7VfC+/b2cizwm45tEWEyI69IRs2yeDs
 U+dF2mdDE/opLuL6avdwwmjFuoJ1stU6vP8fY5tmyoaEG30/Q4Pl0cP8FNV/tEEEfLxg
 Lo/qnJ6sU/1PH57a39gtgeERDxqaUa2MNC6ae+O1/hYgd80wpEwPpN0UVQw6IGhzuu/b
 4Zkg==
X-Gm-Message-State: AOJu0YwzSPGvqwVkBQeFN/Ivv3B5Z8BrlCNg190JFzYfTwGUbwG4ovFC
 swj2FDXzd5W3aHF63AyqJu7SWlqsqgsgUyYNvns=
X-Google-Smtp-Source: AGHT+IHgN/faRt8n0DEazTm3tclLwFpQ/hMORsLnMW8rH+xhAe/6poiU4ijbGIOjm9oMyjyxOgvh+Q==
X-Received: by 2002:a05:6a21:66c6:b0:174:2a38:9d9c with SMTP id
 ze6-20020a056a2166c600b001742a389d9cmr5259134pzb.57.1698218841060; 
 Wed, 25 Oct 2023 00:27:21 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 13/29] tcg/i386: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:26:51 -0700
Message-Id: <20231025072707.833943-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 tcg/i386/tcg-target.c.inc | 43 +++++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index f4f456a2c0..0d97864174 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -504,6 +504,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_GEU] = JCC_JAE,
     [TCG_COND_LEU] = JCC_JBE,
     [TCG_COND_GTU] = JCC_JA,
+    [TCG_COND_TSTEQ] = JCC_JE,
+    [TCG_COND_TSTNE] = JCC_JNE,
 };
 
 #if TCG_TARGET_REG_BITS == 64
@@ -1419,12 +1421,14 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 }
 
 /* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
+static void tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
 {
     if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
         tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
         tcg_out8(s, i);
+    } else if ((i & ~0xff00) == 0 && r < 4) {
+        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, r);
+        tcg_out8(s, i >> 8);
     } else {
         tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, r);
         tcg_out32(s, i);
@@ -1434,15 +1438,25 @@ tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i, int rexw)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    if (const_arg2) {
-        if (arg2 == 0) {
-            /* test r, r */
+    if (is_tst_cond(cond)) {
+        if (!const_arg2) {
+            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
+        } else {
+            if (!rexw) {
+                arg2 = (uint32_t)arg2;
+            } else if ((arg2 >> 31 >> 1) == 0) {
+                rexw = 0;
+            }
+            tcg_out_testi(s, arg1, arg2, rexw);
+        }
+    } else {
+        if (!const_arg2) {
+            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        } else if (arg2 == 0) {
             tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
         } else {
             tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
         }
-    } else {
-        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
     }
     return tcg_cond_to_jcc[cond];
 }
@@ -1461,18 +1475,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
+    TCGCond cond = args[4];
 
-    switch(args[4]) {
+    switch (cond) {
     case TCG_COND_EQ:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
-                       label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+    case TCG_COND_TSTEQ:
+        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
+                       args[0], args[2], const_args[2], label_next, 1);
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+    case TCG_COND_TSTNE:
+        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
                        label_this, small);
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_LT:
-- 
2.34.1


