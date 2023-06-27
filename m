Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B185373FC58
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 15:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE8Lg-0008TS-Qz; Tue, 27 Jun 2023 09:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8Le-0008SH-80
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qE8La-00073F-2R
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 09:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687870985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jLIMFL3RGpvTWWJghQtYs7EfwwGgWZRaOc2yyn4IxPk=;
 b=QO07qHBaqYAoSRxWs+VNGTogYU6o0Zp9makaazDtZ2gnSzj1rUuJnQMtsVcQymqJrNyWdX
 ayi9TdKd63me3kT8TGFQrlvEvVs+bw5Fg8qSTJ1aaJD65/3XrDJ5ccnyONF+xT1fZuC2Wg
 9w1alRo5bXeweLhEORN6MFnXyDvqpiY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-T1BpxG_tPRKj1ldia3eEow-1; Tue, 27 Jun 2023 09:03:00 -0400
X-MC-Unique: T1BpxG_tPRKj1ldia3eEow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7528A83DCC2;
 Tue, 27 Jun 2023 13:02:41 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E56E0200A3AD;
 Tue, 27 Jun 2023 13:02:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Keqian Zhu <zhukeqian1@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 04/33] virtio-gpu: Optimize 2D resource data transfer
Date: Tue, 27 Jun 2023 15:02:01 +0200
Message-ID: <20230627130231.1614896-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Keqian Zhu via <qemu-devel@nongnu.org>

The following points sometimes can reduce much data
to copy:
1. When width matches, we can transfer data with one
call of iov_to_buf().
2. Only the required height need to transfer, not
whole image.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20230612021358.25068-1-zhukeqian1@huawei.com>
---
 hw/display/virtio-gpu.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index 66cddd94d9..af31018ab0 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -438,11 +438,11 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
                                            struct virtio_gpu_ctrl_command *cmd)
 {
     struct virtio_gpu_simple_resource *res;
-    int h;
+    int h, bpp;
     uint32_t src_offset, dst_offset, stride;
-    int bpp;
     pixman_format_code_t format;
     struct virtio_gpu_transfer_to_host_2d t2d;
+    void *img_data;
 
     VIRTIO_GPU_FILL_CMD(t2d);
     virtio_gpu_t2d_bswap(&t2d);
@@ -471,23 +471,23 @@ static void virtio_gpu_transfer_to_host_2d(VirtIOGPU *g,
     format = pixman_image_get_format(res->image);
     bpp = DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
     stride = pixman_image_get_stride(res->image);
+    img_data = pixman_image_get_data(res->image);
 
-    if (t2d.offset || t2d.r.x || t2d.r.y ||
-        t2d.r.width != pixman_image_get_width(res->image)) {
-        void *img_data = pixman_image_get_data(res->image);
+    if (t2d.r.x || t2d.r.width != pixman_image_get_width(res->image)) {
         for (h = 0; h < t2d.r.height; h++) {
             src_offset = t2d.offset + stride * h;
             dst_offset = (t2d.r.y + h) * stride + (t2d.r.x * bpp);
 
             iov_to_buf(res->iov, res->iov_cnt, src_offset,
-                       (uint8_t *)img_data
-                       + dst_offset, t2d.r.width * bpp);
+                       (uint8_t *)img_data + dst_offset,
+                       t2d.r.width * bpp);
         }
     } else {
-        iov_to_buf(res->iov, res->iov_cnt, 0,
-                   pixman_image_get_data(res->image),
-                   pixman_image_get_stride(res->image)
-                   * pixman_image_get_height(res->image));
+        src_offset = t2d.offset;
+        dst_offset = t2d.r.y * stride + t2d.r.x * bpp;
+        iov_to_buf(res->iov, res->iov_cnt, src_offset,
+                   (uint8_t *)img_data + dst_offset,
+                   stride * t2d.r.height);
     }
 }
 
-- 
2.41.0


