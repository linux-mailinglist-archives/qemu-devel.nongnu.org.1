Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8C67C5EA8
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:48:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqg7I-00087R-01; Wed, 11 Oct 2023 16:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg75-000853-6W
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqg71-0005Sp-7l
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697057242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gU5GxAarevf/Fiw4KDpWZonSphVZ+x/f+SBLgawLGwk=;
 b=eM4W+ZmuC2MdK1Z4TRLr52UFqWRAdi6/x2E+Ecg7aMsOo3lbVH8V3wNdRIsqX3knwyiCKg
 pAvk9ZkW8uK9Fbr94PYdM3hdsKrc9Cet5xEJO+aj1NxLuhTjR+8tc30eku1CgM5n/bfClk
 hfSEgRvf+INMxv/agkJNtuYUyLB+sNQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-qw-JGgD4MDK-cvtJq-MALg-1; Wed, 11 Oct 2023 16:47:20 -0400
X-MC-Unique: qw-JGgD4MDK-cvtJq-MALg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 485B2101B047;
 Wed, 11 Oct 2023 20:47:20 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CF4940C6CA0;
 Wed, 11 Oct 2023 20:47:17 +0000 (UTC)
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
Subject: [PATCH v3 2/4] migration: migrate 'blk' command option is deprecated.
Date: Wed, 11 Oct 2023 22:47:09 +0200
Message-ID: <20231011204711.9744-3-quintela@redhat.com>
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

Set the 'block' migration capability to 'true' instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/migration.json       | 10 +++++++---
 migration/migration.c     |  5 +++++
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index eb0f326f00..b2b7e11742 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -424,3 +424,10 @@ The new way to modify migration is using migration parameters.
 ``inc`` functionality can be achieved by setting the
 ``block-incremental`` migration parameter to ``true``.
 
+``blk`` migrate command option (since 8.2)
+''''''''''''''''''''''''''''''''''''''''''
+
+The new way to modify migration is using migration parameters.
+``blk`` functionality can be achieved by setting the
+``block`` migration capability to ``true``.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 7669c98c7a..e4949e0d8e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1484,7 +1484,9 @@
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
@@ -1498,7 +1500,8 @@
 # Features:
 #
 # @deprecated: option @inc should be enabled by setting the
-#     'block-incremental' migration parameter to 'true'.
+#     'block-incremental' migration parameter to 'true', option @blk
+#     should be enabled by setting the 'block' capability to 'true'.
 #
 # Returns: nothing on success
 #
@@ -1521,7 +1524,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': ['deprecated'] },
            '*inc': { 'type': 'bool', 'features': ['deprecated'] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration.c b/migration/migration.c
index c7e4c37b8a..dbe33bfd37 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1607,6 +1607,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
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
2.41.0


