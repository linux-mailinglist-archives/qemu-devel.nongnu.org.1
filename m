Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DE27DC8F6
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:04:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkdh-0008AI-KM; Tue, 31 Oct 2023 05:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkdd-00086v-KL
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkda-0006rA-Mq
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wSytcPgXUihOAo8jO1TEKPhY/Cs4SiCxtxaCJgHSibA=;
 b=iamWVlqqoLfCse/IoWTW9CBWC6vf8e2sm+QmbPfiFeZbHZGEXqZdCTMVUIQSosg7lcbweQ
 Zyte5azMCqPvZ0lxmzuc2x00E8GJKtRwX7osHYOCqIZWE5wy1iB/p3M3iYEcwLhdIPUhza
 RxQc6D7ZbNOUMTbUIhD7NG24XZ9mwog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-INxsbuvsNhae8lCVBAtL9w-1; Tue,
 31 Oct 2023 05:02:01 -0400
X-MC-Unique: INxsbuvsNhae8lCVBAtL9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC59A3822549;
 Tue, 31 Oct 2023 09:02:00 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4A1B61C060AE;
 Tue, 31 Oct 2023 09:01:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 05/38] migration: Receiving a zero page non zero is an error
Date: Tue, 31 Oct 2023 10:01:09 +0100
Message-ID: <20231031090142.13122-6-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

We don't allow non zero compressed pages since:

commit 3edcd7e6ebae3ef0ac178eed5f4225803159562d
Author: Peter Lieven <pl@kamp.de>
Date:   Tue Mar 26 10:58:35 2013 +0100

    migration: search for zero instead of dup pages

RDMA case is a bit more complicated, but they don't handle it since:

commit a1febc4950f2c6232c002f401d7cd409f6fa6a88
Author: Richard Henderson <rth@twiddle.net>
Date:   Mon Aug 29 11:46:14 2016 -0700

    cutils: Export only buffer_is_zero

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231019085259.13307-2-quintela@redhat.com>
---
 migration/ram.c  | 15 +++++++++++----
 migration/rdma.c |  6 +++++-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 92769902bb..4bfb20c94a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3715,16 +3715,18 @@ int ram_load_postcopy(QEMUFile *f, int channel)
         switch (flags & ~RAM_SAVE_FLAG_CONTINUE) {
         case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
+            if (ch != 0) {
+                error_report("Found a zero page with value %d", ch);
+                ret = -EINVAL;
+                break;
+            }
             /*
              * Can skip to set page_buffer when
              * this is a zero page and (block->page_size == TARGET_PAGE_SIZE).
              */
-            if (ch || !matches_target_page_size) {
+            if (!matches_target_page_size) {
                 memset(page_buffer, ch, TARGET_PAGE_SIZE);
             }
-            if (ch) {
-                tmp_page->all_zero = false;
-            }
             break;
 
         case RAM_SAVE_FLAG_PAGE:
@@ -4030,6 +4032,11 @@ static int ram_load_precopy(QEMUFile *f)
 
         case RAM_SAVE_FLAG_ZERO:
             ch = qemu_get_byte(f);
+            if (ch != 0) {
+                error_report("Found a zero page with value %d", ch);
+                ret = -EINVAL;
+                break;
+            }
             ram_handle_compressed(host, ch, TARGET_PAGE_SIZE);
             break;
 
diff --git a/migration/rdma.c b/migration/rdma.c
index 2a1852ec7f..2d963fd147 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3592,7 +3592,11 @@ int rdma_registration_handle(QEMUFile *f)
 
             host_addr = block->local_host_addr +
                             (comp->offset - block->offset);
-
+            if (comp->value) {
+                error_report("rdma: Zero page with non-zero (%d) value",
+                             comp->value);
+                goto err;
+            }
             ram_handle_compressed(host_addr, comp->value, comp->length);
             break;
 
-- 
2.41.0


