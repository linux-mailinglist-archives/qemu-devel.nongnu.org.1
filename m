Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BB7A9866
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 19:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjNcW-00026c-VA; Thu, 21 Sep 2023 13:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcO-00022K-Kv
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjNcH-0007fo-Ln
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 13:37:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-404314388ceso13929315e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 10:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695317848; x=1695922648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a5oDc+Yq+g+grY1ZGCS7U6eCrdf7ur5IfU4giqXKmlM=;
 b=Yj7B0IBqU/fuDMrrItQnpSdDgfbjDAI9x0CH7wG0OF7/PdF5K2mmwcTFWnXj+7tJro
 +psMwSUsOqK4utOExVAmzpdxMGH0FqOG7Xv3+UpC+JaZwastTmP+o8gxFa83e7u2YW8D
 Dh4KOAI+ckP5DCU0RebXSutTQLax3IrHskhNvh+A5kTHPL3+vQSJXgv+bhMZ/P3fh/s4
 VVm9pXmtR/Cg24piSwW2bT3uhJJPtUNHsiXkzT8qA69HqXJsYDQfmzhADU4bruT3xtwl
 JtyOkD9mK8h0hkCGmkEVzF+F8EWCzj598f0HT+FzMIS/pvPz50P23jv2VTZeZzCwGROM
 3gsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695317848; x=1695922648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a5oDc+Yq+g+grY1ZGCS7U6eCrdf7ur5IfU4giqXKmlM=;
 b=G7fPpny1ss3LRs/JHKAHYENajRLFeE9TfKSBNhxMe55bQEUgdJTFX6Z38/rT72tjTU
 s/8rXV5BJKOi7iSPJpwO1kjgXx5m9FSdLKRqqsWWhFd5C/Hq+U0wafOQYpz6mCVtIvfa
 BVjzDkIDHMU/PtWVRRsrSV5ZgLhIjot07Del4AlUnqOkWSCGvXyhTVim9xBJKV3pOCcQ
 6P4hkZWLpb+SUELF5rg1v5bDgcu8T/7/gEy18WABkvdEGcpjUz8kH7ErviLX1HS4bZrj
 lhCLpg4g6LRd1ydO2zAdwqtmVX5poo+OgQ+A0nzco+/nRNdRGj9qUCyE0MiuT5uPaKAh
 zdyQ==
X-Gm-Message-State: AOJu0Yw1COrr7spnCAzeLuG1Me5653OcpPD3u7dlzg3Sv14ynw4Zz8up
 +g1DSIYf44TS9TWnfmtTLgv3OcWoBbeQ9Orchho=
X-Google-Smtp-Source: AGHT+IEAvb4qQt8t4vYEl/kUpjbakwZp/JdIpYdmk3Ey4fti+HY9IW6QDBDs8X/ESHGbFjgyYi5ptg==
X-Received: by 2002:a05:600c:21c2:b0:405:1ba9:e862 with SMTP id
 x2-20020a05600c21c200b004051ba9e862mr5734560wmj.10.1695317848178; 
 Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020a7bce0e000000b003feff926fc5sm2464122wmc.17.2023.09.21.10.37.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Sep 2023 10:37:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/30] target/arm: Pass unpriv bool to get_a64_user_mem_index()
Date: Thu, 21 Sep 2023 18:37:03 +0100
Message-Id: <20230921173720.3250581-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921173720.3250581-1-peter.maydell@linaro.org>
References: <20230921173720.3250581-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
Message-id: 20230912140434.1333369-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1dd86edae13..24afd929144 100644
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
@@ -3088,7 +3096,7 @@ static void op_addr_ldst_imm_pre(DisasContext *s, arg_ldst_imm *a,
     if (!a->p) {
         tcg_gen_addi_i64(*dirty_addr, *dirty_addr, offset);
     }
-    memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    memidx = get_a64_user_mem_index(s, a->unpriv);
     *clean_addr = gen_mte_check1_mmuidx(s, *dirty_addr, is_store,
                                         a->w || a->rn != 31,
                                         mop, a->unpriv, memidx);
@@ -3109,7 +3117,7 @@ static bool trans_STR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    int memidx = get_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, true, mop);
@@ -3127,7 +3135,7 @@ static bool trans_LDR_i(DisasContext *s, arg_ldst_imm *a)
 {
     bool iss_sf, iss_valid = !a->w;
     TCGv_i64 clean_addr, dirty_addr, tcg_rt;
-    int memidx = a->unpriv ? get_a64_user_mem_index(s) : get_mem_index(s);
+    int memidx = get_a64_user_mem_index(s, a->unpriv);
     MemOp mop = finalize_memop(s, a->sz + a->sign * MO_SIGN);
 
     op_addr_ldst_imm_pre(s, a, &clean_addr, &dirty_addr, a->imm, false, mop);
-- 
2.34.1


