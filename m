Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A407568FA
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:22:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQyu-0002ZM-5f; Mon, 17 Jul 2023 12:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLQyj-0002JA-IR
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qLQyg-0008MJ-59
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689610897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pfxMAgQSsYnpHAASTrWoEi4WGzS35lvo4o0nj+hUXeQ=;
 b=busdq0K4yHo55s+ynYnHc5OJrONNLsS+koLeGrc1KygSiNjLBzoku7uBVKngYQZV1jvCnk
 es167BmropTJ7fJNWNuJHCanZql2TgS3dg6w9y1Fi83CJXFhtoWNXVlQ16xgLDRXsg1nY6
 73DFkEu/EifOlGb5fSnR8uQsBtlmlbg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-PXwDPZi7P6q6LoF9fGwJCQ-1; Mon, 17 Jul 2023 12:21:33 -0400
X-MC-Unique: PXwDPZi7P6q6LoF9fGwJCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1C92857FD3;
 Mon, 17 Jul 2023 16:21:32 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.192.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 10A371454142;
 Mon, 17 Jul 2023 16:21:29 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, jean-philippe@linaro.org
Cc: qemu-stable@nongnu.org,
	mcascell@redhat.com,
	taoym@zju.edu.cn
Subject: [PATCH for-8.1 v2] hw/virtio-iommu: Fix potential OOB access in
 virtio_iommu_handle_command()
Date: Mon, 17 Jul 2023 18:21:26 +0200
Message-Id: <20230717162126.11693-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org

---
- added the Cc: qemu-stable@nongnu.org and copied 2 persons involved
  in the reporting loop
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


