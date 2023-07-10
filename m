Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA2474CF2B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIljx-00085h-36; Mon, 10 Jul 2023 03:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qIljq-000856-49
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qIljo-0001sR-Ed
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688975715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xx+84ETFNR4NRMBJcjg8V11jELTtZwxiGipmXMfb1c=;
 b=ZEZocL5VZROQVP7pJru0GEcyC9SXmVqABAaTLO1fjNbpDXnXMtmyOHFXjmOwfiJUawtpAk
 iHjtDz4derO4T3nmbWhrMHoSAEttKRKF6SNkTzzkKfx9/ry1jQ1I71B8LPtQiGeo+ZggyD
 +4EAmrXVNh1DwSpU67i66Wq8bZa1kr4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-NSoFXCxzPjSjcNhQueyhkw-1; Mon, 10 Jul 2023 03:55:14 -0400
X-MC-Unique: NSoFXCxzPjSjcNhQueyhkw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so384602085a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:55:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688975713; x=1691567713;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5xx+84ETFNR4NRMBJcjg8V11jELTtZwxiGipmXMfb1c=;
 b=fqpS1vWERBVzVktTHb2pV7yy/RpXK33sGyCgBC1INMjIGuWS93NNXisdvf7QHm6HS6
 vFbNTOcuw/Hn1uaV2CraLqjpsLffReRihj/yHirSHPdJzJ7X7NC3ZZzzVBk77CdOA3/z
 NKGdx0nRsqi2nvG/hZ35MA2Fbf09LfatNpbLhqw5YV6cDcM9DkxoaZde6VdDg2MLSg8Y
 3ZI+LrHzb9qepJRua42hY5MeXHuADl3dgWeA2B1Ypsvsx3VW3SsSbAgYokU3fN0BZr/p
 6fLbMP+HQCXqeypBEi1X4Sgr61kRqEAFIZqGAsmyWPrjDoDAG10sH2PY0BO6mK/xqSm7
 As0Q==
X-Gm-Message-State: ABy/qLYoYAQ2mYuepoi/zT9Gjfau6jufWiSkU2idPm04ojcGKyG8LRZE
 ZEf6vewbycq4oAhrs92Iivx/8dt34x3qiLV/jCmmkkUMg2dNy7MpAKCWuzMoYJWmwIQ5yNZx2LT
 AchqvMUSxPFaKyC3mFrP/6DXikkkSQFTPkPD6nZLcvmGOXltJbKNdlpMUbcXcLDjbFFlq
X-Received: by 2002:a37:b441:0:b0:765:6782:cafd with SMTP id
 d62-20020a37b441000000b007656782cafdmr7842744qkf.69.1688975713505; 
 Mon, 10 Jul 2023 00:55:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG+0dNq6ZLnrBl90ApAyZ5GYbQc4MBEWv6A87BINNeoZ8y7n4LYqoS65sxYPV6wrpL8zDP3ZA==
X-Received: by 2002:a37:b441:0:b0:765:6782:cafd with SMTP id
 d62-20020a37b441000000b007656782cafdmr7842737qkf.69.1688975713207; 
 Mon, 10 Jul 2023 00:55:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 n22-20020a05620a153600b007672e3348edsm4610323qkk.108.2023.07.10.00.55.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 00:55:12 -0700 (PDT)
