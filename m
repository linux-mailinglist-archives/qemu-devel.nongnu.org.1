Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AA86A7FA
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 06:22:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCK2-0002pW-VN; Wed, 28 Feb 2024 00:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJR-0001SS-7O
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCJP-0007c3-87
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yruyBw49zJ5tVwVlBKVbE1Lx8R7iKPKHx4phAx9r0jE=;
 b=EQqEMIZWdxwogw8PWjjGwV/fYPxVxZKiF6Jjz8nNQqil6ohsWojDSKEg/rJRuyfH30YjHG
 3emTo63m/LfqamJh0YTwHVW3ZhOUtvl5iaAwbQfUz5nCC9amxzEQR40H8OyWlCehtVjA+N
 k7EOjyxhF/JH5UaxRUqJzP1m0M0RrlI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-L20Dph42MiuM3VHlBC4gcw-1; Wed,
 28 Feb 2024 00:16:55 -0500
X-MC-Unique: L20Dph42MiuM3VHlBC4gcw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A606B38212D8;
 Wed, 28 Feb 2024 05:16:54 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E81C81C060B1;
 Wed, 28 Feb 2024 05:16:45 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PULL 22/25] migration: options incompatible with cpr
Date: Wed, 28 Feb 2024 13:13:12 +0800
Message-ID: <20240228051315.400759-23-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Fail the migration request if options are set that are incompatible
with cpr.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-15-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qapi/migration.json   |  2 ++
 migration/migration.c | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/qapi/migration.json b/qapi/migration.json
index bee5e71fe3..0b33a71ab4 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -657,6 +657,8 @@
 #     shared backend must be be non-volatile across reboot, such as by backing
 #     it with a dax device.
 #
+#     cpr-reboot may not be used with postcopy, colo, or background-snapshot.
+#
 #     (since 8.2)
 ##
 { 'enum': 'MigMode',
diff --git a/migration/migration.c b/migration/migration.c
index 90a90947fb..7652fd4d14 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1953,6 +1953,23 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
         return false;
     }
 
+    if (migrate_mode_is_cpr(s)) {
+        const char *conflict = NULL;
+
+        if (migrate_postcopy()) {
+            conflict = "postcopy";
+        } else if (migrate_background_snapshot()) {
+            conflict = "background snapshot";
+        } else if (migrate_colo()) {
+            conflict = "COLO";
+        }
+
+        if (conflict) {
+            error_setg(errp, "Cannot use %s with CPR", conflict);
+            return false;
+        }
+    }
+
     if (blk || blk_inc) {
         if (migrate_colo()) {
             error_setg(errp, "No disk migration is required in COLO mode");
-- 
2.43.0


