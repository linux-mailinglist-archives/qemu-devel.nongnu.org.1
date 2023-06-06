Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6D47246E5
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:55:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Y4v-0000oV-HG; Tue, 06 Jun 2023 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1q6Y4t-0000oG-UW
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1q6Y4s-0005mt-4A
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686063263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gSeT4qIrWCcoxuhq22rggORr/hr2cJ49wMUyCkVe4Vc=;
 b=ScmMPWHVTwlJVb8CLUSvDolDJZlMP+uRZwLlpfOUyYuwOx3E/K88hCqBHDbYUTXsKPyker
 UHd3NpqFOSmrXo9PPEg/+ynBeqVsybExCQ7EyxpKJ8vroEp6nfhiVRC7Pf0kPrufGywEAE
 UNkxRTY12GiV7QdJlK2jS+5HFda84qY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-DuRq7RuuMOK4USXIDakMyg-1; Tue, 06 Jun 2023 10:54:21 -0400
X-MC-Unique: DuRq7RuuMOK4USXIDakMyg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b2c4b3e02so429892285a.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686063259; x=1688655259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gSeT4qIrWCcoxuhq22rggORr/hr2cJ49wMUyCkVe4Vc=;
 b=fqms5Fk+e1ovudXwrJZ5732r1mzZgzhencfATHLywagiQHvsVQABujpY4MYOjDNWer
 EUKdA0FF7Bee3tMMRX4FXa2KyGAQ2UuSYL9NO5c35sr7WP4L94HpykR2V/0yR38cF4YD
 8fk8Hoi8ZVph6zGc3lJrERB7Pbovgm9u6qAJQE8G1tltGxdj8TReJDD12amI0ACmFvzP
 aeFZWaZtzwU6moVxEwAnTaDeElT9hgTBsIWpXr0UCf02y628xvZ7a1jEGlDcfr5NJapC
 sXW9wnuMkyl1bcPswhfAgdrvI82IAJOAw+t5/tBEjoujo5hhoOL1nG/QYbcJHKu0FRix
 qDdw==
X-Gm-Message-State: AC+VfDwYnnA3uMTzN3NIN0Ws9NcwkzFVNl/67gDMzWMD/NsTcm+Xs5lW
 5UYL0BAriQSBwUf+e/1Q7xU9CfYEo3ydMTq4DDY3dy0GOQhqlXbHhQAi8VPcKwsqMSLttpxIG1r
 mWRiefKGubrw+Xq4=
X-Received: by 2002:a05:620a:b05:b0:75d:1f4d:2d9a with SMTP id
 t5-20020a05620a0b0500b0075d1f4d2d9amr3252468qkg.1.1686063259453; 
 Tue, 06 Jun 2023 07:54:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6OKU3THGjmEsTHmfrSMtKowXLkuDgcx624jVAw/cPVDnAczxptxBZQOucOb+++1qzPYgl6kw==
X-Received: by 2002:a05:620a:b05:b0:75d:1f4d:2d9a with SMTP id
 t5-20020a05620a0b0500b0075d1f4d2d9amr3252453qkg.1.1686063259153; 
 Tue, 06 Jun 2023 07:54:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 g14-20020ae9e10e000000b0075bcc5ab975sm4948347qkm.92.2023.06.06.07.54.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:54:18 -0700 (PDT)
Message-ID: <877c8a79-6834-3d8a-a8f1-0c115b850821@redhat.com>
Date: Tue, 6 Jun 2023 16:54:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v1 0/4] Expose GPU memory as coherently CPU accessible
Content-Language: en-US
To: ankita@nvidia.com, jgg@nvidia.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org
References: <20230605235005.20649-1-ankita@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230605235005.20649-1-ankita@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hello Ankit,

On 6/6/23 01:50, ankita@nvidia.com wrote:
> From: Ankit Agrawal <ankita@nvidia.com>
> 
> NVIDIA is building systems which allows the CPU to coherently access
> GPU memory. This GPU device memory can be added and managed by the
> kernel memory manager. The patch holds the required changes in QEMU
> to expose this memory to the device assigned VMs.
> 
> The GPU device memory region is exposed as device BAR1 and QEMU mmaps to
> it. It then adds new proximity domains to represent the memory in the
> VM ACPI SRAT. This allows the device memory to be added as separate NUMA
> nodes inside the VM. The proximity domains (PXM) are passed to the VM
> using ACPI DSD properties to help VM kernel modules add the memory.
> 
> Current Linux cannot create NUMA nodes on the fly, hence creating enough
> NUMA nodes in ACPI is needed so that they are available at the VM bootup
> time. The physical platform firwmare provides 8 NUMA nodes, which QEMU
> is emulating here.
> 
> A new vfio-pci variant driver is added to manage the device memory and
> report as a BAR. Ongoing review of the corresponding kernel side changes
> along with the new vfio-pci variant driver.
> Ref: https://lore.kernel.org/lkml/20230405180134.16932-1-ankita@nvidia.com/
> 
> Applied over v8.0.2.
> 
> Ankit Agrawal (4):
>    qemu: add GPU memory information as object
>    qemu: patch guest SRAT for GPU memory
>    qemu: patch guest DSDT for GPU memory
>    qemu: adjust queried bar size to power-of-2


Please use "vfio:" subject prefix when modifying the hw/vfio files.
If you are not sure and want to know what is the current practice,
simply run :
    
   git log --pretty=oneline  <files>

Also, to know who to send the series, please use :

   ./scripts/get_maintainer.pl <patches>

Thanks,

C.

> 
>   hw/arm/virt-acpi-build.c    | 54 ++++++++++++++++++++++++++++
>   hw/pci-host/gpex-acpi.c     | 71 ++++++++++++++++++++++++++++++++++++
>   hw/vfio/common.c            |  2 +-
>   hw/vfio/pci-quirks.c        | 13 +++++++
>   hw/vfio/pci.c               | 72 +++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.h               |  1 +
>   include/hw/pci/pci_device.h |  3 ++
>   7 files changed, 215 insertions(+), 1 deletion(-)
> 


