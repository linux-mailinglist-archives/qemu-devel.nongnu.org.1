Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2697A946F
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:56:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJD2-0001sr-DR; Thu, 21 Sep 2023 08:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJ0W-0006cL-Ip
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjJ0O-00027l-LB
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695300121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KotT9CrCCEF12Cto8UDI/rLCOWC/U43cjc1QKgnG84Q=;
 b=ehn/iV0FT2oJo5Nukh+9L7qLV8D+zxJHFj/H2FKqw5JvVw2NlFMcaJDMljTAb5diBzm3I4
 pxSzZUpNJJjGGBFYHpbn5VwjGHJ58W2fXVNhIeILaFuxqXup5GZOZ6ELpPro2qrSgnRwp/
 whl9YC1sG3w017/cLBZFAMRISMUaTxQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-uQfCPKOZOlSX7jWOJVNU2Q-1; Thu, 21 Sep 2023 08:19:59 -0400
X-MC-Unique: uQfCPKOZOlSX7jWOJVNU2Q-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so6689895e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 05:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695298798; x=1695903598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KotT9CrCCEF12Cto8UDI/rLCOWC/U43cjc1QKgnG84Q=;
 b=tCoQILXb0R38bXd7ZbGWEDp56uVSsWuvcUcpywb/Thh2sNgqK5EkeE1SoG9DnIO2Vg
 4nqpUj0W15uN1NirRs8TWMTOkepm3j4Z9mN6L/drt6JnWU1k6bbgIAz7ITZkCyPPxeEl
 xGWuyzRcMPFU8ET37qAaaVj08YLxtlpwGRfG0Jyj08t9IZtvuH1CPtRhcE2Xz+MIAzQo
 ozOfATP+hC4bsQ27xzbNZzSb2zOC9qBWwmGckziEmsipvBj+dfnzf8HKrXvGIkWtAxDM
 ch+2C8Qs+VrsVvgMz/okitN50/B82QqIIkwPigHHz4uUmAvLSbPBhyGJvCaBfc25Cx8l
 jziw==
X-Gm-Message-State: AOJu0YzEAMZ2Aq6dC6MZ0RgXq57BHO4/+WHX7Tewy01AnS/CRY3NxrCG
 NOkYohkye74qBJ5/mJ6rjhqGm9dA9MMKfFezKuUHb+x4JFJFstMUvXR/JDNIXWYo+E29Ux1tSAd
 St/MeHd4b9zD97zA=
X-Received: by 2002:a7b:cd0e:0:b0:402:f500:fcee with SMTP id
 f14-20020a7bcd0e000000b00402f500fceemr5003552wmj.0.1695298798485; 
 Thu, 21 Sep 2023 05:19:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsV/nx3rSLxjKUTpnqSwLZoUrJKYuijak48sffzfb+c4Ki+T22aCqhGaFFZos4bE0kNCSQZw==
X-Received: by 2002:a7b:cd0e:0:b0:402:f500:fcee with SMTP id
 f14-20020a7bcd0e000000b00402f500fceemr5003524wmj.0.1695298798053; 
 Thu, 21 Sep 2023 05:19:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a5d634c000000b0031773a8e5c4sm1644296wrw.37.2023.09.21.05.19.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 05:19:57 -0700 (PDT)
Message-ID: <ff418562-245e-2c7a-01a8-060ee970f195@redhat.com>
Date: Thu, 21 Sep 2023 14:19:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 12/22] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "open list:vfio-ccw" <qemu-s390x@nongnu.org>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-13-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> Let the vfio-ccw device use vfio_attach_device() and
> vfio_detach_device(), hence hiding the details of the used
> IOMMU backend.
> 
> Also now all the devices have been migrated to use the new
> vfio_attach_device/vfio_detach_device API, let's turn the
> legacy functions into static functions, local to container.c.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Zhenzhong,

Could you please resend 1-12 independantly as a prereq series for iommufd
support ? I think there wouldn't be much to say and they could be merged
pretty quickly.

Thanks,

C.

> ---
>   hw/vfio/ccw.c                 | 120 ++++++++--------------------------
>   hw/vfio/container.c           |  10 +--
>   include/hw/vfio/vfio-common.h |   5 --
>   3 files changed, 33 insertions(+), 102 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1e2fce83b0..f078e014fa 100644
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
> -    S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
> -    VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
> +    CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
> +    S390CCWDevice *cdev = DO_UPCAST(S390CCWDevice, parent_obj, ccw_dev);
> +    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    VFIODevice *vbasedev = &vcdev->vdev;
>       Error *err = NULL;
> +    int ret;
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> @@ -663,14 +590,25 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           }
>       }
>   
> -    group = vfio_ccw_get_group(cdev, &err);
> -    if (!group) {
> -        goto out_group_err;
> -    }
> +    vbasedev->ops = &vfio_ccw_ops;
> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
> +    vbasedev->name = g_strdup(cdev->mdevid);
> +    vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;
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
> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
> +                             &address_space_memory, errp);
> +    if (ret) {
> +        goto out_attach_dev_err;
>       }
>   
>       vfio_ccw_get_region(vcdev, &err);
> @@ -708,10 +646,9 @@ out_irq_notifier_err:
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
> @@ -724,14 +661,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
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
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 74556da0c7..c71fddc09a 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -837,7 +837,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>       }
>   }
>   
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
> +static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>   {
>       VFIOGroup *group;
>       char path[32];
> @@ -900,7 +900,7 @@ free_group_exit:
>       return NULL;
>   }
>   
> -void vfio_put_group(VFIOGroup *group)
> +static void vfio_put_group(VFIOGroup *group)
>   {
>       if (!group || !QLIST_EMPTY(&group->device_list)) {
>           return;
> @@ -917,8 +917,8 @@ void vfio_put_group(VFIOGroup *group)
>       g_free(group);
>   }
>   
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp)
> +static int vfio_get_device(VFIOGroup *group, const char *name,
> +                           VFIODevice *vbasedev, Error **errp)
>   {
>       g_autofree struct vfio_device_info *info = NULL;
>       int fd;
> @@ -976,7 +976,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>       return 0;
>   }
>   
> -void vfio_put_base_device(VFIODevice *vbasedev)
> +static void vfio_put_base_device(VFIODevice *vbasedev)
>   {
>       if (!vbasedev->group) {
>           return;
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index a29dfe7723..95bcafdaf6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -230,7 +230,6 @@ int vfio_container_add_section_window(VFIOContainer *container,
>   void vfio_container_del_section_window(VFIOContainer *container,
>                                          MemoryRegionSection *section);
>   
> -void vfio_put_base_device(VFIODevice *vbasedev);
>   void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>   void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> @@ -248,11 +247,7 @@ void vfio_region_unmap(VFIORegion *region);
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


