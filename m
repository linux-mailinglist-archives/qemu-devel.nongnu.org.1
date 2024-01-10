Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7C82A438
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLJ-0006YN-7U; Wed, 10 Jan 2024 17:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKZ-0005Qp-QI
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:53 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKT-00030o-F3
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:48 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5f0629e67f4so50746747b3.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926741; x=1705531541; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1dg8xzeToyJ1noTdWjMrmUW84nILSKxoDBHRkIKi/4=;
 b=y8W+KznkA0ezg3TXvvFhc4Dd561fTajwAC6NpYsxqV+5sjfZSFB6ls9Xbo0jElOBK/
 zH96kX6tatdM/H+oV2CWmEKC9sziXVJPHQ7WDB30BHMeEziw7AhPO8haVBv8ItPimvBL
 fKM1dl1oTCMAxkYB29tvT2oAAeQUnGfRoFXB8jQbGxY4jgjE0ukxgT9J8dbyCIL3ULvV
 VOZzgo4xE3BTebdSzJiBndBR71znxLhSswU2A6+Za4mypvf8G9Tq/bOks5Q5PfrxBNnQ
 2afB0Bqt2mDH8aCRotn806y6oIH00DALln25BDD3hnJo9hrcjuRyDdj3ziAmHInb58ra
 kv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926741; x=1705531541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1dg8xzeToyJ1noTdWjMrmUW84nILSKxoDBHRkIKi/4=;
 b=TVAoha9K7Ix3p3eVdqe4jxi5uIz2MrlL8Bd2ZqyCU5Ax8QkFRDIxQKX1P4GDsJX2qh
 R24/nWWk5szAXdjXZ7/0dOHbPg/coybwJFl7YrFPNHIsgnP2yjA6GWY9SRXkxHNAU8z8
 Axdxr/XwXUZn3+pulzjCxCHU3sdWatstALxQPSIDTwQPr0lsDNPqKl+9XeOHLXdtyXNW
 n8HbvM947BqG6A2ToVHmo9oHz0mgbcGp3Z1IuIGeKwSmzYPYCU7E4/8oPidgrJFwUtNQ
 E3K60FJijWyNr7hqYoZGIFrqIB91z3p0urm8kywCT92N3BdFyO9AjHSYV971ueo8DgpV
 3ZWA==
X-Gm-Message-State: AOJu0YzW5X3G3fKG12lx96sTJoZ71/id75xIm17u7xAIW+zzaZyv0VFu
 lgeiqm7P5aivAF/jz35A3dKxIS6VCH7zjZQA3SQzsHURz+7BK911
X-Google-Smtp-Source: AGHT+IFYTwBsEGrih3iTjWB3lV2/oHOrwf/C6MgB8qHVMNZBCZvMYNNNh9kHGaG8lAhGyBGgxxRabA==
X-Received: by 2002:a81:57c3:0:b0:5ee:a910:107 with SMTP id
 l186-20020a8157c3000000b005eea9100107mr364594ywb.21.1704926741409; 
 Wed, 10 Jan 2024 14:45:41 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 15/38] target/s390x: Improve general case of disas_jcc
Date: Thu, 11 Jan 2024 09:43:45 +1100
Message-Id: <20240110224408.10444-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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

Avoid code duplication by handling 7 of the 14 cases
by inverting the test for the other 7 cases.

Use TCG_COND_TSTNE for cc in {1,3}.
Use (cc - 1) <= 1 for cc in {1,2}.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 82 +++++++++++++-----------------------
 1 file changed, 30 insertions(+), 52 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ae4e7b27ec..168974f2e6 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -885,67 +885,45 @@ static void disas_jcc(DisasContext *s, DisasCompare *c, uint32_t mask)
     case CC_OP_STATIC:
         c->is_64 = false;
         c->u.s32.a = cc_op;
-        switch (mask) {
-        case 0x8 | 0x4 | 0x2: /* cc != 3 */
-            cond = TCG_COND_NE;
+
+        /* Fold half of the cases using bit 3 to invert. */
+        switch (mask & 8 ? mask ^ 0xf : mask) {
+        case 0x1: /* cc == 3 */
+            cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(3);
             break;
-        case 0x8 | 0x4 | 0x1: /* cc != 2 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x8 | 0x2 | 0x1: /* cc != 1 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x8 | 0x2: /* cc == 0 || cc == 2 => (cc & 1) == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
-        case 0x8 | 0x4: /* cc < 2 */
-            cond = TCG_COND_LTU;
-            c->u.s32.b = tcg_constant_i32(2);
-            break;
-        case 0x8: /* cc == 0 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
-        case 0x4 | 0x2 | 0x1: /* cc != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.b = tcg_constant_i32(0);
-            break;
-        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_andi_i32(c->u.s32.a, cc_op, 1);
-            break;
-        case 0x4: /* cc == 1 */
-            cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
-        case 0x2 | 0x1: /* cc > 1 */
-            cond = TCG_COND_GTU;
-            c->u.s32.b = tcg_constant_i32(1);
-            break;
         case 0x2: /* cc == 2 */
             cond = TCG_COND_EQ;
             c->u.s32.b = tcg_constant_i32(2);
             break;
-        case 0x1: /* cc == 3 */
+        case 0x4: /* cc == 1 */
             cond = TCG_COND_EQ;
-            c->u.s32.b = tcg_constant_i32(3);
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x2 | 0x1: /* cc == 2 || cc == 3 => cc > 1 */
+            cond = TCG_COND_GTU;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x4 | 0x1: /* cc == 1 || cc == 3 => (cc & 1) != 0 */
+            cond = TCG_COND_TSTNE;
+            c->u.s32.b = tcg_constant_i32(1);
+            break;
+        case 0x4 | 0x2: /* cc == 1 || cc == 2 => (cc - 1) <= 1 */
+            cond = TCG_COND_LEU;
+            c->u.s32.a = tcg_temp_new_i32();
+            c->u.s32.b = tcg_constant_i32(1);
+            tcg_gen_addi_i32(c->u.s32.a, cc_op, -1);
+            break;
+        case 0x4 | 0x2 | 0x1: /* cc != 0 */
+            cond = TCG_COND_NE;
+            c->u.s32.b = tcg_constant_i32(0);
             break;
         default:
-            /* CC is masked by something else: (8 >> cc) & mask.  */
-            cond = TCG_COND_NE;
-            c->u.s32.a = tcg_temp_new_i32();
-            c->u.s32.b = tcg_constant_i32(0);
-            tcg_gen_shr_i32(c->u.s32.a, tcg_constant_i32(8), cc_op);
-            tcg_gen_andi_i32(c->u.s32.a, c->u.s32.a, mask);
-            break;
+            /* case 0: never, handled above. */
+            g_assert_not_reached();
+        }
+        if (mask & 8) {
+            cond = tcg_invert_cond(cond);
         }
         break;
 
-- 
2.34.1


