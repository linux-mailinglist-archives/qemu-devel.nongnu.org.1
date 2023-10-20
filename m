Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FEC7D173A
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:45:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLM-0007fT-5t; Fri, 20 Oct 2023 16:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLJ-0007ef-Jq
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLH-000884-QV
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:37 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b77ab73c6fso996491b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834614; x=1698439414; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J3OQEiXHHMGRWFPueeKCKBwMI85PiFBLtHqDQ0TceE8=;
 b=j/h+rT+K17RJJ0J0tLcUmY3pXxuv+YNNE3tT8J7p2pes6ltTCKR5gDq7lEjTZ71XEG
 1s3vr3w/KsPYPe71YwocADV0P1SmfqG2YebS+zoTg7I9mOxaFXP8PNmoY5Ul+mIhdb0T
 SaeiN/nz+Gseb8nk0/7qcKFixwX25zN0oPKbdnz90bRkvwkYkP+gmUhx4tmOcsXmqBxa
 ugQsxgtU1AUgvXGdFY5sSKMaog20eTGTP4AEm4vb82RbjVUiUecJ/ulBCC4qt8kfKhLF
 p5/AEOSXHL8efxodvy4qgnKSeeAVEk3zF6Gsm+YzlfSV4I+CG8Cg8P3KaNGtRXmu9n7J
 Sf+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834614; x=1698439414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J3OQEiXHHMGRWFPueeKCKBwMI85PiFBLtHqDQ0TceE8=;
 b=HdJLOqvwAzs/VDm0rLUfURDGXrIDRStHTA9pKoM7D/z/anGYiWZV7s3pUHCU8/O61p
 MvTEjeR93ptZ6FQhz8pYNA2zjo+0gNGOcQ2NzPWuBRuIgsrGG19Rlqbcko/5QbwSmQF0
 /o5Cx+wdG8fPta+6SXMx4DtmPCQIGroMXpjY4XIvS/Xa+o6a5g/sKEjObN0QHZCBODV1
 NiCYimPIznSt9mUEBaZzbUDl0JqGr0ZkEJYHL6S1sskkvCIdQKixwPbKQ2wBqX7TecAE
 MVDkzxtpUa+r43Xj8uh/n3pRuDgEd6+K5BVR5WXQu++Z7nkbr00xx8NKD3P7AFzFjABt
 sfTw==
X-Gm-Message-State: AOJu0YyxlpV+sjGLdu4KNW2q54to1Q2+U1S+SW8UXt8HtC5agbI4Jw+/
 RQKlZG7u8R38kaYG7GliYfUjuKsDFpjSJ0AhJMY=
X-Google-Smtp-Source: AGHT+IHY5gQsHQSYD+RUopRh4y+KWBG/a5CPdnmXVVnH12SqTy+Kn5dx0nWJfXBp7QIesIKrV8RMCQ==
X-Received: by 2002:a05:6a00:1c8c:b0:68f:cdb8:ae33 with SMTP id
 y12-20020a056a001c8c00b0068fcdb8ae33mr8909450pfw.10.1697834614185; 
 Fri, 20 Oct 2023 13:43:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 01/65] tcg: Improve expansion of deposit of constant
Date: Fri, 20 Oct 2023 13:42:27 -0700
Message-Id: <20231020204331.139847-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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


