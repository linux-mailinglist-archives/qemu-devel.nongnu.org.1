Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 825A17CBD29
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:14:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsfCz-0004v3-PT; Tue, 17 Oct 2023 04:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsfCx-0004us-Hv
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qsfCv-000297-EY
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697530419;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAb4Vo1xfKZw7D4FNVJESf3XuTkVxaK6teAzbsA34cQ=;
 b=OW5qfIi9U8MOTUCtMSfpjLEpL9npflmkwtqyXJ1+3g7kZ524nuAErJP/Ml1x8fImlqN9hZ
 RfrVrST7bC8x0S9Z+zK5UpzSfPjGz/9BS5FRAijXSalScs4UWIPaytCvToNVH8pU+KdUFt
 EZBd0XpaPV4GTmspyyswfTct0OKgRXM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-EXKx6lPrOkuyn9I_O2qGIQ-1; Tue, 17 Oct 2023 04:13:38 -0400
X-MC-Unique: EXKx6lPrOkuyn9I_O2qGIQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c12bb1f751so51233331fa.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 01:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697530416; x=1698135216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OAb4Vo1xfKZw7D4FNVJESf3XuTkVxaK6teAzbsA34cQ=;
 b=JmZV0kHJrO/NtZzXOWscUc+auBZxilI7L5LnOB37Il45tVAUdKl0fbZdc4rk5fI2Eu
 RtIpnhXiF2HYUH4pOnQ4ZaDM738ciXyX2nvZ+PaZC70gz8NQsSBsc+JfsNbCSAHaRF8i
 0nKSvM8QtFYDfvv9yvTCRb9Nko/Bxv1Xz7nZJY1M9/0cFFe2HLl2+U/F4W+mSMYwUAsb
 UlFeppofW5dKdhgOuuyHVHi+5480huXkyv1VI2aYkaOjRaHfa10XjDOlPS8/oEph6ivz
 5xqEu4iwoLRbif3q+yqE+P/7WWKt1cSjyiazN2envxnCAwfs56eqXN4PbHwYLr0AUKH9
 n84A==
X-Gm-Message-State: AOJu0YywZlYWSyhEHAH7Uf4zp5dbvAM6PB3B6Bi7efrgoO6JnvC/UhZf
 uR7D+0GFMH5aDfLBaCJ0BZKR0iJPKMM+C/lcU11Ux4EkKoqVvIC2Eeb0yrmMwkLLn8R5RgypuOP
 4a+eYSavqmzjccyw=
X-Received: by 2002:a05:651c:543:b0:2c4:fdc9:c8a3 with SMTP id
 q3-20020a05651c054300b002c4fdc9c8a3mr1284076ljp.50.1697530416697; 
 Tue, 17 Oct 2023 01:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWIrYY/hoG8f0wT1OzgXsfqxtauFo9WYzRzJcmDquMftIFvWGDD7QwgaRZQyGgtMG1M82TXQ==
X-Received: by 2002:a05:651c:543:b0:2c4:fdc9:c8a3 with SMTP id
 q3-20020a05651c054300b002c4fdc9c8a3mr1284061ljp.50.1697530416356; 
 Tue, 17 Oct 2023 01:13:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d746:c551:3d67:278e:c0a1:87a2?
 (p200300cfd746c5513d67278ec0a187a2.dip0.t-ipconnect.de.
 [2003:cf:d746:c551:3d67:278e:c0a1:87a2])
 by smtp.gmail.com with ESMTPSA id
 bi13-20020a05600c3d8d00b003fee567235bsm9154231wmb.1.2023.10.17.01.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 01:13:35 -0700 (PDT)
Message-ID: <3e26e29a-b861-deb2-b67a-5e505cf58429@redhat.com>
Date: Tue, 17 Oct 2023 10:13:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Virtio-fs] (no subject)
Content-Language: en-US
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtio-fs@redhat.com" <virtio-fs@redhat.com>,
 =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>,
 Parav Pandit <parav@nvidia.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
 Yajun Wu <yajunw@nvidia.com>
References: <e35f9f71-8d9d-6250-cbaa-70412b5a1149@nvidia.com>
 <3f28b1a4-d618-39df-57e6-6152f61cac6e@redhat.com>
 <8f3694c1-48d4-f34b-8f91-3bc217182ffa@redhat.com>
 <e19eb113-89b1-92ed-3375-8bc93c1ff39c@redhat.com>
 <8f51f02b-4676-c566-7304-f63e76df74ba@nvidia.com>
 <9a36a319-4567-f297-f14a-2025792ae93f@redhat.com> <87lecapxi4.fsf@linaro.org>
 <fbe05651-a65a-23d0-52be-2d611cc5740d@redhat.com> <87lec6mt03.fsf@linaro.org>
 <a7c01dd0-2b41-e294-f20c-a1edf6562a78@redhat.com>
 <20231017074943.gft6f672o6xzeepa@vireshk-i7>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20231017074943.gft6f672o6xzeepa@vireshk-i7>
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

On 17.10.23 09:49, Viresh Kumar wrote:
> On 13-10-23, 20:02, Hanna Czenczek wrote:
>> On 10.10.23 16:35, Alex Bennée wrote:
>>> I was going to say there is also the rust-vmm vhost-user-master crates
>>> which we've imported:
>>>
>>>     https://github.com/vireshk/vhost
>>>
>>> for the Xen Vhost Frontend:
>>>
>>>     https://github.com/vireshk/xen-vhost-frontend
>>>
>>> but I can't actually see any handling for GET/SET_STATUS at all which
>>> makes me wonder how we actually work. Viresh?
>> As far as I know the only back-end implementation of F_STATUS is in DPDK.
>> As I said, if anyone else implemented it right now, that would be dangerous,
>> because qemu doesn’t adhere to the virtio protocol when it comes to the
>> status byte.
> Yeah, none of the Rust based Virtio backends enable `STATUS` in
> `VhostUserProtocolFeatures` and so these messages are never exchanged.
>
> The generic Rust code for the backends, doesn't even implement them.
> Not sure if they should or not.

It absolutely should not, for evidence see this whole thread.  qemu 
sends a SET_STATUS 0, which amounts to a reset, when the VM is merely 
paused[1], and when it sets status bytes, it does not set them according 
to virtio specification.  Implementing it right now means relying on and 
working around qemu’s implementation-defined spec-breaking behavior.  
Also, note that qemu ignores feature negotiation response through 
FEATURES_OK, and DEVICE_NEEDS_RESET, so unless it’s worth working around 
the problems just to get some form of DRIVER_OK information (note this 
information does not come from the driver, but qemu makes it up), I 
absolutely would not implement it.

[1] Notably, it does restore the virtio state to the best of its 
abilities when the VM is resumed, but this is all still wrong (there is 
no point in doing so much on a pause/resume, it needlessly costs time) 
and any implementation that does a reset then will rely on the 
implementation-defined behavior that qemu is actually able to restore 
all the state that the back-end would lose during a reset. Notably, 
reset is not even well-defined in the vhost-user specification.  It was 
argued, in this thread, that DPDK works just fine with this, precisely 
because it ignores SET_STATUS 0.  Finally, if virtiofsd in particular, 
as a user of the Rust crates, is reset, it would lose its internal 
state, which qemu cannot restore short of using the upcoming migration 
facilities.


