Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F193C7BD653
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:08:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmFB-00011y-CV; Mon, 09 Oct 2023 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qpmF8-00011k-VD
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:08:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qpmF2-0006yg-II
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696842475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j60riyKxhGsCSBSMX2X+jw0EWlMxTE98KY+6UrBqwOg=;
 b=dH4lQUai68EkfnPujMWeS6BSWJ+ORmKU1gmax3YV0pFL0vfKu6cFlzcPTrzWHGilkkcSdt
 CCH3OJyiZ1GtcWuJV3ooBkeX0l95vDZWm23BJP44zuiQXHkN/WBE8NteNSvfHFl43qHlwt
 Dnd2hLtZHACVHk/K1QBihcEVnDEpxBQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492--G1exgHtMYGSbanbkvjhHg-1; Mon, 09 Oct 2023 05:07:53 -0400
X-MC-Unique: -G1exgHtMYGSbanbkvjhHg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso96078266b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842472; x=1697447272;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j60riyKxhGsCSBSMX2X+jw0EWlMxTE98KY+6UrBqwOg=;
 b=in6S7TJfZxBU5Iq3xZxhnPAjNCCuVdX6duAkmrkTejz3LAhTJNYScro6wZBpCvY61O
 2AWSadISlNajRWJ/vHCBLuxX2DDlhcVRT3aUo+gaQHsaVLleXOATc16zjiU37PoZc5Cl
 9KCOn25GCqKpgBp5NlY4GkpyNPQGHHXHZ33Vpb5mDplJHcNjgEzxvziJO1b/Py415wBZ
 YYTKxfcceGKkuxGZKTBIALstBZexyWlPlvUcHP+KT7S+ubcVdzG0HT2C3tANjjJBEzCd
 nSFGfEJtiUUjkm91zmTvp7npunie/KdV5u04wroGj/SHYhHrZre/8rGdNt/7ZuQTjzqu
 a26g==
X-Gm-Message-State: AOJu0YwVhW38g49by0VQE8tBC6EHNAAaEk2br0hDSxDeNbyxQ2MmxxiK
 522FQJh3KH/sk5a6NvnZQC6LsezCFplj/UdzNmir+H50RLEAeyHx/wuHbiDTsvt1eu2Dm6i8jDG
 zmjtNO7UZV6ypfXw=
X-Received: by 2002:a50:ee84:0:b0:531:9c1:8276 with SMTP id
 f4-20020a50ee84000000b0053109c18276mr13885854edr.4.1696842472767; 
 Mon, 09 Oct 2023 02:07:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6jxHhc2DHKJMq/UCdNFQgA0s2IoXP3krcc9u6HBCQal/yRwMr5E8Why52IZaXpBPMIgCZ0A==
X-Received: by 2002:a50:ee84:0:b0:531:9c1:8276 with SMTP id
 f4-20020a50ee84000000b0053109c18276mr13885835edr.4.1696842472477; 
 Mon, 09 Oct 2023 02:07:52 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 j25-20020a50ed19000000b005232ea6a330sm5888005eds.2.2023.10.09.02.07.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:07:52 -0700 (PDT)
Message-ID: <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
Date: Mon, 9 Oct 2023 11:07:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
To: Yajun Wu <yajunw@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, virtio-fs@redhat.com,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, parav@nvidia.com,
 maxime.coquelin@redhat.com, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
In-Reply-To: <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 09.10.23 10:21, Hanna Czenczek wrote:
> On 07.10.23 04:22, Yajun Wu wrote:

[...]

>> The main motivation of adding VHOST_USER_SET_STATUS is to let backend 
>> DPDK know
>> when DRIVER_OK bit is valid. It's an indication of all VQ 
>> configuration has sent,
>> otherwise DPDK has to rely on first queue pair is ready, then 
>> receiving/applying
>> VQ configuration one by one.
>>
>> During live migration, configuring VQ one by one is very time consuming.
>
> One question I have here is why it wasn’t then introduced in the live 
> migration code, but in the general VM stop/cont code instead. It does 
> seem time-consuming to do this every time the VM is paused and resumed.
>
>> For VIRTIO
>> net vDPA, HW needs to know how many VQs are enabled to set 
>> RSS(Receive-Side Scaling).
>>
>> If you don’t want SET_STATUS message, backend can remove protocol 
>> feature bit
>> VHOST_USER_PROTOCOL_F_STATUS.
>
> The problem isn’t back-ends that don’t want the message, the problem 
> is that qemu uses the message wrongly, which prevents well-behaving 
> back-ends from implementing the message.
>
>> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device 
>> close/reset.
>
> So the right thing to do for back-ends is to announce STATUS support 
> and then not implement it correctly?
>
> GET_VRING_BASE should not reset the close or reset the device, by the 
> way.  It should stop that one vring, not more.  We have a RESET_DEVICE 
> command for resetting.
>
>> I'm not involved in discussion about adding SET_STATUS in Vhost 
>> protocol. This feature
>> is essential for vDPA(same as vhost-vdpa implements 
>> VHOST_VDPA_SET_STATUS).
>
> So from what I gather from your response is that there is only a 
> single use for SET_STATUS, which is the DRIVER_OK bit.  If so, 
> documenting that all other bits are to be ignored by both back-end and 
> front-end would be fine by me.
>
> I’m not fully serious about that suggestion, but I hear the strong 
> implication that nothing but DRIVER_OK was of any concern, and this is 
> really important to note when we talk about the status of the STATUS 
> feature in vhost today.  It seems to me now that it was not intended 
> to be the virtio-level status byte, but just a DRIVER_OK signalling 
> path from front-end to back-end.  That makes it a vhost-level protocol 
> feature to me.

On second thought, it just is a pure vhost-level protocol feature, and 
has nothing to do with the virtio status byte as-is.  The only stated 
purpose is for the front-end to send DRIVER_OK after migration, but 
migration is transparent to the guest, so the guest would never change 
the status byte during migration.  Therefore, if this feature is 
essential, we will never be able to have a status byte that is 
transparently shared between guest and back-end device, i.e. the virtio 
status byte.

Cc-ing Alex on this mail, because to me, this seems like an important 
detail when he plans on using the byte in the future.  If we need a 
virtio status byte, I can’t see how we could use the existing F_STATUS 
for it.

Hanna


