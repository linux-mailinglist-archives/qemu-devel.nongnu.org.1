Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90F74E5B7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 06:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ4h0-0007qH-7D; Tue, 11 Jul 2023 00:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qJ4gu-0007o6-2l
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:09:32 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qJ4gs-0006Sl-6I
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1689048570; x=1720584570;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=uNTvkCbSqmH/HjgHqOc0EYZhgKEP+Vh5zFgbkakGNao=;
 b=kq7SY2EB0ZrJP+puPA7iojd5GLqDsyNZu1OmxVkBlubjVac8Fg1a3i/1
 mtkk+9IOW0rPaZM0vM6uMrQ0gy6lO9Ond4Ho51eLd+pF8fiozA9Y1HdGd
 hICU/aYgmujztysQk+WqntGxRCrsx9FqXcSP8fMkVXJ+FvopVz76p7oQS
 +xjPMcdOGrr/9U3IIijC6hT1mfOQGWmpEsK0p69mzqL9rfiwH45a2GlAF
 qbZgMPwhFvF44eTNWU2kULu0+spmSHGro0Bd5vt0oNtBhLdNeGvX7V3hJ
 Ukg/RIFA8Iw1r0fYZOCTPwFOjuT02ALDoM/J3uL8sZVzuRtnlkCqBEhnc g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="344838679"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="344838679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2023 21:09:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="750577255"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; d="scan'208";a="750577255"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.210.5])
 ([10.254.210.5])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2023 21:09:24 -0700
Message-ID: <23e1b6fe-2f87-47d3-b66c-71fa30e6421b@intel.com>
Date: Tue, 11 Jul 2023 12:09:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH V2] vhost_vdpa: no need to fetch vring base when poweroff
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org
References: <20230710165333.17506-1-lingshan.zhu@intel.com>
 <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEsNE995Z-TE8wiPc3TwLd3N4Rd+hGMGNfR-d1tFdwOM-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=lingshan.zhu@intel.com; helo=mga17.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 7/11/2023 10:50 AM, Jason Wang wrote:
> On Mon, Jul 10, 2023 at 4:53 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>> In the poweroff routine, no need to fetch last available index.
>>
> This is because there's no concept of shutdown in the vhost layer, it
> only knows start and stop.
>
>> This commit also provides a better debug message in the vhost
>> caller vhost_virtqueue_stop,
> A separate patch is better.
OK
>
>> because if vhost does not fetch
>> the last avail idx successfully, maybe the device does not
>> suspend, vhost will sync last avail idx to vring used idx as a
>> work around, not a failure.
> This only happens if we return a negative value?
Yes
>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   hw/virtio/vhost-vdpa.c | 10 ++++++++++
>>   hw/virtio/vhost.c      |  2 +-
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3c575a9a6e..10b445f64e 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -26,6 +26,7 @@
>>   #include "cpu.h"
>>   #include "trace.h"
>>   #include "qapi/error.h"
>> +#include "sysemu/runstate.h"
>>
>>   /*
>>    * Return one past the end of the end of section. Be careful with uint64_t
>> @@ -1391,6 +1392,15 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
>>       struct vhost_vdpa *v = dev->opaque;
>>       int ret;
>>
>> +    if (runstate_check(RUN_STATE_SHUTDOWN)) {
>> +        /*
>> +         * Some devices do not support this call properly,
>> +         * and we don't need to retrieve the indexes
>> +         * if it is shutting down
>> +         */
>> +        return 0;
> Checking runstate in the vhost code seems like a layer violation.
>
> What happens without this patch?
vhost tries to fetch vring base,
vhost_vdpa needs suspend the device before retrieving last_avail_idx.
However not all devices can support .suspend properly so this call
may fail. Then vhost will print an error shows something failed.

The error msg is confused, as stated in the commit log, restoring 
last_avail_idx with guest used idx
is a workaround rather than a failure. And no needs to fetch last_avail_idx
when power off.

Thanks
>
> Thanks
>
>> +    }
>> +
>>       if (v->shadow_vqs_enabled) {
>>           ring->num = virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
>>           return 0;
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 82394331bf..7dd90cff3a 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>>
>>       r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>       if (r < 0) {
>> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the guest used idx for vhost VQ %u", idx);
>>           /* Connection to the backend is broken, so let's sync internal
>>            * last avail idx to the device used idx.
>>            */
>> --
>> 2.39.3
>>


