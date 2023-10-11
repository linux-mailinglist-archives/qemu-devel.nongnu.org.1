Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2755C7C4EFD
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 11:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqVSH-0005gK-8G; Wed, 11 Oct 2023 05:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS9-0005Ln-L7
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqVS8-0005Fa-1M
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697016267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0oKcmS5F3D6ms1PTcjVPw4CdXqEB0yWzLByNx9k7Heg=;
 b=fgHUyblaiKsNCwe/5pHRycFwFOY5tgY00AIAEEFeBxzHLstj91REvXycSIH6A+5GwLr1QK
 9KwaH1hbqvqZXinT3sqL0UZLFG+BZ/UrI9DG1x8XzuHNnk2Gu5TnxCTFJ8oiO6+T6nIHOd
 +DINelamc9Yw3u/OVsDfKBdlD5946rs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-VTdypbYIP1eBCw1NxEoxKw-1; Wed, 11 Oct 2023 05:24:10 -0400
X-MC-Unique: VTdypbYIP1eBCw1NxEoxKw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 366AB811E8E;
 Wed, 11 Oct 2023 09:24:10 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78CFB1C060AE;
 Wed, 11 Oct 2023 09:24:08 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 61/65] migration: Display error in query-migrate irrelevant of
 status
Date: Wed, 11 Oct 2023 11:21:59 +0200
Message-ID: <20231011092203.1266-62-quintela@redhat.com>
In-Reply-To: <20231011092203.1266-1-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Display it as long as being set, irrelevant of FAILED status.  E.g., it may
also be applicable to PAUSED stage of postcopy, to provide hint on what has
gone wrong.

The error_mutex seems to be overlooked when referencing the error, add it
to be very safe.

This will change QAPI behavior by showing up error message outside !FAILED
status, but it's intended and doesn't expect to break anyone.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2018404
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231004220240.167175-2-peterx@redhat.com>
---
 qapi/migration.json   | 5 ++---
 migration/migration.c | 8 +++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d8f3bbd7b0..d7dfaa5db9 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -230,9 +230,8 @@
 #     throttled during auto-converge.  This is only present when
 #     auto-converge has started throttling guest cpus.  (Since 2.7)
 #
-# @error-desc: the human readable error description string, when
-#     @status is 'failed'. Clients should not attempt to parse the
-#     error strings.  (Since 2.7)
+# @error-desc: the human readable error description string. Clients
+#     should not attempt to parse the error strings.  (Since 2.7)
 #
 # @postcopy-blocktime: total time when all vCPU were blocked during
 #     postcopy live migration.  This is only present when the
diff --git a/migration/migration.c b/migration/migration.c
index 2057e42134..57f9e9ed0c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1060,9 +1060,6 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     case MIGRATION_STATUS_FAILED:
         info->has_status = true;
-        if (s->error) {
-            info->error_desc = g_strdup(error_get_pretty(s->error));
-        }
         break;
     case MIGRATION_STATUS_CANCELLED:
         info->has_status = true;
@@ -1072,6 +1069,11 @@ static void fill_source_migration_info(MigrationInfo *info)
         break;
     }
     info->status = state;
+
+    QEMU_LOCK_GUARD(&s->error_mutex);
+    if (s->error) {
+        info->error_desc = g_strdup(error_get_pretty(s->error));
+    }
 }
 
 static void fill_destination_migration_info(MigrationInfo *info)
-- 
2.41.0


