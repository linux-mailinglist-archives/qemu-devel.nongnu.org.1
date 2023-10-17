Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 947357CC4CC
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:33:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjg6-0005na-T4; Tue, 17 Oct 2023 09:00:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjg0-0005jh-Qp
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:00 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjfx-0003Vq-9j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 08:59:59 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 1132C61A1F;
 Tue, 17 Oct 2023 15:59:54 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gxjRqEIOdGk0-z3xGYPQ2; Tue, 17 Oct 2023 15:59:53 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697547593;
 bh=9uz6mP2DMKRc9fDqr1zPTN4sSUu+LsDqxNyJSCGgRX4=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=v5q2eXjodosGUIXVZLSRDqleCl1V8ns+zWdcX10fUP1DkyCMgQiZdS5D5sD45GE0+
 nPH0NPmH51yoD21QN6Piu2UDofWyiIW/b5IOxRqApW8UKFr86R4quyf2TvIx8fsAfd
 Y1cw1oOmkFiurb3pkXs2PfIXJ3nFf/2AvM0WT5X0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 1/6] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd(): assert
 no overflow
Date: Tue, 17 Oct 2023 15:59:36 +0300
Message-Id: <20231017125941.810461-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017125941.810461-1-vsementsov@yandex-team.ru>
References: <20231017125941.810461-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
---
 hw/i386/intel_iommu.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 2c832ab68b..5e435d9f2d 100644
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


