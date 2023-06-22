Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D981773A923
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 21:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCQKq-0004JP-9A; Thu, 22 Jun 2023 15:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKT-0004CN-22
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCQKR-0002sG-Gr
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 15:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687463450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fI3S2OCmB0MvN93l8l7vdXzPcvm7ZD+8BlQA4Yf3rfQ=;
 b=HMEbIBJNZeLUTrNhhZ4oSTqrgxC+2iBMxx6RNOYE2TDHRKOZcvRqFsib0S24mssHAgYV33
 SLZeEc0b5H8/2e8SblSf6RnnKRKRooVcQg4w+IF/lpMv4lyqPmxIIMXVNZHnEaMq25Z8n9
 heZEtJ57NmDzciqKl432LvGLfz6pojs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-303-LMPxIg_IMACpFuo_Uo-i9Q-1; Thu, 22 Jun 2023 15:50:42 -0400
X-MC-Unique: LMPxIg_IMACpFuo_Uo-i9Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 954E21C07551;
 Thu, 22 Jun 2023 19:50:32 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74466C00049;
 Thu, 22 Jun 2023 19:50:29 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 3/5] migration: migrate 'blk' command option is deprecated.
Date: Thu, 22 Jun 2023 21:50:17 +0200
Message-Id: <20230622195019.4396-4-quintela@redhat.com>
In-Reply-To: <20230622195019.4396-1-quintela@redhat.com>
References: <20230622195019.4396-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Set the 'block' migration capability to 'true' instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/migration.json       | 10 +++++++---
 migration/migration.c     |  5 +++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index cc0001041f..f727db958e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -440,3 +440,10 @@ The new way to modify migration is using migration parameters.
 ``inc`` functionality can be achieved by setting the
 ``block-incremental`` migration parameter to ``true``.
 
+``blk`` migrate command option (since 8.1)
+''''''''''''''''''''''''''''''''''''''''''
+
+The new way to modify migration is using migration parameters.
+``blk`` functionality can be achieved by setting the
+``block`` migration capability to ``true``.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 8b30f748ef..291af9407e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1477,7 +1477,9 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
-# @blk: do block migration (full disk copy)
+# @blk: do block migration (full disk copy). This option is
+#     deprecated.  Set the 'block' migration capability to 'true'
+#     instead.
 #
 # @inc: incremental disk copy migration.  This option is deprecated.
 #     Set the 'block-incremetantal' migration parameter to 'true'
@@ -1491,7 +1493,8 @@
 # Features:
 #
 # @deprecated: option @inc should be enabled by setting the
-#     'block-incremental' migration parameter to 'true'.
+#     'block-incremental' migration parameter to 'true', option @blk
+#     should be enabled by setting the 'block' capability to 'true'.
 #
 # Returns: nothing on success
 #
@@ -1514,7 +1517,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': ['deprecated'] },
            '*inc': { 'type': 'bool', 'features': ['deprecated'] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration.c b/migration/migration.c
index abc40e6ef6..4c7e8ff5ee 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1563,6 +1563,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                     " instead.");
     }
 
+    if (blk) {
+        warn_report("-blk migrate option is deprecated, set the "
+                    "'block' capability to 'true' instead.");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.40.1


