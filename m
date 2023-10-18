Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A8C7CD94B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:33:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3qq-0007vR-Qm; Wed, 18 Oct 2023 06:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3qZ-0007rq-OQ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt3qY-0003iw-0Y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697625133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g6TaytCZdkwnbpVWoENA0m9y1+f/V7wL2SZsufVAXN4=;
 b=LOiWtyiFnC2PK0l88f3h8X4vGQTqNp6e+j6av1ZKw3LVdkOVOxCt5d9BdguA1pLi+Xmf0W
 hF2gUoLIe/2UqLSFlUgndG+MFSmahSRRivseJa+zmCqmeFC0L8UtvP8R633ctrFOQ2YTxK
 BlbEWTJAwzsWTtwg2mTJY7hDEg9FInQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-HyaEviObMcG4ijrQpS7jlA-1; Wed, 18 Oct 2023 06:32:10 -0400
X-MC-Unique: HyaEviObMcG4ijrQpS7jlA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66C48E4158;
 Wed, 18 Oct 2023 10:32:09 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A65972026D4C;
 Wed, 18 Oct 2023 10:32:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Peter Xu <peterx@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, Juan Quintela <quintela@redhat.com>,
 libvir-list@redhat.com, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v7 1/4] migration: migrate 'inc' command option is deprecated.
Date: Wed, 18 Oct 2023 12:32:01 +0200
Message-ID: <20231018103204.33444-2-quintela@redhat.com>
In-Reply-To: <20231018103204.33444-1-quintela@redhat.com>
References: <20231018103204.33444-1-quintela@redhat.com>
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

Use blockdev-mirror with NBD instead.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst      | 8 ++++++++
 qapi/migration.json            | 8 +++++++-
 migration/migration-hmp-cmds.c | 5 +++++
 migration/migration.c          | 5 +++++
 4 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 2febd2d12f..fc6adf1dea 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -461,3 +461,11 @@ Migration
 ``skipped`` field in Migration stats has been deprecated.  It hasn't
 been used for more than 10 years.
 
+``inc`` migrate command option (since 8.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead.
+
+As an intermediate step the ``inc`` functionality can be achieved by
+setting the ``block-incremental`` migration parameter to ``true``.
+But this parameter is also deprecated.
diff --git a/qapi/migration.json b/qapi/migration.json
index db3df12d6c..fa7f4f2575 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1524,6 +1524,11 @@
 #
 # @resume: resume one paused migration, default "off". (since 3.0)
 #
+# Features:
+#
+# @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
+#     NBD instead.
+#
 # Returns: nothing on success
 #
 # Since: 0.14
@@ -1545,7 +1550,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
+  'data': {'uri': 'str', '*blk': 'bool',
+           '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a82597f18e..83176f5bae 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -745,6 +745,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     const char *uri = qdict_get_str(qdict, "uri");
     Error *err = NULL;
 
+    if (inc) {
+        warn_report("option '-i' is deprecated;"
+                    " use blockdev-mirror with NBD instead");
+    }
+
     qmp_migrate(uri, !!blk, blk, !!inc, inc,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
diff --git a/migration/migration.c b/migration/migration.c
index 05c0b801ba..27145cd99e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1604,6 +1604,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 {
     Error *local_err = NULL;
 
+    if (blk_inc) {
+        warn_report("parameter 'inc' is deprecated;"
+                    " use blockdev-mirror with NBD instead");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.41.0


