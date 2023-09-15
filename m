Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F527A1DD6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7Vz-0000Nm-UK; Fri, 15 Sep 2023 08:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh7Vw-0000Ex-8V
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qh7Vo-0006R2-00
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694779286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CdxXzkpa/+ZHy9D3soMBDzrqQm9gHgdMxJWS5xQ2TlA=;
 b=AzeXNdWjyLlf+/C4S40TbqWxBkT+m5a+AFw+JBm6mV75MkVjxwa2zsuvtzcrRc9EY7pkFv
 r0WpIdLo7byPoRNNna/aHwkrgOlnd3vm9fjmcjwBrR1UDCTISW1p6qbfh3yoQ7kB515ocA
 sFfzVbeZ0WZZlAkcm21AXgdw9cbWfbM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-uQ_IXYIQPKSsgkZg-NYSJQ-1; Fri, 15 Sep 2023 08:01:25 -0400
X-MC-Unique: uQ_IXYIQPKSsgkZg-NYSJQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so15502235e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694779284; x=1695384084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdxXzkpa/+ZHy9D3soMBDzrqQm9gHgdMxJWS5xQ2TlA=;
 b=wm3LAAsHVR4LBWHHqiSsYOVIyBAE3lMqBUne4U1P7T4olYN4Grz+1jVVbwDDNoO5Fn
 x7C3rKbETn2GWKyXA5Tua6jU8d3/4RD8RWI+A7WH1l6bN7p9jQGRLAKaGFfd3aH1xuA1
 2PK2EdZ3tVPa2LaqaIWXc2/BsIOllv2wAxg5SDCvPCVhB+mbM0zPXn/gm7kv1gjz4lCI
 CS98LXVvb6hjIudKz3AHPvo335v5zzBeVM7BRmNshmmAbLsBFljwWnKFksKWIY7D8Fvx
 n2C3/ZXVeyxA6C4m1uHMerI4oEsYG0nmbTroGY+CBUMvX2is1HLAkjITAR1mUT3IvEWj
 AUcw==
X-Gm-Message-State: AOJu0Yy1lpNCB0K84UAWq3SrcGmocK5XWi8Upqh5Few+xcmD9ovvMe98
 qBUi4gZurPibymgysIkJRvWyyRTD60cRXqPVjw/HhSCQ7iGKJHk3ZBwxL7e7jPLIcDukThqphuZ
 4thb9rhtkKz7hntY=
X-Received: by 2002:a5d:540f:0:b0:317:6681:e426 with SMTP id
 g15-20020a5d540f000000b003176681e426mr1195096wrv.25.1694779284001; 
 Fri, 15 Sep 2023 05:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYFkJ1WRcC3HGg++hr77dNbs+H0xBCts+DVtNJuHEV9nD2RU4BIqpZIL7xMQa4L+0fjHKRyw==
X-Received: by 2002:a5d:540f:0:b0:317:6681:e426 with SMTP id
 g15-20020a5d540f000000b003176681e426mr1195073wrv.25.1694779283625; 
 Fri, 15 Sep 2023 05:01:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 l4-20020a5d4804000000b0030ada01ca78sm4195346wrq.10.2023.09.15.05.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:01:23 -0700 (PDT)
Message-ID: <1930cd66-393b-979c-7a81-d5615533cba0@redhat.com>
Date: Fri, 15 Sep 2023 14:01:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Usage of vfio-pci without KVM.
Content-Language: en-US
To: Shlomo Pongratz <shlomopongratz@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-discuss <qemu-discuss@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>
References: <CAHzK-V2a-tW8BQBJNurf0QogTNYH3_oEg7HAfi-dSU_3D626Tw@mail.gmail.com>
 <be58faf9-8218-e085-7dc3-b9c2858adac8@linaro.org>
 <20230912065753.37de2393.alex.williamson@redhat.com>
 <CAHzK-V2JxX7Gur_dDN2JtUbV=vWVaNefcinwLbKfu+AML2pE8A@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <CAHzK-V2JxX7Gur_dDN2JtUbV=vWVaNefcinwLbKfu+AML2pE8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/12/23 15:22, Shlomo Pongratz wrote:
> Hi,
> What can I as a user do to honor this requirement.
> Are you suggesting that I should patch the QEMU code as it is not
> supported out of the box?

You could try to upgrade your test environment to use upstream edk2
and QEMU first and change your PCI topology. It does work on my setup,
RHEL9 x86_64 host, RHEL9 aarch64 guest with a NVMe passthrough, under
libvirt.

$ lspci -tv
-[0000:00]-+-00.0  Red Hat, Inc. QEMU PCIe Host bridge
            +-01.0-[01]----00.0  Red Hat, Inc. Virtio 1.0 network device
            +-01.1-[02]----00.0  Red Hat, Inc. QEMU XHCI Host Controller
            +-01.2-[03]----00.0  Red Hat, Inc. Virtio 1.0 console
            +-01.3-[04]----00.0  Red Hat, Inc. Virtio 1.0 block device
            +-01.4-[05]----00.0  Red Hat, Inc. Virtio 1.0 memory balloon
            +-01.5-[06]----00.0  Red Hat, Inc. Virtio 1.0 RNG
            +-01.6-[07]--
            +-01.7-[08]--
            +-02.0-[09]----00.0  Micron/Crucial Technology P5 Plus NVMe PCIe SSD
            +-02.1-[0a]--
            +-02.2-[0b]--
            +-02.3-[0c]--
            +-02.4-[0d]--
            \-02.5-[0e]--


Thanks

C.


> 
> Thank you.
> 
> S.P.
> 
> On Tue, Sep 12, 2023 at 3:58 PM Alex Williamson
> <alex.williamson@redhat.com> wrote:
>>
>> On Tue, 12 Sep 2023 14:47:41 +0200
>> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>>> Cc'ing VFIO maintainers.
>>>
>>> On 12/9/23 14:39, Shlomo Pongratz wrote:
>>>> Hi,
>>>> I'm running qemu-system-aarch64 (QEMU emulator version 7.0.93) on
>>>> Ubuntu 20.04.4 LTS i with Intel's i7.
>>>> I'm trying to pass a Samsung NVME device using vfio-pci. I detached
>>>> the device from the nvme driver and attached it to the vfio-pci.
>>>> Using lspci I can see "Kernel driver in use: vfio-pci"
>>>> In QEMU script I've written "-device vfio-pci,host=0000:03:00.0" where
>>>> 0000:03:00.0 is the device PCI address.
>>>> I get the error
>>>> qemu-system-aarch64: -device vfio-pci,host=0000:03:00.0: VFIO_MAP_DMA
>>>> failed: Invalid argument
>>>> qemu-system-aarch64: -device vfio-pci,host=0000:03:00.0: vfio
>>>> 0000:03:00.0: failed to setup container for group 15: memory listener
>>>> initialization failed: Region mach-virt.ram:
>>>> vfio_dma_map(0x55855c75bf00, 0x40000000, 0x100000000, 0x7f5197e00000)
>>>> = -22 (Invalid argument
>>>>
>>>> My question is vfio-pci is supported with cross architecture?
>>
>> It does, but reserved address ranges need to be honored.  x86 has a
>> reserved range at 0xfee00000 for MSI mapping, so the VM address space
>> needs to be such that it avoids trying to place mappings there.  Thanks,
>>
>> Alex
>>
> 


