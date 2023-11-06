Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A07107E28C7
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:34:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01b9-0008UE-JC; Mon, 06 Nov 2023 10:33:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01au-000807-M8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:54 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0004Nn-OO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:51 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507c5249d55so5992964e87.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284762; x=1699889562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvzbelZcKlKoxbHp/373o+tGsWe8jUUsQB+BUCk9XSw=;
 b=FffpuVr2kVtl/yX1iieLVzyuRUXb+kxiYiLhsvPb6quY+rlzDgax/lpbTDrD0Y/xPX
 bO87D/cCtgcTsnAtSHN5PTCM7XJwU6o2Xs0B5lHlV7hgTYPmVndKLzfrwohCAbyS1zuO
 Soh8KTJKFLxGG512webQkdR5dxyzopkNnkkX+YxbDRNJ6o3qENeRDsuV/mhJROI4KN6W
 +cOf1BzucbF5ysnjx1tI8eq/LrlfoPo84x3R9y+ckHajXnc4Hde8pi8KD3mkm7QOscg4
 DOU8SfTSeuMr3dZU7WdDlNN4allkTsWt9oIQRfKQHq48JY9RuR8x4vHCUId0OvB3C2SC
 lJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284762; x=1699889562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DvzbelZcKlKoxbHp/373o+tGsWe8jUUsQB+BUCk9XSw=;
 b=hzegtbwIE0hwSL0eL6GD2cqRm3hC/CHShJi45i/zqgMu/Z92PzGKOYTHdAu/tN2h9I
 NgkQ7D8nAneVe615m2eeTspTftavDzAnCGkQ6ndY6rcJ69/KXkZzePLl/mwXcAiPsT1X
 SuPLi+ILQh4/FnojiqEY4mBBSVuZ9u6WLv0g4HoJx93m6WhVTeJ24pD5jLkbvUJBwIzA
 htPVC7ZjloH0jpngqfWb997ZiXvBUd1dGPYBYU0kdAbzlyNRAXyDhwUFdu9PNTJQxg4f
 PYhLIE7faiXQAhJT8TDTlafkjGl75zGks+cc6jWOtfE+aVEh8XB8AmgR5wQFyPReo9oX
 BIiA==
X-Gm-Message-State: AOJu0Yy3i11v2TBpldKeHfAsTM7HDNVYEupcu2LYmjfPv61DoCgkVlQY
 7ap67436aG6lo+Ln+9yTtWgKLQ4MQaKVhUamIQY=
X-Google-Smtp-Source: AGHT+IG4PNMo01esEfeYwAFbwwfemEa9GI3ef/dC51HQ94sSLlskuttQHXKgqIocTuDue8SPC3n6bQ==
X-Received: by 2002:ac2:53a5:0:b0:507:96cd:928d with SMTP id
 j5-20020ac253a5000000b0050796cd928dmr20223200lfh.47.1699284761750; 
 Mon, 06 Nov 2023 07:32:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/12] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert no
 overflow
Date: Mon,  6 Nov 2023 15:32:31 +0000
Message-Id: <20231106153238.1426649-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

We support only 3- and 4-level page-tables, which is firstly checked in
vtd_decide_config(), then setup in vtd_init(). Than level fields are
checked by vtd_is_level_supported().

So here we can't have level out from 1..4 inclusive range. Let's assert
it. That also explains Coverity that we are not going to overflow the
array.

CID: 1487158, 1487186
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-2-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i386/intel_iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 1c6c18622fd..1a44ef696c3 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1045,18 +1045,35 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
  * Rsvd field masks for spte:
  *     vtd_spte_rsvd 4k pages
  *     vtd_spte_rsvd_large large pages
+ *
+ * We support only 3-level and 4-level page tables (see vtd_init() which
+ * sets only VTD_CAP_SAGAW_39bit and maybe VTD_CAP_SAGAW_48bit bits in s->cap).
  */
-static uint64_t vtd_spte_rsvd[5];
-static uint64_t vtd_spte_rsvd_large[5];
+#define VTD_SPTE_RSVD_LEN 5
+static uint64_t vtd_spte_rsvd[VTD_SPTE_RSVD_LEN];
+static uint64_t vtd_spte_rsvd_large[VTD_SPTE_RSVD_LEN];
 
 static bool vtd_slpte_nonzero_rsvd(uint64_t slpte, uint32_t level)
 {
-    uint64_t rsvd_mask = vtd_spte_rsvd[level];
+    uint64_t rsvd_mask;
+
+    /*
+     * We should have caught a guest-mis-programmed level earlier,
+     * via vtd_is_level_supported.
+     */
+    assert(level < VTD_SPTE_RSVD_LEN);
+    /*
+     * Zero level doesn't exist. The smallest level is VTD_SL_PT_LEVEL=1 and
+     * checked by vtd_is_last_slpte().
+     */
+    assert(level);
 
     if ((level == VTD_SL_PD_LEVEL || level == VTD_SL_PDP_LEVEL) &&
         (slpte & VTD_SL_PT_PAGE_SIZE_MASK)) {
         /* large page */
         rsvd_mask = vtd_spte_rsvd_large[level];
+    } else {
+        rsvd_mask = vtd_spte_rsvd[level];
     }
 
     return slpte & rsvd_mask;
-- 
2.34.1


