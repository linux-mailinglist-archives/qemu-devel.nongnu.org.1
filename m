Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA94754285
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 20:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKNTN-0007Kc-Pk; Fri, 14 Jul 2023 14:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qKNTM-0007KH-18
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qKNTK-0008FH-IZ
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 14:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689359093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T6MK5YzOYCNol9ozDKibgbWnFnHIfqfo9K9xoth9Ugw=;
 b=AmLNKzILAlL7sIq34FrjhzN4FWuvF1gq6YPlVnkzFAREy9jsh2PUnB7DHj405MoyonwuWt
 6Qc1ocdEYmiy2x8DOAnr5EJA7/8+L03xthLqUMonguEL3LPKwvs9LUeS58XsjzhfkgszIG
 O90WEmB5xJiP1/XdZgpexZwQFrMYXN8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-U47EfWqaOriHxzRXV0q_PA-1; Fri, 14 Jul 2023 14:24:51 -0400
X-MC-Unique: U47EfWqaOriHxzRXV0q_PA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B466B101A54E;
 Fri, 14 Jul 2023 18:24:49 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3CFF7201EE6E;
 Fri, 14 Jul 2023 18:24:48 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH] hw/virtio-iommu: Fix potential OOB access in
 virtio_iommu_handle_command()
Date: Fri, 14 Jul 2023 20:24:45 +0200
Message-Id: <20230714182445.877168-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/virtio/virtio-iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 201127c488..4dcf1d5c62 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -728,13 +728,15 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
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
2.38.1


