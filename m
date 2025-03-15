Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D400A62863
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Mar 2025 08:47:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttMDZ-0001FO-Aq; Sat, 15 Mar 2025 03:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMDD-00006A-W4; Sat, 15 Mar 2025 03:45:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ttMDC-0005K6-4e; Sat, 15 Mar 2025 03:45:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 138B9FFB16;
 Sat, 15 Mar 2025 10:41:56 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 01CAE1CACE0;
 Sat, 15 Mar 2025 10:42:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id A999B55A18; Sat, 15 Mar 2025 10:42:49 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.10 34/42] net: move backend cleanup to NIC cleanup
Date: Sat, 15 Mar 2025 10:42:36 +0300
Message-Id: <20250315074249.634718-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
References: <qemu-stable-8.2.10-20250315104136@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Eugenio Pérez <eperezma@redhat.com>

Commit a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net
structures if peer nic is present") effectively delayed the backend
cleanup, allowing the frontend or the guest to access it resources as
long as the frontend is still visible to the guest.

However it does not clean up the resources until the qemu process is
over.  This causes an effective leak if the device is deleted with
device_del, as there is no way to close the vdpa device.  This makes
impossible to re-add that device to this or other QEMU instances until
the first instance of QEMU is finished.

Move the cleanup from qemu_cleanup to the NIC deletion and to
net_cleanup.

Fixes: a0d7215e33 ("vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present")
Reported-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit e7891c575fb294618b172119a91c892b8f4384a2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/net.c b/net/net.c
index 11e19d3bed..40d6a5ca2d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -422,7 +422,13 @@ void qemu_del_net_client(NetClientState *nc)
         object_unparent(OBJECT(nf));
     }
 
-    /* If there is a peer NIC, delete and cleanup client, but do not free. */
+    /*
+     * If there is a peer NIC, transfer ownership to it.  Delete the client
+     * from net_client list but do not cleanup nor free.  This way NIC can
+     * still access to members of the backend.
+     *
+     * The cleanup and free will be done when the NIC is free.
+     */
     if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
         NICState *nic = qemu_get_nic(nc->peer);
         if (nic->peer_deleted) {
@@ -432,16 +438,13 @@ void qemu_del_net_client(NetClientState *nc)
 
         for (i = 0; i < queues; i++) {
             ncs[i]->peer->link_down = true;
+            QTAILQ_REMOVE(&net_clients, ncs[i], next);
         }
 
         if (nc->peer->info->link_status_changed) {
             nc->peer->info->link_status_changed(nc->peer);
         }
 
-        for (i = 0; i < queues; i++) {
-            qemu_cleanup_net_client(ncs[i], true);
-        }
-
         return;
     }
 
@@ -459,8 +462,12 @@ void qemu_del_nic(NICState *nic)
 
     for (i = 0; i < queues; i++) {
         NetClientState *nc = qemu_get_subqueue(nic, i);
-        /* If this is a peer NIC and peer has already been deleted, free it now. */
+        /*
+         * If this is a peer NIC and peer has already been deleted, clean it up
+         * and free it now.
+         */
         if (nic->peer_deleted) {
+            qemu_cleanup_net_client(nc->peer, false);
             qemu_free_net_client(nc->peer);
         } else if (nc->peer) {
             /* if there are RX packets pending, complete them */
@@ -1536,6 +1543,9 @@ void net_cleanup(void)
      * of the latest NET_CLIENT_DRIVER_NIC, and operate on *p as we walk
      * the list.
      *
+     * However, the NIC may have peers that trust to be clean beyond this
+     * point.  For example, if they have been removed with device_del.
+     *
      * The 'nc' variable isn't part of the list traversal; it's purely
      * for convenience as too much '(*p)->' has a tendency to make the
      * readers' eyes bleed.
@@ -1543,6 +1553,17 @@ void net_cleanup(void)
     while (*p) {
         nc = *p;
         if (nc->info->type == NET_CLIENT_DRIVER_NIC) {
+            NICState *nic = qemu_get_nic(nc);
+
+            if (nic->peer_deleted) {
+                int queues = MAX(nic->conf->peers.queues, 1);
+
+                for (int i = 0; i < queues; i++) {
+                    nc = qemu_get_subqueue(nic, i);
+                    qemu_cleanup_net_client(nc->peer, false);
+                }
+            }
+
             /* Skip NET_CLIENT_DRIVER_NIC entries */
             p = &QTAILQ_NEXT(nc, next);
         } else {
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d0614d7954..94b68063e4 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -221,14 +221,6 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
 
-    /*
-     * If a peer NIC is attached, do not cleanup anything.
-     * Cleanup will happen as a part of qemu_cleanup() -> net_cleanup()
-     * when the guest is shutting down.
-     */
-    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_NIC) {
-        return;
-    }
     munmap(s->cvq_cmd_out_buffer, vhost_vdpa_net_cvq_cmd_page_len());
     munmap(s->status, vhost_vdpa_net_cvq_cmd_page_len());
     if (s->vhost_net) {
-- 
2.39.5


