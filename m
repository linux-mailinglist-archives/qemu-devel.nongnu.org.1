Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F287BB9DB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:57:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qolJU-0006a8-R6; Fri, 06 Oct 2023 09:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qolJQ-0006Zi-10
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qolJO-0004EV-5z
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696600571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZIgjO1GxLXybDH1On2wKXkwuv9e0JWpBGwVkqTEoe0o=;
 b=PrWkbfqJQGQw23KYwcPv15k5dDjPmtlQ5LqUHcmRiadWApba8t4iF5bntr8FW/Buz9ouJG
 pgmT/XEduvpM4Wc9BKjxgGH9Yf07vNWEb95ye/ZLRk8rKo33u/soutNHgea5l7jBtf31pU
 FuXtbYByrC0c6JRWPT+sHcpNVnl6DW0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-_bjYJ2ABO925RPtih4RtWQ-1; Fri, 06 Oct 2023 09:56:00 -0400
X-MC-Unique: _bjYJ2ABO925RPtih4RtWQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-537efd62f36so1823867a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:55:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696600558; x=1697205358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIgjO1GxLXybDH1On2wKXkwuv9e0JWpBGwVkqTEoe0o=;
 b=ijshWtxNoaL1YSFSEdV3sZQByjA+UV51F+mJhOJcAkcRLYZ+tlDzufugiQ+hgczXju
 DprXDpTzo1W2E6fZfrD4VkdTeS4Z9H2cuvaNbvU4H35qc2y5QDS8/mI5/2EkH+BRe0e8
 uvS3zHX5Ev5VbDxx9Y5Xu8dVON7xESFO4DS4WsvzNCAtMej3FNmbZDKNH2wTt0Ux0UUq
 NWDCC6P/FQgnvEfg+HQTL5G6khS+c/e8uxg9vAdLDdY0dY2eP3nkXM1yX7LNSoTxWw6F
 rk43XxUwPrXoo1YwEGCPbfWnQ+thrncaT2orOMzyQo+FdNIw8xPMK7tNbBgQz89ROtOr
 PpdA==
X-Gm-Message-State: AOJu0YxUuyqlfJYsIvKAioHw0/9+DFL/4bj/y3dAEubqFx6M//LPTFP7
 3YG0E6D9nfuChaPFUWJ4AVmpoyp1Fux/rvRNSnoNm6Uc+Ei1mQMkAAYA0lsjZhb/H+cLO5ttETf
 uWUCo35GBofjFme+ltHtCjao=
X-Received: by 2002:aa7:d84d:0:b0:530:9d23:9f27 with SMTP id
 f13-20020aa7d84d000000b005309d239f27mr6941891eds.31.1696600558153; 
 Fri, 06 Oct 2023 06:55:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGloZrHj8jmX3/kdNpRydJ0LYaHVqNZu2QjkcYWgD27BMILFfuQ/KHTOjxnT4HUlEo6RfCdOQ==
X-Received: by 2002:aa7:d84d:0:b0:530:9d23:9f27 with SMTP id
 f13-20020aa7d84d000000b005309d239f27mr6941875eds.31.1696600557835; 
 Fri, 06 Oct 2023 06:55:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 v18-20020aa7d652000000b00533dad8a9c5sm2635395edr.38.2023.10.06.06.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 06:55:57 -0700 (PDT)
Message-ID: <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
Date: Fri, 6 Oct 2023 15:55:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com> <20231005173859.GC1342722@fedora>
 <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
 <20231006044753-mutt-send-email-mst@kernel.org>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231006044753-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06.10.23 10:49, Michael S. Tsirkin wrote:
