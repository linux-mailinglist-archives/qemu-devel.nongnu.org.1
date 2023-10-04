Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4767B7EFB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0vG-0002MA-IE; Wed, 04 Oct 2023 08:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo0vE-0002LH-Ve
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:24:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qo0vC-0003uq-RS
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696422249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jmkpb2MHofs4U+lH07lDbbLiKX8CXGFx15ixU7AxlKM=;
 b=UQlc3T8WJFDWXcU9OnWc3h3So4NOP2sFOpo5hhXI3QgyAKJSNfzNtEQ+FKIK25YE7ax1AE
 ESyFHmY7K5SjH3sGPIa89IygPK9SwC3pOgTizRQszF7a8PdkYxcqkH9CpglxNmQ3WHbDXb
 Dbuy3oYeejACM/ytP9+Y5YbMbwF6FRk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-EzEwcAvkMeOh-N0EEMAT8Q-1; Wed, 04 Oct 2023 08:23:58 -0400
X-MC-Unique: EzEwcAvkMeOh-N0EEMAT8Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso101212666b.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696422237; x=1697027037;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jmkpb2MHofs4U+lH07lDbbLiKX8CXGFx15ixU7AxlKM=;
 b=QuzShrDuWoIMZn5BuZqooJ0pTkRLxU2w4wnRHcSCxUCtG4trHx1bwMBEKzlVqdYTpH
 piBBfPaJ1dNcZMZFWm/o6wnJP7MM5iRMOuQv+XoQGkvRfhPY0XP7YgW8723Wi3fKvqUJ
 4kf3IAZ5sPQEk2hwTMaMRJiv2aZxbyEAkX1K33lHg2+VyLSEBps95dQHU0gqmt7tNYzZ
 8AhaxyLV3TBMLRTiG3S7ixjhVuLGie6mm8j37FYvEYClFtzMkP3xuR/O3+ntqCrmm1nc
 xoSe1PS19HaXhnQnYsZt5+L7BWtlTggmtDmTaDBLO+RXV84JE9NAy72QzuwILGn1UH7B
 s+cg==
X-Gm-Message-State: AOJu0Yx1fyOzeYwVEISk4BdJoEElZAqHMjdGRdnhhyNqilvYZEgPy8UB
 9XzHG/6gi42qQ8L5I4Tme1k16aX5prcF2vHq6w0/Pwz3hGp5OREztp3/fy+2UuwMyAXbZeIRbVK
 zPXnSEvAMq58FaZw=
X-Received: by 2002:a17:907:7857:b0:9b2:b153:925 with SMTP id
 lb23-20020a170907785700b009b2b1530925mr1791116ejc.21.1696422237513; 
 Wed, 04 Oct 2023 05:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUV//bx0bFjj9czDG/W7MgKFieE/+cLiIYgWNXGjs7aIaSw+W1USSDph6b6Ar41Jw/hbf5dg==
X-Received: by 2002:a17:907:7857:b0:9b2:b153:925 with SMTP id
 lb23-20020a170907785700b009b2b1530925mr1791103ejc.21.1696422237123; 
 Wed, 04 Oct 2023 05:23:57 -0700 (PDT)
Received: from ?IPV6:2003:cf:d708:66e5:a5d0:fe92:2899:7179?
 (p200300cfd70866e5a5d0fe9228997179.dip0.t-ipconnect.de.
 [2003:cf:d708:66e5:a5d0:fe92:2899:7179])
 by smtp.gmail.com with ESMTPSA id
 h14-20020a17090634ce00b0099b6becb107sm2735732ejb.95.2023.10.04.05.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 05:23:56 -0700 (PDT)
Message-ID: <80b221c8-cf25-522b-777f-a88f1638b1e6@redhat.com>
Date: Wed, 4 Oct 2023 14:23:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] vhost-user: do not send RESET_OWNER on device reset
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 eperezma@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20231004014532.1228637-1-stefanha@redhat.com>
 <20231004014532.1228637-2-stefanha@redhat.com>
 <346cfde5-82af-724e-cc02-8f55d06e67ee@redhat.com>
 <CAJSP0QV0OWEAYB8h45fK4Gep2OVC7VM0daJbdDXunSpj-2Wctw@mail.gmail.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <CAJSP0QV0OWEAYB8h45fK4Gep2OVC7VM0daJbdDXunSpj-2Wctw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 04.10.23 13:15, Stefan Hajnoczi wrote:
