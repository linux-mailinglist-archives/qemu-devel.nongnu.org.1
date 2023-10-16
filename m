Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B27CA4CB
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 12:09:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsKXZ-0004pZ-CC; Mon, 16 Oct 2023 06:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWw-000412-Hh
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsKWq-0007j4-Rw
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 06:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697450930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OTY4pM/TJ0bm/77AaRoLbQoEqVgt+PioBNyoaRyZqok=;
 b=apNxuZd6rcqDrIiq+SuZ+AXCJ1YMD+UDyUKpA2Xw7Fr/zSR9dhBRkOwWTbDOXruKjKmtnG
 J8j+g3XqTDwgti9Ezu98PV/yT/PYJnN8WA5U2IooAJCSjb1PKOXiSJya7NouYGAHJgky/R
 LxipBxWy0z22Xd5jl/X6rLn/LdWe/c8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-oL_d7XSGM9GHQqOCaTfhnA-1; Mon, 16 Oct 2023 06:08:47 -0400
X-MC-Unique: oL_d7XSGM9GHQqOCaTfhnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9994281D9E5;
 Mon, 16 Oct 2023 10:08:46 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F99C63F21;
 Mon, 16 Oct 2023 10:08:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fam Zheng <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>,
 Eric Blake <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 32/38] migration/ram: Remove RAMState from
 xbzrle_cache_zero_page
Date: Mon, 16 Oct 2023 12:07:00 +0200
Message-ID: <20231016100706.2551-33-quintela@redhat.com>
In-Reply-To: <20231016100706.2551-1-quintela@redhat.com>
References: <20231016100706.2551-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fabiano Rosas <farosas@suse.de>

'rs' is not used in that function. It's a leftover from commit
9360447d34 ("ram: Use MigrationStats for statistics").

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011184604.32364-4-farosas@suse.de>
---
 migration/ram.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 2bd51d6bb5..535172d9be 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -570,7 +570,6 @@ void mig_throttle_counter_reset(void)
 /**
  * xbzrle_cache_zero_page: insert a zero page in the XBZRLE cache
  *
- * @rs: current RAM state
  * @current_addr: address for the zero page
  *
  * Update the xbzrle cache to reflect a page that's been sent as all 0.
@@ -579,7 +578,7 @@ void mig_throttle_counter_reset(void)
  * As a bonus, if the page wasn't in the cache it gets added so that
  * when a small write is made into the 0'd page it gets XBZRLE sent.
  */
-static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
+static void xbzrle_cache_zero_page(ram_addr_t current_addr)
 {
     /* We don't care if this fails to allocate a new cache page
      * as long as it updated an old one */
@@ -2146,7 +2145,7 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
          */
         if (rs->xbzrle_started) {
             XBZRLE_cache_lock();
-            xbzrle_cache_zero_page(rs, block->offset + offset);
+            xbzrle_cache_zero_page(block->offset + offset);
             XBZRLE_cache_unlock();
         }
         return res;
-- 
2.41.0


