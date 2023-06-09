Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C0E7293A5
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 10:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Xo3-0001yJ-29; Fri, 09 Jun 2023 04:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q7Xo1-0001y5-76
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:49:13 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lingshan.zhu@intel.com>)
 id 1q7Xny-0005Ca-PT
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 04:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686300550; x=1717836550;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sx9ISHdUlM55wKbACPfWCF09TBkiTpDcTWeNxOHlJMQ=;
 b=hPfewSJ0IcYEKhTBHtyuc4K0zcO3mlzP3X42E0Wevcn5YH2EQ9alKZ37
 glrHZs2+3g+aEAByofJUxqiVEeK7tMqypmcDjZIvabHojE/t4fekZCO06
 UBKRobmmuILJNRXpAOZgMfz9/WnYtVkyOGl1w3xCY7WEQkHu/EiwVLh9K
 MbvdL9gjh0mKKxvsWshDXYakdKaiIMlRhTBZGO1dKAe9KbSetJuDtaRe+
 Dh7kqFCgpbAlL+zmY7fUJJk+hjEexIf3dDo119mmysugBZcUHc6cOduQG
 +rd4oJW6jNWPNAy3ZdrWkQqWforNirbgOsNn55rApHgY+hrajKl8Oklab Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="347201352"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="347201352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="710298966"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="710298966"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.238.130.161])
 ([10.238.130.161])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:49:03 -0700
Message-ID: <3c623e34-fbd2-03fb-e88a-d8d23feee4ad@intel.com>
Date: Fri, 9 Jun 2023 16:49:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
 <CACGkMEvsX0=QsrbjgHVxZ9BAz4b+64waErtvX6bZcPcgpJV-pg@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEvsX0=QsrbjgHVxZ9BAz4b+64waErtvX6bZcPcgpJV-pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=lingshan.zhu@intel.com; helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 6/9/2023 11:13 AM, Jason Wang wrote:
> On Wed, Jun 7, 2023 at 11:37 PM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
>> On Wed, Jun 7, 2023 at 11:09 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>>> When read the state of a virtqueue, vhost_vdpa need
>>> to check whether the device is suspended.
>>>
>>> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
>>> negotiated when checking vhost_vdpa->suspended.
>>>
>> I'll add: Otherwise, qemu prints XXX error message.
>>
>> On second thought, not returning an error prevents the caller
>> (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
>> guest.
>>
>> I'm not sure about the right fix for this, should we call
>> virtio_queue_restore_last_avail_idx here?
> It should be the duty of the caller:
>
> E.g in vhost_virtqueue_stop() we had:
>
> =>  r = dev->vhost_ops->vhost_get_vring_base(dev, &state);
>      if (r < 0) {
>          VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
>          /* Connection to the backend is broken, so let's sync internal
>           * last avail idx to the device used idx.
>           */
> virtio_queue_restore_last_avail_idx(vdev, idx);
>      } else {
>          virtio_queue_set_last_avail_idx(vdev, idx, state.num);
I agree call virtio_queue_restore_last_avail_idx here in the caller is
better. However I found this debug message is confused:

_get_vring_base() read the queue state, it does not restore anything,
and if failed to read the queue state, it invokes 
virtio_queue_restore_last_avail_idx()
to recover, still works, handled the problem internally.

So how about we remove this debug message or change it to:
restore last_avail_idx of vhost vq N from vring used_idx.

Thanks
>
> Thansk
>
>> Communicate that the backend
>> cannot suspend so vhost.c can print a better error message?
>>
>> Thanks!
>>
>>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>>> ---
>>>   hw/virtio/vhost-vdpa.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>>> index b3094e8a8b..ae176c06dd 100644
>>> --- a/hw/virtio/vhost-vdpa.c
>>> +++ b/hw/virtio/vhost-vdpa.c
>>> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhost_dev *dev,
>>>           return 0;
>>>       }
>>>
>>> -    if (!v->suspended) {
>>> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v->suspended)) {
>>>           /*
>>>            * Cannot trust in value returned by device, let vhost recover used
>>>            * idx from guest.
>>> --
>>> 2.39.1
>>>


