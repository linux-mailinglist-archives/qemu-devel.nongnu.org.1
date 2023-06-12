Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE8872CF9D
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 21:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8nIi-0004Nv-Ly; Mon, 12 Jun 2023 15:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIg-0004NH-MR
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q8nIf-0006DR-7S
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 15:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686598440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BG+ItxdY/Nq2c8whrRKZhnxHj8iNhZRPeYw1Ilf9V2M=;
 b=iqjZCdL0eoPctA+5AeDzoXHzq0dmH//bKl/B8HTzmOz3sStWOgz6Lv3xcgtae1SFyMUysA
 Esbw7Ch+sshD0AQ0wO2P9JQ7fudsGqaHRCO52Dfzdp6osk45EzQnoMFkOxks255fExM/vz
 XzS/AEwAxyhQGjQJ/yOlQZ8hCrCubko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-XszbMVTFNx-gDoy-UqawFg-1; Mon, 12 Jun 2023 15:33:56 -0400
X-MC-Unique: XszbMVTFNx-gDoy-UqawFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 438F185A5BE;
 Mon, 12 Jun 2023 19:33:55 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.192.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1AE141511A;
 Mon, 12 Jun 2023 19:33:52 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [RFC 3/6] migration: migrate 'blk' command option is deprecated.
Date: Mon, 12 Jun 2023 21:33:41 +0200
Message-Id: <20230612193344.3796-4-quintela@redhat.com>
In-Reply-To: <20230612193344.3796-1-quintela@redhat.com>
References: <20230612193344.3796-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

Use 'migrate_set_capability block true' instead.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 docs/about/deprecated.rst |  7 +++++++
 qapi/migration.json       | 11 +++++++----
 migration/migration.c     |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index c75a3a8f5a..47e98dc95e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -440,3 +440,10 @@ The new way to modify migration is using migration parameters.
 ``inc`` functionality can be acchieved using
 ``migrate_set_parameter block-incremental true``.
 
+``blk`` migrate command option (since 8.1)
+''''''''''''''''''''''''''''''''''''''''''
+
+The new way to modify migration is using migration parameters.
+``blk`` functionality can be acchieved using
+``migrate_set_parameter block-incremental true``.
+
diff --git a/qapi/migration.json b/qapi/migration.json
index 4ee28df6da..b71e00737e 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1422,7 +1422,8 @@
 #
 # @uri: the Uniform Resource Identifier of the destination VM
 #
-# @blk: do block migration (full disk copy)
+# @blk: do block migration (full disk copy). This option is deprecated.
+#    Use 'migrate_set_capability block true' instead.
 #
 # @inc: incremental disk copy migration.  This option is deprecated.
 #    Use 'migrate_set_parameter block-incremetantal true' instead.
@@ -1434,8 +1435,9 @@
 #
 # Features:
 #
-# @deprecated: option @inc is better set with
-#     'migrate_set_parameter block-incremental true'.
+# @deprecated: options @inc and @blk are better set with
+#     'migrate_set_parameter block-incremental true' and
+#     'migrate_set_capability block true' respectively.
 #
 # Returns: nothing on success
 #
@@ -1458,7 +1460,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': ['deprecated'] },
            '*inc': { 'type': 'bool', 'features': ['deprecated'] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration.c b/migration/migration.c
index 7ebce7c7bf..b7d5f6b96c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1549,6 +1549,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                     "'migrate_set_parameter block-incremental true' instead.");
     }
 
+    if (blk) {
+        warn_report("-blk migrate option is deprecated, use"
+                    "'migrate_set_capability block true' instead.");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.40.1


