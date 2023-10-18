Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 684D87CE94D
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 22:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDQl-0000UY-Kk; Wed, 18 Oct 2023 16:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtDQi-0000Tq-U0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:46:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtDQg-0002Wj-RE
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:46:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6b44befac59so85047b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 13:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697661969; x=1698266769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=J3OQEiXHHMGRWFPueeKCKBwMI85PiFBLtHqDQ0TceE8=;
 b=Uu7eLMxJDU35zxqCj6Tyq2QdxeKnWG+MTOU+6Ghf8hJHyvFBi+T5u7fqrDu12gKzGw
 JPo/JadioTtPZjo+KlA0weziGtkkkaRfm+ZAIXWM/sG1DU9Q5MphSPK8OdFB35WrG7Sb
 LKJhYNhJe0cWLolbIlQQVW/snLTwPTgVm8RMTydRs0k5JvmhOIFpDwChhMNRMRsi9ulM
 CZxCAmtilJFrEeRLOMYFcYwdy6/j4zcuKrOoe7sQO9UrnFVt26Uc8LHsqmHgNnB+5Va1
 fM/taSOuI6CWqdErtWjSU0SJIyiuhtPHQHgzsV+qyEKPraoPuDw1C6oP+pKa/LTdCEEs
 DQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697661969; x=1698266769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3OQEiXHHMGRWFPueeKCKBwMI85PiFBLtHqDQ0TceE8=;
 b=PrVdrTh6zCkUpB7ZBaTcv2iMCMEBDFCTFzwN72UH5n55a4VnaS0hGho76N0OpldOFM
 vkEAiSXBnLkKEu8k3SIg2MwD9YQsfvInvyFq+fzKeWCI+49JfNfyn5f/pEU59Ynu6/fA
 YMkIwkSsFYRGx8O1x+V4v4Pb3Jna4K7xPOeJwi5xxV0dOb7iIZuMYKaMnS46+6WMtbNU
 EpYwzFXPGx6TexDAZSVnH0IShXPrsSs9ey3FnvOBeViicDh8z27/HOIR7cinUTLFrk+5
 8ZkevwcLNuc7rpjIeg6TJIY5isr6TpEWAMdX/iGHYkIA3EWGja9zEpNyLNa5+djBUzBn
 sHPA==
X-Gm-Message-State: AOJu0YwmkvzbfXmDMNgKP3CSIf+F+H3HBVZkLGF30cMX57kbZwdeu2In
 BrvTQgO7co5FTAryo48LGiKA3c2TAUld2mX0UOQ=
X-Google-Smtp-Source: AGHT+IEj+5RUN3sn2fbTUzKxhNg2XoCiNFcLMYsuOQlUbngno6B5xRzBJmDzhXjqfNN8Ftw4HxAdHQ==
X-Received: by 2002:a05:6a20:8e0a:b0:14e:2208:d62f with SMTP id
 y10-20020a056a208e0a00b0014e2208d62fmr575107pzj.22.1697661969038; 
 Wed, 18 Oct 2023 13:46:09 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k125-20020a632483000000b005742092c211sm2103096pgk.64.2023.10.18.13.46.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 13:46:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tcg: Improve expansion of deposit of constant
Date: Wed, 18 Oct 2023 13:46:05 -0700
Message-Id: <20231018204606.1545518-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018204606.1545518-1-richard.henderson@linaro.org>
References: <20231018204606.1545518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

The extract2 expansion is too difficult for the optimizer to
simplify.  If we have an immediate input, use and+or instead,
skipping the and if the field becomes all 1's.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 393dbcd01c..2ef4b866e2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -602,6 +602,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 {
     uint32_t mask;
     TCGv_i32 t1;
+    TCGTemp *ts;
 
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
@@ -617,6 +618,19 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         return;
     }
 
+    /* Deposit of a constant into a value. */
+    ts = tcgv_i32_temp(arg2);
+    if (ts->kind == TEMP_CONST) {
+        uint32_t mask0 = deposit32(-1, ofs, len, 0);
+        uint32_t maski = deposit32(0, ofs, len, ts->val);
+
+        if (mask0 != ~maski) {
+            tcg_gen_andi_i32(ret, arg1, mask0);
+        }
+        tcg_gen_ori_i32(ret, ret, maski);
+        return;
+    }
+
     t1 = tcg_temp_ebb_new_i32();
 
     if (TCG_TARGET_HAS_extract2_i32) {
@@ -2217,6 +2231,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 {
     uint64_t mask;
     TCGv_i64 t1;
+    TCGTemp *ts;
 
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
@@ -2232,6 +2247,19 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         return;
     }
 
+    /* Deposit of a constant into a value. */
+    ts = tcgv_i64_temp(arg2);
+    if (ts->kind == TEMP_CONST) {
+        uint64_t mask0 = deposit64(-1, ofs, len, 0);
+        uint64_t maski = deposit64(0, ofs, len, ts->val);
+
+        if (mask0 != ~maski) {
+            tcg_gen_andi_i64(ret, arg1, mask0);
+        }
+        tcg_gen_ori_i64(ret, ret, maski);
+        return;
+    }
+
     if (TCG_TARGET_REG_BITS == 32) {
         if (ofs >= 32) {
             tcg_gen_deposit_i32(TCGV_HIGH(ret), TCGV_HIGH(arg1),
-- 
2.34.1


