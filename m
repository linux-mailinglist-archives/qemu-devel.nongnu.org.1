Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A397C83A4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:48:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFiF-0003lq-Sf; Fri, 13 Oct 2023 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiD-0003iw-F9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qrFiA-00076q-U2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697194085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zuqZfkWepTDIq64fHaZHVDAkIEGeYgkaY9/o39QGH1o=;
 b=TsZAycKQGJvXiBmTyBH98Qddvn4FZfRkZ91Ybc1Fl6CEEO6M1SrCCNIwzXaGGrRE0WIh4V
 jMPnEXwL/ns8/zZK5YZ/i+PuCIkIWW65KHtaUMXGA3OYE9c5vaGxXk9cUF4BR8IJOm8an8
 aKq4PysDFZw3lZTfborBFZ7BlBh4cv0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-7AwB4EFtM46DJd2cN2jtFQ-1; Fri, 13 Oct 2023 06:47:54 -0400
X-MC-Unique: 7AwB4EFtM46DJd2cN2jtFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7772E1C00D23;
 Fri, 13 Oct 2023 10:47:53 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.195.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B6D842156701;
 Fri, 13 Oct 2023 10:47:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, libvir-list@redhat.com,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [PATCH v4 04/10] migration: migrate 'blk' command option is
 deprecated.
Date: Fri, 13 Oct 2023 12:47:30 +0200
Message-ID: <20231013104736.31722-5-quintela@redhat.com>
In-Reply-To: <20231013104736.31722-1-quintela@redhat.com>
References: <20231013104736.31722-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>

---

Improve documentation and style (markus)
---
 docs/about/deprecated.rst | 7 +++++++
 qapi/migration.json       | 6 ++++--
 migration/migration.c     | 5 +++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1b6b2870cf..e6928b96cf 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -459,3 +459,10 @@ The new way to modify migration is using migration parameters.
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
index 56bbd55b87..64ebced761 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1495,7 +1495,8 @@
 # Features:
 #
 # @deprecated: Member @inc is deprecated.  Use migration parameter
-#     @block-incremental instead.
+#     @block-incremental instead. Member @blk is deprecated. Set
+#     migration capability 'block' to 'true' instead.
 #
 # Returns: nothing on success
 #
@@ -1518,7 +1519,8 @@
 # <- { "return": {} }
 ##
 { 'command': 'migrate',
-  'data': {'uri': 'str', '*blk': 'bool',
+  'data': {'uri': 'str',
+           '*blk': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*inc': { 'type': 'bool', 'features': [ 'deprecated' ] },
            '*detach': 'bool', '*resume': 'bool' } }
 
diff --git a/migration/migration.c b/migration/migration.c
index ac4897fe0d..9e4ae6b772 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1607,6 +1607,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
                     " instead.");
     }
 
+    if (blk) {
+        warn_report("@blk/-i migrate option is deprecated, set the "
+                    "'block' capability to 'true' instead.");
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
-- 
2.41.0


