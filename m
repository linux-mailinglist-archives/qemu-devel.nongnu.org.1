Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12837DEA19
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:35:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXg-0005cn-Fn; Wed, 01 Nov 2023 21:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXZ-0005Xe-P6
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001TS-8t
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6c32a20d5dbso152072b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888623; x=1699493423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=57r4dbvGmT9c7SflZoBSmAA2ZbZqs4+A6cLuNHSqKd0=;
 b=D97rk0yuZMAldmA/xQResC7VUNBu8oQQfLpqmD5s5e3gCLg3xVjCxg7Vnbm+GeZmm6
 zKYJMOUnGzBLRHRlFLRIu7O3BXDCdm6+1/nUZdaZO6XnkZyrBRQUOyj+ZvzvdtLueFmR
 nipcI4xaUqqZzbF6Nups1tehdWJ0eqHHfBz+nMlxK/TcU4xNEpaX5tHB3kuxPYMZQEAE
 bW6oUwekw8Yxu2ZBiKp3Q4Ivl9ILFzevZheV8BBB8RGvldazIxJHKLRlRfgPPNYFj9z9
 karLsABklCT2YiZHllCdBWaP3mzEqzeOjxgeOZ5Uoq+9Hq/jVcoSezpwfB/663dtbNcg
 HYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888623; x=1699493423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=57r4dbvGmT9c7SflZoBSmAA2ZbZqs4+A6cLuNHSqKd0=;
 b=oVrkV4jFVdHhtB3WlUtw9CP5kCcVetA74hRBKFFQBeaTlzvQe7Wz6BmeD9yMRKeP81
 9c9rwKstKHosTUXcChgSkY83hEnjMCoaweK6I4520hCeqQMeK5Jf9c1iqY8ybWdKqF4R
 jtwiaiybGfSwsm2CvLOSAPJUv1gpQj0fXI1f8FNIOwTq7nU79Xzm+ha3+FaIxg1wsTU6
 k6ue/q+uSE2x/pT/6PKIbYj5DGM/SGjiIlgzSl+p8Q9vZ8/493tvonohNlhPf1NBzXGm
 YMBx8wKBDiV61wHATV7lDJ4EC86X8N4C+MXjLm16Qr7Gu1Qzcmy1qp6WmmcggX0n1XOP
 L9wA==
X-Gm-Message-State: AOJu0YzFJqURkCR3TWcI9s8bx0LyW5/Kkcv0mrm9okJOJICxAdE3wNAp
 pAMpQqC8b7fmsID3NU8FIRqeDQLxYx0Xb/579IU=
X-Google-Smtp-Source: AGHT+IET/h2sKRMby4KbkeU1R7CbVYWlb8PQ00Jp/m06PVqokihPyGkgC6rbTgMMaFijzeu5QJr64A==
X-Received: by 2002:a05:6a00:807:b0:6be:2991:d878 with SMTP id
 m7-20020a056a00080700b006be2991d878mr17109310pfk.15.1698888623485; 
 Wed, 01 Nov 2023 18:30:23 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 07/88] tcg: Improve expansion of deposit of constant
Date: Wed,  1 Nov 2023 18:28:55 -0700
Message-Id: <20231102013016.369010-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The extract2 expansion is too difficult for the optimizer to
simplify.  If we have an immediate input, use and+or instead,
skipping the and if the field becomes all 1's.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 828eb9ee46..e305260099 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -608,6 +608,7 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
 {
     uint32_t mask;
     TCGv_i32 t1;
+    TCGTemp *ts;
 
     tcg_debug_assert(ofs < 32);
     tcg_debug_assert(len > 0);
@@ -623,6 +624,19 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
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
@@ -2229,6 +2243,7 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
 {
     uint64_t mask;
     TCGv_i64 t1;
+    TCGTemp *ts;
 
     tcg_debug_assert(ofs < 64);
     tcg_debug_assert(len > 0);
@@ -2244,6 +2259,19 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
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


