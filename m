Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC45872B550
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 04:16:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8X4l-0002pk-UU; Sun, 11 Jun 2023 22:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1q8X4i-0002pb-Bx
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 22:14:32 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhukeqian1@huawei.com>)
 id 1q8X4e-0000Tg-Rf
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 22:14:31 -0400
Received: from kwepemi500026.china.huawei.com (unknown [172.30.72.57])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QfZqx1vKkz18LwY;
 Mon, 12 Jun 2023 10:09:17 +0800 (CST)
Received: from DESKTOP-5IS4806.china.huawei.com (10.174.187.224) by
 kwepemi500026.china.huawei.com (7.221.188.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 10:14:10 +0800
To: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
CC: <limingwang@huawei.com>, <zhaoyimin1@huawei.com>, <wubinfeng@huawei.com>, 
 <skorodumov.dmitry@huawei.com>, <wanghaibin.wang@huawei.com>, Keqian Zhu
 <zhukeqian1@huawei.com>
Subject: [PATCH] virtio-gpu: Optimize 2D resource data transfer
Date: Mon, 12 Jun 2023 10:13:58 +0800
Message-ID: <20230612021358.25068-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.224]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500026.china.huawei.com (7.221.188.247)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=zhukeqian1@huawei.com; helo=szxga08-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Reply-to:  Keqian Zhu <zhukeqian1@huawei.com>
From:  Keqian Zhu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

The following points sometimes can reduce much data
to copy:
1. When width matches, we can transfer data with one
call of iov_to_buf().
2. Only the required height need to transfer, not
whole image.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
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
2.20.1


