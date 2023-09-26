Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DCB7AF4E2
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETa-0000Y6-Ri; Tue, 26 Sep 2023 16:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETX-0000Wx-MZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:07 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETS-0002gw-FL
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:07 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id D06A660B81;
 Tue, 26 Sep 2023 23:15:55 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-5hDZfIZL; Tue, 26 Sep 2023 23:15:55 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759355;
 bh=jAvh0KaFeV113hpG3Sjju5klfyFefoMWGI2I5yIG3zw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=g8iwTxPXVsH+ai1czxf9XXDj3gEIKGHKy+as3DnaI+14TWFvh5XYwQwTjOfBVLJ3x
 DxJJGK7z76tqu0LRnIJ5ltAltPSfjKC/LPFbjT8paPuQBwULvMf//S71iB3MBsEGtl
 u0tsYvaPwGNByi82wHIj6cIeeNqhId/CxWBzU2/s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v2 1/8] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert
 no overflow
Date: Tue, 26 Sep 2023 23:15:25 +0300
Message-Id: <20230926201532.221152-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

We support only 3- and 4-level page-tables, which is firstly checked in
vtd_decide_config(), then setup in vtd_init(). Than level fields are
checked by vtd_is_level_supported().

So here we can't have level out from 1..4 inclusive range. Let's assert
it. That also explains Coverity that we are not going to overflow the
array.

CID: 1487158, 1487186
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/i386/intel_iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index c0ce896668..3b68183b78 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -1027,18 +1027,35 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
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


