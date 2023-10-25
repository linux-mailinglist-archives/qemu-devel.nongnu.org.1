Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8AA7D62FD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIn-0000LD-3S; Wed, 25 Oct 2023 03:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIi-0000Ke-6B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:36 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIf-0004je-CN
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:35 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9bf22fe05so35212635ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218852; x=1698823652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BFVGCMOltQrt8RNTWYZyEMkY4e7wb1/f4QxWVOJact4=;
 b=tr+v0/IRtpvjGFAC3j5X1C/NV372+pMb3PSuUewyXV2MbZ9u9CIzfiWUOrptDDZbE7
 mbXP//NuClKKTvgYHnTA2XOAcl7HcHzN55k+GiA8T60zOBPWpJLPmXMp+RiHKeaSFlQF
 PMZek/buh+yfUh0N9DrcB8aoAADQa7bhORT9lkJgRam9q1Sn6EfphC8ZttUMFk+T6FR3
 9J31Mvs6+W/G/e64f4ru5uEzDYLCUhAXyk99oDcqTOsr0oLu8RE7I9Y7fS4JvF/yImkW
 pBnJzlsVd9InUr2hPDTPMzYRljHb/wL7sg1O63gSXccictIROdrGcwcri5dLgmzH7KbM
 szfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218852; x=1698823652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BFVGCMOltQrt8RNTWYZyEMkY4e7wb1/f4QxWVOJact4=;
 b=ZJIt6GgCFpwYFpSXJhIZgKeftKbQlriYFKUOJsk7HPFQjYqXmAYipgNJbpAcW5BrJs
 N3XSnvZDIEMgNLYgxwPcg9Uy32hxedHmfISbQLN+EYCdjbB2OpCLuCFgnQdHgPJETOxF
 ceReNb4Rjr2iMLJVcbisCJwkJa9o7J5gvpzLiTotALC/JVZO8C/FN3/qgE0rGvFNjo63
 GfEIHACBafRc6D1JTHEgUoz8GvuLE6mSRvYMD997gA4IlBJjIld415B3LEKk1vFg1Wy1
 F1KPxWZLb7EAHpLsKWq74X0Ii+bDQQ8M8x2ue479ZizaaVhEyXG2k8BYZ17yQ2j3O6CQ
 ehfA==
X-Gm-Message-State: AOJu0YxNmR45SsWb5XfHW1UhgUE5l8bAobApQd/Qvrfa3n+KBm/ph9lR
 325sXCRamCoJfgkS8V9EFdlqOrM+2146nL5a/Q0=
X-Google-Smtp-Source: AGHT+IGyY4sQilHC707aHyerNnB2DswDIHpjfqrb3lGUZM5OYGimWk2478C+0HPZcnqmzvfgqPr5Lg==
X-Received: by 2002:a17:903:284b:b0:1ca:82ef:4d7f with SMTP id
 kq11-20020a170903284b00b001ca82ef4d7fmr9213484plb.67.1698218851925; 
 Wed, 25 Oct 2023 00:27:31 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 24/29] tcg/ppc: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:27:02 -0700
Message-Id: <20231025072707.833943-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


