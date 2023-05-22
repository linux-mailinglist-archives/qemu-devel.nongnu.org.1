Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E766870B65E
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 09:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0zpH-0007L5-Pq; Mon, 22 May 2023 03:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1q0zpF-0007Kr-Gx
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:19:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1q0zpD-0006Hm-RO
 for qemu-devel@nongnu.org; Mon, 22 May 2023 03:19:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684739962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gggc10JJQSof6SYFpkTb2K8wMPtIE9gC4MppJyvcz20=;
 b=Ip4RuxtUIvMBA4VM36a5T8bVQmXU+n8HokQtceFPiyXJ1VwvxoPgN3Dqmbcqz4a1SWTB8w
 ck6WAhxdHKhcIO0iwU8dEdRS3p37bJX0Tx0fY+00sJrV2ivp7C8FMrBZnkZEaDExHH+tDM
 HHMUFuwETwCkOvVi0oUZX485pT3Zbo8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-5f8wFUgnNO-7WMe7mliB_w-1; Mon, 22 May 2023 03:19:20 -0400
X-MC-Unique: 5f8wFUgnNO-7WMe7mliB_w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5ec8aac77so19495995e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 00:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684739960; x=1687331960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gggc10JJQSof6SYFpkTb2K8wMPtIE9gC4MppJyvcz20=;
 b=IdaU5b7gfjj0C1GGkDXOQg7xdtOJmf6nbiBr51Yf53SQ5ZxemyAwZD8AJIL1V70DK6
 Z1BRX0VnsOMaLvpI2qBxFXsZfchIpNJfvZ3XsLadOTK963WGfvSZr7HTEUpBS1NagGXp
 qZBh8z7DBPvj04Tl672/uGgvXJigylAa2CUbFiRDgWhPCa3nFufhkweH/wFcReDBTSgr
 6Zz6DM6mRuHEIqUQqDG1IPHYWlTUpyyrpHhd36uhfcPyymSEsFoMhDbIAGFNmq814siD
 21GEK/yadsh+MFqtxMJJbjjxLUWYEZYWTrGg1tSCODvEAEBIpmsMSgm43Wu3lEGt0ln1
 dGBA==
X-Gm-Message-State: AC+VfDyh1HIQ7BnFJpMoeeRgN1iO4orGQ/JOC9EfR2qXCxyMI1vA03FY
 ZEsGdl5o1qCNPN4cgFn/PjwyKsRtbD37u8teWw5t61au2zVvXlDnrWeDkZtRVjeADYf72FMqQoj
 6myVjzegw5vR9ViU=
X-Received: by 2002:a7b:c843:0:b0:3f1:979f:a734 with SMTP id
 c3-20020a7bc843000000b003f1979fa734mr6485007wml.11.1684739959845; 
 Mon, 22 May 2023 00:19:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7PaRgyXAVZcPCN7xaDvmo2ofOZNFn2YDye4RatwUzpDqTsxrY8l5EHd83Ed3d0p0juply/8w==
X-Received: by 2002:a7b:c843:0:b0:3f1:979f:a734 with SMTP id
 c3-20020a7bc843000000b003f1979fa734mr6484994wml.11.1684739959486; 
 Mon, 22 May 2023 00:19:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 h19-20020a05600c28d300b003f427cba193sm10513303wmd.41.2023.05.22.00.19.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 00:19:18 -0700 (PDT)
Message-ID: <3f739ca9-701d-8870-1e6b-199f6717945b@redhat.com>
Date: Mon, 22 May 2023 09:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH 2/4] vfio: Implement a common device info helper
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, robin@streamhpc.com,
 mst@redhat.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org
References: <20230519215739.402729-1-alex.williamson@redhat.com>
 <20230519215739.402729-3-alex.williamson@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230519215739.402729-3-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/19/23 23:57, Alex Williamson wrote:
> A common helper implementing the realloc algorithm for handling
> capabilities.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

This is a good independent clean up that could be merged now.

Thanks,

C.

