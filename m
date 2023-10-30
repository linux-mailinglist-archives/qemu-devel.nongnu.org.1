Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D23B7DBB20
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:53:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxShJ-0004Kq-R3; Mon, 30 Oct 2023 09:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSh5-0004C6-Nw
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxSh4-0000oG-1n
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698673957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q01bZRDYpp1oz5ak8s4cs/lTX+pVJZmSzGP7jFbKtE8=;
 b=VgFUS4159cP2u65vE4SUHPkeudBo7gqv40xK8Ya9mLD9Y6F+yGtirtCPEDZQ/sBS5jhzlH
 uZa/l2BQ4ALUIoeca+fgOlo5he5XPTdap15JC4Ux12o1PdkJIr7hJAbCOYtVzgFP6U8fus
 uvoOWzRKffuiCbFvH3y5DxzKMya9qTw=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-fzeRaFOjMTqr-kEyldSnxw-1; Mon, 30 Oct 2023 09:52:26 -0400
X-MC-Unique: fzeRaFOjMTqr-kEyldSnxw-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3b2e21c06f9so6683641b6e.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 06:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698673945; x=1699278745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q01bZRDYpp1oz5ak8s4cs/lTX+pVJZmSzGP7jFbKtE8=;
 b=kjCewwV/KgLXbGCHK/Hf2Wni274hh46WLZ02dfaq9U0xbh7t4TDeY/DOkLwMLlI7wy
 aScyRSFUW9aGm3Hj6KcIiBxHnvYSF3SHLd4teHp9OTu44P9IdEd3dnXEn0Ca74CrI8Pl
 4q8WVeYBskytSoxUBPn/bSa3m2DzlTH+e11AX8JFaqX1GtX9yvzrSjTu1Dg/U7a5MB9m
 YvILgSOI0zX3jsjxkSn9zIhXZYWNML5c/vt7F4vD18azmlFmHYwIhXoCk1NRNEzTQDoY
 RmH7D0l2+ejK9Zl5njUkVVNPpfm1M8btwMGpgYWh4IWbzuThUoqhaldJXID3rkbKVqA2
 qnHg==
X-Gm-Message-State: AOJu0YxmGBl8BY1N2hqCrob31+ucOcnVnZqOc0SjXaVdUYfdMAMaXcMe
 i8VxW6AzmoB4xiMKOnhR5M1GoXXt4d4+trV2XtlR7hAqAQzLMwYW3DU3yIoOg4Zi7QTvKIGBdJF
 vSYIdNhCcN7//k/A=
X-Received: by 2002:a05:6808:bc6:b0:3b2:dd49:4e9d with SMTP id
 o6-20020a0568080bc600b003b2dd494e9dmr14948073oik.6.1698673945580; 
 Mon, 30 Oct 2023 06:52:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYa2FqCpPx6fk59Ioa6hGG2kYWAk7pU422ceMH8q+P1qykFB1yFCWtFMojw0NybebusT7KFQ==
X-Received: by 2002:a05:6808:bc6:b0:3b2:dd49:4e9d with SMTP id
 o6-20020a0568080bc600b003b2dd494e9dmr14948048oik.6.1698673945329; 
 Mon, 30 Oct 2023 06:52:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05620a03cd00b0077407e3d68asm3317303qkm.111.2023.10.30.06.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 06:52:24 -0700 (PDT)
Message-ID: <4adcd2be-98fb-45bc-9023-a08b035b8b71@redhat.com>
Date: Mon, 30 Oct 2023 14:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/37] vfio/iommufd: Switch to manual hwpt allocation
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-28-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231026103104.1686921-28-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/26/23 12:30, Zhenzhong Duan wrote:
> IOMMUFD supports auto allocated hwpt and manually allocated one.
> Manually allocated hwpt has benefit that its life cycle is under
> user's control, so it could be used as stage 2 page table by nested
> feature in the future.

Would an option be useful to switch from one mode to another ?

> 
> Introduce two helpers __vfio_device_attach/detach_hwpt to facilitate
> this change.

I think merging this change with the previous patch makes sense.
It doesn't add much to keep it as a standalone patch unless we
want a feature toggle.

Thanks,

C.


> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/iommufd.c | 89 +++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 70 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index aee64d63f3..c1daaf1c39 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -217,38 +217,91 @@ static VFIOIOASHwpt *vfio_container_get_hwpt(VFIOIOMMUFDContainer *container,
>   static void vfio_container_put_hwpt(IOMMUFDBackend *be, VFIOIOASHwpt *hwpt)
>   {
>       QLIST_REMOVE(hwpt, next);
> +    iommufd_backend_free_id(be->fd, hwpt->hwpt_id);
>       g_free(hwpt);
>   }
>   
> -static int vfio_device_attach_container(VFIODevice *vbasedev,
> -                                        VFIOIOMMUFDContainer *container,
> -                                        Error **errp)
> +static int __vfio_device_attach_hwpt(VFIODevice *vbasedev, uint32_t hwpt_id,
> +                                     Error **errp)
>   {
> -    int ret, iommufd = vbasedev->iommufd->fd;
> -    VFIOIOASHwpt *hwpt;
>       struct vfio_device_attach_iommufd_pt attach_data = {
>           .argsz = sizeof(attach_data),
>           .flags = 0,
> -        .pt_id = container->ioas_id,
> +        .pt_id = hwpt_id,
>       };
> +    int ret;
>   
> -    /* Attach device to an ioas within iommufd */
>       ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
>       if (ret) {
>           error_setg_errno(errp, errno,
> -                         "[iommufd=%d] error attach %s (%d) to ioasid=%d",
> -                         container->be->fd, vbasedev->name, vbasedev->fd,
> -                         attach_data.pt_id);
> +                         "[iommufd=%d] error attach %s (%d) to hwpt_id=%d",
> +                         vbasedev->iommufd->fd, vbasedev->name, vbasedev->fd,
> +                         hwpt_id);
> +    }
> +    return ret;
> +}
> +
> +static int __vfio_device_detach_hwpt(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct vfio_device_detach_iommufd_pt detach_data = {
> +        .argsz = sizeof(detach_data),
> +        .flags = 0,
> +    };
> +    int ret;
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "detach %s from ioas failed",
> +                         vbasedev->name);
> +    }
> +    return ret;
> +}
> +
> +static int vfio_device_attach_container(VFIODevice *vbasedev,
> +                                        VFIOIOMMUFDContainer *container,
> +                                        Error **errp)
> +{
> +    int ret, iommufd = vbasedev->iommufd->fd;
> +    VFIOIOASHwpt *hwpt;
> +    uint32_t hwpt_id;
> +    Error *err = NULL;
> +
> +    /* try to attach to an existing hwpt in this container */
> +    QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +        ret = __vfio_device_attach_hwpt(vbasedev, hwpt->hwpt_id, &err);
> +        if (ret) {
> +            const char *msg = error_get_pretty(err);
> +
> +            trace_vfio_iommufd_fail_attach_existing_hwpt(msg);
> +            error_free(err);
> +            err = NULL;
> +        } else {
> +            goto found_hwpt;
> +        }
> +    }
> +
> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> +                                     container->ioas_id, &hwpt_id);
> +
> +    if (ret) {
> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
>           return ret;
> +    }
>   
> +    /* Attach device to an hwpt within iommufd */
> +    ret = __vfio_device_attach_hwpt(vbasedev, hwpt_id, errp);
> +    if (ret) {
> +        iommufd_backend_free_id(iommufd, hwpt_id);
> +        return ret;
>       }
> -    hwpt = vfio_container_get_hwpt(container, attach_data.pt_id);
>   
> +    hwpt = vfio_container_get_hwpt(container, hwpt_id);
> +found_hwpt:
>       QLIST_INSERT_HEAD(&hwpt->device_list, vbasedev, next);
>       vbasedev->hwpt = hwpt;
>   
>       trace_vfio_iommufd_attach_device(iommufd, vbasedev->name, vbasedev->fd,
> -                                     container->ioas_id, attach_data.pt_id);
> +                                     container->ioas_id, hwpt->hwpt_id);
>       return ret;
>   }
>   
> @@ -256,14 +309,12 @@ static void vfio_device_detach_container(VFIODevice *vbasedev,
>                                            VFIOIOMMUFDContainer *container)
>   {
>       VFIOIOASHwpt *hwpt = vbasedev->hwpt;
> -    struct vfio_device_attach_iommufd_pt detach_data = {
> -        .argsz = sizeof(detach_data),
> -        .flags = 0,
> -    };
> +    Error *err = NULL;
> +    int ret;
>   
> -    if (ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data)) {
> -        error_report("detach %s from ioas id=%d failed: %m", vbasedev->name,
> -                     container->ioas_id);
> +    ret = __vfio_device_detach_hwpt(vbasedev, &err);
> +    if (ret) {
> +        error_report_err(err);
>       }
>   
>       QLIST_REMOVE(vbasedev, next);


