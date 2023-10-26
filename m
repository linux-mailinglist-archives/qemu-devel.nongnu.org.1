Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6367D79A6
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:39:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo66-0000pS-Gw; Wed, 25 Oct 2023 20:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5w-0000kJ-DW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:28 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5r-0006as-Iz
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso2057955ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279561; x=1698884361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jvJ/P4HX7554nJIJGIM3vtxFYVYTJFcbVyfLPezXvC4=;
 b=SznyKQfwwDnqnQ8Uj7XTZo5CD5Fh8wljSmKbVEwCHMDjGP/DdIolk/Hfituf3JqdXc
 ylCMYkNrTS3TH+PEaeTSlyXyFy8+tvx84wZmjZRa+8E1yyiIQuLB2vEVZfxEZn2ezSZ8
 WmBw/K6spfxovNUH6m1VyxY18SoQq6U2T8MBhCbBtUFhCsSxRAOXUtcWm2dW6sO6gOnx
 +4Adi1zZpTeyn/lqRg+W1zLPiKaAcp/5SGZrKhkt1/f3B1+BL5HtsIG66MVpnZPmm4+U
 VgAbr9V3SG+QjcGYe1e4/ShWM6Nac3T2u7mdtrMBvpDXw3PwROaQV8siLV97Iu5qJ6eS
 grEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279561; x=1698884361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jvJ/P4HX7554nJIJGIM3vtxFYVYTJFcbVyfLPezXvC4=;
 b=nj7ZSnkemyyevW6N6yd5lPES3rOfGtqFrmYYfu2GW56b0QHLXvb8JMBbFfflnbZzcb
 yvhkFA0pE22wjFTK+bj5VcGrxxI+F6UTt/Ms27HmJg1wXzX6NoBtWRM76eY9R2fy7+zp
 OFr/9UZlilrrJ647N4YSvUwPAXuLfra5xxjw2oN3HVx6GA/brKf+3fkdqF4X/WbUMtNw
 /JnGv0kkQyXhZTRiNJPlGEovRGkL4h25TSrk96cmnMAO8PMzWx47lUzmPPszsC89M/pg
 01hd0nhD4IcXv7+BvDBQj+Y9L+RMuKfZV9UM0ze1LAdXV47rUVKOpakaPmh515PBB6Fs
 Co1g==
X-Gm-Message-State: AOJu0YxJMFBcSFxKRXiteUFl5Lcbhs4ZO2h6P/79Fjy21NXizlS+qkra
 3rB9F7BAVfp+ZMH78+dhwGV9qDr9KSH7sRLQba4=
X-Google-Smtp-Source: AGHT+IHJHseCxsnGDmJyh40a+nBOxs9igp7Dbu5OYOQMr5g9LfQNAZPJDFgZ2ppwmb9XczdTyhXPHQ==
X-Received: by 2002:a17:902:d502:b0:1c4:4dbc:92bc with SMTP id
 b2-20020a170902d50200b001c44dbc92bcmr15605010plg.16.1698279560941; 
 Wed, 25 Oct 2023 17:19:20 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/29] tcg/ppc: Use cr0 in tcg_to_bc and tcg_to_isel
