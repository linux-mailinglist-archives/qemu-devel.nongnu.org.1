Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 200427CC20A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:53:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsid8-00047K-OP; Tue, 17 Oct 2023 07:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsid4-00046R-8j
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsid2-0004uu-Oz
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697543572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJ4O/RVfZpK+CCyz8O3xdNj9Fo+6quHJbCQvwEeg1jY=;
 b=gvYrgNAJoPp+8J4m2h3dzrIHKjDGpCHt4vUVBDF0n3ULeKWuMH6VZstO1IoMcZX3+XlXi2
 WqPFCB29z0w5rKE452YljELuTevyKDez0ZUAHsiOIgPjT1OY8i+eYHKmLWh/xT28IuuHPs
 bAgzx5AmQF2ovWeKVT04e3chzH4w1R8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-Y9suBFTaNwaSZ-ZyvlA6HA-1; Tue, 17 Oct 2023 07:52:48 -0400
X-MC-Unique: Y9suBFTaNwaSZ-ZyvlA6HA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D6892825E80;
 Tue, 17 Oct 2023 11:52:48 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 71794492BFA;
 Tue, 17 Oct 2023 11:52:46 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 3/7] migration: migrate 'blk' command option is deprecated.
Date: Tue, 17 Oct 2023 13:52:34 +0200
Message-ID: <20231017115238.18309-4-quintela@redhat.com>
In-Reply-To: <20231017115238.18309-1-quintela@redhat.com>
References: <20231017115238.18309-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

Use blocked-mirror with NBD instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

---

Improve documentation and style (markus)
---
 docs/about/deprecated.rst      | 10 ++++++++++
 qapi/migration.json            |  6 ++++--
 migration/migration-hmp-cmds.c |  5 +++++
 migration/migration.c          |  5 +++++
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index fc6adf1dea..0149f040b6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -469,3 +469,13 @@ Use blockdev-mirror with NBD instead.
 As an intermediate step the ``inc`` functionality can be achieved by
 setting the ``block-incremental`` migration parameter to ``true``.
 But this parameter is also deprecated.
+
+``blk`` migrate command option (since 8.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+Use blockdev-mirror with NBD instead.
+
+As an intermediate step the ``blk`` functionality can be achieved by
+setting the ``block`` migration capability to ``true``.
+But this capability is also deprecated.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index fa7f4f2575..59a07b50f0 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1527,7 +1527,8 @@
 # Features:
 #
 # @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
-#     NBD instead.
+#     NBD instead.  Member @blk is deprecated.  Use blockdev-mirror
+#     with NBD instead.
 #
 # Returns: nothing on success
 #
@@ -1550,7 +1551,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index fee7079afa..bfeb1a476a 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -750,6 +750,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
                     " instead.");
     }
 
+    if (blk) {
+        warn_report("option '-b' is deprecated.  Use 'blockdev-mirror + NBD'"
+                    " instead.");
+    }
+
     qmp_migrate(uri, !!blk, blk, !!inc, inc,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
diff --git a/migration/migration.c b/migration/migration.c
index b8b3ba58df..4da7fcfe0f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1608,6 +1608,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                     " NBD instead");
     }
 
+    if (blk) {
+        warn_report("capability 'blk is deprecated.  Use blockdev-mirror with"
+                    " NBD instead");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.41.0


