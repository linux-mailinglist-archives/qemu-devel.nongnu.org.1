Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B66C0797638
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 18:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeHU2-0000sR-IT; Thu, 07 Sep 2023 12:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHU0-0000qD-0Z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:52 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeHTv-000206-4p
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 12:03:51 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so12941935e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694102625; x=1694707425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wXwOIXEXDGtPrl1zrOtaqtfc6E7wogzH7eCLgLNl9rE=;
 b=lJhfifKHKkK91MuIX7VUcp81QlXT9qslc0iP06dyJhojoaIRltrrykU7g4tZvwaQ6r
 V4B3iH5Iu6CxNZDXzpKVtUaGvDMtzvCxoDakUspn2QJGfRPQD+4IVZeQZLpBH9KyPt4p
 WW6VH3KHveSqQTwvO0kpSQ1cykIwwW6MqYlxndyXuiHU/yjh4yM6K+gPgE1fHnCdLts5
 3eAUz/fHs3jnOm/kLzb483Zu0rRebaN2Z/0EAoU5Ab0B8jqI48rTmb0WeAW0LvV1cQyZ
 AF+fE0d8gu3Ev9PCUMpkT3vb8U8fmrqlawQg8yuousHMzhLp9GRgvnG0G7sQ7l/OzJfk
 MVtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102625; x=1694707425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wXwOIXEXDGtPrl1zrOtaqtfc6E7wogzH7eCLgLNl9rE=;
 b=hBWQV6NwnFFDhr6N8R/DXKkvegd4MT9Fp2aucD6TlOHtW9jClun0MGzJpWdUtLRJB+
 cshszU36I9n8+5qr3iX64FpScXTHkZZbBqlMLotgb/8w1Fb72jP5PTgb9in4/bTFZgdF
 2hF/PagUEcyLxtufEhmj5IdgJAnG4Eb3yJJjL02Nl8AssSMbnK70iFvGrMkh+EwLgkUw
 iYlkkg52qssgp7xhAcbSmH3XatLTW+hQo50pEDXhoQUIAjWvXUK7Ufn6s9didVkANJne
 OtkOAhsd1O1v594qkF/YN9ZsSsrc42O4+G1E0nj9XeysiIPvyA1i5FShlH8w3CZnBQWB
 eASg==
X-Gm-Message-State: AOJu0Yxj0MsxT7Njp/bIHhJn2AruUiJQgbSa889SG7XRoNL3O00XbaWi
 mRbg4gANE4rg/QWG3YQQ1hwUew==
X-Google-Smtp-Source: AGHT+IGChUhK1b5mZllGS5wMN8cZNW3FNYVJPgoTPN37bKDq3DA2+X2IL5pSTeYoJVKuU5saV2BeBA==
X-Received: by 2002:a5d:58da:0:b0:31d:8fed:c527 with SMTP id
 o26-20020a5d58da000000b0031d8fedc527mr4552554wrf.42.1694102625673; 
 Thu, 07 Sep 2023 09:03:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa401000000b0031980294e9fsm20256241wra.116.2023.09.07.09.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 09:03:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 05/14] target/arm: Pass unpriv bool to get_a64_user_mem_index()
Date: Thu,  7 Sep 2023 17:03:31 +0100
Message-Id: <20230907160340.260094-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230907160340.260094-1-peter.maydell@linaro.org>
References: <20230907160340.260094-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In every place that we call the get_a64_user_mem_index() function
we do it like this:
 memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
Refactor so the caller passes in the bool that says whether they
want the 'unpriv' or 'normal' mem_index rather than having to
do the ?: themselves.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm about to add another use of this function which would
otherwise also end up doing this same ?: expression...
---
 target/arm/tcg/translate-a64.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 0b77c92437f..ea1954d4a2a 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -105,9 +105,17 @@ void a64_translate_init(void)
 }
 
 /*
- * Return the core mmu_idx to use for A64 "unprivileged load/store" insns
+ * Return the core mmu_idx to use for A64 load/store insns which
+ * have a "unprivileged load/store" variant. Those insns access
+ * EL0 if executed from an EL which has control over EL0 (usually
+ * EL1) but behave like normal loads and stores if executed from
+ * elsewhere (eg EL3).
+ *
+ * @unpriv : true for the unprivileged encoding; false for the
+ *           normal encoding (in which case we will return the same
+ *           thing as get_mem_index().
  */
-static int get_a64_user_mem_index(DisasContext *s)
+static int get_a64_user_mem_index(DisasContext *s, bool unpriv)
 {
     /*
      * If AccType_UNPRIV is not used, the insn uses AccType_NORMAL,
@@ -115,7 +123,7 @@ static int get_a64_user_mem_index(DisasContext *s)
      */
     ARMMMUIdx useridx = s->mmu_idx;
 
-    if (s->unpriv) {
+    if (unpriv && s->unpriv) {
         /*
          * We have pre-computed the condition for AccType_UNPRIV.
          * Therefore we should never get here with a mmu_idx for
@@ -3078,7 +3086,7 @@ static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
     if (!a->p) {
         tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
-    memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    memidx = get_a64_user_mem_index(s, a->unpriv);
     *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
                                         a->w || a->rn != 31,
                                         mop, a->unpriv, memidx);
@@ -3099,7 +3107,7 @@ static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    int memidx = get_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
@@ -3117,7 +3125,7 @@ static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    int memidx = get_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
-- 
2.34.1


