Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6611D7084C7
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfQZ-0006ME-Cv; Thu, 18 May 2023 11:20:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfQV-0006JP-Tt
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzfQT-0002ip-Nv
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684423220;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ivZgV5qJ+t0LIf2FhXGBgqxhnCQoljSEylgxxUt5aDo=;
 b=S8IWjER78L1Zsi/WBS+0kBbIUjIMdYm22ofj5gw3CjvYcl77mRPHfGkjFhFwy9vFzNp8oW
 1gybCYeW+D9o0Uw/FvLtDQPt3IIUHbm5ZHnDTzISRWWVUeWpgc51KgJ9e8Yhz8mFTUVlFF
 DiW4lPxyDmzWHDyr3IndYGd6S77nCLw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-r92S-ue_NJCKlhikIeZa-Q-1; Thu, 18 May 2023 11:20:18 -0400
X-MC-Unique: r92S-ue_NJCKlhikIeZa-Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f419a053c5so7243895e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684423217; x=1687015217;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ivZgV5qJ+t0LIf2FhXGBgqxhnCQoljSEylgxxUt5aDo=;
 b=eJYUI+JA9isHF1KACcDvh6lG2ZTJGtpFWOkqie1f1yU049moGW+Fg71a9vV7zgfOcv
 yCiepojTo/SfZz4mgB/wVCvseZQBZEAJaEY2wSyvpdHBuX9rpka8ofnvjWxDVciGlQ66
 PAeHGVs35fiNMhSetv0Ef0Jt15ybYdYmI9SCeqMnGCjHR0Wn79YhNa2sbCnavTbcSo1v
 EQuHx2LI1kou5CacyiN4svRIG4gEphxgqFa1MhrYOsmYNm7XZfyUWEMobvvwvdoTh+8v
 KAAITSGfRKRf1wJdnsXtxilZtpJ3DqqzJ5U/JGD9aY1VpP5rNiUP3lR3KFpltaYNbzkW
 7ORg==
X-Gm-Message-State: AC+VfDyxj1Edtl9xesUfIIrLArp2vEaFu39uUpSajcYGG9XqFmK1CC1Z
 F5UnQAq2TD2UqLDqobG/KQM4AfS0Ay6JkTBRCBUiUDrLMknKhIiS9wBzNJA7Eh+2x9c3BoROKWD
 rF+0CMsIQj25fqx0=
X-Received: by 2002:a05:600c:4191:b0:3f5:11c:33e7 with SMTP id
 p17-20020a05600c419100b003f5011c33e7mr1674458wmh.19.1684423217442; 
 Thu, 18 May 2023 08:20:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4OFu4JkjgrEtNwu8HCYDKdtVVO8CkKc/EqROPtzKry22dbd07oDE/X4EW6jhbqNGQ3CMhf3Q==
X-Received: by 2002:a05:600c:4191:b0:3f5:11c:33e7 with SMTP id
 p17-20020a05600c419100b003f5011c33e7mr1674442wmh.19.1684423217120; 
 Thu, 18 May 2023 08:20:17 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 b8-20020a5d4d88000000b003062c609115sm2516132wru.21.2023.05.18.08.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:20:16 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>,  Fiona Ebner <f.ebner@proxmox.com>,
 Leonardo Bras <leobras@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] hw/pci: Disable PCI_ERR_UNCOR_MASK register for
 machine type < 8.0
In-Reply-To: <ZGYnpQmc+5Sut3x8@x1n> (Peter Xu's message of "Thu, 18 May 2023
 09:27:01 -0400")
References: <20230503002701.854329-1-leobras@redhat.com>
 <7f308149-5495-d415-5e51-1fa15fc20f84@proxmox.com>
 <87jzxf5ki9.fsf@secure.mitica>
 <8c3a4f60-b3ab-7c38-27c0-3f8f2caaeae4@tls.msk.ru>
 <87wn15dgbs.fsf@secure.mitica> <ZGYnpQmc+5Sut3x8@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 17:20:15 +0200
Message-ID: <871qjdd5u8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Peter Xu <peterx@redhat.com> wrote:
> On Thu, May 18, 2023 at 01:33:43PM +0200, Juan Quintela wrote:
>> See patch for documentation:
>> 
>> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03288.html
>> 
>> Basically, the best we can do is:
>> - get the patch posted.  Fixes everything except:
>>   (3) qemu-8.0 -M pc-7.2 -> qemu-8.0.1 -M pc-7.2 works
>> 
>> And for that, we can document somewhere that we need to launch
>> qemu-8.0.1 as:
>> 
>> $ qemu-8.0.1 -M pc-7.2 -device blah,x-pci-err-unc-mask=on
>
> One thing we can also do to avoid it in the future is simply having someone
> do this check around each softfreeze (and we'll also need maintainers be
> careful on merging anything that's risky though after softfreeze) rather
> than after release (what I did for this time, which is late), try to cover
> as much devices as possible. I don't know whether there's a way to always
> cover all devices.
>
> I'll volunteer myself for that as long as I'll remember.  Juan, please also
> have a check or remind me if I didn't. :)
>
> I am not sure whether I mentioned it somewhere before, but maybe it'll work
> if we can also have some way we check migrating each of the vmsd from
> old-qemu to new-qemu (and also new->old) covering all devices.  It doesn't
> need to be a real migration, just generate the per-device stream and try
> loading on the other binary.
>
> It might be an overkill to be part of CI to check each commit, but if
> there's some way to check it then at least we can run it also after
> softfreeze.  I also don't know whether it'll be easy to achieve it at all,
> but I'll think more about it too and update if I found something useful.

Hi Peter

First, thanks for volunteering.

And next, I think this is done better as part of avocado.  Several
reasons:
- We need two different qemu's
- We want to run it perhaps daily.
- We want to report any problem.

I will start with something really simply.  Like getting the
migration-test tests cases that we have, and just run them in both
directions.  I.e. new -> old and old -> new.

That will give us a baseline:
- x86_64
- i386
- aarch64
- ppc
- s390

I think nothing else cares about versioned machine types right now.

Once the mechanism is working and the reporting is sent somewhere, we
can go from there and add machines with the devices that we care about.

But just the example that I showed would have detected the problem that
we are talking about.

After that I would make sure that we are checking all virtio devices,
with/without vhost.

And once we have done that, the device authors that care about their
devices will add test to the infrastructure.

Later, Juan.