> ---
>   hw/s390x/s390-pci-vfio.c      | 37 ++++------------------------
>   hw/vfio/common.c              | 46 ++++++++++++++++++++++++++---------
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 41 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index f51190d4662f..66e8ec3bdef9 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -289,38 +289,11 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
>       memcpy(pbdev->zpci_fn.pfip, cap->pfip, CLP_PFIP_NR_SEGMENTS);
>   }
>   
> -static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev,
> -                                                uint32_t argsz)
> +static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev);
>   {
> -    struct vfio_device_info *info = g_malloc0(argsz);
> -    VFIOPCIDevice *vfio_pci;
> -    int fd;
> +    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
>   
> -    vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
> -    fd = vfio_pci->vbasedev.fd;
> -
> -    /*
> -     * If the specified argsz is not large enough to contain all capabilities
> -     * it will be updated upon return from the ioctl.  Retry until we have
> -     * a big enough buffer to hold the entire capability chain.  On error,
> -     * just exit and rely on CLP defaults.
> -     */
> -retry:
> -    info->argsz = argsz;
> -
> -    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
> -        trace_s390_pci_clp_dev_info(vfio_pci->vbasedev.name);
> -        g_free(info);
> -        return NULL;
> -    }
> -
> -    if (info->argsz > argsz) {
> -        argsz = info->argsz;
> -        info = g_realloc(info, argsz);
> -        goto retry;
> -    }
> -
> -    return info;
> +    return vfio_get_device_info(vfio_pci->vbasedev.fd);
>   }
>   
>   /*
> @@ -335,7 +308,7 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>   
>       assert(fh);
>   
> -    info = get_device_info(pbdev, sizeof(*info));
> +    info = get_device_info(pbdev);
>       if (!info) {
>           return false;
>       }
> @@ -356,7 +329,7 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>   {
>       g_autofree struct vfio_device_info *info = NULL;
>   
> -    info = get_device_info(pbdev, sizeof(*info));
> +    info = get_device_info(pbdev);
>       if (!info) {
>           return;
>       }
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..ed142296e9fe 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2843,11 +2843,35 @@ void vfio_put_group(VFIOGroup *group)
>       }
>   }
>   
> +struct vfio_device_info *vfio_get_device_info(int fd)
> +{
> +    struct vfio_device_info *info;
> +    uint32_t argsz = sizeof(*info);
> +
> +    info = g_malloc0(argsz);
> +
> +retry:
> +    info->argsz = argsz;
> +
> +    if (ioctl(fd, VFIO_DEVICE_GET_INFO, info)) {
> +        g_free(info);
> +        return NULL;
> +    }
> +
> +    if (info->argsz > argsz) {
> +        argsz = info->argsz;
> +        info = g_realloc(info, argsz);
> +        goto retry;
> +    }
> +
> +    return info;
> +}
> +
>   int vfio_get_device(VFIOGroup *group, const char *name,
>                       VFIODevice *vbasedev, Error **errp)
>   {
> -    struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
> -    int ret, fd;
> +    g_autofree struct vfio_device_info *info = NULL;
> +    int fd;
>   
>       fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>       if (fd < 0) {
> @@ -2859,11 +2883,11 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>           return fd;
>       }
>   
> -    ret = ioctl(fd, VFIO_DEVICE_GET_INFO, &dev_info);
> -    if (ret) {
> +    info = vfio_get_device_info(fd);
> +    if (!info) {
>           error_setg_errno(errp, errno, "error getting device info");
>           close(fd);
> -        return ret;
> +        return -1;
>       }
>   
>       /*
> @@ -2891,14 +2915,14 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>       vbasedev->group = group;
>       QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
>   
> -    vbasedev->num_irqs = dev_info.num_irqs;
> -    vbasedev->num_regions = dev_info.num_regions;
> -    vbasedev->flags = dev_info.flags;
> +    vbasedev->num_irqs = info->num_irqs;
> +    vbasedev->num_regions = info->num_regions;
> +    vbasedev->flags = info->flags;
> +
> +    trace_vfio_get_device(name, info->flags, info->num_regions, info->num_irqs);
>   
> -    trace_vfio_get_device(name, dev_info.flags, dev_info.num_regions,
> -                          dev_info.num_irqs);
> +    vbasedev->reset_works = !!(info->flags & VFIO_DEVICE_FLAGS_RESET);
>   
> -    vbasedev->reset_works = !!(dev_info.flags & VFIO_DEVICE_FLAGS_RESET);
>       return 0;
>   }
>   
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..a8dcda592c08 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -212,6 +212,7 @@ void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
>   VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>   void vfio_put_group(VFIOGroup *group);
> +struct vfio_device_info *vfio_get_device_info(int fd);
>   int vfio_get_device(VFIOGroup *group, const char *name,
>                       VFIODevice *vbasedev, Error **errp);
>   


