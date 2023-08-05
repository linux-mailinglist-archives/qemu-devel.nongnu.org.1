Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13077711DD
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 21:41:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSN9c-0007aC-VH; Sat, 05 Aug 2023 15:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9a-0007Z0-9h; Sat, 05 Aug 2023 15:41:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qSN9Y-0007rZ-M7; Sat, 05 Aug 2023 15:41:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2862A1865E;
 Sat,  5 Aug 2023 22:41:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EF2FA1BA44;
 Sat,  5 Aug 2023 22:41:27 +0300 (MSK)
Received: (nullmailer pid 70352 invoked by uid 1000);
 Sat, 05 Aug 2023 19:41:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hawkins Jiawei <yin31149@gmail.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 65/71] vdpa: Fix possible use-after-free for
 VirtQueueElement
Date: Sat,  5 Aug 2023 22:41:06 +0300
Message-Id: <20230805194127.70304-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230805223954@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Hawkins Jiawei <yin31149@gmail.com>

QEMU uses vhost_handle_guest_kick() to forward guest's available
buffers to the vdpa device in SVQ avail ring.

In vhost_handle_guest_kick(), a `g_autofree` `elem` is used to
iterate through the available VirtQueueElements. This `elem` is
then passed to `svq->ops->avail_handler`, specifically to the
vhost_vdpa_net_handle_ctrl_avail(). If this handler fails to
process the CVQ command, vhost_handle_guest_kick() regains
ownership of the `elem`, and either frees it or requeues it.

Yet the problem is that, vhost_vdpa_net_handle_ctrl_avail()
mistakenly frees the `elem`, even if it fails to forward the
CVQ command to vdpa device. This can result in a use-after-free
for the `elem` in vhost_handle_guest_kick().

This patch solves this problem by refactoring
vhost_vdpa_net_handle_ctrl_avail() to only freeing the `elem` if
it owns it.

Fixes: bd907ae4b0 ("vdpa: manual forward CVQ buffers")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <e3f2d7db477734afe5c6a5ab3fa8b8317514ea34.1688746840.git.yin31149@gmail.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 031b1abacbdb3f4e016b6b926f7e7876c05339bb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 2086a92965..7c2c4fb7ea 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -790,7 +790,16 @@ out:
         error_report("Bad device CVQ written length");
     }
     vhost_svq_push_elem(svq, elem, MIN(in_len, sizeof(status)));
-    g_free(elem);
+    /*
+     * `elem` belongs to vhost_vdpa_net_handle_ctrl_avail() only when
+     * the function successfully forwards the CVQ command, indicated
+     * by a non-negative value of `dev_written`. Otherwise, it still
+     * belongs to SVQ.
+     * This function should only free the `elem` when it owns.
+     */
+    if (dev_written >= 0) {
+        g_free(elem);
+    }
     return dev_written < 0 ? dev_written : 0;
 }
 
-- 
2.39.2


