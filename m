Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4247BB555
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:34:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoi9K-00079t-GV; Fri, 06 Oct 2023 06:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoi9J-00079e-1f
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:33:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qoi9F-0006Ex-LL
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696588412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSObnGQjql5XtiF1FZHG9BcCQWZ9zF24st7TukUwPBA=;
 b=AzqfJwxe9ovw0W6WVK/0Moh7wKG/clCk5nFmd+afjTzZslCFuFRr1oZLof8kahP1JMQ3oK
 O4KeIVCDjaSvAG/ERsXUtWSVIv+/zWrqPqCA44WZkIzHUA17n0nVg3wfLUfqxSxFO0/kT/
 qW+GHypriXQbvUdXNUHtaHkBtihJEF0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-HBtyDCrpNqeEhMJ2KpFTuw-1; Fri, 06 Oct 2023 06:33:25 -0400
X-MC-Unique: HBtyDCrpNqeEhMJ2KpFTuw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77593f7173eso253182085a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 03:33:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696588405; x=1697193205;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSObnGQjql5XtiF1FZHG9BcCQWZ9zF24st7TukUwPBA=;
 b=xUXjoNvB92F98xy34N53fjVEoebRyLH9KzPTREYNwS/8GP6/zcoz1o/2YZFd4S50U7
 +cO1qgqulYbpCzw4LMPuasxBNPqEGIpLUDOTCzQ01nIs5y8gopfDUoaXdzeemya6rUkn
 DdQ1Apg89rxKJ+ODcT0JdeyZDZsxJl2gGEsN4vA5iclUPhk2zNpT2R5TUTq6YRwObU9C
 ofAVVlmCRL+YTjZIVCYVbznxQmlczFH+sFMy082Z+/CAn1OrAu8t5T73e07t+lkT340h
 BG0/mgTFpkoPIgzqpVHrYPjwxMm0uxRZqD/Ss17vSaDEVVBLrZO/B10tsv+FQhE9atPI
 tEXw==
X-Gm-Message-State: AOJu0Yy4fFG9RhENUjOHv1xFHXq44Jbl5OxfpRiLIRt7hHbE5jMBhR7R
 IQFCUVCubTITwbMIRx4oVT4uMD4dDVLAqHXWWAia7lEYHevaKzsCqadhgHTqS2t3aFMQ+2yL8mA
 9YjzaYsAhqOct3mzSY8sn/b/nQRK+CeoFXk8NlzCWSyUBlTaJta76lB0vqG2zaian3aWZ
X-Received: by 2002:a05:620a:46:b0:773:ea18:f825 with SMTP id
 t6-20020a05620a004600b00773ea18f825mr7534092qkt.77.1696588405026; 
 Fri, 06 Oct 2023 03:33:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPODIG02X+ctOO8u84dDJGtaIOmk+4/AEsEo2A56AOxUFQ9uhHBj6y1V2Wlz1TD/swFNo6Zw==
X-Received: by 2002:a05:620a:46:b0:773:ea18:f825 with SMTP id
 t6-20020a05620a004600b00773ea18f825mr7534075qkt.77.1696588404679; 
 Fri, 06 Oct 2023 03:33:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 pj30-20020a05620a1d9e00b00775afce4235sm1178182qkn.131.2023.10.06.03.33.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 03:33:23 -0700 (PDT)
Message-ID: <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
Date: Fri, 6 Oct 2023 12:33:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eauger@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231006062005.1040296-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On 10/6/23 08:19, Cédric Le Goater wrote:
> The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
> 
>    Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20231006
> 
> for you to fetch changes up to 6e86aaef9ac57066aa923211a164df95b7b3cdf7:
> 
>    vfio/common: Move legacy VFIO backend code into separate container.c (2023-10-05 22:04:52 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fix for VFIO display when using Intel vGPUs
> * Support for dynamic MSI-X
> * Preliminary work for IOMMUFD support

Stefan,

I just did some tests on z with passthough devices (PCI and AP) and
the series is not bisectable. QEMU crashes at patch  :

   "vfio/pci: Introduce vfio_[attach/detach]_device".

Also, with everything applied, the guest fails to start with :

  vfio: IRQ 0 not available (number of irqs 0)

So, please hold on and sorry for the noise. I will start digging
on my side.

Thanks,

C.

> ----------------------------------------------------------------
> Alex Williamson (1):
>        vfio/display: Fix missing update to set backing fields
> 
> Eric Auger (7):
>        scripts/update-linux-headers: Add iommufd.h
>        vfio/common: Propagate KVM_SET_DEVICE_ATTR error if any
>        vfio/common: Introduce vfio_container_add|del_section_window()
>        vfio/pci: Introduce vfio_[attach/detach]_device
>        vfio/platform: Use vfio_[attach/detach]_device
>        vfio/ap: Use vfio_[attach/detach]_device
>        vfio/ccw: Use vfio_[attach/detach]_device
> 
> Jing Liu (4):
>        vfio/pci: detect the support of dynamic MSI-X allocation
>        vfio/pci: enable vector on dynamic MSI-X allocation
>        vfio/pci: use an invalid fd to enable MSI-X
>        vfio/pci: enable MSI-X in interrupt restoring on dynamic allocation
> 
> Yi Liu (2):
>        vfio/common: Move IOMMU agnostic helpers to a separate file
>        vfio/common: Move legacy VFIO backend code into separate container.c
> 
> Zhenzhong Duan (7):
>        vfio/pci: rename vfio_put_device to vfio_pci_put_device
>        linux-headers: Add iommufd.h
>        vfio/common: Extract out vfio_kvm_device_[add/del]_fd
>        vfio/common: Move VFIO reset handler registration to a group agnostic function
>        vfio/common: Introduce a per container device list
>        vfio/common: Store the parent container in VFIODevice
>        vfio/common: Introduce a global VFIODevice list
> 
>   hw/vfio/pci.h                   |    1 +
>   include/hw/vfio/vfio-common.h   |   60 +-
>   linux-headers/linux/iommufd.h   |  444 +++++++++
>   hw/vfio/ap.c                    |   69 +-
>   hw/vfio/ccw.c                   |  122 +--
>   hw/vfio/common.c                | 1885 +++------------------------------------
>   hw/vfio/container.c             | 1161 ++++++++++++++++++++++++
>   hw/vfio/display.c               |    2 +
>   hw/vfio/helpers.c               |  612 +++++++++++++
>   hw/vfio/pci.c                   |  194 ++--
>   hw/vfio/platform.c              |   43 +-
>   hw/vfio/meson.build             |    2 +
>   hw/vfio/trace-events            |    6 +-
>   scripts/update-linux-headers.sh |    3 +-
>   14 files changed, 2580 insertions(+), 2024 deletions(-)
>   create mode 100644 linux-headers/linux/iommufd.h
>   create mode 100644 hw/vfio/container.c
>   create mode 100644 hw/vfio/helpers.c
> 


