Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F557A933C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGF2-0004bG-HU; Thu, 21 Sep 2023 05:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjGF0-0004b4-C7
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:44:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qjGEx-0006zu-6u
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695289493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+hBXxlcvWowQ+Y9AmZ3d6oGSLSIG5SYF9rjvQuwlqE=;
 b=PRfLqqIYilRtUEVRX3W45pgcZ7eFZQ4wDsolKq7d6yDSKa2JsAJO/nm7yXlJqEZGznjlLa
 XlBMtNrksocI00LqtaR7yLfxW8od+5QH81USjK7zjhGoMONGQ9E89IUMLRcnYkd31JwciR
 /FD0lpR58pYaN+UykLcL9xtJ0I5Xxx0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-O8-7E4KPN7y-O7WWKIuGJg-1; Thu, 21 Sep 2023 05:44:52 -0400
X-MC-Unique: O8-7E4KPN7y-O7WWKIuGJg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65794c79aaeso6805096d6.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 02:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695289492; x=1695894292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+hBXxlcvWowQ+Y9AmZ3d6oGSLSIG5SYF9rjvQuwlqE=;
 b=mYNwnZuyqfPe6tPGSpy2mcw9B1HTRxdnrAJTDktWzNGizLJo3b74eNQt6M924ooYht
 TcEEowt95/oBkPDfn3euR+qRtRvz59nVIMqiiKUrLOVb+Vxgut7n087Mc6Qe9KNpyu19
 qrvci3H1ZBa1k1WEFAYE6xO8vv54K1nbJFGhJXbSvut30ceNVATQZEfmW+pAd9eUJOc6
 AR5iC2t7KCtdtavF2vyo/Q89P7b/20Bba1nRHZshZUUwxASL1BVVpv96s3wkkmuAGNHV
 peG1xFcmU93jsnYJrAbHGIEJFOdUeVQ3mPed/6sHFlagOjYaWTMGL5NypJx8qkyxkyfm
 vXow==
X-Gm-Message-State: AOJu0Yw+ls2G24YrmoECgpbV4M/NB8zhoVeXlUyL6ooViJDugPsUlWfs
 12UdpJnT2oxUvZhgt5c6prrDzaQz/B82h7d5lV1u57sXG/4mtASv8JXaaIHywgG5FQA8re8IbHj
 Qy1Geod37L+Oesxw=
X-Received: by 2002:a0c:8ccb:0:b0:658:31cd:aa60 with SMTP id
 q11-20020a0c8ccb000000b0065831cdaa60mr4273514qvb.28.1695289491820; 
 Thu, 21 Sep 2023 02:44:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5PjRqrT+61bLe7zhjOiv+pL6KS/HauCLrrvNYija5NkXPzkrTUVHkMXll2IgqUVrg5IO70Q==
X-Received: by 2002:a0c:8ccb:0:b0:658:31cd:aa60 with SMTP id
 q11-20020a0c8ccb000000b0065831cdaa60mr4273503qvb.28.1695289491404; 
 Thu, 21 Sep 2023 02:44:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a0ce3c4000000b0064c1b27bf2dsm416748qvl.140.2023.09.21.02.44.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 02:44:50 -0700 (PDT)
Message-ID: <aa25cfff-d83b-cd2e-05bc-554b44c54584@redhat.com>
Date: Thu, 21 Sep 2023 11:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 09/22] vfio/container: Introduce
 vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-10-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230830103754.36461-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 8/30/23 12:37, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
> 
> We want the VFIO devices to be able to use two different
> IOMMU callbacks, the legacy VFIO one and the new iommufd one.
> 
> Introduce vfio_[attach/detach]_device which aim at hiding the
> underlying IOMMU backend (IOCTLs, datatypes, ...).
> 
> Once vfio_attach_device completes, the device is attached
> to a security context and its fd can be used. Conversely
> When vfio_detach_device completes, the device has been
> detached to the security context.
> 
> In this patch, only the vfio-pci device gets converted to use
> the new API. Subsequent patches will handle other devices.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/container.c           | 66 +++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c                 | 50 ++++----------------------
>   hw/vfio/trace-events          |  2 +-
>   include/hw/vfio/vfio-common.h |  3 ++
>   4 files changed, 76 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 175cdbbdff..74556da0c7 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -1083,3 +1083,69 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>       }
>       return vfio_eeh_container_op(container, op);
>   }
> +
> +static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
> +{
> +    char *tmp, group_path[PATH_MAX], *group_name;
> +    int ret, groupid;
> +    ssize_t len;
> +
> +    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
> +    len = readlink(tmp, group_path, sizeof(group_path));
> +    g_free(tmp);
> +
> +    if (len <= 0 || len >= sizeof(group_path)) {
> +        ret = len < 0 ? -errno : -ENAMETOOLONG;
> +        error_setg_errno(errp, -ret, "no iommu_group found");
> +        return ret;
> +    }
> +
> +    group_path[len] = 0;
> +
> +    group_name = basename(group_path);
> +    if (sscanf(group_name, "%d", &groupid) != 1) {
> +        error_setg_errno(errp, errno, "failed to read %s", group_path);
> +        return -errno;
> +    }
> +    return groupid;
> +}

VFIO has 4 other  routines reading the iommu_group from sysfs :

   vfio_ccw_get_group()
   vfio_ap_get_group()
   vfio_base_device_init()
   sysfs_find_group_file()

which could use this helper. Thanks for introducing it !



