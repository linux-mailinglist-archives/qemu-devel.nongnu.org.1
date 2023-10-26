Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 725097D7976
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:29:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo6V-0001fr-Kq; Wed, 25 Oct 2023 20:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo6E-00013b-AK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:46 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo5t-0006be-P0
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:19:45 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cac925732fso2256745ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279564; x=1698884364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BFVGCMOltQrt8RNTWYZyEMkY4e7wb1/f4QxWVOJact4=;
 b=DjB8mQupz0zkvpdhkknTvvoANNFyACJlW98L9/0aHtGEpuD7y0uRqDjSp0PFb9iS/e
 9QKYoyR4fs0qUNkP7hs1+X+4dy8ZUY/hrH9hkEI5QOdhKjr3+eQErZ+VXFv01n+uiIYv
 pTsUglXQt483YkdBhBCih8jzAr2O6HiOHLl975zlnIE5vZJn7fRovFHcdRSOKQ8hqIfq
 nTnFsLt20cjeMwFZuqW/BIVI6ukV62SwImf7tcVJzgaSIwKBJQ2TSuhWIc2ecpve/hvN
 OQvivB9gWpVu2BpPDNkzwcXbv9t6CpwRX4haIquGqQuloi6YlcVjQBBQmN8eyuA5h2FH
 k6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279564; x=1698884364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFVGCMOltQrt8RNTWYZyEMkY4e7wb1/f4QxWVOJact4=;
 b=Cnw6r1GXxpS5g2vK2oEId6DbTrGh54P1lwcfFCDry1qKcd3dxCyzBfZ8NSdO8G15ud
 X+D85Gj5C7ssFFlCqJItdezGQhUz0I7mDnIgpXDhiHKXbrlqIO5QbUn4B71cwK3l32qA
 N2sH7CIBe7pbX6QlA/OMEvu0r7eB4nyP8pQIpF84H/MAVj64f0ewBI2E17YlussdMKko
 Nis3PUv8IAJ97QTPgc4po7uy4AdH4yOXCuWin2LEqS+HBPvxY9J41D0v8lmfIllLledm
 X96b4XgXxDmzOrXe5RHw51Y8dvimJjvIRQC62krUghI6y3fXWEsuQz2nzdw39pwX95VW
 wepQ==
X-Gm-Message-State: AOJu0YzUUPc+nLJJZDxqqNbuQaibe8sywzmd0c8pcUEEXRaykULx7fVt
 bsxdY39/DE5GAh3gc6dGJy6TInA7ki7pxAK2Qls=
X-Google-Smtp-Source: AGHT+IFQauImQLC9YEIxbdf/kBDllUD55DDLi+4wzc4Sb42YFu6nNox43dE/gISRV3WtK7/ysFrt3g==
X-Received: by 2002:a17:902:f550:b0:1ca:8541:e1ea with SMTP id
 h16-20020a170902f55000b001ca8541e1eamr15874808plf.0.1698279564265; 
 Wed, 25 Oct 2023 17:19:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001c5fc291ef9sm9754655plb.209.2023.10.25.17.19.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:19:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/29] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 17:14:27 -0700
Message-Id: <20231026001542.1141412-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/ppc/tcg-target.c.inc | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index fe141a26f9..5a316f364d 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -669,9 +669,11 @@ enum {
     CR_SO
 };
 
-static const uint32_t tcg_to_bc[] = {
+static const uint32_t tcg_to_bc[16] = {
     [TCG_COND_EQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
     [TCG_COND_NE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
+    [TCG_COND_TSTEQ]  = BC | BI(0, CR_EQ) | BO_COND_TRUE,
+    [TCG_COND_TSTNE]  = BC | BI(0, CR_EQ) | BO_COND_FALSE,
     [TCG_COND_LT]  = BC | BI(0, CR_LT) | BO_COND_TRUE,
     [TCG_COND_GE]  = BC | BI(0, CR_LT) | BO_COND_FALSE,
     [TCG_COND_LE]  = BC | BI(0, CR_GT) | BO_COND_FALSE,
@@ -683,9 +685,11 @@ static const uint32_t tcg_to_bc[] = {
 };
 
 /* The low bit here is set if the RA and RB fields must be inverted.  */
-static const uint32_t tcg_to_isel[] = {
+static const uint32_t tcg_to_isel[16] = {
     [TCG_COND_EQ]  = ISEL | BC_(0, CR_EQ),
     [TCG_COND_NE]  = ISEL | BC_(0, CR_EQ) | 1,
+    [TCG_COND_TSTEQ] = ISEL | BC_(0, CR_EQ),
+    [TCG_COND_TSTNE] = ISEL | BC_(0, CR_EQ) | 1,
     [TCG_COND_LT]  = ISEL | BC_(0, CR_LT),
     [TCG_COND_GE]  = ISEL | BC_(0, CR_LT) | 1,
     [TCG_COND_LE]  = ISEL | BC_(0, CR_GT) | 1,
@@ -1699,6 +1703,12 @@ static void tcg_out_cmp(TCGContext *s, int cond, TCGArg arg1, TCGArg arg2,
         imm = 0;
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_debug_assert(cr == 0);
+        tcg_out_and_rc(s, type, TCG_REG_R0, arg1, arg2, const_arg2, true);
+        return;
+
     case TCG_COND_LT:
     case TCG_COND_GE:
     case TCG_COND_LE:
@@ -1909,6 +1919,16 @@ static void tcg_out_setcond(TCGContext *s, TCGType type, TCGCond cond,
         tcg_out_setcond_ne0(s, type, arg0, arg1, neg);
         break;
 
+    case TCG_COND_TSTEQ:
+        tcg_out_and_rc(s, type, TCG_REG_R0, arg1, arg2, const_arg2, false);
+        tcg_out_setcond_eq0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
+    case TCG_COND_TSTNE:
+        tcg_out_and_rc(s, type, TCG_REG_R0, arg1, arg2, const_arg2, false);
+        tcg_out_setcond_ne0(s, type, arg0, TCG_REG_R0, neg);
+        break;
+
     case TCG_COND_LE:
     case TCG_COND_LEU:
         inv = true;
@@ -2081,6 +2101,13 @@ static void tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out32(s, op | BT(0, CR_EQ) | BA(6, CR_EQ) | BB(7, CR_EQ));
         break;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        tcg_out_and_rc(s, TCG_TYPE_I32, TCG_REG_R0, al, bl, blconst, false);
+        tcg_out_and_rc(s, TCG_TYPE_I32, TCG_REG_TMP1, ah, bh, bhconst, false);
+        tcg_out32(s, OR | SAB(TCG_REG_R0, TCG_REG_R0, TCG_REG_TMP1) | 1);
+        break;
+
     case TCG_COND_LT:
     case TCG_COND_LE:
     case TCG_COND_GT:
-- 
2.34.1