Message-ID: <87453f3a-d25a-6d10-6cc6-1fdc20022329@redhat.com>
Date: Mon, 10 Jul 2023 09:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 00/11] vfio queue
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20230710074848.456453-1-clg@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230710074848.456453-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/10/23 09:48, Cédric Le Goater wrote:
> The following changes since commit 2ff49e96accc8fd9a38e9abd16f0cfa0adab1605:
> 
>    Merge tag 'pull-tcg-20230709' of https://gitlab.com/rth7680/qemu into staging (2023-07-09 15:01:43 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20230710
> 
> for you to fetch changes up to 9495bf68dd2fe305f5e95a53ae146ca523dc2a02:
> 
>    vfio/pci: Enable AtomicOps completers on root ports (2023-07-10 09:46:09 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Fixes in error handling paths of VFIO PCI devices
> * Improvements of reported errors for VFIO migration
> * Linux header update
> * Enablement of AtomicOps completers on root ports
> * Fix for unplug of passthrough AP devices
> 
> ----------------------------------------------------------------
> Alex Williamson (3):
>        hw/vfio/pci-quirks: Sanitize capability pointer
>        pcie: Add a PCIe capability version helper
>        vfio/pci: Enable AtomicOps completers on root ports
> 
> Avihai Horon (1):
>        vfio: Fix null pointer dereference bug in vfio_bars_finalize()
> 
> Cédric Le Goater (1):
>        linux-headers: update to v6.5-rc1

I pushed this patch with an broken S-o-b tag. I will repush the tree.

Sorry about that,

C.


> 
> Tony Krowiak (1):
>        s390x/ap: Wire up the device request notifier interface
> 
> Zhenzhong Duan (5):
>        vfio/pci: Disable INTx in vfio_realize error path
>        vfio/migration: Change vIOMMU blocker from global to per device
>        vfio/migration: Free resources when vfio_migration_realize fails
>        vfio/migration: Remove print of "Migration disabled"
>        vfio/migration: Return bool type for vfio_migration_realize()
> 
>   hw/vfio/pci.h                                  |   1 +
>   include/hw/pci/pcie.h                          |   1 +
>   include/hw/vfio/vfio-common.h                  |   5 +-
>   include/standard-headers/drm/drm_fourcc.h      |  43 ++++++++
>   include/standard-headers/linux/const.h         |   2 +-
>   include/standard-headers/linux/pci_regs.h      |   1 +
>   include/standard-headers/linux/vhost_types.h   |  16 +++
>   include/standard-headers/linux/virtio_blk.h    |  18 ++--
>   include/standard-headers/linux/virtio_config.h |   6 ++
>   include/standard-headers/linux/virtio_net.h    |   1 +
>   linux-headers/asm-arm64/bitsperlong.h          |  23 -----
>   linux-headers/asm-arm64/kvm.h                  |  33 ++++++
>   linux-headers/asm-generic/bitsperlong.h        |  13 ++-
>   linux-headers/asm-generic/unistd.h             | 134 +++++++------------------
>   linux-headers/asm-mips/unistd_n32.h            |   1 +
>   linux-headers/asm-mips/unistd_n64.h            |   1 +
>   linux-headers/asm-mips/unistd_o32.h            |   1 +
>   linux-headers/asm-powerpc/unistd_32.h          |   1 +
>   linux-headers/asm-powerpc/unistd_64.h          |   1 +
>   linux-headers/asm-riscv/bitsperlong.h          |  13 ---
>   linux-headers/asm-riscv/kvm.h                  | 134 ++++++++++++++++++++++++-
>   linux-headers/asm-riscv/unistd.h               |   9 ++
>   linux-headers/asm-s390/unistd_32.h             |   2 +
>   linux-headers/asm-s390/unistd_64.h             |   2 +
>   linux-headers/asm-x86/kvm.h                    |   3 +
>   linux-headers/asm-x86/unistd_32.h              |   1 +
>   linux-headers/asm-x86/unistd_64.h              |   1 +
>   linux-headers/asm-x86/unistd_x32.h             |   1 +
>   linux-headers/linux/const.h                    |   2 +-
>   linux-headers/linux/kvm.h                      |  18 +++-
>   linux-headers/linux/mman.h                     |  14 +++
>   linux-headers/linux/psp-sev.h                  |   7 ++
>   linux-headers/linux/userfaultfd.h              |  17 +++-
>   linux-headers/linux/vfio.h                     |  27 +++++
>   linux-headers/linux/vhost.h                    |  31 ++++++
>   hw/pci/pcie.c                                  |   7 ++
>   hw/vfio/ap.c                                   | 113 +++++++++++++++++++++
>   hw/vfio/common.c                               |  51 +---------
>   hw/vfio/migration.c                            |  51 +++++++---
>   hw/vfio/pci-quirks.c                           |  10 +-
>   hw/vfio/pci.c                                  |  91 ++++++++++++++++-
>   41 files changed, 678 insertions(+), 229 deletions(-)
> 


