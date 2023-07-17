Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA27756929
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLR6d-0005Ix-D6; Mon, 17 Jul 2023 12:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLR6Y-0005Ic-0j
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:29:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLR6W-0001Vy-6Q
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:29:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317009c0f9aso1385810f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689611382; x=1692203382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GOEC8iPAYYYAzaAMnSoH2HOqZ7oHubARoWtWdFLh2SI=;
 b=cAJ7QLgjztYG0l93UI1aFPYhhB+7B2z0Z8t5DVy823eAOdBJF0+FGfwq7sGusAekYI
 Dne3yB0UNvYa6sZdwFyotMeMKGyXyHfq+Fac8xUXfw48qKnNHQEO917SIWy6ul25QQdE
 b34K9JwEqoIqfo5kj5lS8KvychB2uyunBZO2uo9k73svorCQlUbR8MPoISQbHBH8egUi
 RADH43mKxj2ssY25roD7eogbUfeeSELsiJ2RWZo6X3JJcIG2TN7T6edWvj1GoELpoaQr
 2AF7RTSfBiM3jvApQtSZlFhJSVlAHVy83N1L48Wh0hsGUp0vlvsKiPzz64YfUo3mJpqL
 E/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689611382; x=1692203382;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOEC8iPAYYYAzaAMnSoH2HOqZ7oHubARoWtWdFLh2SI=;
 b=CIA5kKv/GoPzA/QjjeMfAs8/bmjLXaa5dLC4Ya+ufaaTvTqFTlZ+oJqrKkdkRd0xtx
 g0QkQDKOnn2a8SRjK5nxwvSZg3z+yjawlMg2XHaB1lgE0ZfgX28Erj7HoGF7vg3T9ONG
 sZwuywmBH0Zfw/XsWW/VPDIhkTzMyL9pRV4SD/Z24ZREFT5VO0okmXPTNNhW+mxtgSdd
 OGJ6X9l3W4prfzbTJ6rB/JKxyA0PAOAiMAB6GuJfKtefCuIMOEX8WPQa8Nkwr6hNz1GM
 dys4V6GGnKIdiLRG0P92NAafm458piRqpYBJaATYI14Av3Q1DvU9JzTNp8kWwWIPTTth
 Q6yQ==
X-Gm-Message-State: ABy/qLYLBjVqoelOgq1qC9KnHxv5RqyX7CByeBBuyY3e+NoYkrGV3o2U
 PcaHigithVlUas4tlqh3U1B4nz/Rq9sfNRza8Dw=
X-Google-Smtp-Source: APBJJlGbVJRFNEMa42uOOo5Kga3R7Ez684DINrq9gIKcUt/WCeBlepETnlX1hHG4KivDJS0qFFfTUg==
X-Received: by 2002:adf:df0c:0:b0:317:ec8:6e4 with SMTP id
 y12-20020adfdf0c000000b003170ec806e4mr287122wrl.43.1689611381993; 
 Mon, 17 Jul 2023 09:29:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q10-20020adfdfca000000b003144b95e1ecsm19596791wrn.93.2023.07.17.09.29.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 09:29:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH for-8.1] target/mips: Avoid shift by negative number in
 page_table_walk_refill()
Date: Mon, 17 Jul 2023 17:29:40 +0100
Message-Id: <20230717162940.814078-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Coverity points out that in page_table_walk_refill() we can shift by
a negative number, which is undefined behaviour (CID 1452918,
1452920, 1452922).  We already catch the negative directory_shift and
leaf_shift as being a "bail out early" case, but not until we've
already used them to calculated some offset values.

Move the calculation of the offset values to after we've done the
"return early if directory_shift or leaf_shift are -1" check.

Since walk_directory() re-calculates these shift values, add an
assert() to tell Coverity that the caller has already ensured they
won't be negative.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index e5e1e9dd3ff..c67c2b09026 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -643,6 +643,9 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
     uint64_t lsb = 0;
     uint64_t w = 0;
 
+    /* The caller should have checked this */
+    assert(directory_shift > 0 && leaf_shift > 0);
+
     if (get_physical_address(env, &paddr, &prot, *vaddr, MMU_DATA_LOAD,
                              cpu_mmu_index(env, false)) !=
                              TLBRET_MATCH) {
@@ -743,13 +746,8 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
             (ptew == 1) ? native_shift + 1 : native_shift;
 
     /* Offsets into tables */
-    int goffset = gindex << directory_shift;
-    int uoffset = uindex << directory_shift;
-    int moffset = mindex << directory_shift;
-    int ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
-    int ptoffset1 = ptoffset0 | (1 << (leaf_shift));
-
-    uint32_t leafentry_size = 1 << (leaf_shift + 3);
+    int goffset, uoffset, moffset, ptoffset0, ptoffset1;
+    uint32_t leafentry_size;
 
     /* Starting address - Page Table Base */
     uint64_t vaddr = env->CP0_PWBase;
@@ -775,6 +773,14 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
         return false;
     }
 
+    goffset = gindex << directory_shift;
+    uoffset = uindex << directory_shift;
+    moffset = mindex << directory_shift;
+    ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
+    ptoffset1 = ptoffset0 | (1 << (leaf_shift));
+
+    leafentry_size = 1 << (leaf_shift + 3);
+
     /* Global Directory */
     if (gdw > 0) {
         vaddr |= goffset;
-- 
2.34.1


