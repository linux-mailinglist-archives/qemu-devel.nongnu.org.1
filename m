Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F9981297E
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 08:37:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDgGM-0000g4-R2; Thu, 14 Dec 2023 02:36:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1rDgGK-0000fg-Ar
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:36:04 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1rDgGC-0000Hi-Lt
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:36:01 -0500
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SrPJz144xzsS6k;
 Thu, 14 Dec 2023 15:35:31 +0800 (CST)
Received: from kwepemm000016.china.huawei.com (unknown [7.193.23.210])
 by mail.maildlp.com (Postfix) with ESMTPS id 287C01404F2;
 Thu, 14 Dec 2023 15:35:40 +0800 (CST)
Received: from [10.174.187.88] (10.174.187.88) by
 kwepemm000016.china.huawei.com (7.193.23.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 15:35:39 +0800
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <kraxel@redhat.com>, <qemu-devel@nongnu.org>, <wangmeiling21@huawei.com>
Subject: [PATCHv2] Fix segmentation fault when VM shutdown with virtio-gpu
 unplugged
Message-ID: <7bbbc0f3-2ad9-83ca-b39b-f976d0837daf@huawei.com>
Date: Thu, 14 Dec 2023 15:35:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000016.china.huawei.com (7.193.23.210)
Received-SPF: pass client-ip=45.249.212.187; envelope-from=wubinfeng@huawei.com;
 helo=szxga01-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Binfeng Wu <wubinfeng@huawei.com>
From:  Binfeng Wu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From 366ba4e21d8a11728957ccdcf974317e84fac140 Mon Sep 17 00:00:00 2001
From: wangmeiling <wangmeiling21@huawei.com>
Date: Thu, 14 Dec 2023 07:22:08 +0000
Subject: [PATCH] Fix bugs when VM shutdown with virtio-gpu unplugged

Virtio-gpu malloc memory for the queue when it realized, but the queues was not
released when it unrealized, which resulting in a memory leak. In addition,
vm_change_state_handler is not cleaned up, which is related to vdev and will
lead to segmentation fault when VM shutdown.

Signed-off-by: wangmeiling <wangmeiling21@huawei.com>
Signed-off-by: Binfeng Wu <wubinfeng@huawei.com>
---
V1->V2:
- fix memory leak
- add Signed-off-by tag

 hw/display/virtio-gpu-base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 37af256219..4fc7ef8896 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -251,7 +251,11 @@ void
 virtio_gpu_base_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
+    VirtIODevice *vdev = VIRTIO_DEVICE(qdev);

+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
+    virtio_cleanup(vdev);
     migrate_del_blocker(&g->migration_blocker);
 }

-- 
2.27.0


