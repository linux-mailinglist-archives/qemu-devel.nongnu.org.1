Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CDAFE279
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Jul 2025 10:25:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQ78-0001LZ-3J; Wed, 09 Jul 2025 04:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ74-0001Hp-Ji
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1uZQ72-0006Of-I8
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752049507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TEHH5PwPPhiBn0zoqbiFaFLfogPQjxS5hORUtCtU9hk=;
 b=hfBh1JTlFFioMIIODwGcVcCywrU8mpQTtATZ9NNC9Y7iFByQk1mDAHs51zHx7/ZSYuS8tH
 VUUpSgjad+Q8Nwnrf8RFjA07sN0MbXwBNcAxDJaRVWWBmRQm4V+ChIs7QVS959y4krr8r8
 JQCE/PYs9viT9/6h5faZThgvMAJgojE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-XtG0veujNU2XhuRW5ixjag-1; Wed,
 09 Jul 2025 04:25:06 -0400
X-MC-Unique: XtG0veujNU2XhuRW5ixjag-1
X-Mimecast-MFC-AGG-ID: XtG0veujNU2XhuRW5ixjag_1752049505
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FA491955F38; Wed,  9 Jul 2025 08:25:05 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.147])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AFC9195608F; Wed,  9 Jul 2025 08:25:01 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH v4 07/11] net: Add save_acked_features callback to vhost_net
Date: Wed,  9 Jul 2025 10:24:21 +0200
Message-ID: <20250709082425.601990-8-lvivier@redhat.com>
In-Reply-To: <20250709082425.601990-1-lvivier@redhat.com>
References: <20250709082425.601990-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

This commit introduces a save_acked_features function pointer to
vhost_net and converts the vhost_net function into a generic dispatcher.

The vhost-user backend provides the callback, making its function static.
With this change, no other module has a direct dependency on the
vhost-user implementation.

This cleanup allows for the complete removal of the net/vhost-user.h
header file.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/net/vhost_net-stub.c   |  1 -
 hw/net/vhost_net.c        | 10 +++++-----
 include/hw/virtio/vhost.h |  2 ++
 include/net/vhost-user.h  | 16 ----------------
 include/net/vhost_net.h   |  2 ++
 net/tap.c                 |  1 +
 net/vhost-user-stub.c     |  1 -
 net/vhost-user.c          |  4 ++--
 net/vhost-vdpa.c          |  1 +
 9 files changed, 13 insertions(+), 25 deletions(-)
 delete mode 100644 include/net/vhost-user.h

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index 7bed0bf92b8e..7d49f82906a9 100644
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
index fb169af0e81b..976d2b315a2f 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -16,7 +16,6 @@
 #include "qemu/osdep.h"
 #include "net/net.h"
 #include "net/tap.h"
-#include "net/vhost-user.h"
 #include "net/vhost-vdpa.h"
 
 #include "standard-headers/linux/vhost_types.h"
@@ -70,11 +69,11 @@ uint64_t vhost_net_get_acked_features(VHostNetState *net)
 
 void vhost_net_save_acked_features(NetClientState *nc)
 {
-#ifdef CONFIG_VHOST_NET_USER
-    if (nc->info->type == NET_CLIENT_DRIVER_VHOST_USER) {
-        vhost_user_save_acked_features(nc);
+    struct vhost_net *net = get_vhost_net(nc);
+
+    if (net && net->save_acked_features) {
+        net->save_acked_features(nc);
     }
-#endif
 }
 
 static void vhost_net_disable_notifiers_nvhosts(VirtIODevice *dev,
@@ -245,6 +244,7 @@ struct vhost_net *vhost_net_init(VhostNetOptions *options)
     net->nc = options->net_backend;
     net->dev.nvqs = options->nvqs;
     net->feature_bits = options->feature_bits;
+    net->save_acked_features = options->save_acked_features;
 
     net->dev.max_queues = 1;
     net->dev.vqs = net->vqs;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 6a75fdc0213c..b0830bac798a 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -1,6 +1,7 @@
 #ifndef VHOST_H
 #define VHOST_H
 
+#include "net/vhost_net.h"
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/virtio.h"
 #include "system/memory.h"
@@ -144,6 +145,7 @@ struct vhost_net {
     struct vhost_virtqueue vqs[2];
     int backend;
     const int *feature_bits;
+    SaveAcketFeatures *save_acked_features;
     NetClientState *nc;
 };
 
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
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index a8d281c8f7c2..eb26ed9bdcbf 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -8,6 +8,7 @@ struct vhost_net;
 typedef struct vhost_net VHostNetState;
 
 typedef uint64_t (GetAckedFeatures)(NetClientState *nc);
+typedef void (SaveAcketFeatures)(NetClientState *nc);
 
 typedef struct VhostNetOptions {
     VhostBackendType backend_type;
@@ -16,6 +17,7 @@ typedef struct VhostNetOptions {
     unsigned int nvqs;
     const int *feature_bits;
     GetAckedFeatures *get_acked_features;
+    SaveAcketFeatures *save_acked_features;
     void *opaque;
 } VhostNetOptions;
 
diff --git a/net/tap.c b/net/tap.c
index acd77f816fec..79fa02a65c91 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -745,6 +745,7 @@ static void net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         options.nvqs = 2;
         options.feature_bits = kernel_feature_bits;
         options.get_acked_features = NULL;
+        options.save_acked_features = NULL;
 
         s->vhost_net = vhost_net_init(&options);
         if (!s->vhost_net) {
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
index 93b413b49f34..8a3df27b02cf 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -11,7 +11,6 @@
 #include "qemu/osdep.h"
 #include "clients.h"
 #include "net/vhost_net.h"
-#include "net/vhost-user.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
 #include "standard-headers/linux/virtio_net.h"
@@ -88,7 +87,7 @@ static uint64_t vhost_user_get_acked_features(NetClientState *nc)
     return s->acked_features;
 }
 
-void vhost_user_save_acked_features(NetClientState *nc)
+static void vhost_user_save_acked_features(NetClientState *nc)
 {
     NetVhostUserState *s;
 
@@ -140,6 +139,7 @@ static int vhost_user_start(int queues, NetClientState *ncs[],
         options.nvqs = 2;
         options.feature_bits = user_feature_bits;
         options.get_acked_features = vhost_user_get_acked_features;
+        options.save_acked_features = vhost_user_save_acked_features;
 
         net = vhost_net_init(&options);
         if (!net) {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index a3980d1fb5ed..c63225d3d2ed 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -203,6 +203,7 @@ static int vhost_vdpa_add(NetClientState *ncs, void *be,
     options.nvqs = nvqs;
     options.feature_bits = vdpa_feature_bits;
     options.get_acked_features = NULL;
+    options.save_acked_features = NULL;
 
     net = vhost_net_init(&options);
     if (!net) {
-- 
2.49.0


