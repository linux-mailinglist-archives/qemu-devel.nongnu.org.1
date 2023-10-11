Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B837C5584
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZKM-0006db-GD; Wed, 11 Oct 2023 09:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lv.mengzhao@zte.com.cn>)
 id 1qqSUb-0004q1-O8
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:14:51 -0400
Received: from mxhk.zte.com.cn ([63.216.63.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lv.mengzhao@zte.com.cn>)
 id 1qqSUX-0002Ul-0Q
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 02:14:47 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mxhk.zte.com.cn (FangMail) with ESMTPS id 4S52Y36Nqzz8XrRC;
 Wed, 11 Oct 2023 14:14:31 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
 by mse-fl1.zte.com.cn with SMTP id 39B6EOGA027041;
 Wed, 11 Oct 2023 14:14:24 +0800 (+08)
 (envelope-from lv.mengzhao@zte.com.cn)
Received: from mapi (xaxapp01[null]) by mapi (Zmail) with MAPI id mid31;
 Wed, 11 Oct 2023 14:14:26 +0800 (CST)
Date: Wed, 11 Oct 2023 14:14:26 +0800 (CST)
X-Zmail-TransId: 2af965263d422e0-b4a60
X-Mailer: Zmail v1.0
Message-ID: <202310111414266586398@zte.com.cn>
Mime-Version: 1.0
From: <lv.mengzhao@zte.com.cn>
To: <mst@redhat.com>, <stefanha@redhat.com>, <kwolf@redhat.com>,
 <hreitz@redhat.com>
Cc: <hreitz@redhat.com>, <qemu-devel@nongnu.org>, <hu.jian@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB2aXJ0aW8tYmxrOiBkb24ndCBzdGFydCBkYXRhcGxhbmUgZHVyaW5nIHRoZSBzdG9wIG9mIGRhdGFwbGFuZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39B6EOGA027041
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 65263D47.001/4S52Y36Nqzz8XrRC
Received-SPF: pass client-ip=63.216.63.40; envelope-from=lv.mengzhao@zte.com.cn;
 helo=mxhk.zte.com.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:32:02 -0400
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

From: hujian <hu.jian@zte.com.cn>

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