> +
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp)
> +{
> +    int groupid = vfio_device_groupid(vbasedev, errp);
> +    VFIODevice *vbasedev_iter;
> +    VFIOGroup *group;
> +    int ret;
> +
> +    if (groupid < 0) {
> +        return groupid;
> +    }
> +
> +    group = vfio_get_group(groupid, as, errp);
> +    if (!group) {
> +        return -ENOENT;
> +    }
> +
> +    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
> +        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
> +            error_setg(errp, "device is already attached");
> +            vfio_put_group(group);
> +            return -EBUSY;
> +        }
> +    }
> +    ret = vfio_get_device(group, name, vbasedev, errp);
> +    if (ret) {
> +        vfio_put_group(group);
> +    }
> +
> +    return ret;
> +}
> +
> +void vfio_detach_device(VFIODevice *vbasedev)
> +{
> +    VFIOGroup *group = vbasedev->group;
> +
> +    vfio_put_base_device(vbasedev);
> +    vfio_put_group(group);
> +}
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index a205c6b113..34f65ecd17 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2828,10 +2828,10 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>   
>   static void vfio_put_device(VFIOPCIDevice *vdev)
>   {
> +    vfio_detach_device(&vdev->vbasedev);
> +
>       g_free(vdev->vbasedev.name);
>       g_free(vdev->msix);
> -
> -    vfio_put_base_device(&vdev->vbasedev);
>   }
>   
>   static void vfio_err_notifier_handler(void *opaque)
> @@ -2978,13 +2978,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>       VFIODevice *vbasedev = &vdev->vbasedev;
> -    VFIODevice *vbasedev_iter;
> -    VFIOGroup *group;
> -    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
> +    char *tmp, *subsys;
>       Error *err = NULL;
> -    ssize_t len;
>       struct stat st;
> -    int groupid;
>       int i, ret;
>       bool is_mdev;
>       char uuid[UUID_FMT_LEN];
> @@ -3015,38 +3011,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>       vbasedev->dev = DEVICE(vdev);
>   
> -    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
> -    len = readlink(tmp, group_path, sizeof(group_path));
> -    g_free(tmp);
> -
> -    if (len <= 0 || len >= sizeof(group_path)) {
> -        error_setg_errno(errp, len < 0 ? errno : ENAMETOOLONG,
> -                         "no iommu_group found");
> -        goto error;
> -    }
> -
> -    group_path[len] = 0;
> -
> -    group_name = basename(group_path);
> -    if (sscanf(group_name, "%d", &groupid) != 1) {
> -        error_setg_errno(errp, errno, "failed to read %s", group_path);
> -        goto error;
> -    }
> -
> -    trace_vfio_realize(vbasedev->name, groupid);
> -
> -    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev), errp);
> -    if (!group) {
> -        goto error;
> -    }
> -
> -    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
> -        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
> -            error_setg(errp, "device is already attached");
> -            vfio_put_group(group);
> -            goto error;
> -        }
> -    }
> +    trace_vfio_realize(vbasedev->name);

I would move the trace event after vfio_attach_device() and print out the group.
Or simply add trace events in vfio_detach/attach_device().

This is a general comment on the VFIO PCI routines which do not use a 'vfio_pci'
prefix and I find it confusing, sometimes. Like this call stack :

   vfio_put_device()
     vfio_detach_device()
       vfio_put_base_device()

I think we should rename vfio_put_device() in vfio_pci_put_device(). This is
not for this series.

Thanks,

C.

>   
>       /*
>        * Mediated devices *might* operate compatibly with discarding of RAM, but
> @@ -3065,7 +3030,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>       if (vbasedev->ram_block_discard_allowed && !is_mdev) {
>           error_setg(errp, "x-balloon-allowed only potentially compatible "
>                      "with mdev devices");
> -        vfio_put_group(group);
>           goto error;
>       }
>   
> @@ -3076,10 +3040,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>           name = g_strdup(vbasedev->name);
>       }
>   
> -    ret = vfio_get_device(group, name, vbasedev, errp);
> +    ret = vfio_attach_device(name, vbasedev,
> +                             pci_device_iommu_address_space(pdev), errp);
>       g_free(name);
>       if (ret) {
> -        vfio_put_group(group);
>           goto error;
>       }
>   
> @@ -3318,7 +3282,6 @@ error:
>   static void vfio_instance_finalize(Object *obj)
>   {
>       VFIOPCIDevice *vdev = VFIO_PCI(obj);
> -    VFIOGroup *group = vdev->vbasedev.group;
>   
>       vfio_display_finalize(vdev);
>       vfio_bars_finalize(vdev);
> @@ -3332,7 +3295,6 @@ static void vfio_instance_finalize(Object *obj)
>        * g_free(vdev->igd_opregion);
>        */
>       vfio_put_device(vdev);
> -    vfio_put_group(group);
>   }
>   
>   static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index ee7509e68e..8016d9f0d2 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -37,7 +37,7 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
>   vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
>   vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
>   vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> -vfio_realize(const char *name, int group_id) " (%s) group %d"
> +vfio_realize(const char *name) " (%s)"
>   vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>   vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>   vfio_pci_reset(const char *name) " (%s)"
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index bb7f9fe9c4..a29dfe7723 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -253,6 +253,9 @@ void vfio_put_group(VFIOGroup *group);
>   struct vfio_device_info *vfio_get_device_info(int fd);
>   int vfio_get_device(VFIOGroup *group, const char *name,
>                       VFIODevice *vbasedev, Error **errp);
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp);
> +void vfio_detach_device(VFIODevice *vbasedev);
>   
>   extern int vfio_kvm_device_fd;
>   


