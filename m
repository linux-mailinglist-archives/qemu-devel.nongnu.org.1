Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE55F71A175
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 17:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jnh-0004TK-Fd; Thu, 01 Jun 2023 11:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4jne-0004Rv-SN
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:01:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robin@streamhpc.com>)
 id 1q4jnb-0006to-Li
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:01:14 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-973bf581759so135588366b.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=streamhpc-com.20221208.gappssmtp.com; s=20221208; t=1685631669; x=1688223669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wR6iaCRu6kOBQfYwToBY3fa3qUbFrqLJXX7vZRcNXYU=;
 b=aLs6ZPkSS5IvNTqLR7tJF03n3mtAhjDLcKUjhqRX1d/LpJ7oVpHXy7eWLkLr/pvEN8
 88yRGRPfkulChENRCzB12XYeTPBbaGHniYFweh0FOtvjQO1CrpoXN2jWHgcdGxIjk8nd
 d31NGnihPCSTErmzeNEoEpvi3bG3Q88PUUMKUJlHAdBSNykwXDVeFBfD42gI27PHaJ0W
 chJQSbGaGHdKdAcdCezxUpLVIgd52lTjhfOyTKZRa6KlGYgGj3eli3OqBxKFCBWbRxlT
 Vo3EEQN9NVGJJZu9OU4ugTcpcI/7+l8SYZQYOmQKWZm8D0XHpUSZvS+jGSdiiPV6RdYT
 t54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685631669; x=1688223669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wR6iaCRu6kOBQfYwToBY3fa3qUbFrqLJXX7vZRcNXYU=;
 b=i3j6/UrrrH/S18kLRakOzypVRfpyvbLwQpD1AVJbeC+Em0Fjlw0jGxCCbvjy/F3004
 slDzfrZxU0thARkZ/VO7MTPexVbue4lclHYzhoZE2/t9u2N0nf9hMTXU/NjPwlOEQeI7
 rUusQiE2xDNXbtVOY6G7yee557OrSgHl5mM67+wcw5xoBtUyGDpEoIOBuUFkkRE3JEag
 5PObuZ1OuIeMd1N+KggFInkJs2b2vDK2IaWh+Yhjy7zBOw0hkeq5yIL61r7L0pLiIlnO
 l16CJ3JEGnU8rQcbif/qgORcLGgd4vSsR2/2vxBn46r2ePtJASz4I2mg0mVC+GkKd6Yh
 NXmQ==
X-Gm-Message-State: AC+VfDz4UozSSilTOA81M/c/5RzBdjxc1SC4Wz7is2dApopVo3mkZQxf
 5dMjKxZLaLf6g8jDoVXSW3YUtw==
X-Google-Smtp-Source: ACHHUZ7wA+eAgJ6/WAAjDBPC9z1gk0kX5uXfGL7F8RbG84kAi0y4t6PrzhFA1ooclgmmsfqfcGfFKA==
X-Received: by 2002:a17:907:a09:b0:974:5480:171e with SMTP id
 bb9-20020a1709070a0900b009745480171emr555457ejc.32.1685631668829; 
 Thu, 01 Jun 2023 08:01:08 -0700 (PDT)
Received: from [192.168.8.135] (095-097-139-014.static.chello.nl.
 [95.97.139.14]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170906960f00b00966069b78absm10599201ejx.192.2023.06.01.08.01.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 08:01:08 -0700 (PDT)
Message-ID: <0de45ad8-0b7d-f4db-e9df-0f74cb9527cb@streamhpc.com>
Date: Thu, 1 Jun 2023 17:01:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] vfio: Implement a common device info helper
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org
Cc: clg@redhat.com, philmd@linaro.org
References: <20230601144506.2105353-1-alex.williamson@redhat.com>
From: Robin Voetter <robin@streamhpc.com>
In-Reply-To: <20230601144506.2105353-1-alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=robin@streamhpc.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
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



On 6/1/23 16:45, Alex Williamson wrote:
> A common helper implementing the realloc algorithm for handling
> capabilities.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Reviewed-by: Robin Voetter <robin@streamhpc.com>

> ---
> 
> RFCv2 -> v1: Remove spurious semicolon
> 
>  hw/s390x/s390-pci-vfio.c      | 37 ++++------------------------
>  hw/vfio/common.c              | 46 ++++++++++++++++++++++++++---------
>  include/hw/vfio/vfio-common.h |  1 +
>  3 files changed, 41 insertions(+), 43 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
> index f51190d4662f..59a2e03873bd 100644
> --- a/hw/s390x/s390-pci-vfio.c
> +++ b/hw/s390x/s390-pci-vfio.c
> @@ -289,38 +289,11 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
>      memcpy(pbdev->zpci_fn.pfip, cap->pfip, CLP_PFIP_NR_SEGMENTS);
>  }
>  
> -static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev,
> -                                                uint32_t argsz)
> +static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
>  {
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
>  }
>  
>  /*
> @@ -335,7 +308,7 @@ bool s390_pci_get_host_fh(S390PCIBusDevice *pbdev, uint32_t *fh)
>  
>      assert(fh);
>  
> -    info = get_device_info(pbdev, sizeof(*info));
> +    info = get_device_info(pbdev);
>      if (!info) {
>          return false;
>      }
> @@ -356,7 +329,7 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
>  {
>      g_autofree struct vfio_device_info *info = NULL;
>  
> -    info = get_device_info(pbdev, sizeof(*info));
> +    info = get_device_info(pbdev);
>      if (!info) {
>          return;
>      }
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 78358ede2764..ed142296e9fe 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2843,11 +2843,35 @@ void vfio_put_group(VFIOGroup *group)
>      }
>  }
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
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp)
>  {
> -    struct vfio_device_info dev_info = { .argsz = sizeof(dev_info) };
> -    int ret, fd;
> +    g_autofree struct vfio_device_info *info = NULL;
> +    int fd;
>  
>      fd = ioctl(group->fd, VFIO_GROUP_GET_DEVICE_FD, name);
>      if (fd < 0) {
> @@ -2859,11 +2883,11 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>          return fd;
>      }
>  
> -    ret = ioctl(fd, VFIO_DEVICE_GET_INFO, &dev_info);
> -    if (ret) {
> +    info = vfio_get_device_info(fd);
> +    if (!info) {
>          error_setg_errno(errp, errno, "error getting device info");
>          close(fd);
> -        return ret;
> +        return -1;
>      }
>  
>      /*
> @@ -2891,14 +2915,14 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>      vbasedev->group = group;
>      QLIST_INSERT_HEAD(&group->device_list, vbasedev, next);
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
>      return 0;
>  }
>  
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index eed244f25f34..a8dcda592c08 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -212,6 +212,7 @@ void vfio_region_finalize(VFIORegion *region);
>  void vfio_reset_handler(void *opaque);
>  VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>  void vfio_put_group(VFIOGroup *group);
> +struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp);
>  

