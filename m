Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71DB7BD4E0
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:08:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplIZ-0005Cv-Os; Mon, 09 Oct 2023 04:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qplIY-0005Cj-D9
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qplIW-0003px-IY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:07:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696838847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YccVT16e23O2tcd8pZY9r4xU4J+swsFLyDBxw8Rm+Fw=;
 b=CNi3Y7wjhyPmDngrHpdU+9yfPfO4weCzWeuPFHuzlbeGAr/Uh2ZMIHu1yXYiCXPOd2XkcN
 vgwyNqgivYIVnJwwVDKKSpMrb4CywSpBBuBFO5bhAnQmJuL00dJi57UNkDC4dyacmkUodl
 Ztlyr+6yHd2Yiap1X7vhp3cug+iEag4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-RjbenCfAM4GYhnTPu8c-iQ-1; Mon, 09 Oct 2023 04:07:15 -0400
X-MC-Unique: RjbenCfAM4GYhnTPu8c-iQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so305156666b.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696838834; x=1697443634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YccVT16e23O2tcd8pZY9r4xU4J+swsFLyDBxw8Rm+Fw=;
 b=tUoX0sFE4r4is0Dcx/mQ/7COj7kl/jsZZQ/bgzOlRa7VAFrwbnKAOShxszyGEIQ7ZU
 flPc/P1BycHxJVtGeW/QRqKrctUoshrDi9IEbSMHVJaga315mcXfm+VE24uFaqEEbFXB
 a+/5ftupp12+YeZ2K1DT+E6PmoW2isfW5va5HUd8XA3ISlaTesjLKoVJLJ2BrRP5U8bu
 PmiBA5vtgUFnYGygivxHmdgVGNn6iPINWsvte25q72NvtljOKNHG07Euh0JDly99XLM4
 VkPhaoA7nX9aJMRvXAFSy31SKMkhYZgzKP9GhlTRhI0ahJ5rA6JeotA9lWMO+rKnPHZB
 75mg==
X-Gm-Message-State: AOJu0YzAHDIDPZADZHhI8RfGCh7G6TUEddu3neUi0ABvqF+n1wsAPscs
 1XIh7OZH03t/zxl9xCoaHl47B4Ls/69ayNk77dYNXy93w0To+oHg5fLYyvgasBqL6zIDDrSCW0O
 QdCpOYro/6wsQIHY=
X-Received: by 2002:a17:907:780d:b0:9b6:4df9:e5b5 with SMTP id
 la13-20020a170907780d00b009b64df9e5b5mr13215029ejc.61.1696838834620; 
 Mon, 09 Oct 2023 01:07:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHN4jToyYFznJkNH76G6X0zgsXivkbPswycgC9GO7s3a1kH0d996pZ1MKXkEloOvwsSzJ2mg==
X-Received: by 2002:a17:907:780d:b0:9b6:4df9:e5b5 with SMTP id
 la13-20020a170907780d00b009b64df9e5b5mr13215015ejc.61.1696838834291; 
 Mon, 09 Oct 2023 01:07:14 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 si5-20020a170906cec500b009875a6d28b0sm6422817ejb.51.2023.10.09.01.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:07:13 -0700 (PDT)
Message-ID: <1a681baf-b78b-f46e-1925-e69bfbcfcaff@redhat.com>
Date: Mon, 9 Oct 2023 10:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 Anton Kuchin <antonkuchin@yandex-team.ru>, Yajun Wu <yajunw@nvidia.com>
References: <20231004125904.110781-1-hreitz@redhat.com>
 <20231004125904.110781-2-hreitz@redhat.com> <20231005170852.GB1342722@fedora>
 <20231005131352-mutt-send-email-mst@kernel.org>
 <00272da3-0a48-5544-6ba8-5dfde00be241@redhat.com>
 <20231006043518-mutt-send-email-mst@kernel.org>
 <a8b9d842-0925-38d0-2f0d-f2560bab251b@redhat.com>
 <20231006051802-mutt-send-email-mst@kernel.org>
 <a4af0357-12ee-fc7f-e249-239da34409b0@redhat.com>
 <20231006055229-mutt-send-email-mst@kernel.org>
 <d9c2d2c4-5ab3-a3f3-8925-155e1c4ff73a@redhat.com> <87il7jg4oe.fsf@linaro.org>
 <2ba3ef6b-4af1-9c65-f542-bfcc8412e99c@redhat.com> <875y3j4gmu.fsf@linaro.org>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <875y3j4gmu.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

