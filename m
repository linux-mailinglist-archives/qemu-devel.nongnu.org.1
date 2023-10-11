Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D26897C5EAB
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqg7C-000859-9E; Wed, 11 Oct 2023 16:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg73-00084t-7n
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg70-0005SY-Nh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697057241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ySPhwgrsUGdd3FlvrWw+iRTKHrAJxtaNBJgcQx6Mkls=;
 b=h1W5isR9LkTnH562jvwpX75qRVp4zHk5BOnURPte5rw1iQ1sI5S9CWIu6qrGvCTpBNRfFy
 q3arrTd9Kmc8ow3MkzillEJx7l0nqZ+ZbOP7V/lfyKxqqYB0DGKHd1bJzWCK3ltA7ggwvp
 6eASrmDmbLCb8MK5VqZyQzE+KCziga4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-Icgh2XpZP9eBaM1Cm2Sg6w-1; Wed, 11 Oct 2023 16:47:18 -0400
X-MC-Unique: Icgh2XpZP9eBaM1Cm2Sg6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBF15382135A;
 Wed, 11 Oct 2023 20:47:17 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A009640C6CA0;
 Wed, 11 Oct 2023 20:47:15 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 1/4] migration: migrate 'inc' command option is deprecated.
Date: Wed, 11 Oct 2023 22:47:08 +0200
Message-ID: <20231011204711.9744-2-quintela@redhat.com>
In-Reply-To: <20231011204711.9744-1-quintela@redhat.com>
References: <20231011204711.9744-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Set the 'block_incremental' migration parameter to 'true' instead.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/migration.json       | 12 ++++++++++--
 migration/migration.c     |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8b136320e2..eb0f326f00 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -417,3 +417,10 @@ Migration
 ``skipped`` field in Migration stats has been deprecated.  It hasn't
 been used for more than 10 years.
 
+``inc`` migrate command option (since 8.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+The new way to modify migration is using migration parameters.
+``inc`` functionality can be achieved by setting the
+``block-incremental`` migration parameter to ``true``.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index d7dfaa5db9..7669c98c7a 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1486,13 +1486,20 @@
 #
 # @blk: do block migration (full disk copy)
 #
-# @inc: incremental disk copy migration
+# @inc: incremental disk copy migration.  This option is deprecated.
+#     Set the 'block-incremetantal' migration parameter to 'true'
+#     instead.
 #
 # @detach: this argument exists only for compatibility reasons and is
 #     ignored by QEMU
 #
 # @resume: resume one paused migration, default "off". (since 3.0)
 #
+# Features:
+#
+# @deprecated: option @inc should be enabled by setting the
+#     'block-incremental' migration parameter to 'true'.
+#
 # Returns: nothing on success
 #
 # Since: 0.14
@@ -1514,7 +1521,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
+  'data': {'uri': 'str', '*blk': 'bool',
+           '*inc': { 'type': 'bool', 'features': ['deprecated'] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
diff --git a/migration/migration.c b/migration/migration.c
index 1c6c81ad49..c7e4c37b8a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1601,6 +1601,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 {
     Error *local_err = NULL;
 
+    if (blk_inc) {
+        warn_report("-inc migrate option is deprecated, set the "
+                    "'block-incremental' migration parameter to 'true'"
+                    " instead.");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.41.0


