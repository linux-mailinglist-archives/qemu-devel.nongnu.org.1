Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0867DC8EF
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:03:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkeW-0001jJ-9m; Tue, 31 Oct 2023 05:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeL-0001VP-T5
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxkeK-00072I-7f
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698742979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10JfSxom2lk2mbOjj76bRdexz5YSQtyyggKlwWnHJ6E=;
 b=LFVN5zdlDokmG1jZ9YmQWY2Wu/ki6EwODPFMzlUGKtC05DK4ijvBiJ3aw0Z6pt8M9Dq9yw
 LHj+HTDhUnkQD/VQI+NqBEISARGftaR3+pdf+Ax6Zq5NlHbme2YWHJu+n0BkxZkNtt9i2m
 z/uM12G6JdSPaV53/DCpNEcnm/pPpdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-OgGxdt4oOOmwWC_iKjl4NQ-1; Tue, 31 Oct 2023 05:02:51 -0400
X-MC-Unique: OgGxdt4oOOmwWC_iKjl4NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ADAC2185A786;
 Tue, 31 Oct 2023 09:02:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 300BE1C060AE;
 Tue, 31 Oct 2023 09:02:48 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, libvir-list@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 23/38] migration: migrate 'blk' command option is deprecated.
Date: Tue, 31 Oct 2023 10:01:27 +0100
Message-ID: <20231031090142.13122-24-quintela@redhat.com>
In-Reply-To: <20231031090142.13122-1-quintela@redhat.com>
References: <20231031090142.13122-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-ID: <20231018115513.2163-4-quintela@redhat.com>
---
 docs/about/deprecated.rst      | 9 +++++++++
 qapi/migration.json            | 7 ++++---
 migration/migration-hmp-cmds.c | 5 +++++
 migration/migration.c          | 5 +++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1c8c8c34c4..c1613468e6 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -477,3 +477,12 @@ Use blockdev-mirror with NBD instead.
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
+setting the ``block`` migration capability to ``true``.  But this
+capability is also deprecated.
diff --git a/qapi/migration.json b/qapi/migration.json
index fa7f4f2575..3765c2b662 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1526,8 +1526,8 @@
 #
 # Features:
 #
-# @deprecated: Member @inc is deprecated.  Use blockdev-mirror with
-#     NBD instead.
+# @deprecated: Members @inc and @blk are deprecated.  Use
+#     blockdev-mirror with NBD instead.
 #
 # Returns: nothing on success
 #
@@ -1550,7 +1550,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 83176f5bae..dfe98da355 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -750,6 +750,11 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
                     " use blockdev-mirror with NBD instead");
     }
 
+    if (blk) {
+        warn_report("option '-b' is deprecated;"
+                    " use blockdev-mirror with NBD instead");
+    }
+
     qmp_migrate(uri, !!blk, blk, !!inc, inc,
                 false, false, true, resume, &err);
     if (hmp_handle_error(mon, err)) {
diff --git a/migration/migration.c b/migration/migration.c
index 06a706ad90..cb2d7161b5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1625,6 +1625,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                     " use blockdev-mirror with NBD instead");
     }
 
+    if (blk) {
+        warn_report("parameter 'blk' is deprecated;"
+                    " use blockdev-mirror with NBD instead");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.41.0


