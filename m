Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFCB7B05EF
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 16:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlV4k-0005Wp-L8; Wed, 27 Sep 2023 09:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlV4f-0005SN-W9
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:59:34 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets@ovn.org>)
 id 1qlV4e-0007Bj-Ku
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 09:59:33 -0400
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2821DC0008;
 Wed, 27 Sep 2023 13:59:29 +0000 (UTC)
From: Ilya Maximets <i.maximets@ovn.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH v2 1/2] virtio: remove unnecessary thread fence while reading
 next descriptor
Date: Wed, 27 Sep 2023 15:59:41 +0200
Message-ID: <20230927140016.2317404-2-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230927140016.2317404-1-i.maximets@ovn.org>
References: <20230927140016.2317404-1-i.maximets@ovn.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
Received-SPF: pass client-ip=217.70.183.198; envelope-from=i.maximets@ovn.org;
 helo=relay6-d.mail.gandi.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It was supposed to be a compiler barrier and it was a compiler barrier
initially called 'wmb' when virtio core support was introduced.
Later all the instances of 'wmb' were switched to smp_wmb to fix memory
ordering issues on non-x86 platforms.  However, this one doesn't need
to be an actual barrier, as its only purpose was to ensure that the
value is not read twice.

And since commit aa570d6fb6bd ("virtio: combine the read of a descriptor")
there is no need for a barrier at all, since we're no longer reading
guest memory here, but accessing a local structure.

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---
 hw/virtio/virtio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 4577f3f5b3..37584aaa74 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -1050,8 +1050,6 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
 
     /* Check they're not leading us off end of descriptors. */
     *next = desc->next;
-    /* Make sure compiler knows to grab that: we don't want it changing! */
-    smp_wmb();
 
     if (*next >= max) {
         virtio_error(vdev, "Desc next is %u", *next);
-- 
2.41.0


