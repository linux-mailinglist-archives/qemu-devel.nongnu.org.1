Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE6174CC59
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 07:45:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIjgW-0006XH-5m; Mon, 10 Jul 2023 01:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qIjgI-0006VO-3P
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 01:43:30 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1qIjgC-0000xq-Kj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 01:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688967804; x=1720503804;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZKyWrO4E7c/u9VRXtHO+U2xU5DlZiEKl1Z/Atg4ayKM=;
 b=htT5YbHMbMzK6cHLbZdnC/ahulBmpOpfn8Ngr0VkJTo6oticLjLZCaxt
 prQbT/VyKBJ9bJVXnuyfRd0BlbcxaLAXlND5wpxBB3ip5YY21qmCjSD+o
 o/+In2xDXiLFLGK9Bm95qIeCwsa1d3C9sDUurgND7C5Ik2jB1j1CBSKXc
 0WJx0mYFUCiHWKxg4NKR2Cw1h6XaUt2eCMUoOlMBGeFRvYs1JUFPfXNs9
 9XJpZTCx4GFMI7DuSui8kRy8bSFnET6Tun9Ntf0R0lxiyavPga0WKTDh5
 SbWap+9oq/OX82e0/ldLTZAU6DAmGUNOLnYhFvIaLnLdySRMnjV2LJ6v2 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="430333774"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="430333774"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2023 22:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="750216608"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; d="scan'208";a="750216608"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.170.243])
 ([10.249.170.243])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2023 22:43:14 -0700
Message-ID: <dbcfedca-ebeb-3540-b361-706627964668@intel.com>
Date: Mon, 10 Jul 2023 13:43:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] vhost_vdpa: no need to fetch vring base when poweroff
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>
References: <20230707181826.10946-1-lingshan.zhu@intel.com>
 <CAJaqyWdp6FvVT3wms39-paqQndLPQwQjqb4Ocua0ja=N3bxvpw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CAJaqyWdp6FvVT3wms39-paqQndLPQwQjqb4Ocua0ja=N3bxvpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=lingshan.zhu@intel.com; helo=mga07.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 7/7/2023 7:02 PM, Eugenio Perez Martin wrote:
> On Fri, Jul 7, 2023 at 12:18 PM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>> In the poweroff routine, no need to fetch last available index.
>>
>> This commit also provides a better debug message in the vhost
>> caller vhost_virtqueue_stop, because if vhost does not fetch
>> the last avail idx successfully, maybe the device does not
>> suspend, vhost will sync last avail idx to vring used idx as a
>> work around, not a failure.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> CCing MST.
>
>> ---
>>   hw/virtio/vhost-vdpa.c | 4 ++++
>>   hw/virtio/vhost.c      | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3c575a9a6e..f62952e1c7 100644
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
>> @@ -1391,6 +1392,9 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
>>       struct vhost_vdpa *v = dev->opaque;
>>       int ret;
>>
>> +    if (runstate_check(RUN_STATE_SHUTDOWN))
>> +        return 0;
>> +
> QEMU coding style mandates braces around the "if" body (CODING_STYLE.rst file).
>
> Apart from that I think we should add a comment here. Something in the line of:
>
> Some devices do not support the call properly, and we don't need to
> retrieve the indexes if we're not migrating. Skip it in this case.
V2 will include these changes, thanks!
>
>>       if (v->shadow_vqs_enabled) {
>>           ring->num = virtio_queue_get_last_avail_idx(dev->vdev, ring->index);
>>           return 0;
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index 82394331bf..84712743e0 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -1262,7 +1262,7 @@ void vhost_virtqueue_stop(struct vhost_dev *dev,
>>
>>       r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>>       if (r < 0) {
>> -        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>> +        VHOST_OPS_DEBUG(r, "sync last avail idx to the used idx for vhost VQ %u", idx);
> Guest's used idx? Also, maybe it is worth splitting this in a separated patch.
Yes, guest used idx is much clearer. I am not sure whether this worthy a 
separated
patch, this is only a comment.
>
> Apart from the nitpicking, I think the general line of the patch is
> the way to go :).
Thanks!
>
> Thanks!
>
>>           /* Connection to the backend is broken, so let's sync internal
>>            * last avail idx to the device used idx.
>>            */
>> --
>> 2.39.3
>>


