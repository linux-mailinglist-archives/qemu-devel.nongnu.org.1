Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D77BA7EC1DD
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 13:11:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Eio-0003nd-Rj; Wed, 15 Nov 2023 07:10:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3EiS-0003n6-Bm
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:09:57 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3EiP-0003j5-Sy
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 07:09:55 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50fbc218bso88921761fa.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 04:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700050187; x=1700654987; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ffVui3aGzWT7dRXj6u7cuE8oTAweUYzRzYhL5COj/kA=;
 b=gZ0wrjE1RH0GNPljyPPjn2+yAUOUrLD7FFBlGThGCapVV31BzPyCUtetqREhJ2N98k
 7ErnwfVJq5vMDLq1/g1rFmAPpuMamUDNpwzcD/KGEy3J6MaegZ8l2k4N5CGZEyhMdToE
 29C+cyRuxu3kN+P3P+DA7009eYLqllXM40r81//UMGHcG+YKz2LuJgL1hvQcSC+PCqJG
 7pdAqzqzFhJuIbZN6iHVICj5U9c80JIf6J1J1+atn3fiTzoG3UBqspxR/mqob5xdTQpi
 xWK1n+fggriHkQsKwW3By/Sfub/IViu8LLXbGnWXCLlxCymjadDqsYYtb7ABHNRaTbWN
 0Qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700050187; x=1700654987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffVui3aGzWT7dRXj6u7cuE8oTAweUYzRzYhL5COj/kA=;
 b=wq+20i7iAbpQVf6fz300iXhIK+dHUkroFpFmRBWptQfxQT2DSxPL17WyJaUOtwbDHF
 3eAWzlVvk5Ae4LJojHid1ZijNPuhwY3TjI1G87m+OTEvi8UD7U3cuEYBQfwVwPhIu6Jj
 84Z7lRywLn2lzPXmgmpndxfQOxyB9tY4+2VEhfsY6yqSp9cAwKQa8kbMcqXgtho0ImB/
 cbX8Va//qTcp59ct3Yqnw1gRiWnATapLOTYSbDKuqER43lxcxWUBY0DadCyqoHHZ4jI9
 MQbjissI1XmAQDTz70X14ONj1ch8eTs+UQhwfBo9XzBmjOMojNZHC+VriON+8lZzCu1i
 smIg==
X-Gm-Message-State: AOJu0Yx7WpK60RHE4FBMC4ZZhsCmtzG+GClLo9qoGZoE1IhksrUQTMtX
 IEssXgNS/MsHimz4zEaQ9Rf32A==
X-Google-Smtp-Source: AGHT+IGv5zmpE0H6S4Dq10nvJpbittipNGCL1cFMax0jmheULOiZpdmdaQAvWSHYFZgBQJM6+t96zQ==
X-Received: by 2002:a2e:964f:0:b0:2c5:b87:39bc with SMTP id
 z15-20020a2e964f000000b002c50b8739bcmr4053682ljh.1.1700050187301; 
 Wed, 15 Nov 2023 04:09:47 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c198900b00407752bd834sm14902243wmq.1.2023.11.15.04.09.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 04:09:46 -0800 (PST)
Message-ID: <b6c6f336-8f56-415a-b6a7-fce19dfd2241@linaro.org>
Date: Wed, 15 Nov 2023 13:09:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/21] vfio/pci: Make vfio cdev pre-openable by passing
 a file handle
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, eric.auger@redhat.com,
 peterx@redhat.com, jasowang@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-12-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114100955.1961974-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Zhenzhong,

