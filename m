Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C812396E91F
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 07:20:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRMP-0000C8-GX; Fri, 06 Sep 2024 01:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMK-0008Cv-Bx; Fri, 06 Sep 2024 01:18:12 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRMI-00087y-J0; Fri, 06 Sep 2024 01:18:12 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 71E258C128;
 Fri,  6 Sep 2024 08:15:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 222E113336E;
 Fri,  6 Sep 2024 08:16:35 +0300 (MSK)
Received: (nullmailer pid 10445 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 20/40] hw/i386/amd_iommu: Don't leak memory in
 amdvi_update_iotlb()
Date: Fri,  6 Sep 2024 08:16:08 +0300
Message-Id: <20240906051633.10288-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

In amdvi_update_iotlb() we will only put a new entry in the hash
table if to_cache.perm is not IOMMU_NONE.  However we allocate the
memory for the new AMDVIIOTLBEntry and for the hash table key
regardless.  This means that in the IOMMU_NONE case we will leak the
memory we alloacted.

Move the allocations into the if() to the point where we know we're
going to add the item to the hash table.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2452
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240731170019.3590563-1-peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 9a45b0761628cc59267b3283a85d15294464ac31)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index a20f3e1d50..02597db1e1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -346,12 +346,12 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
                                uint64_t gpa, IOMMUTLBEntry to_cache,
                                uint16_t domid)
 {
-    AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-    uint64_t *key = g_new(uint64_t, 1);
-    uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
-
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
+        AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
+        uint64_t *key = g_new(uint64_t, 1);
+        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
 
-- 
2.39.2


