Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0FE8BDC67
	for <lists+qemu-devel@lfdr.de>; Tue,  7 May 2024 09:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4FEp-0004oV-Jy; Tue, 07 May 2024 03:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4FEY-0004l9-Au
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:27:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1s4FEU-0000x3-Mj
 for qemu-devel@nongnu.org; Tue, 07 May 2024 03:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715066845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AZ79fERz2AUb26RLZi//sW5vxbsFypxdqUTumF1RawY=;
 b=MwstL6mfXjsjZXQWpJBIa7OGqmVlAmx+dM+xMsyEfA/ACmJ4KhrIEQ8LCUf5FlizBvWeUV
 yao4/k3hBnBmD23ZwmdcACZUR4YSbSgEtr4j+4Z5ErfaMZIEYvvZyaou74Uja3/JLNH1xf
 cV6S61Jd1anIKc8uaXtQF8OVwokYxX0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-YjvixQzNP7qfxrFR4jmnkA-1; Tue, 07 May 2024 03:27:22 -0400
X-MC-Unique: YjvixQzNP7qfxrFR4jmnkA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0ce87adf5so34506186d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 00:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715066842; x=1715671642;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AZ79fERz2AUb26RLZi//sW5vxbsFypxdqUTumF1RawY=;
 b=ogjDHzOxAr+SPl4MYnXvGRRnaeNhZl82v/WmyF2TDctiUhCxLdm74UOhPJ6BmpYt1+
 tQx358INpSJiwG0gHRnD/yJWSIzdD7Rg2WGXQSkCXcdi4skwmBrNRgq26JYPZAbD8td8
 73ZciATzT1xqqfy1/ZVJusFHkL7i+qZrhd/bn2oX96SdoGmjpO3oYpsX8YfQkJikjgv/
 KoSyF6utFh9m2To8nGgu9wlfL3RyDv5cXA+dZeNHaPz7XsYUSTjIlz2tS1y7djbjZIlx
 TmPpFKRlVT9m5ufQv1Wv0JZficD4syIMJnLGyKtMp3c2QIRxwrFuLMikZDUgPHLcl4nH
 FF1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzqN3ekoauB61QOhofMwDz+Q1NQqdzyOFfIffLsLS01P6GC+qj5g6MQFOUD1CnPrJSyWqgXTYJM9RX6mvdmtbvEegiVZI=
X-Gm-Message-State: AOJu0YwZDZLWERtdSwc3ZYiMvF921R0/1bHQfHHKA5kN4tBfW+jj19Yw
 DNbRoMVbfARae0vvYnhgLnepZTrVV6psSim1hJaGTCEeTDUv3BUTl/GDzJsb0P2BuS4y5JJzKKa
 DyE3jP7a2eUABPprF9MaZt0kBguWEuCv4al1E7/m9gRFdFAgjtMko
X-Received: by 2002:a05:6214:d88:b0:6a0:91f0:ca4d with SMTP id
 e8-20020a0562140d8800b006a091f0ca4dmr14616426qve.22.1715066841711; 
 Tue, 07 May 2024 00:27:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEW8nUB1RFTSxSFtcTJRFaGjd715XmBXEo/NbUXybcabwIL3Bg4URvdoUlSK13e433RySwMyg==
X-Received: by 2002:a05:6214:d88:b0:6a0:91f0:ca4d with SMTP id
 e8-20020a0562140d8800b006a091f0ca4dmr14616395qve.22.1715066841228; 
 Tue, 07 May 2024 00:27:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a056214102900b006a0e6ffd710sm4450993qvr.97.2024.05.07.00.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 00:27:20 -0700 (PDT)
Message-ID: <a41fe2df-62dd-4d65-ba00-45ca888dedbf@redhat.com>
Date: Tue, 7 May 2024 09:27:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] vfio: Make VFIOIOMMUClass::attach_device() and
 its wrapper return bool
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, chao.p.peng@intel.com, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:vfio-ap" <qemu-s390x@nongnu.org>
References: <20240507064252.457884-1-zhenzhong.duan@intel.com>
 <20240507064252.457884-4-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240507064252.457884-4-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/7/24 08:42, Zhenzhong Duan wrote:
