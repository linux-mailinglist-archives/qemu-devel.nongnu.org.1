Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 895D578B888
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 21:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qai5b-0006O8-Bx; Mon, 28 Aug 2023 15:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qai5a-0006Nu-1z
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:39:54 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qai5X-0001n6-Tt
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 15:39:53 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so21446705ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693251590; x=1693856390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=E7msnRk4yfcEdp2xPJQnHXl6mU2W+3e48Aa/Ps4Tp/0=;
 b=TNeSewSiu1w62WeGFb1p9CHvAgBLJc16+o6QISMH0imal1SfTvPHvaPFonIplg5NE0
 vzksmFkzUrO13LbbHb67UYt2kVVFG6BBygjNXiCqt4juggzNAfI9JNmqbiKoQe2l3RN2
 7my4iqdvVRTkmZ0d8hw/+zoCurEaQrlsq4RwSDlxCSU38N6JLzwWX2XlbZfUA9NYGehB
 iE4OkE/52zZTGxBt8wMGWVR/gorYLfwvcafoK3ezRSOuXZOvwFlZLQ1XcY0jtTZ38z3D
 KRzzvSUrYyHhhvoNRB9BqYOtbRMcjWxLsJuDjdK9a/OT9yKwoRwvsTFuKsH4b8WJVWY0
 XsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693251590; x=1693856390;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E7msnRk4yfcEdp2xPJQnHXl6mU2W+3e48Aa/Ps4Tp/0=;
 b=XhottomZEiFheqJLufnLxeDZlha9NfWpJwy+rzVytH/LzsZyg2CF1uKiJ6uPkCQu1m
 rpocOBW2Wo2LLx+Q1bNlgf3j3kBWFpat/z6ehBf9kKDoEk6S0OqySxFKOYlMbUfml89k
 7RZl4Btl5+7yo6IlUA8VNm42jbj4nR9mcq2hn/4kE8uBVfb6jQCSL359hEQGFRR+WnuU
 2wtsoCduJqxN63BQzSnA797PY4PdWwihqFt5wOCwboUf7/xI5bzWYuNFH4o79LZP9fFz
 /G7G4YluuY/N0YIsaE0IvCwL53puLAcdbxYu5wZNKsqKhrv71BCfA421T+mo9RbCnCeR
 xpWw==
X-Gm-Message-State: AOJu0YwdBK8s47Qhg55oD09jFbCRfvdNQuPk/87Hkoo8aXyIMMbsGHHN
 4+Le0xJA1es9kUJegCs7e4PpkZJWm42K2/xOCvw=
X-Google-Smtp-Source: AGHT+IHK71I1wjzj34XICWRBGMOpW1ZtGAXLYN7adUN+KpWJWynsHaHf17gEJ0ga4s2Mn1+ux85iGQ==
X-Received: by 2002:a17:902:c70a:b0:1b8:a569:f980 with SMTP id
 p10-20020a170902c70a00b001b8a569f980mr19398787plp.65.1693251590630; 
 Mon, 28 Aug 2023 12:39:50 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 a18-20020a170902b59200b001b89045ff03sm7707313pls.233.2023.08.28.12.39.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 12:39:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tcg: Remove vecop_list check from tcg_gen_not_vec
Date: Mon, 28 Aug 2023 12:39:49 -0700
Message-Id: <20230828193949.576198-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

The not pattern is always available via generic expansion.
See debug block in tcg_can_emit_vecop_list.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ad8ee08a7e..094298bb27 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -391,12 +391,11 @@ static bool do_op2(unsigned vece, TCGv_vec r, TCGv_vec a, TCGOpcode opc)
 
 void tcg_gen_not_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
 {
-    const TCGOpcode *hold_list = tcg_swap_vecop_list(NULL);
-
-    if (!TCG_TARGET_HAS_not_vec || !do_op2(vece, r, a, INDEX_op_not_vec)) {
+    if (TCG_TARGET_HAS_not_vec) {
+        vec_gen_op2(INDEX_op_not_vec, 0, r, a);
+    } else {
         tcg_gen_xor_vec(0, r, a, tcg_constant_vec_matching(r, 0, -1));
     }
-    tcg_swap_vecop_list(hold_list);
 }
 
 void tcg_gen_neg_vec(unsigned vece, TCGv_vec r, TCGv_vec a)
-- 
2.34.1


