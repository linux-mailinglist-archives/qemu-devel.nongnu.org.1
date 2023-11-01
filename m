Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 052387DDBF4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 05:51:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy3BB-0008WO-Rx; Wed, 01 Nov 2023 00:50:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy3B9-0008Vx-Bv
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:50:07 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qy3B7-0004so-9d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 00:50:07 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28019b66ad5so4116734a91.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 21:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698814203; x=1699419003;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ObfTIHEUUMEL1VvEeXoBSUW1NSic/p2A6IS/me0r040=;
 b=U5xrv/NFehdEYAkA1wOZWAa6em68atBPIsY7UsRanHShu9PRTKidmf7vY8FxEczHbb
 aKHGUIg6Ak1vGRFMiR+YOXpr58pxDCjnCPQ87Oj6kuMbeqpvp3cEisCwdKS/jsb6pWR7
 X1N9sEqzHNDH+eojSaautffc6MSM7Xh3UvqcVvVk2DJ8i4Mgfx44iP+yyyTAac01CMWi
 w2RVXQydvhZ77CSOOqae3d94Ozmf+GYw/AGIVKl/V5JOOqXirp5ECSHVhNmaMduncDQS
 VeeILzNhClEfMiPKd/jWIoq2fLWdJhEfEPK8ufNV3uolvMW8tvkCgrIj5hXXsWLRk0f7
 FvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698814203; x=1699419003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ObfTIHEUUMEL1VvEeXoBSUW1NSic/p2A6IS/me0r040=;
 b=lYGaLqsVBxo8ByEr6MA0hpMKK8AEliRvBjGTN5iqyzwRPxUUSlP13x2hc6KHO52Dzp
 8CbOcH6mtzk38F0fwf8Tq8SUKZ9MP8EXKSOXCOclD29jb5EinhclDa04hqSV4/cE2NOF
 8Mp9SmsXnPqMqlHI3uTYuLB3HiUH6lxQdFjAV5g7arFN5kCJhq61j5wVQh9kgE7DEFF7
 nMzUTA1Rk3ivxQVmzdg8WLcVcdhv++Z58aEneQkitlfI8pceQ0Hn2979k49+c7wMZ8B6
 DmrP849aTyM6Htkb8R5ovm71TmpfsSyYiHW9EjyUQnWZcQjb0Q3alUATBWZV2RjgOAbx
 HU9g==
X-Gm-Message-State: AOJu0Yz8emE/vsdruQCKWygmFOsMDf1gAsCG56DH7brCaV0gj9Erjyw9
 cqymwywVJdCJj69aT7aU6nM1fw==
X-Google-Smtp-Source: AGHT+IFqCOln2pbXvbY3CoMiIcGoQy9nGIKR/I8wdH7hcnb6U8Ct9RTtgvlW7iha/wA+ELYhHXdWSw==
X-Received: by 2002:a17:902:f394:b0:1c5:f0fd:51be with SMTP id
 f20-20020a170902f39400b001c5f0fd51bemr11225267ple.69.1698814203374; 
 Tue, 31 Oct 2023 21:50:03 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a170902f7d400b001b86dd825e7sm411754plw.108.2023.10.31.21.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 21:50:02 -0700 (PDT)
Message-ID: <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
Date: Wed, 1 Nov 2023 13:50:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
 <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/11/01 13:19, Jason Wang wrote:
> On Mon, Oct 30, 2023 at 9:15 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2023/10/30 21:51, Yuri Benditovich wrote:
>>>
>>>
>>> On Mon, Oct 30, 2023 at 2:21 PM Akihiko Odaki <akihiko.odaki@daynix.com
>>> <mailto:akihiko.odaki@daynix.com>> wrote:
>>>
>>>      On 2023/10/30 21:14, Yuri Benditovich wrote:
>>>       >
>>>       >
>>>       > On Mon, Oct 30, 2023 at 7:14 AM Akihiko Odaki
>>>      <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>>>       > <mailto:akihiko.odaki@daynix.com
>>>      <mailto:akihiko.odaki@daynix.com>>> wrote:
>>>       >
>>>       >     vhost requires eBPF for RSS. When eBPF is not available,
>>>      virtio-net
>>>       >     implicitly disables RSS even if the user explicitly requests
>>>      it. Return
>>>       >     an error instead of implicitly disabling RSS if RSS is
>>>      requested but not
>>>       >     available.
>>>       >
>>>       >
>>>       > I think that suggesting RSS feature when in fact it is not
>>>      available is
>>>       > not a good idea, this rather desinforms the guest.
>>>       > Existing behavior (IMHO) makes more sense.
>>>       > We can extend this discussion if needed, of course.
>>>
>>>      This change is not to advertise RSS when it's not available; it instead
>>>      reports an error to the user.
>>>
>>>      For example, think of the following command line:
>>>      qemu-system-x86_64 -device virtio-net,rss=on,netdev=n -netdev user,id=n
>>>
>>>      Before this change, it gives no error and the user will not know RSS is
>>>      not available. With this change it now gives an error as follows:
>>>      qemu-system-x86_64: -device virtio-net,rss=on,netdev=n: Can't load
>>>      eBPF RSS
>>>
>>>
>>> Does this mean failure to run QEMU if the RSS required in the command
>>> line and EBPF can't be loaded?
>>> (for example if we run the system with kernel < 5.8)?
>>> I'm not sure this is user-friendly behavior...
>>
>> This patch is wrong that it assumes software RSS is not enabled at all;
>> I missed the vhost check before clearing VIRTIO_NET_F_RSS in
>> virtio_net_get_features().
>>
>> That said, I indeed intend to make it return a hard error for the case
>> that RSS is requested for vhost but eBPF can't be loaded.
>>
>> I believe the current behavior of implicitly disabling a feature
>> explicitly requested by the user is not good,
> 
> Yes, but it has been there for years. It complicates a lot to stick to
> the migration compatibility.
> 
>> but we can still emit a warning instead of an error.
>>
>> It's better to follow a convention common in QEMU but I see no
>> documentation regarding this kind of situation. I know virtio-gpu gives
>> an error in such a case but it's just one example.
> 
> The problem is that it's too late to fix old Qemu, so we probably
> can't do more than using compatibility flags...

This patch does not affect migration in my understanding; it does not 
touch any VM state or runtime behavior.

We had another discussion regarding migration for patch "virtio-net: Do 
not clear VIRTIO_NET_F_HASH_REPORT". It does change the runtime behavior 
so we need to take migration into account. I still think the patch does 
not require a compatibility flag since it only exposes a new feature and 
does not prevent migrating from old QEMU that exposes less features. It 
instead fixes the case where migrating between hosts with different tap 
feature sets.

Regards,
Akihiko Odaki

