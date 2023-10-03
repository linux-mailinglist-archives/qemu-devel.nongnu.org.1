Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 371E97B6D66
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 17:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnhbM-0005TH-GT; Tue, 03 Oct 2023 11:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhat-0005Sj-PY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:45:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qnhar-0004RK-IL
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 11:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696347951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MIKo0D6KLV1x/AuyDO3M7Lg8FwwQ3be98rEZKqPFI4=;
 b=PwNk1VxjPkEYo0rrXgb0z5m+wuPeHIH5UBQ0XaL/IXnIi96etIGER6YQAsx65EUE9kKY0q
 VArxbES+zhtDVRB78Uep+xdRB5TNDH8qbDnaQ9L7M8AdLe18iSgmlSDdssFzuB56d+71+J
 jczLmZP3u/KXV8d8u9/WsSI4yJNj0e8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-Kf_TyIy5P8aXupJ6BFW-4g-1; Tue, 03 Oct 2023 11:45:50 -0400
X-MC-Unique: Kf_TyIy5P8aXupJ6BFW-4g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-65b00c2cbb6so13900086d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 08:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696347949; x=1696952749;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2MIKo0D6KLV1x/AuyDO3M7Lg8FwwQ3be98rEZKqPFI4=;
 b=XqS5MuX8mow6l6zFPNEgUQ+bmZuBfL9DJD5QNTvReV7PjJVPXrHqBafKWYtwbjGCrJ
 mY8sLCr54PvAf4e72Yqab2lpAvW5bxaCBH5rH69v2R/IOQMKGnUFyz8MsYCb2uUHHssa
 YB9TI35m/CW01ubDWwoPcs9lBtdHFw2H+rxPy/z46SqPWcBnI9cXiS87UJRl41tW5mHJ
 zxcRjfQ44HAMu2IHoGYdpDNwh1SQQU/ghJ2MCIw/6g3W2GJDBfDNatVPjgMzbjE7CZL4
 6fBPNSyoFp/IwPjY+dyTOrOhKJ+iv1ZU7zNj/Hv3nEEfTKCWcUMQYTv1fjz8GyWJuY7q
 06JA==
X-Gm-Message-State: AOJu0Yxwq4j6Um3TYtIQivMcmkPNfxtA0R11RBGW0on6r/JYhzYJDMBQ
 x9VbIy8IyGycmdzxK2JWuNb/MB3V36eE1nuEDBv5Ajcoc92gZQ+lAE1WaDB5bvZtsM8Nqhxrb4j
 mtZl6r2bCqRCqlBU=
X-Received: by 2002:a0c:aa5b:0:b0:63c:fa7d:74ee with SMTP id
 e27-20020a0caa5b000000b0063cfa7d74eemr14081977qvb.50.1696347949655; 
 Tue, 03 Oct 2023 08:45:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEudGHfBXSmEVEWbsmP6xkks9F0HcyaHu3sefqxOF2M79PJ6aDtgWLlJ8e4NjSk9V85RK1n/g==
X-Received: by 2002:a0c:aa5b:0:b0:63c:fa7d:74ee with SMTP id
 e27-20020a0caa5b000000b0063cfa7d74eemr14081959qvb.50.1696347949325; 
 Tue, 03 Oct 2023 08:45:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a0cf30c000000b0065b079366a7sm567453qvl.114.2023.10.03.08.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 08:45:48 -0700 (PDT)
Message-ID: <2b5f76ed-6727-4e4c-c018-d47aa2e1c958@redhat.com>
Date: Tue, 3 Oct 2023 17:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, joao.m.martins@oracle.com,
 peterx@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-11-eric.auger@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231003101530.288864-11-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Let the vfio-ccw device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> Note that the migration reduces the following trace
