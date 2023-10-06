Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBED07BB2B8
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 09:54:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qofez-0005fx-5t; Fri, 06 Oct 2023 03:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qofes-0005f8-S5
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:54:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qofeq-0008Ln-AY
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 03:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696578838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ybJ7HP/trjIH+H85NP71hfxkLzEXMihD+VxcjnxHJ9o=;
 b=AhAb3nhpJJWJ0P0zXJLEIaPmZIODUbjUYFs8aEDOf/vRyJ6IkXkumarSv31OUfB9OL28gz
 nIuZnB7k8NshkH7pBvg7LdpcGOsRIDLLiATTm544Qxt/S7y65lf9eFfjK0zUVYJLxUDnAk
 ie+EwduYUpcFCpYbxyXwKu4PrfMNCjE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-VMUnGgKvOZOvV9LAYr1V8Q-1; Fri, 06 Oct 2023 03:53:56 -0400
X-MC-Unique: VMUnGgKvOZOvV9LAYr1V8Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9b2e3f315d5so214808166b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 00:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696578835; x=1697183635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ybJ7HP/trjIH+H85NP71hfxkLzEXMihD+VxcjnxHJ9o=;
 b=AWquZfCpVbWpd7qlVuXZ5ulHhazHlTFFreO/iGo9u/kJW9eIQKRSqKZUg++kV+KKEr
 eJGlt3EFeXEWELt8327vSqexgXP94AALvmTcoV+svgqPPD7byI0oL04MLZOF84EKoXfe
 hdCqSE8TB8+BTobkkIgsbY+farCD31v3Rbbb7VOq3d5V1Mv8znDckSAwMoLH1OM4b9nh
 7sEHQexwLPqarz7QIE+9Q6O17ZODqHJdSQemSM1iTc+aH9bcwsSYZLMHuKc7bDHvx6A5
 j9hdJ5FA4UOwxWZhBba3e7aDP+6soyPWcRfDZTcHJ3bYK1LaJ/4d/ENeRFkH7xDI7e1l
 DL8g==
X-Gm-Message-State: AOJu0YzCyZw5erM/XABsLXj0DRh5IIeLvL5wWYT5JkonVxbVXlLQXAZQ
 Ty8X4wRWBZoh12UXtOTd3/jq3FEjiiKjXpF4EsxWKyJSBDHnNLGmHdW1jFfXBgX1LgyHlWPcoxu
 9idsH02z/tc8wDZY=
X-Received: by 2002:a17:907:d02:b0:9ae:5a56:be32 with SMTP id
 gn2-20020a1709070d0200b009ae5a56be32mr3257297ejc.38.1696578835609; 
 Fri, 06 Oct 2023 00:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWFyL4GliC/mmyxlPHCczA96wbys0hc8BJs9VZL4YGpqy4gEDn0u31ttk4PCgaJiqc9mOqXA==
X-Received: by 2002:a17:907:d02:b0:9ae:5a56:be32 with SMTP id
 gn2-20020a1709070d0200b009ae5a56be32mr3257280ejc.38.1696578835239; 
 Fri, 06 Oct 2023 00:53:55 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 rp19-20020a170906d97300b009b95b46bbd1sm2421827ejb.133.2023.10.06.00.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 00:53:54 -0700 (PDT)
Message-ID: <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
Date: Fri, 6 Oct 2023 09:53:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com> <20231005173859.GC1342722@fedora>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231005173859.GC1342722@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 05.10.23 19:38, Stefan Hajnoczi wrote:
> On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:
>> GET_VRING_BASE does not mention that it stops the respective ring.  Fix
>> that.
>>
>> Furthermore, it is not fully clear what the "base offset" these
>> commands' documentation refers to is; an offset could be many things.
>> Be more precise and verbose about it, especially given that these
>> commands use different payload structures depending on whether the vring
>> is split or packed.
>>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   docs/interop/vhost-user.rst | 66 ++++++++++++++++++++++++++++++++++---
>>   1 file changed, 62 insertions(+), 4 deletions(-)
>>
>> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> index 2f68e67a1a..50f5acebe5 100644
>> --- a/docs/interop/vhost-user.rst
>> +++ b/docs/interop/vhost-user.rst
>> @@ -108,6 +108,37 @@ A vring state description
>>   
>>   :num: a 32-bit number
>>   
>> +A vring descriptor index for split virtqueues
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-------------+---------------------+
>> +| vring index | index in avail ring |
>> ++-------------+---------------------+
>> +
>> +:vring index: 32-bit index of the respective virtqueue
>> +
>> +:index in avail ring: 32-bit value, of which currently only the lower 16
>> +  bits are used:
>> +
>> +  - Bits 0–15: Next descriptor index in the *Available Ring*
> I think we need to say more to make this implementable just by reading
> the spec:
>
>    Index of the next *Available Ring* descriptor that the back-end will
>    process. This is a free-running index that is not wrapped by the ring
>    size.

