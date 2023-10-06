Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A87BB9E6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 15:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qolMB-0007TF-3c; Fri, 06 Oct 2023 09:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qolM8-0007SS-HF
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:59:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qolM5-0004fy-Go
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 09:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696600740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yidTvFKJ9+155QDLvsZn7wmzGxyfFjwAZu25K1V7I0w=;
 b=ZWlnb3v4/gemn3I1ATED46zcmlqDZJogOF8fmJwJzJ4TOqvkBxDjgfW9JJRaZXiwTeckMs
 Xap9bEW2U1YPYVnhujt4VsZCMp3FuqQy/Kav23KfaiPqQV56f/htvcfsG9/zLNdnDHUaIY
 Vs4S5cBIvZvY8JlQaLz2OQ7q3NB84u8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-_vt2y7LyOi2LxeyPQjpiBA-1; Fri, 06 Oct 2023 09:58:47 -0400
X-MC-Unique: _vt2y7LyOi2LxeyPQjpiBA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b65b6bcfb7so184717366b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 06:58:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696600726; x=1697205526;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yidTvFKJ9+155QDLvsZn7wmzGxyfFjwAZu25K1V7I0w=;
 b=cPtrakQ5wvQq7IpT0QVrc5z65420HTrKbbAbbw2xF1nsUHOaJSCKODfqqaNKhqLfrs
 9SA91EkB4XDqDAdyHlz2nBBP0j6aj8m+miSRCCnjWDKXNywchUGHaix1xNYogTGzc0XE
 ZxAYGOS1gg3dYa/7uhyE7AL66uzfTvkxTX0S/6XB2iGiUxaLFKslmtHIal6ItRHD5wy7
 uofTpztwXqQEdXDvxodnN3BBWvz7S1TgqT8Nj65+dEiu7Rk/0wAZ7yJVbQF43dxmOPce
 2bGgp8ZAV8MJeCAa6AFZluLsdJs072ANg1bS4cUjnkIaTa2A++jS+b/JATj5wtj88V5P
 oNAA==
X-Gm-Message-State: AOJu0YzEcS7kNfLOL98x6a4CssmR1GbDXRZukmL9i0c0H/BlTYcfN+Lu
 LXKqi5vqNxAHLb2pZ/nctg2U9texq8IjjbZEC7HOoaqgr7JaQ0daVVJKJkDpF/hALfqtRoXjsM7
 MCmS2RKV68nRej1k=
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id
 o14-20020a170906768e00b009b2f38dc44bmr7248915ejm.24.1696600726714; 
 Fri, 06 Oct 2023 06:58:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKhzoR4RCv63X1z3zYEyuv8m/hcKMbyqa1FTllZNSZkej1XKPTjT1GXu4kgk/0+xAPpinNg==
X-Received: by 2002:a17:906:768e:b0:9b2:f38d:c44b with SMTP id
 o14-20020a170906768e00b009b2f38dc44bmr7248897ejm.24.1696600726401; 
 Fri, 06 Oct 2023 06:58:46 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a17090611d700b00991e2b5a27dsm2946085eja.37.2023.10.06.06.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 06:58:45 -0700 (PDT)
Message-ID: <3523c3c6-cd0c-947d-cf84-d648ef813f66@redhat.com>
Date: Fri, 6 Oct 2023 15:58:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] [PATCH v4 2/8] vhost-user.rst: Improve
 [GS]ET_VRING_BASE doc
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?=
 <eperezma@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-3-hreitz@redhat.com> <20231005173859.GC1342722@fedora>
 <851b7629-2302-5624-eb81-6839e250991e@redhat.com>
 <20231006044753-mutt-send-email-mst@kernel.org>
 <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
In-Reply-To: <483bedcf-9c55-6977-f82c-5ce611ca5769@redhat.com>
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

On 06.10.23 15:55, Hanna Czenczek wrote:
> On 06.10.23 10:49, Michael S. Tsirkin wrote:
>> On Fri, Oct 06, 2023 at 09:53:53AM +0200, Hanna Czenczek wrote:
>>> On 05.10.23 19:38, Stefan Hajnoczi wrote:
>>>> On Wed, Oct 04, 2023 at 02:58:58PM +0200, Hanna Czenczek wrote:

[...]

>>>>    ``VHOST_USER_GET_VRING_BASE``
>>>>      :id: 11
>>>>      :equivalent ioctl: ``VHOST_USER_GET_VRING_BASE``
>>>>      :request payload: vring state description
>>>> -  :reply payload: vring state description
>>>> +  :reply payload: vring descriptor index/indices
>>>> +
>>>> +  Stops the vring and returns the current descriptor index or 
>>>> indices:
>>>> +
>>>> +    * For a split virtqueue, returns only the 16-bit next descriptor
>>>> +      index in the *Available Ring*.  The index in the *Used Ring* is
>>>> +      controlled by the guest driver and can be read from the vring
>>>> I find "is controlled by the guest driver" confusing. The device 
>>>> writes
>>>> the Used Ring index. The driver only reads it. The device is the 
>>>> active
>>>> party here.
>>> Er, good point.  That breaks the whole reasoning.  Then I don’t 
>>> understand
>>> why we do get/set the available ring index and not the used ring 
>>> index.  Do
>>> you know why?
>> It's simple. used ring index in memory is controlled by the device and
>> reflects device state.
>
> Exactly, it’s device state, that’s why I thought the front-end needs 
> to ensure its read and restored around the reset we currently have in 
> vhost_dev_stop()/start().
>
>> device can just read it back to restore.
>
> I find it strange that the device is supposed to read its own state 
> from memory.
>
>> available ring index in memory is controlled by driver and does
>> not reflect device state.
>
> Why can’t the device read the available index from memory?  That value 
> is put into memory by the driver precisely so the device can read it 
> from there.

Ah, wait, is the idea that the device may have an internal available 
index counter that reflects what descriptor it has already fetched? I.e. 
this index will lag behind the one in memory, and the difference are new 
descriptors that the device still needs to read? If that internal 
counter is the index that’s get/set here, then yes, that makes a lot of 
sense.

Hanna


