Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8EC7D6647
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:10:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvZt6-0005Ft-JC; Wed, 25 Oct 2023 05:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRn-0004RU-Vx
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:52 -0400
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1qvWRm-0001BW-3R
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 01:28:51 -0400
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
 by Atcsqr.andestech.com with ESMTP id 39P5FFKt024539
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 13:15:15 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 39P5F3F2024461;
 Wed, 25 Oct 2023 13:15:03 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox.andestech.com (10.0.12.51) by
 ATCPCS16.andestech.com (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; 
 Wed, 25 Oct 2023 13:14:58 +0800
To: <qemu-devel@nongnu.org>
CC: Ethan Chen <ethan84@andestech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/6] exec/memory: Introduce the translate_size function within
 the IOMMU class
Date: Wed, 25 Oct 2023 13:14:25 +0800
Message-ID: <20231025051430.493079-2-ethan84@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025051430.493079-1-ethan84@andestech.com>
References: <20231025051430.493079-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 39P5FFKt024539
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 25 Oct 2023 05:09:13 -0400
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

IOMMU have size information during translation.

Signed-off-by: Ethan Chen <ethan84@andestech.com>
---
 include/exec/memory.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 9087d02769..5520b7c8c0 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -396,6 +396,25 @@ struct IOMMUMemoryRegionClass {
      */
     IOMMUTLBEntry (*translate)(IOMMUMemoryRegion *iommu, hwaddr addr,
                                IOMMUAccessFlags flag, int iommu_idx);
+    /**
+     * @translate_size:
+     *
+     * Return a TLB entry that contains a given address and size.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     *
+     * @hwaddr: address to be translated within the memory region
+     *
+     * @size: size to indicate the scope of the entire transaction
+     *
+     * @flag: requested access permission
+     *
+     * @iommu_idx: IOMMU index for the translation
+     */
+    IOMMUTLBEntry (*translate_size)(IOMMUMemoryRegion *iommu, hwaddr addr,
+                                    hwaddr size, IOMMUAccessFlags flag,
+                                    int iommu_idx);
+
     /**
      * @get_min_page_size:
      *
-- 
2.34.1


