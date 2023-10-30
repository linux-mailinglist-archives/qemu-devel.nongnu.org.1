Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C9B7DBA66
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:16:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxS6m-0003l7-IF; Mon, 30 Oct 2023 09:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxS6g-0003ks-Ix
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:15:02 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxS6e-0001VR-1Z
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:15:01 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso3709996b3a.3
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698671699; x=1699276499;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OdzqFZHj2NW1M+p12UiDmr3Q2KJky3PUm/8VJBJ1X2c=;
 b=rZeCAWtznHDLtI/ZDGFOI828RigdXKvrBPJx+271+0U+X4NuYEktyrgdZhMqmxMVv3
 PcaKU83UEDkwRuZji4URF/4H7QPjYoNnW1uSnjCzP9LNkxt7ufNmoZUJKX86HPtIBjC3
 PWFWvrXglDCnP6SQRNZ8iO2p34lyC4mY9XrC+tQAiYmaDd2BrPGIGzfLSKSOplEQk4Rs
 yZiS9+9jj+TNQEb5vU62DeJDS3A+Jyga3PsAfBIuTTYSxQ4mntuXlCSnWgffrLwRv8WE
 skUGwwprYpURB3OkaQCVq3m9n+xlTnJnMyTBgrhMogm8kU5R7pJgjn2LbgUi/tFU606K
 tC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698671699; x=1699276499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OdzqFZHj2NW1M+p12UiDmr3Q2KJky3PUm/8VJBJ1X2c=;
 b=PTTeMg42aPIerGmb+LrNwK8Pc+daKeXAVqPqf+Tfu2/UEFmE8AF5FOh5UK09bo6XEY
 94eJ64jzFRt1evF5VNnFUUI4RPbuL+p6Rjb72SF7gvhEYA8w0frBSREgqmCGcjs+TcpD
 vS41/Lzm1jxcjbEon7UhzjQ2U6zW05LBE40XhNCqIecfq30XSj2PI+34xqhoUbh3Xfrn
 sRSZFkAJzSY5e4Ds3aQJotLaPVuvY9rzRhwo/5z2+spfkg+s0Z1YQTYTT4WrPVjvZsYq
 ACn74gqoJMErjVW2+MBXMLl5S2Vs5OOhnlIcGTYdO/gyF4Wq8bX33ZGvDxVUqs2kV/y8
 gAPQ==
X-Gm-Message-State: AOJu0Yya/lAfZbo0hImT5xM4fXpHOmIoM4IzmPwADFiVjUnGLImZz+yY
 eaRQMxDRswTy/HvKjDhNrocrxQ==
X-Google-Smtp-Source: AGHT+IE3s8dY6X9RtYE+4CR0nsSkNBWgDpVMRtmzsrWmNZhnsnR3ieD1QLJbKJLzSBMVbtfkZE7QAA==
X-Received: by 2002:a05:6a20:6a05:b0:17a:fcda:4a6b with SMTP id
 p5-20020a056a206a0500b0017afcda4a6bmr8830939pzk.13.1698671698659; 
 Mon, 30 Oct 2023 06:14:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x17-20020aa79571000000b0068bbe3073b6sm5825096pfq.181.2023.10.30.06.14.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 06:14:58 -0700 (PDT)
Message-ID: <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
Date: Mon, 30 Oct 2023 22:14:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Content-Language: en-US
To: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
 <20231030051356.33123-12-akihiko.odaki@daynix.com>
 <CAOEp5OdEEVcojjwCOU+9Z5yBKN+e5iNbAMOA5d-97D81N4Y0tw@mail.gmail.com>
 <58fb3b75-dd69-4715-a8ec-4c3df3b7e4c5@daynix.com>
 <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAOEp5Oern10jW8Pi-_mceU_ZJVD=a1f3tW8rB2O4efLX45-nvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/30 21:51, Yuri Benditovich wrote:
> 
> 
> On Mon, Oct 30, 2023 at 2:21 PM Akihiko Odaki <akihiko.odaki@daynix.com 
> <mailto:akihiko.odaki@daynix.com>> wrote:
> 
>     On 2023/10/30 21:14, Yuri Benditovich wrote:
>      >
>      >
>      > On Mon, Oct 30, 2023 at 7:14 AM Akihiko Odaki
>     <akihiko.odaki@daynix.com <mailto:akihiko.odaki@daynix.com>
>      > <mailto:akihiko.odaki@daynix.com
>     <mailto:akihiko.odaki@daynix.com>>> wrote:
>      >
>      >     vhost requires eBPF for RSS. When eBPF is not available,
>     virtio-net
>      >     implicitly disables RSS even if the user explicitly requests
>     it. Return
>      >     an error instead of implicitly disabling RSS if RSS is
>     requested but not
>      >     available.
>      >
>      >
>      > I think that suggesting RSS feature when in fact it is not
>     available is
>      > not a good idea, this rather desinforms the guest.
>      > Existing behavior (IMHO) makes more sense.
>      > We can extend this discussion if needed, of course.
> 
>     This change is not to advertise RSS when it's not available; it instead
>     reports an error to the user.
> 
>     For example, think of the following command line:
>     qemu-system-x86_64 -device virtio-net,rss=on,netdev=n -netdev user,id=n
> 
>     Before this change, it gives no error and the user will not know RSS is
>     not available. With this change it now gives an error as follows:
>     qemu-system-x86_64: -device virtio-net,rss=on,netdev=n: Can't load
>     eBPF RSS
> 
> 
> Does this mean failure to run QEMU if the RSS required in the command 
> line and EBPF can't be loaded?
> (for example if we run the system with kernel < 5.8)?
> I'm not sure this is user-friendly behavior...

This patch is wrong that it assumes software RSS is not enabled at all; 
I missed the vhost check before clearing VIRTIO_NET_F_RSS in 
virtio_net_get_features().

That said, I indeed intend to make it return a hard error for the case 
that RSS is requested for vhost but eBPF can't be loaded.

I believe the current behavior of implicitly disabling a feature 
explicitly requested by the user is not good, but we can still emit a 
warning instead of an error.

It's better to follow a convention common in QEMU but I see no 
documentation regarding this kind of situation. I know virtio-gpu gives 
an error in such a case but it's just one example.

I'd also like to ask Jason if we should have a warning or error. Perhaps 
we may better consult QOM maintainers too.

