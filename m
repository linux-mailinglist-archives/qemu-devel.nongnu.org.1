Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4AEADE5E3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Jun 2025 10:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRoMT-0005rU-O7; Wed, 18 Jun 2025 04:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoMJ-0005o6-LW
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uRoM8-0002cQ-7b
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 04:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750236075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6+zu2UnX7p4TL7GhSRcCRTo2xWwrAFDUKE6pr4935U=;
 b=LeE8e42T8A4qQdW331GcStF2UkchpSL0XcKR0tqf9C8Bh2TcujJc3PB028plk/F23kPtj9
 du54yVy4P9NI3J27GhQCn1UXRb765iiOkys1biIw2RD3ppFbOlRpzLCWZ1h2gHJBJE3v2B
 GepRCPLJUcRf4XQpj5cNeNvJUxuHJYY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-ufZc1lHnP-u1updQuYY5Hg-1; Wed,
 18 Jun 2025 04:40:06 -0400
X-MC-Unique: ufZc1lHnP-u1updQuYY5Hg-1
X-Mimecast-MFC-AGG-ID: ufZc1lHnP-u1updQuYY5Hg_1750236005
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BA1318089B4; Wed, 18 Jun 2025 08:40:05 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.44.33.123])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E326B19560A3; Wed, 18 Jun 2025 08:40:00 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 6/8] net: Add save_acked_features callback to NetClientInfo
Date: Wed, 18 Jun 2025 10:39:28 +0200
Message-ID: <20250618083930.451313-7-lvivier@redhat.com>
In-Reply-To: <20250618083930.451313-1-lvivier@redhat.com>
References: <20250618083930.451313-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch completes the series of refactorings aimed at decoupling the
generic vhost layer from specific network backends.

The final remaining dependency was in vhost_net_save_acked_features,
which contained a hardcoded check for the vhost-user client type.

This commit applies the now-established callback pattern, introducing a
save_acked_features function pointer to NetClientInfo and
converting the vhost_net function into a generic dispatcher.

The vhost-user backend provides the callback, making its function static.
With this change, no other module has a direct dependency on the
vhost-user implementation.

This cleanup allows for the complete removal of the net/vhost-user.h
header file.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c  |  1 -
 hw/net/vhost_net.c       |  7 ++-----
 include/net/net.h        |  2 ++
 include/net/vhost-user.h | 16 ----------------
 net/vhost-user-stub.c    |  1 -
 net/vhost-user.c         |  4 ++--
 6 files changed, 6 insertions(+), 25 deletions(-)
 delete mode 100644 include/net/vhost-user.h

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 72df6d757e4d..dab9943172da 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -13,7 +13,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 4ed28a6d4186..756af26db207 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 #include "net/vhost-vdpa.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -152,11 +151,9 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net)
 
 void vhost_net_save_acked_features(NetClientState *nc)
 {
-#ifdef CONFIG_VHOST_NET_USER
-    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_user_save_acked_features(nc);
+    if (nc->info->save_acked_features) {
+        nc->info->save_acked_features(nc);
     }
-#endif
 }
 
 static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
diff --git a/include/net/net.h b/include/net/net.h
index ed9febd378b6..5ef86cd6c384 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -70,6 +70,7 @@ typedef bool (NetCheckPeerType)(NetClientState *, ObjectClass *, Error **);
 typedef bool (IsVHostUser)(NetClientState *);
 typedef struct vhost_net *(GetVHostNet)(NetClientState *nc);
 typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
+typedef void (SaveAcketFeatures)(NetClientState *nc);
 
 typedef struct NetClientInfo {
     NetClientDriver type;
@@ -98,6 +99,7 @@ typedef struct NetClientInfo {
     IsVHostUser *is_vhost_user;
     GetVHostNet *get_vhost_net;
     GetAckedFeatures *get_acked_features;
+    SaveAcketFeatures *save_acked_features;
 } NetClientInfo;
 
 struct NetClientState {
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
deleted file mode 100644
index a4d0ce4b8dd1..000000000000
--- a/include/net/vhost-user.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/*
- * vhost-user.h
- *
- * Copyright (c) 2013 Virtual Open Systems Sarl.
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#ifndef VHOST_USER_H
-#define VHOST_USER_H
-
-void vhost_user_save_acked_features(NetClientState *nc);
-
-#endif /* VHOST_USER_H */
diff --git a/net/vhost-user-stub.c b/net/vhost-user-stub.c
index 52ab4e13f12a..283dee87db2d 100644
--- a/net/vhost-user-stub.c
+++ b/net/vhost-user-stub.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "net/vhost_net.h"
-#include "net/vhost-user.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 45c952b1e76d..5b9f08163fc5 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "net/vhost_net.h"
-#include "net/vhost-user.h"
 #include "hw/virtio/vhost-user.h"
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
@@ -46,7 +45,7 @@ static uint64_t vhost_user_get_acked_features(NetClientState *nc)
     return s->acked_features;
 }
 
-void vhost_user_save_acked_features(NetClientState *nc)
+static void vhost_user_save_acked_features(NetClientState *nc)
 {
     NetVhostUserState *s;
 
@@ -241,6 +240,7 @@ static NetClientInfo net_vhost_user_info = {
         .is_vhost_user = vhost_user_is_vhost_user,
         .get_vhost_net = vhost_user_get_vhost_net,
         .get_acked_features = vhost_user_get_acked_features,
+        .save_acked_features = vhost_user_save_acked_features,
 };
 
 static gboolean net_vhost_user_watch(void *do_not_use, GIOCondition cond,
-- 
2.49.0


