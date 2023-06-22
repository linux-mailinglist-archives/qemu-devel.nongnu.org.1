Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBAB173A921
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQKF-000455-4l; Thu, 22 Jun 2023 15:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKC-00043r-FK
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKB-0002nK-0S
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OJEoWvSK4rcyGnW5iFuITs0CavsS5ZXLN1pX+qXE0ZU=;
 b=Xd/FxPfhGT+SYXaKqsA5XMoRqvKPviK9XOqs//PkB/dcCuCQbriqXwJolhUXTBehsmvA7R
 5+6953T16lEhlXszGLEi9Q7E/zVr0sNL5s3Li2/StuxzLmGUN9D+teYRCNlQlZipttqDGB
 RTzQZRWbltNoeKGn3E0YanHTuMNVnn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-U8oc86UiNlOR1g2WYBqoig-1; Thu, 22 Jun 2023 15:50:32 -0400
X-MC-Unique: U8oc86UiNlOR1g2WYBqoig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F2FC88D0FD;
 Thu, 22 Jun 2023 19:50:29 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F036C00049;
 Thu, 22 Jun 2023 19:50:26 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 2/5] migration: migrate 'inc' command option is deprecated.
Date: Thu, 22 Jun 2023 21:50:16 +0200
Message-Id: <20230622195019.4396-3-quintela@redhat.com>
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Set the 'block_incremental' migration parameter to 'true' instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/migration.json       | 12 ++++++++++--
 migration/migration.c     |  6 ++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index e1aa0eafc8..cc0001041f 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -433,3 +433,10 @@ Migration
 ``skipped`` field in Migration stats has been deprecated.  It hasn't
 been used for more than 10 years.
 
+``inc`` migrate command option (since 8.1)
+''''''''''''''''''''''''''''''''''''''''''
+
+The new way to modify migration is using migration parameters.
+``inc`` functionality can be achieved by setting the
+``block-incremental`` migration parameter to ``true``.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index ad8cc57071..8b30f748ef 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1479,13 +1479,20 @@
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
@@ -1507,7 +1514,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool',
+  'data': {'uri': 'str', '*blk': 'bool',
+           '*inc': { 'type': 'bool', 'features': ['deprecated'] },
            '*detach': 'bool', '*resume': 'bool' } }
 
 ##
diff --git a/migration/migration.c b/migration/migration.c
index 7a4ba2e846..abc40e6ef6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1557,6 +1557,12 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
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
2.40.1


