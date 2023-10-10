Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162A17BF584
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 10:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7wt-0004mq-7Q; Tue, 10 Oct 2023 04:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qq7wr-0004mc-Pc
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:18:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qq7wp-0002Oi-U7
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 04:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696925914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cKVIhwnCT0coZDAV/dXj9FGa+4tSFc74g3w0KILKoJ4=;
 b=h1aV2PdwoniPJUMALoPoMaC5CzVgHoAvcZYpF+ieYMtRwoo9cXhosMAUYIfZJHTLLIfzgQ
 oaeziSOecipY8dKevMjXUH/9SoKcTi8Pr4ZgKJQ/PVvbNxWGChT/INzfa9jYKPRIUMYlZ4
 yq6Ih7hmRvBLpyFJ/FHTnDHyRbvLxXM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-cnfltvCDM9iaxCfWPFMQiQ-1; Tue, 10 Oct 2023 04:18:32 -0400
X-MC-Unique: cnfltvCDM9iaxCfWPFMQiQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9adc78b386cso413973766b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 01:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696925912; x=1697530712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cKVIhwnCT0coZDAV/dXj9FGa+4tSFc74g3w0KILKoJ4=;
 b=LOxbx7rR+p2yIxa+xt6lii8V0DqrizB/aNoCa+FTYM4/y6DKWtozRu1F5KXr0V2r9L
 /cicpUDY2Y6a7Q2U0MdtfZRwL8fo+S6TPWPQISgTG8LAA2N56ers+mNIWuQGZ+4R+Lhp
 mUZGvAx6PO56HDNj+bWub2He46b+V0SL05Ne9GUxtoB+KG7KZR7IG92uF0qtV7xb4hd5
 1vUzW+YZJXhRKWG31tmxvhGD1o8iFnZBfwD8ZaOk2I3m607v00tNCuHRyWCF9Yiqk4qJ
 tZ7Kgn+BKzVi5pv2KJIO0fu9zDAuYz1S69fnALV4xV/FUrGGCDa/A7+5AfnBpNIWc/zQ
 I7Rg==
X-Gm-Message-State: AOJu0YwXXutmwU5sX9AUIZc494iczrcCVInUf0ErHRfZeeAw414Tf4cA
 vCtWpi5F1uHfjPcKQoDt0XztoNRBCiAwTWRIzxvE3Yd6qdhShazdjeRVvTAfO21/TYAMq8cqQRV
 jfl3gbBbHk2JMySk=
X-Received: by 2002:a17:906:2dd:b0:9b2:babb:5fe9 with SMTP id
 29-20020a17090602dd00b009b2babb5fe9mr14854092ejk.23.1696925911673; 
 Tue, 10 Oct 2023 01:18:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGixuYch2oND/KO3FeHcD/fGB/HMn0GjfqRHDD6G6J958TJNo27tVCI1PL+QvKBVfrU8UYG9g==
X-Received: by 2002:a17:906:2dd:b0:9b2:babb:5fe9 with SMTP id
 29-20020a17090602dd00b009b2babb5fe9mr14854083ejk.23.1696925911292; 
 Tue, 10 Oct 2023 01:18:31 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1709064b1100b0099cc3c7ace2sm8156990eju.140.2023.10.10.01.18.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 01:18:30 -0700 (PDT)
Message-ID: <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com>
Date: Tue, 10 Oct 2023 10:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
To: Yajun Wu <yajunw@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Parav Pandit <parav@nvidia.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
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
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
 <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10.10.23 06:00, Yajun Wu wrote:
>
> On 10/9/2023 5:13 PM, Hanna Czenczek wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 09.10.23 11:07, Hanna Czenczek wrote:
>>> On 09.10.23 10:21, Hanna Czenczek wrote:
>>>> On 07.10.23 04:22, Yajun Wu wrote:
>>> [...]
>>>
>>>>> The main motivation of adding VHOST_USER_SET_STATUS is to let
>>>>> backend DPDK know
>>>>> when DRIVER_OK bit is valid. It's an indication of all VQ
>>>>> configuration has sent,
>>>>> otherwise DPDK has to rely on first queue pair is ready, then
>>>>> receiving/applying
>>>>> VQ configuration one by one.
>>>>>
>>>>> During live migration, configuring VQ one by one is very time
>>>>> consuming.
>>>> One question I have here is why it wasn’t then introduced in the live
>>>> migration code, but in the general VM stop/cont code instead. It does
>>>> seem time-consuming to do this every time the VM is paused and 
>>>> resumed.
>
> Yes, VM stop/cont will call vhost_net_stop/vhost_net_start. Maybe 
> because there's no device level stop/cont vhost message?

No, it is because qemu will reset the status in stop/cont*, which it 
should not do.  Aside from guest-initiated resets, the only thing where 
a reset comes into play is when the back-end is changed, e.g. during 
migration.  In that case, the source back-end will see a disconnect on 
the vhost-user socket and can then do whatever uninitialization it needs 
to do, and the destination front-end will need to be reconfigured by 
qemu anyway, because it’s just a case of the destination qemu initiating 
a fresh connection to a new back-end (except that it will need to 
restore the state from the source).

*Yes, technically, dpdk will ignore that reset, but it still stops the 
device on a different message (when it should just pause processing 
vrings), so the outcome is the same.