On 14/11/23 11:09, Zhenzhong Duan wrote:
> This gives management tools like libvirt a chance to open the vfio
> cdev with privilege and pass FD to qemu. This way qemu never needs
> to have privilege to open a VFIO or iommu cdev node.
> 
> Together with the earlier support of pre-opening /dev/iommu device,
> now we have full support of passing a vfio device to unprivileged
> qemu by management tool. This mode is no more considered for the
> legacy backend. So let's remove the "TODO" comment.
> 
> Add helper functions vfio_device_set_fd() and vfio_device_get_name()
> to set fd and get device name, they will also be used by other vfio
> devices.
> 
> There is no easy way to check if a device is mdev with FD passing,
> so fail the x-balloon-allowed check unconditionally in this case.
> 
> There is also no easy way to get BDF as name with FD passing, so
> we fake a name by VFIO_FD[fd].
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
> v6: simplify CONFIG_IOMMUFD checking code
>      introduce a helper vfio_device_set_fd
> 
>   include/hw/vfio/vfio-common.h |  3 +++
>   hw/vfio/helpers.c             | 44 +++++++++++++++++++++++++++++++++++
>   hw/vfio/iommufd.c             | 12 ++++++----
>   hw/vfio/pci.c                 | 28 ++++++++++++----------
>   4 files changed, 71 insertions(+), 16 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3dac5c167e..567e5f7bea 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -251,4 +251,7 @@ int vfio_devices_query_dirty_bitmap(VFIOContainerBase *bcontainer,
>                                       hwaddr size);
>   int vfio_get_dirty_bitmap(VFIOContainerBase *bcontainer, uint64_t iova,
>                                    uint64_t size, ram_addr_t ram_addr);
> +

Please add bare documentation:

   /* Returns 0 on success, or a negative errno. */

> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp);

Functions taking an Error** param should return a boolean, so:

   /* Return: true on success, else false setting @errp with error. */

> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>   #endif /* HW_VFIO_VFIO_COMMON_H */


> @@ -609,3 +611,45 @@ bool vfio_has_region_cap(VFIODevice *vbasedev, int region, uint16_t cap_type)
>   
>       return ret;
>   }
> +
> +int vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
> +{
> +    struct stat st;
> +
> +    if (vbasedev->fd < 0) {
> +        if (stat(vbasedev->sysfsdev, &st) < 0) {
> +            error_setg_errno(errp, errno, "no such host device");
> +            error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> +            return -errno;
> +        }
> +        /* User may specify a name, e.g: VFIO platform device */
> +        if (!vbasedev->name) {
> +            vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
> +        }
> +    } else {
> +        if (!vbasedev->iommufd) {
> +            error_setg(errp, "Use FD passing only with iommufd backend");
> +            return -EINVAL;
> +        }
> +        /*
> +         * Give a name with fd so any function printing out vbasedev->name
> +         * will not break.
> +         */
> +        if (!vbasedev->name) {
> +            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)

    bool vfio_device_set_fd(..., Error **errp)

> +{
> +    int fd = monitor_fd_param(monitor_cur(), str, errp);
> +
> +    if (fd < 0) {
> +        error_prepend(errp, "Could not parse remote object fd %s:", str);
> +        return;

            return false;

> +    }
> +    vbasedev->fd = fd;

        return true;

> +}
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index 3eec428162..e08a217057 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -326,11 +326,15 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       uint32_t ioas_id;
>       Error *err = NULL;
>   
> -    devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> -    if (devfd < 0) {
> -        return devfd;
> +    if (vbasedev->fd < 0) {
> +        devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
> +        if (devfd < 0) {
> +            return devfd;
> +        }
> +        vbasedev->fd = devfd;
> +    } else {
> +        devfd = vbasedev->fd;
>       }
> -    vbasedev->fd = devfd;
>   
>       ret = iommufd_cdev_connect_and_bind(vbasedev, errp);
>       if (ret) {
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c5984b0598..b23b492cce 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2944,17 +2944,19 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       VFIODevice *vbasedev = &vdev->vbasedev;
>       char *tmp, *subsys;
>       Error *err = NULL;
> -    struct stat st;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_STR_LEN];
>       char *name;
>   
> -    if (!vbasedev->sysfsdev) {
> +    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>           if (!(~vdev->host.domain || ~vdev->host.bus ||
>                 ~vdev->host.slot || ~vdev->host.function)) {
>               error_setg(errp, "No provided host device");
>               error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
> +#ifdef CONFIG_IOMMUFD
> +                              "or -device vfio-pci,fd=DEVICE_FD "
> +#endif
>                                 "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
>               return;
>           }
> @@ -2964,13 +2966,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>                               vdev->host.slot, vdev->host.function);
>       }
>   
> -    if (stat(vbasedev->sysfsdev, &st) < 0) {
> -        error_setg_errno(errp, errno, "no such host device");
> -        error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
> +    if (vfio_device_get_name(vbasedev, errp)) {

Clearer as:

        if (vfio_device_get_name(vbasedev, errp) < 0) {

>           return;
>       }

Regards,

Phil.

