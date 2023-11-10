Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 967427E799B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 07:53:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1LN3-0008KZ-SU; Fri, 10 Nov 2023 01:52:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1r1LMz-0008KB-QI
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 01:51:57 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wubinfeng@huawei.com>)
 id 1r1LMx-0008L0-Bu
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 01:51:57 -0500
Received: from kwepemm000016.china.huawei.com (unknown [172.30.72.53])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SRTxy5wkTzhZFT;
 Fri, 10 Nov 2023 14:51:34 +0800 (CST)
Received: from [10.174.187.88] (10.174.187.88) by
 kwepemm000016.china.huawei.com (7.193.23.210) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 10 Nov 2023 14:51:45 +0800
Subject: Re: [PATCH] Fix segmentation fault when VM shutdown with virtio-gpu
 unplugged
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231110043916.1116-1-wubinfeng@huawei.com>
 <20231110003905-mutt-send-email-mst@kernel.org>
CC: <kraxel@redhat.com>, <qemu-devel@nongnu.org>, <wangmeiling21@huawei.com>
Message-ID: <7fd5016a-cbe6-064e-e926-351b1da66642@huawei.com>
Date: Fri, 10 Nov 2023 14:51:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20231110003905-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="gbk"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.187.88]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000016.china.huawei.com (7.193.23.210)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187; envelope-from=wubinfeng@huawei.com;
 helo=szxga01-in.huawei.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.265, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-to:  Binfeng Wu <wubinfeng@huawei.com>
From:  Binfeng Wu via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Sorry for this mistake. Please check now.
Please let us know if we need resubmit it.

From e798cf68b1a4043dcf8dda9b895812c1dab88da2 Mon Sep 17 00:00:00 2001
From: wangmeiling <wangmeiling21@huawei.com>
Date: Fri, 10 Nov 2023 10:17:54 +0800
Subject: [PATCH] Fix segmentation fault when VM shutdown with virtio-gpu
 unplugged

In the virtio-gpu unrealize process, the vdev structure has been cleaned up.
However, vm_change_state_handler is not cleaned up yet, which is related to
vdev. This handler will be cleaned up when VM shutdown, but the vdev is
already a null pointer at this time, this will lead to segmentation fault.

Signed-off-by: wangmeiling <wangmeiling21@huawei.com>
Signed-off-by: wubinfeng <wubinfeng@huawei.com>
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


ÔÚ 2023/11/10 13:40, Michael S. Tsirkin Ð´µÀ:
> On Fri, Nov 10, 2023 at 12:39:16PM +0800, Binfeng Wu wrote:
>> From: wangmeiling <wangmeiling21@huawei.com>
>>
>> In the virtio-gpu unrealize process, the vdev structure has been cleaned up.
>> However, vm_change_state_handler is not cleaned up yet, which is related to
>> vdev. This handler will be cleaned up when VM shutdown, but the vdev is
>> already a null pointer at this time, this will lead to segmentation fault.
>>
>> Signed-off-by: wangmeiling21@huawei.com
>> Signed-off-by: wubinfeng@huawei.com
> 
> You need to add your real names, not just email.
> 
> With that:
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
>> ---
>>  hw/display/virtio-gpu-base.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
>> index 37af256219..b31b8d683f 100644
>> --- a/hw/display/virtio-gpu-base.c
>> +++ b/hw/display/virtio-gpu-base.c
>> @@ -252,6 +252,8 @@ virtio_gpu_base_device_unrealize(DeviceState *qdev)
>>  {
>>      VirtIOGPUBase *g = VIRTIO_GPU_BASE(qdev);
>>  
>> +    virtio_cleanup(VIRTIO_DEVICE(g));
>> +
>>      migrate_del_blocker(&g->migration_blocker);
>>  }
>>  
>> -- 
>> 2.20.1
> 
> 
> .
> 

