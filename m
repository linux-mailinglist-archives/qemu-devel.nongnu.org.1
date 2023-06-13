Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FA372E66E
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 16:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q95Ta-0006H8-S9; Tue, 13 Jun 2023 10:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TU-0006Ce-1V
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q95TS-0007aL-66
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 10:58:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686668301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=syZYUbF0RRsso7q5i6xC2UsHkPUInHWHOLDSqW2YAak=;
 b=OPGEprAsHgYL0Rnnmz8umYF5mXcHdmJbuRy4sJAB+TooC00CLqnJhLMwAoqQ/k4ft60x21
 5H84d6G7o23hcWgsja2RFrlFv140J4UTpkTwqb0TZTV3Veb6M2IsYBkAk1QySj3PZb8Uwc
 tTJjrOoNkcVobL0soSMdIOYNC2UjmFQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-cUpnqGSANLiqAwc-65ZLvw-1; Tue, 13 Jun 2023 10:58:20 -0400
X-MC-Unique: cUpnqGSANLiqAwc-65ZLvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57B85280158F;
 Tue, 13 Jun 2023 14:58:19 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B44640C6F5C;
 Tue, 13 Jun 2023 14:58:18 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH 16/18] migration: control_save_page() can take block through
 pss
Date: Tue, 13 Jun 2023 16:57:55 +0200
Message-Id: <20230613145757.10131-17-quintela@redhat.com>
In-Reply-To: <20230613145757.10131-1-quintela@redhat.com>
References: <20230613145757.10131-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index e3ff98a6ce..293ea87a70 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1114,14 +1114,14 @@ static int save_zero_page(PageSearchStatus *pss, QEMUFile *f, RAMBlock *block,
  *
  * Return true if the pages has been saved, otherwise false is returned.
  */
-static bool control_save_page(PageSearchStatus *pss, RAMBlock *block,
+static bool control_save_page(PageSearchStatus *pss,
                               ram_addr_t offset, int *pages)
 {
     uint64_t bytes_xmit = 0;
     int ret;
 
     *pages = -1;
-    ret = ram_control_save_page(pss->pss_channel, block->offset, offset,
+    ret = ram_control_save_page(pss->pss_channel, pss->block->offset, offset,
                                 TARGET_PAGE_SIZE, &bytes_xmit);
     if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
         return false;
@@ -2025,7 +2025,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
-    if (control_save_page(pss, block, offset, &res)) {
+    if (control_save_page(pss, offset, &res)) {
         return res;
     }
 
-- 
2.40.1


