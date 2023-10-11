Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F37C5588
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZKK-0006cW-IB; Wed, 11 Oct 2023 09:32:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@localhost.localdomain>)
 id 1qqQCT-0000q0-1u; Tue, 10 Oct 2023 23:47:57 -0400
Received: from [223.68.142.242] (helo=localhost.localdomain)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@localhost.localdomain>)
 id 1qqQCQ-0002yx-PL; Tue, 10 Oct 2023 23:47:56 -0400
Received: by localhost.localdomain (Postfix, from userid 0)
 id F0ECF9920EE; Wed, 11 Oct 2023 11:37:41 +0800 (CST)
From: hujian <hu.jian@zte.com.cn>
To: mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com, hreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hujian <hu.jian@zte.com.cn>
Subject: [PATCH] virtio-blk: don't start dataplane during the stop of dataplane
Date: Wed, 11 Oct 2023 11:37:34 +0800
Message-Id: <1696995454-15188-1-git-send-email-hu.jian@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-Host-Lookup-Failed: Reverse DNS lookup failed for 223.68.142.242 (failed)
Received-SPF: none client-ip=223.68.142.242;
 envelope-from=root@localhost.localdomain; helo=localhost.localdomain
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NO_DNS_FOR_FROM=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:31:41 -0400
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

During the stop of dataplane for virtio-blk, virtio_bus_cleanup_host_notifier() is be
called to clean up notifier at the end, if polled ioeventfd, virtio_blk_handle_output()
is used to handle io request. But due to s->dataplane_disabled is false, it will be
returned directly, which drops io request.
Backtrace:
->virtio_blk_data_plane_stop
  ->virtio_bus_cleanup_host_notifier
    ->virtio_queue_host_notifier_read
      ->virtio_queue_notify_vq
        ->vq->handle_output
          ->virtio_blk_handle_output
            ->if (s->dataplane  && !s->dataplane_stoped)
              ->if (!s->dataplane_disabled)
                ->return *
            ->virtio_blk_handle_output_do
The above problem can occur when using "virsh reset" cmdline to reset guest, while
guest does io.
To fix this problem, don't try to start dataplane if s->stopping is true, and io would
be handled by virtio_blk_handle_vq().

Signed-off-by: hujian <hu.jian@zte.com.cn>
---
 hw/block/virtio-blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 39e7f23..c2d5938 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1166,7 +1166,7 @@ static void virtio_blk_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
     VirtIOBlock *s = (VirtIOBlock *)vdev;
 
-    if (s->dataplane && !s->dataplane_started) {
+    if (s->dataplane && !s->dataplane_started && !s->stopping) {
         /* Some guests kick before setting VIRTIO_CONFIG_S_DRIVER_OK so start
          * dataplane here instead of waiting for .set_status().
          */
-- 
1.8.3.1


