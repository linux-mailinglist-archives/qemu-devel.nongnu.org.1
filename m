Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B85B770842
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:55:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwr-0002Pe-M6; Fri, 04 Aug 2023 14:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwh-0002P2-IZ; Fri, 04 Aug 2023 14:54:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwg-0008Co-5m; Fri, 04 Aug 2023 14:54:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DF32D18411;
 Fri,  4 Aug 2023 21:54:19 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 719D71B888;
 Fri,  4 Aug 2023 21:53:59 +0300 (MSK)
Received: (nullmailer pid 1874233 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 27/36] hw/virtio-iommu: Fix potential OOB access in
 virtio_iommu_handle_command()
Date: Fri,  4 Aug 2023 21:53:40 +0300
Message-Id: <20230804185350.1874133-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Eric Auger <eric.auger@redhat.com>

In the virtio_iommu_handle_command() when a PROBE request is handled,
output_size takes a value greater than the tail size and on a subsequent
iteration we can get a stack out-of-band access. Initialize the
output_size on each iteration.

The issue was found with ASAN. Credits to:
Yiming Tao(Zhejiang University)
Gaoning Pan(Zhejiang University)

Fixes: 1733eebb9e7 ("virtio-iommu: Implement RESV_MEM probe request")
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Mauro Matteo Cascella <mcascell@redhat.com>
Cc: qemu-stable@nongnu.org

Message-Id: <20230717162126.11693-1-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit cf2f89edf36a59183166ae8721a8d7ab5cd286bd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 62e07ec2e4..eb82462c95 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -727,13 +727,15 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
     VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
     struct virtio_iommu_req_head head;
     struct virtio_iommu_req_tail tail = {};
-    size_t output_size = sizeof(tail), sz;
     VirtQueueElement *elem;
     unsigned int iov_cnt;
     struct iovec *iov;
     void *buf = NULL;
+    size_t sz;
 
     for (;;) {
+        size_t output_size = sizeof(tail);
+
         elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
         if (!elem) {
             return;
-- 
2.39.2