> On Fri, Oct 06, 2023 at 09:53:53AM +0200, Hanna Czenczek wrote:
>> On 05.10.23 19:38, Stefan Hajnoczi wrote:
>>> On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:
>>>> GET_VRING_BASE does not mention that it stops the respective ring.  Fix
>>>> that.
>>>>
>>>> Furthermore, it is not fully clear what the "base offset" these
>>>> commands' documentation refers to is; an offset could be many things.
>>>> Be more precise and verbose about it, especially given that these
>>>> commands use different payload structures depending on whether the vring
>>>> is split or packed.
>>>>
>>>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>>>> ---
>>>>    docs/interop/vhost-user.rst | 66 ++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 62 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>>>> index 2f68e67a1a..50f5acebe5 100644
>>>> --- a/docs/interop/vhost-user.rst
>>>> +++ b/docs/interop/vhost-user.rst
>>>> @@ -108,6 +108,37 @@ A vring state description
>>>>    :num: a 32-bit number
>>>> +A vring descriptor index for split virtqueues
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> ++-------------+---------------------+
>>>> +| vring index | index in avail ring |
>>>> ++-------------+---------------------+
>>>> +
>>>> +:vring index: 32-bit index of the respective virtqueue
>>>> +
>>>> +:index in avail ring: 32-bit value, of which currently only the lower 16
>>>> +  bits are used:
>>>> +
>>>> +  - Bits 0–15: Next descriptor index in the *Available Ring*
>>> I think we need to say more to make this implementable just by reading
>>> the spec:
>>>
>>>     Index of the next *Available Ring* descriptor that the back-end will
>>>     process. This is a free-running index that is not wrapped by the ring
>>>     size.
>> Sure, thanks.
>>
>>> Feel free to rephrase.
>>>
>>>> +  - Bits 16–31: Reserved (set to zero)
>>>> +
>>>> +Vring descriptor indices for packed virtqueues
>>>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> +
>>>> ++-------------+--------------------+
>>>> +| vring index | descriptor indices |
>>>> ++-------------+--------------------+
>>>> +
>>>> +:vring index: 32-bit index of the respective virtqueue
>>>> +
>>>> +:descriptor indices: 32-bit value:
>>>> +
>>>> +  - Bits 0–14: Index in the *Available Ring*
>>> Same here.
>>>
>>>> +  - Bit 15: Driver (Available) Ring Wrap Counter
>>>> +  - Bits 16–30: Index in the *Used Ring*
>>> Same here.
>>>
>>>> +  - Bit 31: Device (Used) Ring Wrap Counter
>>>> +
>>>>    A vring address description
>>>>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>> @@ -1031,18 +1062,45 @@ Front-end message types
>>>>    ``VHOST_USER_SET_VRING_BASE``
>>>>      :id: 10
>>>>      :equivalent ioctl: ``VHOST_SET_VRING_BASE``
>>>> -  :request payload: vring state description
>>>> +  :request payload: vring descriptor index/indices
>>>>      :reply payload: N/A
>>>> -  Sets the base offset in the available vring.
>>>> +  Sets the next index to use for descriptors in this vring:
>>>> +
>>>> +  * For a split virtqueue, sets only the next descriptor index in the
>>>> +    *Available Ring*.  The device is supposed to read the next index in
>>>> +    the *Used Ring* from the respective vring structure in guest memory.
>>>> +
>>>> +  * For a packed virtqueue, both indices are supplied, as they are not
>>>> +    explicitly available in memory.
>>>> +
>>>> +  Consequently, the payload type is specific to the type of virt queue
>>>> +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>>>> +  indices for packed virtqueues*).
>>>>    ``VHOST_USER_GET_VRING_BASE``
>>>>      :id: 11
>>>>      :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
>>>>      :request payload: vring state description
>>>> -  :reply payload: vring state description
>>>> +  :reply payload: vring descriptor index/indices
>>>> +
>>>> +  Stops the vring and returns the current descriptor index or indices:
>>>> +
>>>> +    * For a split virtqueue, returns only the 16-bit next descriptor
>>>> +      index in the *Available Ring*.  The index in the *Used Ring* is
>>>> +      controlled by the guest driver and can be read from the vring
>>> I find "is controlled by the guest driver" confusing. The device writes
>>> the Used Ring index. The driver only reads it. The device is the active
>>> party here.
>> Er, good point.  That breaks the whole reasoning.  Then I don’t understand
>> why we do get/set the available ring index and not the used ring index.  Do
>> you know why?
> It's simple. used ring index in memory is controlled by the device and
> reflects device state.

Exactly, it’s device state, that’s why I thought the front-end needs to 
ensure its read and restored around the reset we currently have in 
vhost_dev_stop()/start().

> device can just read it back to restore.

I find it strange that the device is supposed to read its own state from 
memory.

> available ring index in memory is controlled by driver and does
> not reflect device state.

Why can’t the device read the available index from memory?  That value 
is put into memory by the driver precisely so the device can read it 
from there.

Hanna


