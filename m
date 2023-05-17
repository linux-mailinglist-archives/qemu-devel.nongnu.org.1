Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A25547063C4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:15:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCr-0003sL-HH; Wed, 17 May 2023 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC7-0001ih-Nu; Wed, 17 May 2023 05:11:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC4-0006VG-Qm; Wed, 17 May 2023 05:11:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 37F3C6843;
 Wed, 17 May 2023 12:10:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A13815F14;
 Wed, 17 May 2023 12:10:46 +0300 (MSK)
Received: (nullmailer pid 3626754 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Yanghang Liu <yanghliu@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v7.2.3 29/30] Revert "vhost-user: Monitor slave channel in
 vhost_user_read()"
Date: Wed, 17 May 2023 12:10:41 +0300
Message-Id: <20230517091042.3626593-29-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
References: <cover.1684310574.git.mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Greg Kurz <groug@kaod.org>

This reverts commit db8a3772e300c1a656331a92da0785d81667dc81.

Motivation : this is breaking vhost-user with DPDK as reported in [0].

Received unexpected msg type. Expected 22 received 40
Fail to update device iotlb
Received unexpected msg type. Expected 40 received 22
Received unexpected msg type. Expected 22 received 11
Fail to update device iotlb
Received unexpected msg type. Expected 11 received 22
vhost VQ 1 ring restore failed: -71: Protocol error (71)
Received unexpected msg type. Expected 22 received 11
Fail to update device iotlb
Received unexpected msg type. Expected 11 received 22
vhost VQ 0 ring restore failed: -71: Protocol error (71)
unable to start vhost net: 71: falling back on userspace virtio

The failing sequence that leads to the first error is :
- QEMU sends a VHOST_USER_GET_STATUS (40) request to DPDK on the master
  socket
- QEMU starts a nested event loop in order to wait for the
  VHOST_USER_GET_STATUS response and to be able to process messages from
  the slave channel
- DPDK sends a couple of legitimate IOTLB miss messages on the slave
  channel
- QEMU processes each IOTLB request and sends VHOST_USER_IOTLB_MSG (22)
  updates on the master socket
- QEMU assumes to receive a response for the latest VHOST_USER_IOTLB_MSG
  but it gets the response for the VHOST_USER_GET_STATUS instead

The subsequent errors have the same root cause : the nested event loop
breaks the order by design. It lures QEMU to expect responses to the
latest message sent on the master socket to arrive first.

Since this was only needed for DAX enablement which is still not merged
upstream, just drop the code for now. A working solution will have to
be merged later on. Likely protect the master socket with a mutex
and service the slave channel with a separate thread, as discussed with
Maxime in the mail thread below.

[0] https://lore.kernel.org/qemu-devel/43145ede-89dc-280e-b953-6a2b436de395@redhat.com/

Reported-by: Yanghang Liu <yanghliu@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2155173
Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
(cherry picked from commit f340a59d5a852d75ae34555723694c7e8eafbd0c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/virtio/vhost-user.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 1fc37f92be..d95f24ed24 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -356,35 +356,6 @@ end:
     return G_SOURCE_REMOVE;
 }
 
-static gboolean slave_read(QIOChannel *ioc, GIOCondition condition,
-                           gpointer opaque);
-
-/*
- * This updates the read handler to use a new event loop context.
- * Event sources are removed from the previous context : this ensures
- * that events detected in the previous context are purged. They will
- * be re-detected and processed in the new context.
- */
-static void slave_update_read_handler(struct vhost_dev *dev,
-                                      GMainContext *ctxt)
-{
-    struct vhost_user *u = dev->opaque;
-
-    if (!u->slave_ioc) {
-        return;
-    }
-
-    if (u->slave_src) {
-        g_source_destroy(u->slave_src);
-        g_source_unref(u->slave_src);
-    }
-
-    u->slave_src = qio_channel_add_watch_source(u->slave_ioc,
-                                                G_IO_IN | G_IO_HUP,
-                                                slave_read, dev, NULL,
-                                                ctxt);
-}
-
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
@@ -406,7 +377,6 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
      * be prepared for re-entrancy. So we create a new one and switch chr
      * to use it.
      */
-    slave_update_read_handler(dev, ctxt);
     qemu_chr_be_update_read_handlers(chr->chr, ctxt);
     qemu_chr_fe_add_watch(chr, G_IO_IN | G_IO_HUP, vhost_user_read_cb, &data);
 
@@ -418,7 +388,6 @@ static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
      * context that have been processed by the nested loop are purged.
      */
     qemu_chr_be_update_read_handlers(chr->chr, prev_ctxt);
-    slave_update_read_handler(dev, NULL);
 
     g_main_loop_unref(loop);
     g_main_context_unref(ctxt);
@@ -1802,7 +1771,9 @@ static int vhost_setup_slave_channel(struct vhost_dev *dev)
         return -ECONNREFUSED;
     }
     u->slave_ioc = ioc;
-    slave_update_read_handler(dev, NULL);
+    u->slave_src = qio_channel_add_watch_source(u->slave_ioc,
+                                                G_IO_IN | G_IO_HUP,
+                                                slave_read, dev, NULL, NULL);
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
-- 
2.39.2


