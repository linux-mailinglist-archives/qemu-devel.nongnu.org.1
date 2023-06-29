Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF41742217
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:26:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmyG-0000ra-Sx; Thu, 29 Jun 2023 04:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmyB-0000pi-Aq
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:39 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmy9-0003uV-4S
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+PBx1IM+VwAvSsI6vsBRb75BGq9VK9/Wqng6jChjVOA=; b=d29lo1f7Z58WgvdrbzQr29dw3I
 DmekJkEzcpdCpSySYs8dlAoljIYh1ptYFdvPqtQbRbbeWPRbzdYulCewkVAgb4of+yf3yvP99yJo9
 Skhu0VsJIdLOJ2PG66F4ZNRaFEJjzkqnDK9pjQAOjZEklEs3iXltoU/VEoUXRbc5WUgwcw7/iligV
 GdZQUMGp2IE01JVohpl2P2/m2MysPG/MKRfNZONm2nzrwlryEOFSuN0C2EwM+dZ7XtQJc1HShM9Nr
 BzqRUxr97Qu3JXiQLToLOCi3ZkBGFMoHOLYt/nyz2uS3Bh9KQvLExW5OHgDUdDnpIsczjs56p8rX3
 w5ZtxBk+sS/akiG8WpU9mU5i0DSsqIKSLvkt/j2PX4ht0efShy/9hdQEwOqcKiihy2zKLUpdzwOZA
 +FJG2CuQjkX2FilDDxaWd39qNzsVGhICdYr/WfbRdOhhi83bBdTgPZ47vMsG0YEh1y2BMw4uWsPha
 tGm7CCoKEGgCqf7j5NhQ3MePbBasaKYh0ntE0ruLcMYQSlJaFhJ7dFSnxathC1y6xT9qSetwsuoHq
 P3WurQVzZcUzBjo5IUn+iOMP33deGo6nEkMwzicgljOFtjZA5JeJ3aLpnbXBl2s75kfdgK0V5GOgM
 LddepUYZTFtAqD471YvL0IrnnNFlV/1LSs0gcvvt4=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEmxs-000AaV-WE; Thu, 29 Jun 2023 09:25:25 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org, clegoate@redhat.com, hsp.cat7@gmail.com,
 qemu-devel@nongnu.org
Date: Thu, 29 Jun 2023 09:25:21 +0100
Message-Id: <20230629082522.606219-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/2] accel/tcg: fix start page passed to
 tb_invalidate_phys_page_range__locked()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Due to a copy-paste error in tb_invalidate_phys_range() the start address of the
invalidation range was being passed to tb_invalidate_phys_page_range__locked()
instead of the start address of the current page.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: e506ad6a05 ("accel/tcg: Pass last not end to tb_invalidate_phys_range")
---
 accel/tcg/tb-maint.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3541419845..33ea1aadd1 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1182,15 +1182,17 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
     index_last = last >> TARGET_PAGE_BITS;
     for (index = start >> TARGET_PAGE_BITS; index <= index_last; index++) {
         PageDesc *pd = page_find(index);
-        tb_page_addr_t bound;
+        tb_page_addr_t page_start, page_last;
 
         if (pd == NULL) {
             continue;
         }
         assert_page_locked(pd);
-        bound = (index << TARGET_PAGE_BITS) | ~TARGET_PAGE_MASK;
-        bound = MIN(bound, last);
-        tb_invalidate_phys_page_range__locked(pages, pd, start, bound, 0);
+        page_start = index << TARGET_PAGE_BITS;
+        page_last = page_start | ~TARGET_PAGE_MASK;
+        page_last = MIN(page_last, last);
+        tb_invalidate_phys_page_range__locked(pages, pd,
+                                              page_start, page_last, 0);
     }
     page_collection_unlock(pages);
 }
-- 
2.30.2


