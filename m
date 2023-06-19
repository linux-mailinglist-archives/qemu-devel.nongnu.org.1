Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD71735986
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:30:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFsk-0000bP-In; Mon, 19 Jun 2023 10:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsf-0000YS-KG
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsd-0002Aa-Cr
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so8619475e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184958; x=1689776958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p5AHeXSNq8A09A3osIiOP7MyhShnndOyCGPqtuAITLU=;
 b=ZkeWNEPpCXLOmNzBtXBwP3Q4u14mRPGc6gRwLMi1GEYpfx49XarB2qh8NXa0lEi54J
 uIcoqSEdmbjHMTqh3DEcBCL2J/wMbjVTdsGLnVZEhkCjtsUS6lpy/VsBUDdXLn4Lslcw
 tY0sDEmlBxrs0NaTVvEdCMUvXFvcEB7/0Mpi1nMdVYvhcsP7uTvsWuh7/tcy5cygQVug
 5luA87Xy2eRmwl4zANbcrHKB3LEs+m8cpp+XoZa8zN2Dc6D+moOvsacozYIbGDCmEl9c
 scRU3kcJIGBEV2C8vRLIc9cC29h/SNajLV1vyiTp4UZM3bjdeEWhcStULRPyMZP7LA2L
 e9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184958; x=1689776958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p5AHeXSNq8A09A3osIiOP7MyhShnndOyCGPqtuAITLU=;
 b=PsuZ0BJXrLm90phzYwDkbqfAbQeYD3zgrZU/rovFKxqHGZYmCMiNhyt7anZ3VUpzSc
 +lX1UKBZZgHeE5kXTuFYHG/yVR0YD98+NtKFSb3MmJR87EcMUo/4SGnGH9E5K2PfW/+a
 aAP9tUH3AO/XZoGsKwN8Fe7ShrSnaUFkYfXjjY72fMvE2fB0quqUvHecsd+L5dXAImev
 +VGYw74GVnRjH/wIPab1JyVyCxzdm2MvQG8qqs5lGdAXWcFAsRBA6BH/eCnB0jdtCIcs
 thyyyvq0W9BwruZlecLGjC39VAJ5TgS5eEJtw+/qiyo7TotDnEwWbafeKFsWub5mEkz5
 4rzg==
X-Gm-Message-State: AC+VfDxywSAkFAiYTIuZqs/hndoyqjATtzg83AObPNE6mnf+H0CTfOaZ
 iUWzsaCr1ds+9GypCeu3Z8g98PpZLtZrmvRIQfs=
X-Google-Smtp-Source: ACHHUZ6K6pLKOOaaQWupSioekzbbnggtrgrln1xExPLhNTG05smQeqqhfZFBKHEsU8opfuQZ8DqPRA==
X-Received: by 2002:a7b:c391:0:b0:3f9:b3f5:b8f with SMTP id
 s17-20020a7bc391000000b003f9b3f50b8fmr900964wmj.34.1687184958061; 
 Mon, 19 Jun 2023 07:29:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] target/arm: Consistently use finalize_memop_asimd() for
 ASIMD loads/stores
Date: Mon, 19 Jun 2023 15:28:45 +0100
Message-Id: <20230619142914.963184-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

In the recent refactoring we missed a few places which should be
calling finalize_memop_asimd() for ASIMD loads and stores but
instead are just calling finalize_memop(); fix these.

For the disas_ldst_single_struct() and disas_ldst_multiple_struct()
cases, this is not a behaviour change because there the size
is never MO_128 and the two finalize functions do the same thing.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d271449431a..1108f8287b8 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -3309,6 +3309,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (size == 3 && opc == 2) {
             /* PRFM - prefetch */
@@ -3321,6 +3322,7 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
         is_store = (opc == 0);
         is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
+        memop = finalize_memop(s, size + is_signed * MO_SIGN);
     }
 
     if (rn == 31) {
@@ -3333,7 +3335,6 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
 
     tcg_gen_add_i64(dirty_addr, dirty_addr, tcg_rm);
 
-    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, true, memop);
 
     if (is_vector) {
@@ -3398,6 +3399,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
         if (!fp_access_check(s)) {
             return;
         }
+        memop = finalize_memop_asimd(s, size);
     } else {
         if (size == 3 && opc == 2) {
             /* PRFM - prefetch */
@@ -3410,6 +3412,7 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
         is_store = (opc == 0);
         is_signed = !is_store && extract32(opc, 1, 1);
         is_extended = (size < 3) && extract32(opc, 0, 1);
+        memop = finalize_memop(s, size + is_signed * MO_SIGN);
     }
 
     if (rn == 31) {
@@ -3419,7 +3422,6 @@ static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
     offset = imm12 << size;
     tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
 
-    memop = finalize_memop(s, size + is_signed * MO_SIGN);
     clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, memop);
 
     if (is_vector) {
@@ -3861,7 +3863,7 @@ static void disas_ldst_multiple_struct(DisasContext *s, uint32_t insn)
      * promote consecutive little-endian elements below.
      */
     clean_addr = gen_mte_checkN(s, tcg_rn, is_store, is_postidx || rn != 31,
-                                total, finalize_memop(s, size));
+                                total, finalize_memop_asimd(s, size));
 
     /*
      * Consecutive little-endian elements from a single register
@@ -4019,7 +4021,7 @@ static void disas_ldst_single_struct(DisasContext *s, uint32_t insn)
     total = selem << scale;
     tcg_rn = cpu_reg_sp(s, rn);
 
-    mop = finalize_memop(s, scale);
+    mop = finalize_memop_asimd(s, scale);
 
     clean_addr = gen_mte_checkN(s, tcg_rn, !is_load, is_postidx || rn != 31,
                                 total, mop);
-- 
2.34.1