On 06.10.23 22:49, Alex Bennée wrote:
> Hanna Czenczek <hreitz@redhat.com> writes:
>
>> On 06.10.23 17:17, Alex Bennée wrote:
>>> Hanna Czenczek <hreitz@redhat.com> writes:
>>>
>>>> On 06.10.23 12:34, Michael S. Tsirkin wrote:
>>>>> On Fri, Oct 06, 2023 at 11:47:55AM +0200, Hanna Czenczek wrote:
>>>>>> On 06.10.23 11:26, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Oct 06, 2023 at 11:15:55AM +0200, Hanna Czenczek wrote:
>>>>>>>> On 06.10.23 10:45, Michael S. Tsirkin wrote:
>>>>>>>>> On Fri, Oct 06, 2023 at 09:48:14AM +0200, Hanna Czenczek wrote:
>>>>>>>>>> On 05.10.23 19:15, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Thu, Oct 05, 2023 at 01:08:52PM -0400, Stefan Hajnoczi wrote:
>>>>>>>>>>>> On Wed, Oct 04, 2023 at 02:58:57PM +0200, Hanna Czenczek wrote:
>>> <snip>
>>>>>> What I’m saying is, 923b8921d21 introduced SET_STATUS calls that broke all
>>>>>> devices that would implement them as per virtio spec, and even today it’s
>>>>>> broken for stateful devices.  The mentioned performance issue is likely
>>>>>> real, but we can’t address it by making up SET_STATUS calls that are wrong.
>>>>>>
>>>>>> I concede that I didn’t think about DRIVER_OK.  Personally, I would do all
>>>>>> final configuration that would happen upon a DRIVER_OK once the first vring
>>>>>> is started (i.e. receives a kick).  That has the added benefit of being
>>>>>> asynchronous because it doesn’t block any vhost-user messages (which are
>>>>>> synchronous, and thus block downtime).
>>>>>>
>>>>>> Hanna
>>>>> For better or worse kick is per ring. It's out of spec to start rings
>>>>> that were not kicked but I guess you could do configuration ...
>>>>> Seems somewhat asymmetrical though.
>>>> I meant to take the first ring being started as the signal to do the
>>>> global configuration, i.e. not do this once per vring, but once
>>>> globally.
>>>>
>>>>> Let's wait until next week, hopefully Yajun Wu will answer.
>>>> I mean, personally I don’t really care about the whole SET_STATUS
>>>> thing.  It’s clear that it’s broken for stateful devices.  The fact
>>>> that it took until 6f8be29ec17d to fix it for just any device that
>>>> would implement it according to spec to me is a strong indication that
>>>> nobody does implement it according to spec, and is currently only used
>>>> to signal to some specific back-end that all rings have been set up
>>>> and should be configured in a single block.
>>> I'm certainly using [GS]ET_STATUS for the proposed F_TRANSPORT
>>> extensions where everything is off-loaded to the vhost-user backend.
>> How do these back-ends work with the fact that qemu uses SET_STATUS
>> incorrectly when not offloading?  Do you plan on fixing that?
> Mainly having a common base implementation which does it right and
> having very lightweight derivations for legacy stubs using it. The
> aim is to eliminate the need for QEMU stubs entirely by fully specifying
> the device from the vhost-user API.

If the current SET_STATUS use is overhauled, too, that would be good.  I 
wonder why you need the status byte, though.

>> (I.e. that we send SET_STATUS 0 when the VM is paused, potentially
>> resetting state that is not recoverable, and that we set DRIVER and
>> DRIVER_OK simultaneously.)
> This is QEMU simulating a SET_STATUS rather than the guest triggering
> it?

Yes, and the fact that we simulate it when the guest will not have 
triggered it, i.e. we reset the device (SET_STATUS 0) when the VM is 
paused.  Effectively, qemu injects virtio commands that the guest has 
never requested, which generally feels like a bad idea, because qemu 
will need to get the device back to its previous state before the guest 
is resumed, which may or may not work.  Specifically, it won’t work for 
devices that have internal state.

Furthermore, we use SET_STATUS to set ACKNOWLEDGE | DRIVER | DRIVER_OK 
simultaneously, which is wrong.  ACKNOWLEDGE | DRIVER may perhaps be set 
simultaneously, but then comes feature negotiation (setting and checking 
FEATURES_OK), and then DRIVER_OK.

Finally, how the status byte is to be used is not noted in the 
vhost-user specification, which instead points to the virtio 
specification.  I think if we keep SET_STATUS, it must be documented how 
it interacts with other vhost-user commands.  For example, how the 
FEATURES_OK protocol described in the virtio specification interacts 
with GET_FEATURES/SET_FEATURES, or whether SET_STATUS 0 and RESET_DEVICE 
are equivalent.  Currently, the only implementation of SET_STATUS I know 
(DPDK) ignores SET_STATUS 0, i.e. doesn’t do a reset.  To me that 
indicates that the spec must be clear on what these status values mean 
with regards to the vhost-user protocol as a whole.

So every software implementation with STATUS support that I know 
implements SET_STATUS wrongly right now, and that’s a problem, because 
it prevents implementations like virtiofsd from doing so correctly.

Hanna


