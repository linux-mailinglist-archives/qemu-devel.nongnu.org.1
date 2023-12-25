Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D91681DF0B
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 09:11:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHg3B-00086t-Ce; Mon, 25 Dec 2023 03:11:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2f-0007iz-69; Mon, 25 Dec 2023 03:10:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rHg2d-0008Lf-KS; Mon, 25 Dec 2023 03:10:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A4EA43E96B;
 Mon, 25 Dec 2023 11:10:32 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 652B853012;
 Mon, 25 Dec 2023 11:10:08 +0300 (MSK)
Received: (nullmailer pid 78192 invoked by uid 1000);
 Mon, 25 Dec 2023 08:10:07 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 7/7] virtio-blk: Fix potential nullpointer read access in
 virtio_blk_data_plane_destroy
Date: Mon, 25 Dec 2023 11:10:07 +0300
Message-Id: <20231225081007.78141-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231225081007.78141-1-mjt@tls.msk.ru>
References: <20231225081007.78141-1-mjt@tls.msk.ru>
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

Fixes: CID 1532828
Fixes: b6948ab01d ("virtio-blk: add iothread-vq-mapping parameter")
Signed-off-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/block/dataplane/virtio-blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 6debd4401e..97a302cf49 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -152,7 +152,7 @@ bool virtio_blk_data_plane_create(VirtIODevice *vdev, VirtIOBlkConf *conf,
 void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
 {
     VirtIOBlock *vblk;
-    VirtIOBlkConf *conf = s->conf;
+    VirtIOBlkConf *conf;
 
     if (!s) {
         return;
@@ -160,6 +160,7 @@ void virtio_blk_data_plane_destroy(VirtIOBlockDataPlane *s)
 
     vblk = VIRTIO_BLK(s->vdev);
     assert(!vblk->dataplane_started);
+    conf = s->conf;
 
     if (conf->iothread_vq_mapping_list) {
         IOThreadVirtQueueMappingList *node;
-- 
2.39.2