Date: Wed, 25 Oct 2023 17:14:23 -0700
Message-Id: <20231026001542.1141412-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Using cr0 means we could choose to use rc=1 to compute the condition.
Adjust the tables and tcg_out_cmp that feeds them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 68 ++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 666d480e86..3c2ec4db4b 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -670,30 +670,30 @@ enum {
 };
 
 static const uint32_t tcg_to_bc[] = {
-    [TCG_COND_EQ]  = BC | BI(7, CR_EQ) | BO_COND_TRUE,
-    [TCG_COND_NE]  = BC | BI(7, CR_EQ) | BO_COND_FALSE,
-    [TCG_COND_LT]  = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GE]  = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LE]  = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GT]  = BC | BI(7, CR_GT) | BO_COND_TRUE,
-    [TCG_COND_LTU] = BC | BI(7, CR_LT) | BO_COND_TRUE,
-    [TCG_COND_GEU] = BC | BI(7, CR_LT) | BO_COND_FALSE,
-    [TCG_COND_LEU] = BC | BI(7, CR_GT) | BO_COND_FALSE,
-    [TCG_COND_GTU] = BC | BI(7, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GT]  = BC | BI(0, CR_GT) | BO_COND_TRUE,
+    [TCG_COND_LTU] = BC | BI(0, CR_LT) | BO_COND_TRUE,
+    [TCG_COND_GEU] = BC | BI(0, CR_LT) | BO_COND_FALSE,
+    [TCG_COND_LEU] = BC | BI(0, CR_GT) | BO_COND_FALSE,
+    [TCG_COND_GTU] = BC | BI(0, CR_GT) | BO_COND_TRUE,
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
 static const uint32_t tcg_to_isel[] = {
-    [TCG_COND_EQ]  = ISEL | BC_(7, CR_EQ),
-    [TCG_COND_NE]  = ISEL | BC_(7, CR_EQ) | 1,
-    [TCG_COND_LT]  = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GE]  = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LE]  = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GT]  = ISEL | BC_(7, CR_GT),
-    [TCG_COND_LTU] = ISEL | BC_(7, CR_LT),
-    [TCG_COND_GEU] = ISEL | BC_(7, CR_LT) | 1,
-    [TCG_COND_LEU] = ISEL | BC_(7, CR_GT) | 1,
-    [TCG_COND_GTU] = ISEL | BC_(7, CR_GT),
+    [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GT]  = ISEL | BC_(0, CR_GT),
+    [TCG_COND_LTU] = ISEL | BC_(0, CR_LT),
+    [TCG_COND_GEU] = ISEL | BC_(0, CR_LT) | 1,
+    [TCG_COND_LEU] = ISEL | BC_(0, CR_GT) | 1,
+    [TCG_COND_GTU] = ISEL | BC_(0, CR_GT),
 };
 
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
@@ -1826,7 +1826,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isa_3_10) {
         tcg_insn_unit bi, opc;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         /* Re-use tcg_to_bc for BI and BO_COND_{TRUE,FALSE}. */
         bi = tcg_to_bc[cond] & (0x1f << 16);
@@ -1879,7 +1879,7 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
     if (have_isel) {
         int isel, tab;
 
-        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+        tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
 
         isel = tcg_to_isel[cond];
 
@@ -1965,7 +1965,7 @@ static void tcg_out_brcond(TCGContext *s, TCGCond cond,
                            TCGArg arg1, TCGArg arg2, int const_arg2,
                            TCGLabel *l, TCGType type)
 {
-    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 7, type);
+    tcg_out_cmp(s, cond, arg1, arg2, const_arg2, 0, type);
     tcg_out_bc_lab(s, cond, l);
 }
 
@@ -1979,7 +1979,7 @@ static void tcg_out_movcond(TCGContext *s, TCGType type, TCGCond cond,
         return;
     }
 
-    tcg_out_cmp(s, cond, c1, c2, const_c2, 7, type);
+    tcg_out_cmp(s, cond, c1, c2, const_c2, 0, type);
 
     if (have_isel) {
         int isel = tcg_to_isel[cond];
@@ -2023,7 +2023,7 @@ static void tcg_out_cntxz(TCGContext *s, TCGType type, uint32_t opc,
     if (const_a2 && a2 == (type == TCG_TYPE_I32 ? 32 : 64)) {
         tcg_out32(s, opc | RA(a0) | RS(a1));
     } else {
-        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 7, type);
+        tcg_out_cmp(s, TCG_COND_EQ, a1, 0, 1, 0, type);
         /* Note that the only other valid constant for a2 is 0.  */
         if (have_isel) {
             tcg_out32(s, opc | RA(TCG_REG_R0) | RS(a1));
@@ -2078,7 +2078,7 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
     do_equality:
         tcg_out_cmp(s, cond, al, bl, blconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond, ah, bh, bhconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
     case TCG_COND_LT:
@@ -2096,8 +2096,8 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
 
         tcg_out_cmp(s, cond, ah, bh, bhconst, 6, TCG_TYPE_I32);
         tcg_out_cmp(s, cond2, al, bl, blconst, 7, TCG_TYPE_I32);
-        tcg_out32(s, op | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
-        tcg_out32(s, CROR | BT(7, CR_EQ) | BA(6, bit1) | BB(7, CR_EQ));
+        tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, bit2));
+        tcg_out32(s, CROR | BT(0, CR_EQ) | BA(6, bit1) | BB(0, CR_EQ));
         break;
 
     default:
@@ -2109,8 +2109,8 @@ static void tcg_out_setcond2(TCGContext *s, const TCGArg *args,
                              const int *const_args)
 {
     tcg_out_cmp2(s, args + 1, const_args + 1);
-    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(7));
-    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, 31, 31, 31);
+    tcg_out32(s, MFOCRF | RT(TCG_REG_R0) | FXM(0));
+    tcg_out_rlw(s, RLWINM, args[0], TCG_REG_R0, CR_EQ + 0*4 + 1, 31, 31);
 }
 
 static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
@@ -2441,12 +2441,12 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_cmp(s, TCG_COND_EQ, addrhi, TCG_REG_TMP2,
                         0, 6, TCG_TYPE_I32);
 
-            /* Combine comparisons into cr7. */
-            tcg_out32(s, CRAND | BT(7, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
+            /* Combine comparisons into cr0. */
+            tcg_out32(s, CRAND | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         } else {
-            /* Full comparison into cr7. */
+            /* Full comparison into cr0. */
             tcg_out_cmp(s, TCG_COND_EQ, TCG_REG_R0, TCG_REG_TMP2,
-                        0, 7, addr_type);
+                        0, 0, addr_type);
         }
 
         /* Load a pointer into the current opcode w/conditional branch-link. */
-- 
2.34.1