>>>>
>>>>> For VIRTIO
>>>>> net vDPA, HW needs to know how many VQs are enabled to set
>>>>> RSS(Receive-Side Scaling).
>>>>>
>>>>> If you don’t want SET_STATUS message, backend can remove protocol
>>>>> feature bit
>>>>> VHOST_USER_PROTOCOL_F_STATUS.
>>>> The problem isn’t back-ends that don’t want the message, the problem
>>>> is that qemu uses the message wrongly, which prevents well-behaving
>>>> back-ends from implementing the message.
>>>>
>>>>> DPDK is ignoring SET_STATUS 0, but using GET_VRING_BASE to do device
>>>>> close/reset.
>>>> So the right thing to do for back-ends is to announce STATUS support
>>>> and then not implement it correctly?
>>>>
>>>> GET_VRING_BASE should not reset the close or reset the device, by the
>>>> way.  It should stop that one vring, not more.  We have a
>>>> RESET_DEVICE command for resetting.
> I believe dpdk uses GET_VRING_BASE long before qemu has RESET_DEVICE? 

I don’t think it matters who came first.  What matters is the 
specification, and that dpdk decided to rely on implementation-specific 
behavior without having all involved parties agree by matters of putting 
that in the specification.  And now dpdk clearly deviates from the 
specification as a result of that action, which can result in problems 
if the front-end doesn’t do what qemu always used to do.  (E.g. the 
front-end might just send GET_VRING_BASE for all vrings when suspending 
the guest, and then only send kicks on resume to re-start the vrings.  
dpdk would most likely be left in a state where the whole device is 
stopped, expecting DRIVER_OK.  Same thing in general for front-ends that 
don’t support F_STATUS.)

> It's a compatible issue. For new backend implements, we can have 
> better solution, right?

The fact that dpdk and qemu deviate from the specification is a problem 
as-is.

>>>>> I'm not involved in discussion about adding SET_STATUS in Vhost
>>>>> protocol. This feature
>>>>> is essential for vDPA(same as vhost-vdpa implements
>>>>> VHOST_VDPA_SET_STATUS).
>>>> So from what I gather from your response is that there is only a
>>>> single use for SET_STATUS, which is the DRIVER_OK bit.  If so,
>>>> documenting that all other bits are to be ignored by both back-end
>>>> and front-end would be fine by me.
>>>>
>>>> I’m not fully serious about that suggestion, but I hear the strong
>>>> implication that nothing but DRIVER_OK was of any concern, and this
>>>> is really important to note when we talk about the status of the
>>>> STATUS feature in vhost today.  It seems to me now that it was not
>>>> intended to be the virtio-level status byte, but just a DRIVER_OK
>>>> signalling path from front-end to back-end.  That makes it a
>>>> vhost-level protocol feature to me.
>>> On second thought, it just is a pure vhost-level protocol feature, and
>>> has nothing to do with the virtio status byte as-is.  The only stated
>>> purpose is for the front-end to send DRIVER_OK after migration, but
>>> migration is transparent to the guest, so the guest would never change
>>> the status byte during migration.  Therefore, if this feature is
>>> essential, we will never be able to have a status byte that is
>>> transparently shared between guest and back-end device, i.e. the
>>> virtio status byte.
>> On third thought, scratch that.  The guest wouldn’t set it, but
>> naturally, after migration, the front-end will need to restore the
>> status byte from the source, so the front-end will always need to set
>> it, even if it were otherwise used controlled only by the guest and the
>> back-end device.  So technically, this doesn’t prevent such a use case.
>> (In practice, it isn’t controlled by the guest right now, but that could
>> be fixed.)
> I only tested the feature with DPDK(the only backend use it today?). 
> Max defined the protocol and added the corresponding code in DPDK 
> before I added QEMU support. If other backend or different device type 
> want to use this, we can have further discussion?

So as far as I understand, the feature is supposed to rely on 
implementation-specific behavior between specifically qemu as a 
front-end and dpdk as a back-end, nothing else.  Honestly, that to me is 
a very good reason to deprecate it.  That would make it clear that any 
implementation that implements it does so because it relies on 
implementation-specific behavior from other implementations.

Option 2 is to fix it.  It is not right to use this broadly defined 
feature with its clear protocol as given in the virtio specification 
just to set and clear a single bit (DRIVER_OK).  The vhost-user 
specification points to that virtio protocol.  We must adhere to the 
protocol.  And note that we must not reset devices just because the VM 
is paused/resumed.  (That is why I wanted to deprecate SET_STATUS, so 
that Stefan’s series would introduce RESET_DEVICE where we need it, and 
we can (for now) ignore the SET_STATUS 0 in vhost_dev_stop().)

Option 3 would be to just be honest in the specification, and limit the 
scope of F_STATUS to say the only bit that matters is DRIVER_OK.  I 
would say this is not really different from deprecating, though it 
wouldn’t affect your case.  However, I understand Alex relies on a full 
status byte.  I’m still interested to know why that is.

Option 4 is of course not to do anything, and leave everything as-is, 
waiting for the next person to stir the hornet’s nest.

>>> Cc-ing Alex on this mail, because to me, this seems like an important
>>> detail when he plans on using the byte in the future. If we need a
>>> virtio status byte, I can’t see how we could use the existing F_STATUS
>>> for it.
>>>
>>> Hanna
>