> "vfio: subchannel %s has already been attached" (featuring
> cssid.ssid.devid) into "device is already attached"
> 
> Also now all the devices have been migrated to use the new
> vfio_attach_device/vfio_detach_device API, let's turn the
> legacy functions into static functions, local to container.c.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> 
> ---
> v2 -> v3:
> - Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>    while keeping into account Matthew's comment
>    https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/
> ---
>   include/hw/vfio/vfio-common.h |   5 --
>   hw/vfio/ccw.c                 | 122 +++++++++-------------------------
>   hw/vfio/common.c              |  10 +--
>   3 files changed, 37 insertions(+), 100 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 12fbfbc37d..c486bdef2a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -202,7 +202,6 @@ typedef struct {
>       hwaddr pages;
>   } VFIOBitmap;
>   
> -void vfio_put_base_device(VFIODevice *vbasedev);
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>   void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
> -void vfio_put_group(VFIOGroup *group);
>   struct vfio_device_info *vfio_get_device_info(int fd);
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp);
>   int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                          AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1e2fce83b0..84eafb2e87 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>       g_free(vcdev->io_region);
>   }
>   
> -static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
> -{
> -    g_free(vcdev->vdev.name);
> -    vfio_put_base_device(&vcdev->vdev);
> -}
> -
> -static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
> -                                Error **errp)
> -{
> -    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
> -    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> -                                 cdev->hostid.ssid,
> -                                 cdev->hostid.devid);
> -    VFIODevice *vbasedev;
> -
> -    QLIST_FOREACH(vbasedev, &group->device_list, next) {
> -        if (strcmp(vbasedev->name, name) == 0) {
> -            error_setg(errp, "vfio: subchannel %s has already been attached",
> -                       name);
> -            goto out_err;
> -        }
> -    }
> -
> -    /*
> -     * All vfio-ccw devices are believed to operate in a way compatible with
> -     * discarding of memory in RAM blocks, ie. pages pinned in the host are
> -     * in the current working set of the guest driver and therefore never
> -     * overlap e.g., with pages available to the guest balloon driver.  This
> -     * needs to be set before vfio_get_device() for vfio common to handle
> -     * ram_block_discard_disable().
> -     */
> -    vcdev->vdev.ram_block_discard_allowed = true;
> -
> -    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
> -        goto out_err;
> -    }
> -
> -    vcdev->vdev.ops = &vfio_ccw_ops;
> -    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
> -    vcdev->vdev.name = name;
> -    vcdev->vdev.dev = DEVICE(vcdev);
> -
> -    return;
> -
> -out_err:
> -    g_free(name);
> -}
> -
> -static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
> -{
> -    char *tmp, group_path[PATH_MAX];
> -    ssize_t len;
> -    int groupid;
> -
> -    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
> -                          cdev->hostid.cssid, cdev->hostid.ssid,
> -                          cdev->hostid.devid, cdev->mdevid);
> -    len = readlink(tmp, group_path, sizeof(group_path));
> -    g_free(tmp);
> -
> -    if (len <= 0 || len >= sizeof(group_path)) {
> -        error_setg(errp, "vfio: no iommu_group found");
> -        return NULL;
> -    }
> -
> -    group_path[len] = 0;
> -
> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
> -        error_setg(errp, "vfio: failed to read %s", group_path);
> -        return NULL;
> -    }
> -
> -    return vfio_get_group(groupid, &address_space_memory, errp);
> -}
> -
>   static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>   {
> -    VFIOGroup *group;
>       S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>       VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    VFIODevice *vbasedev = &vcdev->vdev;
>       Error *err = NULL;
> +    char *name;
> +    int ret;
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> @@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    group = vfio_ccw_get_group(cdev, &err);
> -    if (!group) {
> -        goto out_group_err;
> -    }
> +    name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
> +                           vcdev->cdev.hostid.ssid,
> +                           vcdev->cdev.hostid.devid);
> +    vbasedev->sysfsdev = g_strdup_printf("/sys/bus/css/devices/%s/%s",
> +                                         name,
> +                                         cdev->mdevid);
> +    vbasedev->ops = &vfio_ccw_ops;
> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
> +    vbasedev->name = name;
> +    vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;

Would DEVICE(vcdev) be the same ?

Thanks,

C.

>   
> -    vfio_ccw_get_device(group, vcdev, &err);
> -    if (err) {
> -        goto out_device_err;
> +    /*
> +     * All vfio-ccw devices are believed to operate in a way compatible with
> +     * discarding of memory in RAM blocks, ie. pages pinned in the host are
> +     * in the current working set of the guest driver and therefore never
> +     * overlap e.g., with pages available to the guest balloon driver.  This
> +     * needs to be set before vfio_get_device() for vfio common to handle
> +     * ram_block_discard_disable().
> +     */
> +    vbasedev->ram_block_discard_allowed = true;
> +
> +    ret = vfio_attach_device(cdev->mdevid, vbasedev,
> +                             &address_space_memory, errp);
> +    if (ret) {
> +        goto out_attach_dev_err;
>       }
>   
>       vfio_ccw_get_region(vcdev, &err);
> @@ -708,10 +652,9 @@ out_irq_notifier_err:
>   out_io_notifier_err:
>       vfio_ccw_put_region(vcdev);
>   out_region_err:
> -    vfio_ccw_put_device(vcdev);
> -out_device_err:
> -    vfio_put_group(group);
> -out_group_err:
> +    vfio_detach_device(vbasedev);
> +out_attach_dev_err:
> +    g_free(vbasedev->name);
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
>       }
> @@ -724,14 +667,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>       S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>       VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> -    VFIOGroup *group = vcdev->vdev.group;
>   
>       vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX);
>       vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
>       vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>       vfio_ccw_put_region(vcdev);
> -    vfio_ccw_put_device(vcdev);
> -    vfio_put_group(group);
> +    vfio_detach_device(&vcdev->vdev);
> +    g_free(vcdev->vdev.name);
>   
>       if (cdc->unrealize) {
>           cdc->unrealize(cdev);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index f4c33c9858..56cfe94d97 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2335,7 +2335,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       }
>   }
>   
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
> +static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>   {
>       VFIOGroup *group;
>       char path[32];
> @@ -2402,7 +2402,7 @@ free_group_exit:
>       return NULL;
>   }
>   
> -void vfio_put_group(VFIOGroup *group)
> +static void vfio_put_group(VFIOGroup *group)
>   {
>       if (!group || !QLIST_EMPTY(&group->device_list)) {
>           return;
> @@ -2447,8 +2447,8 @@ retry:
>       return info;
>   }
>   
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp)
> +static int vfio_get_device(VFIOGroup *group, const char *name,
> +                           VFIODevice *vbasedev, Error **errp)
>   {
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
> @@ -2506,7 +2506,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>       return 0;
>   }
>   
> -void vfio_put_base_device(VFIODevice *vbasedev)
> +static void vfio_put_base_device(VFIODevice *vbasedev)
>   {
>       if (!vbasedev->group) {
>           return;


