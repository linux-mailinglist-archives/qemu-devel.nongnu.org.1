Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 101117E789D
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 05:41:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1JJG-0007gh-7C; Thu, 09 Nov 2023 23:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1r1JJ9-0007gM-Ri
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:39:51 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1r1JJ7-0007av-2o
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:39:51 -0500
Received: from kwepemm000016.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SRQxr1W1fz1P87X;
 Fri, 10 Nov 2023 12:36:16 +0800 (CST)
Received: from huawei.com (10.174.187.88) by kwepemm000016.china.huawei.com
 (7.193.23.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 10 Nov
 2023 12:39:28 +0800
To: <mst@redhat.com>, <kraxel@redhat.com>
CC: <qemu-devel@nongnu.org>, <wangmeiling21@huawei.com>
Subject: [PATCH] Fix segmentation fault when VM shutdown with virtio-gpu
 unplugged
Date: Fri, 10 Nov 2023 12:39:16 +0800
Message-ID: <20231110043916.1116-1-wubinfeng@huawei.com>
X-Mailer: git-send-email 2.26.2.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.187.88]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm000016.china.huawei.com (7.193.23.210)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255; envelope-from=wubinfeng@huawei.com;
 helo=szxga08-in.huawei.com
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

From: wangmeiling <wangmeiling21@huawei.com>

In the virtio-gpu unrealize process, the vdev structure has been cleaned up.
However, vm_change_state_handler is not cleaned up yet, which is related to
vdev. This handler will be cleaned up when VM shutdown, but the vdev is
already a null pointer at this time, this will lead to segmentation fault.

Signed-off-by: wangmeiling21@huawei.com
Signed-off-by: wubinfeng@huawei.com
---
 hw/display/virtio-gpu-base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 37af256219..b31b8d683f 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -252,6 +252,8 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
 {
     VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
 
+    virtio_cleanup(VIRTIO_DEVICE(g));
+
     migrate_del_blocker(&g->migration_blocker);
 }
 
-- 
2.20.1


