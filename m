Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A98CD7063D1
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:16:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzDCn-0003WE-QX; Wed, 17 May 2023 05:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC5-0001UI-Ss; Wed, 17 May 2023 05:11:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzDC3-0006VL-T5; Wed, 17 May 2023 05:11:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60D856844;
 Wed, 17 May 2023 12:10:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C2E415F15;
 Wed, 17 May 2023 12:10:46 +0300 (MSK)
Received: (nullmailer pid 3626757 invoked by uid 1000);
 Wed, 17 May 2023 09:10:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v7.2.3 30/30] Revert "vhost-user: Introduce nested event loop
 in vhost_user_read()"
Date: Wed, 17 May 2023 12:10:42 +0300
Message-Id: <20230517091042.3626593-30-mjt@msgid.tls.msk.ru>
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

This reverts commit a7f523c7d114d445c5d83aecdba3efc038e5a692.

The nested event loop is broken by design. It's only user was removed.
Drop the code as well so that nobody ever tries to use it again.

I had to fix a couple of trivial conflicts around return values because
of 025faa872bcf ("vhost-user: stick to -errno error return convention").

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
(cherry picked from commit 4382138f642f69fdbc79ebf4e93d84be8061191f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/virtio/vhost-user.c | 65 ++++--------------------------------------
 1 file changed, 5 insertions(+), 60 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index d95f24ed24..d92b026e1c 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -305,19 +305,8 @@ static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *msg)
     return 0;
 }
 
-struct vhost_user_read_cb_data {
-    struct vhost_dev *dev;
-    VhostUserMsg *msg;
-    GMainLoop *loop;
-    int ret;
-};
-
-static gboolean vhost_user_read_cb(void *do_not_use, GIOCondition condition,
-                                   gpointer opaque)
+static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
-    struct vhost_user_read_cb_data *data = opaque;
-    struct vhost_dev *dev = data->dev;
-    VhostUserMsg *msg = data->msg;
     struct vhost_user *u = dev->opaque;
     CharBackend *chr = u->user->chr;
     uint8_t *p = (uint8_t *) msg;
@@ -325,8 +314,7 @@ static gboolean vhost_user_read_cb(void *do_not_use, GIOCondition condition,
 
     r = vhost_user_read_header(dev, msg);
     if (r < 0) {
-        data->ret = r;
-        goto end;
+        return r;
     }
 
     /* validate message size is sane */
@@ -334,8 +322,7 @@ static gboolean vhost_user_read_cb(void *do_not_use, GIOCondition condition,
         error_report("Failed to read msg header."
                 " Size %d exceeds the maximum %zu.", msg->hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
-        data->ret = -EPROTO;
-        goto end;
+        return -EPROTO;
     }
 
     if (msg->hdr.size) {
@@ -346,53 +333,11 @@ static gboolean vhost_user_read_cb(void *do_not_use, GIOCondition condition,
             int saved_errno = errno;
             error_report("Failed to read msg payload."
                          " Read %d instead of %d.", r, msg->hdr.size);
-            data->ret = r < 0 ? -saved_errno : -EIO;
-            goto end;
+            return r < 0 ? -saved_errno : -EIO;
         }
     }
 
-end:
-    g_main_loop_quit(data->loop);
-    return G_SOURCE_REMOVE;
-}
-
-static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
-{
-    struct vhost_user *u = dev->opaque;
-    CharBackend *chr = u->user->chr;
-    GMainContext *prev_ctxt = chr->chr->gcontext;
-    GMainContext *ctxt = g_main_context_new();
-    GMainLoop *loop = g_main_loop_new(ctxt, FALSE);
-    struct vhost_user_read_cb_data data = {
-        .dev = dev,
-        .loop = loop,
-        .msg = msg,
-        .ret = 0
-    };
-
-    /*
-     * We want to be able to monitor the slave channel fd while waiting
-     * for chr I/O. This requires an event loop, but we can't nest the
-     * one to which chr is currently attached : its fd handlers might not
-     * be prepared for re-entrancy. So we create a new one and switch chr
-     * to use it.
-     */
-    qemu_chr_be_update_read_handlers(chr->chr, ctxt);
-    qemu_chr_fe_add_watch(chr, G_IO_IN | G_IO_HUP, vhost_user_read_cb, &data);
-
-    g_main_loop_run(loop);
-
-    /*
-     * Restore the previous event loop context. This also destroys/recreates
-     * event sources : this guarantees that all pending events in the original
-     * context that have been processed by the nested loop are purged.
-     */
-    qemu_chr_be_update_read_handlers(chr->chr, prev_ctxt);
-
-    g_main_loop_unref(loop);
-    g_main_context_unref(ctxt);
-
-    return data.ret;
+    return 0;
 }
 
 static int process_message_reply(struct vhost_dev *dev,
-- 
2.39.2


