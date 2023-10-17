Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 682EB7CBD85
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfTy-0005Hk-Sa; Tue, 17 Oct 2023 04:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTc-0004tQ-Me
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsfTa-0005Jx-Tk
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697531453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QT7DYsh3rLn0leJw2asa1GhQ4CWEuPtmAnuhYisVYhM=;
 b=GDwoJ6e7E2qPx/+lOnMqaTMAgxR4OTvaB2LXDGsLWiHIN1cy+GysZVI+bOrBEX3qkvBVNp
 tyhwjI8cU+wD+IqIAq5xXW8OriQp2Wy7hoW9xbCyJuzDPDV0lbKOy23/PDUctWQEFW063F
 nYs2Pg7TuWlWSCH6YvjpvLh9RUNVn5k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-6iWyq_8wN56ZmYwFIIE8PA-1; Tue, 17 Oct 2023 04:30:48 -0400
X-MC-Unique: 6iWyq_8wN56ZmYwFIIE8PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA309185A7A7;
 Tue, 17 Oct 2023 08:30:47 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 240391C060AE;
 Tue, 17 Oct 2023 08:30:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 13/38] migration: Non multifd migration don't care about
 multifd flushes
Date: Tue, 17 Oct 2023 10:29:38 +0200
Message-ID: <20231017083003.15951-14-quintela@redhat.com>
In-Reply-To: <20231017083003.15951-1-quintela@redhat.com>
References: <20231017083003.15951-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
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

RDMA was having trouble because
migrate_multifd_flush_after_each_section() can only be true or false,
but we don't want to send any flush when we are not in multifd
migration.

CC: Fabiano Rosas <farosas@suse.de
Fixes: 294e5a4034e81 ("multifd: Only flush once each full round of memory")

Reported-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231011205548.10571-2-quintela@redhat.com>
---
 migration/ram.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index d3d9c8b65b..acb8f95f00 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1395,7 +1395,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
         pss->page = 0;
         pss->block = QLIST_NEXT_RCU(pss->block, next);
         if (!pss->block) {
-            if (!migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                !migrate_multifd_flush_after_each_section()) {
                 QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
                 int ret = multifd_send_sync_main(f);
                 if (ret < 0) {
@@ -3072,7 +3073,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (!migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
 
@@ -3184,7 +3185,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
 out:
     if (ret >= 0
         && migration_is_setup_or_active(migrate_get_current()->state)) {
-        if (migrate_multifd_flush_after_each_section()) {
+        if (migrate_multifd() && migrate_multifd_flush_after_each_section()) {
             ret = multifd_send_sync_main(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel);
             if (ret < 0) {
                 return ret;
@@ -3261,7 +3262,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         return ret;
     }
 
-    if (!migrate_multifd_flush_after_each_section()) {
+    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()) {
         qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
     }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
@@ -3768,7 +3769,8 @@ int ram_load_postcopy(QEMUFile *f, int channel)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
             }
             break;
@@ -4046,7 +4048,8 @@ static int ram_load_precopy(QEMUFile *f)
             break;
         case RAM_SAVE_FLAG_EOS:
             /* normal exit */
-            if (migrate_multifd_flush_after_each_section()) {
+            if (migrate_multifd() &&
+                migrate_multifd_flush_after_each_section()) {
                 multifd_recv_sync_main();
             }
             break;
-- 
2.41.0


