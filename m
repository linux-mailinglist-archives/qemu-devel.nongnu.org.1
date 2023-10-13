Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254207C80AA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpc-0007Ki-D2; Fri, 13 Oct 2023 04:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpR-0007H1-Gk
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:30 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpM-0000ja-Hz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:29 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so1780617f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186838; x=1697791638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKmBvQsHwbGxOhD+LokghU3rcucYQNrB15f3Fu9+nRE=;
 b=vl3KJyTdrYtnxgZc2lw/7ON6b10ROtSm09c1QRrVqFn3hb2oYDLOGasLutKDFyHae9
 L1oNiErAGzfVq3Tn17NVESJPRDLlcRuPtLRITy4iSXT8TFVZGhujYqrddAjuTBGl730k
 9mvWZhM9/gh9pTE2NJ6o0YMyQm0H8oZJv76C3/dyZjIu1Dqg4AsmaHWGBkvuvYU4A0ZX
 LfbBCjMyypmjVdwYQ603nE9GsimnosbH48FeFDKZyz9Tjt+Wq1siBX9MOW+c0ph6NXZ0
 X3Ib9cJyEakYATpsQlUfKqVQ/sMksTq4udqooEW4cHlsKqd6UOwsGoNzwlb0y322dqWa
 u6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186838; x=1697791638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKmBvQsHwbGxOhD+LokghU3rcucYQNrB15f3Fu9+nRE=;
 b=hYpwWGn0maSWzhpz4cQQFsGHm1JevUO1XLKbylfFuqucLDaxnQDiQa6mt71hxCxPvB
 RiomWSfj+ButdsDQcZsHY6fQ9JE864UOys0dalY4kFJjoA4Hjb7t0ArDMP9JbSFGsoyp
 nZHf7Cx8vVLG0dq5Zkxihw4AwFrgfGdrtKfVYDFjTruvDCVJAxvNHmscNOP3RzecQmsz
 NoYP168wbBgk0Z8zkcJafExl2R/pwFlE8FbCuFIGeq5nvahowY4N2UehsEJWURohXzS8
 gYwx1bpdDXdDHq8UwG+lhGszU/AfjRBeb8zRDHotUglIr6CTukiQ/VU6AbiJn46FIF6T
 A0Bg==
X-Gm-Message-State: AOJu0Yy5Wyn2KqeMNyJ40qg9QSX/KL3c894E4bd1VWYBTWCgexAdVMS9
 5XigBNRPh7rdq6CHORVjWza16Ks8Wz9OhVcHxcM=
X-Google-Smtp-Source: AGHT+IFlwNJB5XGrNtW+UJouo5LlJyS+6AVdbnkI39LQ0f6iDgibKJmf95jWBPzsUBLSJaUgHCCFMg==
X-Received: by 2002:adf:f403:0:b0:321:5b64:f744 with SMTP id
 g3-20020adff403000000b003215b64f744mr21953943wro.20.1697186838287; 
 Fri, 13 Oct 2023 01:47:18 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:17 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v3 03/78] fpu/softfloat: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:31 +0300
Message-Id: <f329886becdeaa9a0b7cc2d19a02b3973266151b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 fpu/softfloat-parts.c.inc | 8 ++++----
 fpu/softfloat.c           | 7 ++++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
index a44649f4f4..df64cc7a29 100644
--- a/fpu/softfloat-parts.c.inc
+++ b/fpu/softfloat-parts.c.inc
@@ -181,7 +181,7 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
         break;
     case float_round_to_odd:
         overflow_norm = true;
-        /* fall through */
+        fallthrough;
     case float_round_to_odd_inf:
         if (N > 64 && frac_lsb == 0) {
             inc = p->frac_hi & 1 ? 0 : round_mask;
@@ -1068,7 +1068,7 @@ static int64_t partsN(float_to_sint)(FloatPartsN *p, FloatRoundMode rmode,
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = max;
@@ -1135,7 +1135,7 @@ static uint64_t partsN(float_to_uint)(FloatPartsN *p, FloatRoundMode rmode,
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = max;
@@ -1198,7 +1198,7 @@ static int64_t partsN(float_to_sint_modulo)(FloatPartsN *p,
     switch (p->cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = 0;
diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 027a8e576d..e16e1896ee 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1835,6 +1835,7 @@ static floatx80 floatx80_round_pack_canonical(FloatParts128 *p,
             break;
         }
         /* rounded to inf -- fall through to set frac correctly */
+        fallthrough;
 
     case float_class_inf:
         /* x86 and m68k differ in the setting of the integer bit. */
@@ -2670,7 +2671,7 @@ static void parts_float_to_ahp(FloatParts64 *a, float_status *s)
     switch (a->cls) {
     case float_class_snan:
         float_raise(float_flag_invalid_snan, s);
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         /*
          * There is no NaN in the destination format.  Raise Invalid
@@ -3199,7 +3200,7 @@ static Int128 float128_to_int128_scalbn(float128 a, FloatRoundMode rmode,
     switch (p.cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = UINT128_MAX;
@@ -3626,7 +3627,7 @@ static Int128 float128_to_uint128_scalbn(float128 a, FloatRoundMode rmode,
     switch (p.cls) {
     case float_class_snan:
         flags |= float_flag_invalid_snan;
-        /* fall through */
+        fallthrough;
     case float_class_qnan:
         flags |= float_flag_invalid;
         r = UINT128_MAX;
-- 
2.39.2


