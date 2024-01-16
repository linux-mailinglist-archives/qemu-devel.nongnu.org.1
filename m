Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A93282E825
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 04:21:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPZzh-0005f6-0O; Mon, 15 Jan 2024 22:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzf-0005ey-Ke
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPZzd-0002kz-RA
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 22:20:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705375201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlKHHaiILIxucG6Imi52ZHb3N/57FdWmDTOKqL1DEPo=;
 b=Popktlznl5haTKEtH48gTn80iF8vylq7O0PXPVoa4Qut8/qmpAhtb2HwnzCkeRBLoQAKKb
 kvxgIjbhrcYkK5/emRs52jKkoKJ9bTrYCNfjF5hxdRnL7I5lskn/QzAH7NCx8RtrGMXTnQ
 Y8WvcBZR0uYG61Vea3r7Z7nL+wA4adg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-MwkvHsMHP6S82Bs-8Fm2fg-1; Mon, 15 Jan 2024 22:19:56 -0500
X-MC-Unique: MwkvHsMHP6S82Bs-8Fm2fg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F1D685A588;
 Tue, 16 Jan 2024 03:19:56 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E49123C25;
 Tue, 16 Jan 2024 03:19:52 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Het Gala <het.gala@nutanix.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 01/20] migration: Simplify initial conditionals in migration
 for better readability
Date: Tue, 16 Jan 2024 11:19:28 +0800
Message-ID: <20240116031947.69017-2-peterx@redhat.com>
In-Reply-To: <20240116031947.69017-1-peterx@redhat.com>
References: <20240116031947.69017-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Het Gala <het.gala@nutanix.com>

The inital conditional statements in qmp migration functions is harder
to understand than necessary. It is better to get all errors out of
the way in the beginning itself to have better readability and error
handling.

Signed-off-by: Het Gala <het.gala@nutanix.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20231205080039.197615-1-het.gala@nutanix.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 98c5c3e140..2365a3a13c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -523,28 +523,26 @@ static void qemu_start_incoming_migration(const char *uri, bool has_channels,
     /*
      * Having preliminary checks for uri and channel
      */
-    if (uri && has_channels) {
-        error_setg(errp, "'uri' and 'channels' arguments are mutually "
-                   "exclusive; exactly one of the two should be present in "
-                   "'migrate-incoming' qmp command ");
+    if (!uri == !channels) {
+        error_setg(errp, "need either 'uri' or 'channels' argument");
         return;
-    } else if (channels) {
+    }
+
+    if (channels) {
         /* To verify that Migrate channel list has only item */
         if (channels->next) {
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
         addr = channels->value->addr;
-    } else if (uri) {
+    }
+
+    if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
         addr = channel->addr;
-    } else {
-        error_setg(errp, "neither 'uri' or 'channels' argument are "
-                   "specified in 'migrate-incoming' qmp command ");
-        return;
     }
 
     /* transport mechanism not suitable for migration? */
@@ -1924,28 +1922,26 @@ void qmp_migrate(const char *uri, bool has_channels,
     /*
      * Having preliminary checks for uri and channel
      */
-    if (uri && has_channels) {
-        error_setg(errp, "'uri' and 'channels' arguments are mutually "
-                   "exclusive; exactly one of the two should be present in "
-                   "'migrate' qmp command ");
+    if (!uri == !channels) {
+        error_setg(errp, "need either 'uri' or 'channels' argument");
         return;
-    } else if (channels) {
+    }
+
+    if (channels) {
         /* To verify that Migrate channel list has only item */
         if (channels->next) {
             error_setg(errp, "Channel list has more than one entries");
             return;
         }
         addr = channels->value->addr;
-    } else if (uri) {
+    }
+
+    if (uri) {
         /* caller uses the old URI syntax */
         if (!migrate_uri_parse(uri, &channel, errp)) {
             return;
         }
         addr = channel->addr;
-    } else {
-        error_setg(errp, "neither 'uri' or 'channels' argument are "
-                   "specified in 'migrate' qmp command ");
-        return;
     }
 
     /* transport mechanism not suitable for migration? */
-- 
2.43.0


