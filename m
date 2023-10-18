Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF977CD8D0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:08:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3SS-0007O1-CE; Wed, 18 Oct 2023 06:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SJ-0007Lu-Tc
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3SH-0007i7-KG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697623628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eB5hf4L6HPajlM/c3jKrckOfhTyEPI90C+hr6h717L8=;
 b=VXBMw1c+Z3zor+lO1IW1r3WkPJN8e5IzZu+9okRouak9N2KseWbzAiqP3M1W5sSEoAIFur
 Gm6c4HEmMbP4+EoVYYkm3Bu0avbDeJkpnTKeUg/Bc+83cFnpODdwhZ2+iteMD2yb7AghaR
 vo9opA+MijU+Iq+SyFc20zPMOMdN0EU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-EgR_3tv1P3OWgE2uqc0qcA-1; Wed, 18 Oct 2023 06:07:05 -0400
X-MC-Unique: EgR_3tv1P3OWgE2uqc0qcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 06D0D8E4145;
 Wed, 18 Oct 2023 10:07:05 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2D2C2026D4C;
 Wed, 18 Oct 2023 10:07:03 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PULL 09/11] migration: save_compress_page() can take block through
 pss
Date: Wed, 18 Oct 2023 12:06:49 +0200
Message-ID: <20231018100651.32674-10-quintela@redhat.com>
In-Reply-To: <20231018100651.32674-1-quintela@redhat.com>
References: <20231018100651.32674-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Lukas Straub <lukasstraub2@web.de>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5595379fa6..378d310fbd 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2067,7 +2067,7 @@ static bool save_page_use_compression(RAMState *rs)
  * paths to handle it
  */
 static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
-                               RAMBlock *block, ram_addr_t offset)
+                               ram_addr_t offset)
 {
     if (!save_page_use_compression(rs)) {
         return false;
@@ -2083,12 +2083,13 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
      * We post the fist page as normal page as compression will take
      * much CPU resource.
      */
-    if (block != pss->last_sent_block) {
+    if (pss->block != pss->last_sent_block) {
         ram_flush_compressed_data(rs);
         return false;
     }
 
-    if (compress_page_with_multi_thread(block, offset, send_queued_data) > 0) {
+    if (compress_page_with_multi_thread(pss->block, offset,
+                                        send_queued_data) > 0) {
         return true;
     }
 
@@ -2114,7 +2115,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return res;
     }
 
-    if (save_compress_page(rs, pss, block, offset)) {
+    if (save_compress_page(rs, pss, offset)) {
         return 1;
     }
 
-- 
2.41.0


