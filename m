Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F886A7F8
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 06:22:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCJ7-0000Yy-PA; Wed, 28 Feb 2024 00:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHt-0008Re-1T
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCHq-0006tv-49
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WmBFm2fHdY4EPa57HeU0g1kLg5q4DnLUdY/1J2BYCE=;
 b=PbxEInpzh8pRXvWTwSwN84Ztl/XVsRuOOlnSDbpfhVizDio0JV2gv3pjXgBtxIMuaNXZp9
 mbRDdKV0yHLL5VLM2IMid9d7g1R9c1yvNb9c9uxuLAp7jEW1O+LG1EphF7n9ohuVnTFZaH
 m7CgRqY5ZsTmM4I7XG/KqpIWaXAmtNs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-Ui_mVdT7PM2OA9tdUHblrA-1; Wed, 28 Feb 2024 00:15:17 -0500
X-MC-Unique: Ui_mVdT7PM2OA9tdUHblrA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605C7185A787;
 Wed, 28 Feb 2024 05:15:17 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A6911C060AF;
 Wed, 28 Feb 2024 05:15:08 +0000 (UTC)
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
Subject: [PULL 12/25] migration: remove error from notifier data
Date: Wed, 28 Feb 2024 13:13:02 +0800
Message-ID: <20240228051315.400759-13-peterx@redhat.com>
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

Remove the error object from opaque data passed to notifiers.
Use the new error parameter passed to the notifier instead.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/1708622920-68779-3-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 1 -
 migration/postcopy-ram.h | 1 -
 hw/virtio/vhost-user.c   | 8 ++++----
 migration/postcopy-ram.c | 1 -
 migration/ram.c          | 1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 1bc8902e6d..5e65c18f1a 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -31,7 +31,6 @@ typedef enum PrecopyNotifyReason {
 
 typedef struct PrecopyNotifyData {
     enum PrecopyNotifyReason reason;
-    Error **errp;
 } PrecopyNotifyData;
 
 void precopy_infrastructure_init(void);
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index 442ab89752..ecae941211 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -128,7 +128,6 @@ enum PostcopyNotifyReason {
 
 struct PostcopyNotifyData {
     enum PostcopyNotifyReason reason;
-    Error **errp;
 };
 
 void postcopy_add_notifier(NotifierWithReturn *nn);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index f502345f37..a1eea8547e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -2096,20 +2096,20 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
         if (!virtio_has_feature(dev->protocol_features,
                                 VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
             /* TODO: Get the device name into this error somehow */
-            error_setg(pnd->errp,
+            error_setg(errp,
                        "vhost-user backend not capable of postcopy");
             return -ENOENT;
         }
         break;
 
     case POSTCOPY_NOTIFY_INBOUND_ADVISE:
-        return vhost_user_postcopy_advise(dev, pnd->errp);
+        return vhost_user_postcopy_advise(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_LISTEN:
-        return vhost_user_postcopy_listen(dev, pnd->errp);
+        return vhost_user_postcopy_listen(dev, errp);
 
     case POSTCOPY_NOTIFY_INBOUND_END:
-        return vhost_user_postcopy_end(dev, pnd->errp);
+        return vhost_user_postcopy_end(dev, errp);
 
     default:
         /* We ignore notifications we don't know */
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3ab2f6b8fd..0273dc6a94 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -77,7 +77,6 @@ int postcopy_notify(enum PostcopyNotifyReason reason, Error **errp)
 {
     struct PostcopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&postcopy_notifier_list,
                                             &pnd, errp);
diff --git a/migration/ram.c b/migration/ram.c
index 5b6b09edd9..45a00b45ed 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -426,7 +426,6 @@ int precopy_notify(PrecopyNotifyReason reason, Error **errp)
 {
     PrecopyNotifyData pnd;
     pnd.reason = reason;
-    pnd.errp = errp;
 
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd, errp);
 }
-- 
2.43.0


