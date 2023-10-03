Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CB67B6C77
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qngn5-0003EX-LA; Tue, 03 Oct 2023 10:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qngn2-0003DL-Rt
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qngmy-0003ft-A9
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696344859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YdVn9J/4dMFYxzY12Sm72BfHENYSEhIZTLEk8Ychc4g=;
 b=He/bOyOfSftGA8liZGo/8WAXOs7fjSz1mVbTduNc9bzruImKOfxvMJ/iWt81gjjpaNUA8B
 GBqnaC9weZcU0HE7ZWwr/HEYdH28/2srus/vnKJQie+6AeJKt4we+IP0cPWAC9WVUjwRQT
 VkQOMP6gBO18WE0303GU6AnbmaXbUWU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-hGGU_uCdNQCLFYue3a-xoA-1; Tue, 03 Oct 2023 10:54:03 -0400
X-MC-Unique: hGGU_uCdNQCLFYue3a-xoA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4180b3527c7so11899721cf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696344842; x=1696949642;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YdVn9J/4dMFYxzY12Sm72BfHENYSEhIZTLEk8Ychc4g=;
 b=tdHEVeOpOZuOOXcQroqY1EylRey7tRXJAigtHK+vtvoi/DE4RIioSfVbQK3EHseswL
 ZdztcM0IGUi42IfO66BaMm6UgHboN7vW0H8ElNIALLm2j9vzaunCdpkkusn91I5ybv42
 00yOQQh6T06gjOs6Vm9lD4Ozl5hfCucyfVGD8JXwUkcfjgGFZEQ6RAkyw+fhDmyn6hwQ
 40zdVMWOWbP65rZfgMQEomaNzTEOHFK4WTRYMnb0URC3jUYJBCA7hbCAFdKJOnAHtaiy
 qjkvc8rMx0TaOmHf6OxutSwKsj7E2kez0SC/71nJx6aNMiZFMZxnZM7UsX8Cn+/L0ImW
 PCUw==
X-Gm-Message-State: AOJu0Yws7nSmq8EI2RhXBM6eSqCy7T9TKWEDib2l0YrSoCdsyLHTuxJg
 ayF3yGbIJtZw9Amx1LIORTJ4REIfz7BwjiIPyyhAH2jHELywmiGh4Kh5maI9+e+kcjT+bZNlIwv
 ZqhF/sD3+vejWses=
X-Received: by 2002:a05:6214:4a91:b0:658:7441:ff1b with SMTP id
 pi17-20020a0562144a9100b006587441ff1bmr17357483qvb.45.1696344842721; 
 Tue, 03 Oct 2023 07:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk+mvc2e0qbHq3oaq0X06zO00hSngjAdwtkLpJyCKXT1S8AKPDK8FWotPlNyBGZpyeLk/Cow==
X-Received: by 2002:a05:6214:4a91:b0:658:7441:ff1b with SMTP id
 pi17-20020a0562144a9100b006587441ff1bmr17357449qvb.45.1696344842376; 
 Tue, 03 Oct 2023 07:54:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 q7-20020a0cf5c7000000b00656506a1881sm547008qvm.74.2023.10.03.07.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 07:54:02 -0700 (PDT)
Message-ID: <302f7b27-b367-d64c-a860-49e41192ac9f@redhat.com>
Date: Tue, 3 Oct 2023 16:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 04/15] vfio/common: Propagate KVM_SET_DEVICE_ATTR error
 if any
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-5-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-5-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 10/3/23 12:14, Eric Auger wrote:
> In the VFIO_SPAPR_TCE_v2_IOMMU container case, when
> KVM_SET_DEVICE_ATTR fails, we currently don't propagate the
> error as we do on the vfio_spapr_create_window() failure
> case. Let's align the code. Take the opportunity to
> reword the error message and make it more explicit.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> I think thise should end up in the
>      if (!container->initialized) {
>          if (!container->error) {
> path and call the error_propagate_prepend()

We could have this case also

     if (memory_region_is_ram_device(section->mr)) {
         error_report("failed to vfio_dma_map. pci p2p may not work");
         return;
     }

which was added by commit 567b5b309abe ("vfio/pci: Relax DMA map errors
for MMIO regions"). There were a few changes in the failure path, like
commit ac6dc3894fbb ("vfio: Generalize vfio_listener_region_add failure
path") and it is unclear to me which one will be used. Anyhow, this needs
some cleanup and this is what this patchset is proposing. Let's move on :

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/common.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4e122fc4e4..c54a72ec80 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -878,11 +878,11 @@ static void vfio_listener_region_add(MemoryListener *listener,
>                   QLIST_FOREACH(group, &container->group_list, container_next) {
>                       param.groupfd = group->fd;
>                       if (ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr)) {
> -                        error_report("vfio: failed to setup fd %d "
> -                                     "for a group with fd %d: %s",
> -                                     param.tablefd, param.groupfd,
> -                                     strerror(errno));
> -                        return;
> +                        error_setg_errno(&err, errno,
> +                                         "vfio: failed GROUP_SET_SPAPR_TCE for "
> +                                         "KVM VFIO device %d and group fd %d",
> +                                         param.tablefd, param.groupfd);
> +                        goto fail;
>                       }
>                       trace_vfio_spapr_group_attach(param.groupfd, param.tablefd);
>                   }


