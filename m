Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B127D6650
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZtG-0005b5-VA; Wed, 25 Oct 2023 05:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRu-0004ac-Ps
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:58 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRs-0001CN-UW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:58 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 39P5FKiB024567
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:15:20 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39P5F8Tg024492;
 Wed, 25 Oct 2023 13:15:08 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.51) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Wed, 25 Oct 2023 13:15:03 +0800
To: <qemu-devel@nongnu.org>
CC: Ethan Chen <ethan84@andestech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/6] system/physmem: IOMMU: Invoke the translate_size function
 if it is implemented
Date: Wed, 25 Oct 2023 13:14:26 +0800
Message-ID: <20231025051430.493079-3-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051430.493079-1-ethan84@andestech.com>
References: <20231025051430.493079-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39P5FKiB024567
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:16 -0400
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 system/physmem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index fc2b0fee01..53b6ab735c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -432,8 +432,13 @@ static MemoryRegionSection address_space_translate_iommu(IOMMUMemoryRegion *iomm
             iommu_idx = imrc->attrs_to_index(iommu_mr, attrs);
         }
 
-        iotlb = imrc->translate(iommu_mr, addr, is_write ?
-                                IOMMU_WO : IOMMU_RO, iommu_idx);
+        if (imrc->translate_size) {
+            iotlb = imrc->translate_size(iommu_mr, addr, *plen_out, is_write ?
+                                         IOMMU_WO : IOMMU_RO, iommu_idx);
+        } else {
+            iotlb = imrc->translate(iommu_mr, addr, is_write ?
+                                    IOMMU_WO : IOMMU_RO, iommu_idx);
+        }
 
         if (!(iotlb.perm & (1 << is_write))) {
             goto unassigned;
-- 
2.34.1