> Make VFIOIOMMUClass::attach_device() and its wrapper function
> vfio_attach_device() return bool.
> 
> This is to follow the coding standand to return bool if 'Error **'
> is used to pass error.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/vfio/vfio-common.h         |  4 ++--
>   include/hw/vfio/vfio-container-base.h |  4 ++--
>   hw/vfio/ap.c                          |  6 ++----
>   hw/vfio/ccw.c                         |  6 ++----
>   hw/vfio/common.c                      |  4 ++--
>   hw/vfio/container.c                   | 14 +++++++-------
>   hw/vfio/iommufd.c                     | 11 +++++------
>   hw/vfio/pci.c                         |  5 ++---
>   hw/vfio/platform.c                    |  7 +++----
>   9 files changed, 27 insertions(+), 34 deletions(-)
> 
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..a7b6fc8f46 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -198,8 +198,8 @@ void vfio_region_exit(VFIORegion *region);
>   void vfio_region_finalize(VFIORegion *region);
>   void vfio_reset_handler(void *opaque);
>   struct vfio_device_info *vfio_get_device_info(int fd);
> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                       AddressSpace *as, Error **errp);
> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                        AddressSpace *as, Error **errp);
>   void vfio_detach_device(VFIODevice *vbasedev);
>   
>   int vfio_kvm_device_add_fd(int fd, Error **errp);
> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
> index 3582d5f97a..c839cfd9cb 100644
> --- a/include/hw/vfio/vfio-container-base.h
> +++ b/include/hw/vfio/vfio-container-base.h
> @@ -118,8 +118,8 @@ struct VFIOIOMMUClass {
>       int (*dma_unmap)(const VFIOContainerBase *bcontainer,
>                        hwaddr iova, ram_addr_t size,
>                        IOMMUTLBEntry *iotlb);
> -    int (*attach_device)(const char *name, VFIODevice *vbasedev,
> -                         AddressSpace *as, Error **errp);
> +    bool (*attach_device)(const char *name, VFIODevice *vbasedev,
> +                          AddressSpace *as, Error **errp);
>       void (*detach_device)(VFIODevice *vbasedev);
>       /* migration feature */
>       int (*set_dirty_page_tracking)(const VFIOContainerBase *bcontainer,
> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> index 7c4caa5938..d50600b702 100644
> --- a/hw/vfio/ap.c
> +++ b/hw/vfio/ap.c
> @@ -156,7 +156,6 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>   {
>       ERRP_GUARD();
> -    int ret;
>       Error *err = NULL;
>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(dev);
>       VFIODevice *vbasedev = &vapdev->vdev;
> @@ -165,9 +164,8 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    ret = vfio_attach_device(vbasedev->name, vbasedev,
> -                             &address_space_memory, errp);
> -    if (ret) {
> +    if (!vfio_attach_device(vbasedev->name, vbasedev,
> +                            &address_space_memory, errp)) {
>           goto error;
>       }
>   
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 90e4a53437..782bd4bed7 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -580,7 +580,6 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>       S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>       VFIODevice *vbasedev = &vcdev->vdev;
>       Error *err = NULL;
> -    int ret;
>   
>       /* Call the class init function for subchannel. */
>       if (cdc->realize) {
> @@ -594,9 +593,8 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>           return;
>       }
>   
> -    ret = vfio_attach_device(cdev->mdevid, vbasedev,
> -                             &address_space_memory, errp);
> -    if (ret) {
> +    if (!vfio_attach_device(cdev->mdevid, vbasedev,
> +                            &address_space_memory, errp)) {
>           goto out_attach_dev_err;
>       }
>   
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 8f9cbdc026..890d30910e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1492,8 +1492,8 @@ retry:
>       return info;
>   }
>   
> -int vfio_attach_device(char *name, VFIODevice *vbasedev,
> -                       AddressSpace *as, Error **errp)
> +bool vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                        AddressSpace *as, Error **errp)
>   {
>       const VFIOIOMMUClass *ops =
>           VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_LEGACY));

This is still broken. No need to resend. I will update the code.


Thanks,

C.




> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276e..ea3b145913 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -908,8 +908,8 @@ static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>    * @name and @vbasedev->name are likely to be different depending
>    * on the type of the device, hence the need for passing @name
>    */
> -static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
> -                                     AddressSpace *as, Error **errp)
> +static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
> +                                      AddressSpace *as, Error **errp)
>   {
>       int groupid = vfio_device_groupid(vbasedev, errp);
>       VFIODevice *vbasedev_iter;
> @@ -918,27 +918,27 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       int ret;
>   
>       if (groupid < 0) {
> -        return groupid;
> +        return false;
>       }
>   
>       trace_vfio_attach_device(vbasedev->name, groupid);
>   
>       group = vfio_get_group(groupid, as, errp);
>       if (!group) {
> -        return -ENOENT;
> +        return false;
>       }
>   
>       QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>           if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>               error_setg(errp, "device is already attached");
>               vfio_put_group(group);
> -            return -EBUSY;
> +            return false;
>           }
>       }
>       ret = vfio_get_device(group, name, vbasedev, errp);
>       if (ret) {
>           vfio_put_group(group);
> -        return ret;
> +        return false;
>       }
>   
>       bcontainer = &group->container->bcontainer;
> @@ -946,7 +946,7 @@ static int vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>       QLIST_INSERT_HEAD(&bcontainer->device_list, vbasedev, container_next);
>       QLIST_INSERT_HEAD(&vfio_device_list, vbasedev, global_next);
>   
> -    return ret;
> +    return true;
>   }
>   
>   static void vfio_legacy_detach_device(VFIODevice *vbasedev)
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index c644127972..4c6992fca1 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -299,8 +299,8 @@ error:
>       return ret;
>   }
>   
> -static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
> -                               AddressSpace *as, Error **errp)
> +static bool iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
> +                                AddressSpace *as, Error **errp)
>   {
>       VFIOContainerBase *bcontainer;
>       VFIOIOMMUFDContainer *container;
> @@ -315,7 +315,7 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       if (vbasedev->fd < 0) {
>           devfd = iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>           if (devfd < 0) {
> -            return devfd;
> +            return false;
>           }
>           vbasedev->fd = devfd;
>       } else {
> @@ -392,7 +392,6 @@ static int iommufd_cdev_attach(const char *name, VFIODevice *vbasedev,
>       memory_listener_register(&bcontainer->listener, bcontainer->space->as);
>   
>       if (bcontainer->error) {
> -        ret = -1;
>           error_propagate_prepend(errp, bcontainer->error,
>                                   "memory listener initialization failed: ");
>           goto err_listener_register;
> @@ -431,7 +430,7 @@ found_container:
>   
>       trace_iommufd_cdev_device_info(vbasedev->name, devfd, vbasedev->num_irqs,
>                                      vbasedev->num_regions, vbasedev->flags);
> -    return 0;
> +    return true;
>   
>   err_listener_register:
>       iommufd_cdev_ram_block_discard_disable(false);
> @@ -444,7 +443,7 @@ err_alloc_ioas:
>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>   err_connect_bind:
>       close(vbasedev->fd);
> -    return ret;
> +    return false;
>   }
>   
>   static void iommufd_cdev_detach(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 576b21e2bb..d3beb15514 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3001,9 +3001,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           name = g_strdup(vbasedev->name);
>       }
>   
> -    ret = vfio_attach_device(name, vbasedev,
> -                             pci_device_iommu_address_space(pdev), errp);
> -    if (ret) {
> +    if (!vfio_attach_device(name, vbasedev,
> +                            pci_device_iommu_address_space(pdev), errp)) {
>           goto error;
>       }
>   
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index dcd2365fb3..2bd16096bb 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -552,10 +552,9 @@ static int vfio_base_device_init(VFIODevice *vbasedev, Error **errp)
>           return ret;
>       }
>   
> -    ret = vfio_attach_device(vbasedev->name, vbasedev,
> -                             &address_space_memory, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_attach_device(vbasedev->name, vbasedev,
> +                            &address_space_memory, errp)) {
> +        return -EINVAL;
>       }
>   
>       ret = vfio_populate_device(vbasedev, errp);