Sure, thanks.

> Feel free to rephrase.
>
>> +  - Bits 16–31: Reserved (set to zero)
>> +
>> +Vring descriptor indices for packed virtqueues
>> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> +
>> ++-------------+--------------------+
>> +| vring index | descriptor indices |
>> ++-------------+--------------------+
>> +
>> +:vring index: 32-bit index of the respective virtqueue
>> +
>> +:descriptor indices: 32-bit value:
>> +
>> +  - Bits 0–14: Index in the *Available Ring*
> Same here.
>
>> +  - Bit 15: Driver (Available) Ring Wrap Counter
>> +  - Bits 16–30: Index in the *Used Ring*
> Same here.
>
>> +  - Bit 31: Device (Used) Ring Wrap Counter
>> +
>>   A vring address description
>>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   
>> @@ -1031,18 +1062,45 @@ Front-end message types
>>   ``VHOST_USER_SET_VRING_BASE``
>>     :id: 10
>>     :equivalent ioctl: ``VHOST_SET_VRING_BASE``
>> -  :request payload: vring state description
>> +  :request payload: vring descriptor index/indices
>>     :reply payload: N/A
>>   
>> -  Sets the base offset in the available vring.
>> +  Sets the next index to use for descriptors in this vring:
>> +
>> +  * For a split virtqueue, sets only the next descriptor index in the
>> +    *Available Ring*.  The device is supposed to read the next index in
>> +    the *Used Ring* from the respective vring structure in guest memory.
>> +
>> +  * For a packed virtqueue, both indices are supplied, as they are not
>> +    explicitly available in memory.
>> +
>> +  Consequently, the payload type is specific to the type of virt queue
>> +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>> +  indices for packed virtqueues*).
>>   
>>   ``VHOST_USER_GET_VRING_BASE``
>>     :id: 11
>>     :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
>>     :request payload: vring state description
>> -  :reply payload: vring state description
>> +  :reply payload: vring descriptor index/indices
>> +
>> +  Stops the vring and returns the current descriptor index or indices:
>> +
>> +    * For a split virtqueue, returns only the 16-bit next descriptor
>> +      index in the *Available Ring*.  The index in the *Used Ring* is
>> +      controlled by the guest driver and can be read from the vring
> I find "is controlled by the guest driver" confusing. The device writes
> the Used Ring index. The driver only reads it. The device is the active
> party here.

Er, good point.  That breaks the whole reasoning.  Then I don’t 
understand why we do get/set the available ring index and not the used 
ring index.  Do you know why?

> The sentence can be shortened to omit the "controlled by the guest
> driver" part.

I don’t want to shorten it, because I would like to know why we don’t 
get/set both indices for split virtqueues, too.

Hanna

>> +      structure in memory, so is not covered.
>> +
>> +    * For a packed virtqueue, neither index is explicitly available to
>> +      read from memory, so both indices (as maintained by the device) are
>> +      returned.
>> +
>> +  Consequently, the payload type is specific to the type of virt queue
>> +  (*a vring descriptor index for split virtqueues* vs. *vring descriptor
>> +  indices for packed virtqueues*).
>>   
>> -  Get the available vring base offset.
>> +  The request payload’s *num* field is currently reserved and must be
>> +  set to 0.
>>   
>>   ``VHOST_USER_SET_VRING_KICK``
>>     :id: 12
>> -- 
>> 2.41.0
>>
>>
>> _______________________________________________
>> Virtio-fs mailing list
>> Virtio-fs@redhat.com
>> https://listman.redhat.com/mailman/listinfo/virtio-fs