> On Wed, 4 Oct 2023 at 06:44, Hanna Czenczek <hreitz@redhat.com> wrote:
>> On 04.10.23 03:45, Stefan Hajnoczi wrote:
>>> The VHOST_USER_RESET_OWNER message is deprecated in the spec:
>>>
>>>      This is no longer used. Used to be sent to request disabling all
>>>      rings, but some back-ends interpreted it to also discard connection
>>>      state (this interpretation would lead to bugs).  It is recommended
>>>      that back-ends either ignore this message, or use it to disable all
>>>      rings.
>> According to the spec, it is then indeed better to not call it in
>> vhost_user_reset_device, because it seems like it would be interpreted
>> as something completely different.
>>
>> However, between the three back-end implementations of vhost-user I know
>> of (libvhost-user, DPDK, the vhost crates; four if you count RSD), none
>> implement RESET_DEVICE.  libvhost-user and DPDK do implement
>> RESET_OWNER, though, and they both do it by resetting the device, not by
>> disabling any vring.  The vhost crate also implements RESET_OWNER, but
>> it doesn’t do anything but forward it as such to the actual device
>> implementation (virtiofsd doesn’t implement this function, so ignores
>> it).  It does document that it would disable all vrings, but does so in
>> the past and has marked it deprecated (ever since the method was
>> introduced in the fourth commit to the repository, making it extremely
>> unlikely that anyone would implement it).
> Hi Hanna,
> vhost-user-backend still seems to reset all vhost-user protocol state,
> making RESET_OWNER unusable:
> https://github.com/rust-vmm/vhost/blob/main/crates/vhost-user-backend/src/handler.rs#L230
>
> Have I missed something?

No, I missed that.  I overlooked that when grepping for reset_owner.

This implementation kind of does follow the original pre-2015 
description of RESET_OWNER, but I can’t believe this code originated 
from pre-2015, which makes it really weird.  It’s strange that in a 
commit from April 2019 the vhost crate marked the function as (“no 
longer used”), and then it was implemented in September of 2019, notably 
as something completely different than “Used to be sent to request 
disabling all rings”.

Another thing I noticed is that while libvhost-user does call the 
function vu_reset_device_exec(), what it does is indeed disable all 
vrings instead of resetting anything, i.e. what the spec says (and what 
I didn’t think anyone did).

DPDK interestingly does do a reset, and this includes clearing 
protocol_features (in reset_device()).

So two things: First, I’d prefer (slightly) for the commit message to 
mention that while RESET_OWNER would not be usable for a reset if 
everything were according to spec, the main problem to me seems that 
RESET_OWNER was never clearly defined before being deprecated, so 
different implementations do different things regardless of what the 
spec says now, which means it’s basically burned and no front-end may 
ever issue it at all lest it wants to get the back-end into an 
implementation-defined state.

Second, I wonder what exactly you mean by saying that RESET_OWNER 
resetting all vhost-user protocol state were to make the command 
unusable for resetting.  The vhost-user-backend implementation doesn’t 
clear all state, but resets only three things: The @owned field (which I 
don’t think is really used outside of 
vhost/src/vhost_user/dummy_slave.rs (this name is begging for a 
conscious language overhaul...), which appears not really important?), 
the virtio features (this I would expect any device reset to do), and 
the vhost-user protocol features.  Now, yes, clearing the vhost-user 
protocol features doesn’t seem like something that should be done just 
because of a device reset. However, note that DPDK’s reset_device() does 
this, too.  What I’m getting at is that we don’t have a clear definition 
of what RESET_DEVICE is supposed to do either, i.e. it doesn’t 
explicitly say that protocol features are not to be reset.  Sure, that 
may be obvious, but we should clarify this so that if e.g. DPDK is to 
implement RESET_DEVICE, they will take care not use its reset_device() 
implementation, which does reset protocol_features.

(Also, now that I look at RESET_DEVICE – why does it say that it 
disables all vrings?  (Has done so since its introduction.)  Is this 
something that qemu expects and will handle, i.e. that after a 
guest-initiated reset, the rings are enabled when the guest wants to use 
the device again?  Also, it doesn’t say the rings are stopped, so 
basically, as it is *right now* (where we only have three ring states, 
stopped, started+disabled, started+enabled), disabling vrings implicitly 
means they must still be started, because they can’t be disabled when 
stopped.  I’m going to change that, but as it reads right now, 
RESET_DEVICE does not seem like the reset we want. We should really get 
to fix that, too, before back-ends start to actually implement it.)

Hanna


