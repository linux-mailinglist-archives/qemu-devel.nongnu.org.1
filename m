Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 782687AFF50
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 11:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlQQW-0000Oc-Jj; Wed, 27 Sep 2023 05:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQQS-0000OP-GN
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:01:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlQQQ-0001LK-Jl
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 05:01:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695805300;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W7jvPwt4yHQxhLWK0PcnOLAIgXNc6lQ8QecvUizB00g=;
 b=OA/cE6BZJx5MP59NC/i/c/4Mw+3Bq7pjCOM4AYnxCVS/b1/PpptVczSYvp2IMALrUk8gt5
 WncOo5+TCqIVk8Z12YFnNDKKJEi6BPzER6RZSLuR7R1iAXmD82E0KR+SP4Nd9VyblemDKX
 xXfLqm9Sp68iZYPF+/9zhPjLsV2/La4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-TNS0rushN0KCpogd1UnXlA-1; Wed, 27 Sep 2023 05:01:38 -0400
X-MC-Unique: TNS0rushN0KCpogd1UnXlA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65aff02d602so131765766d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 02:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695805297; x=1696410097;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7jvPwt4yHQxhLWK0PcnOLAIgXNc6lQ8QecvUizB00g=;
 b=HK1+pHFgTEs6sXHgnK/LzFGlzphw1l6O5nZjiwBZZqbgJbXjV5Eusd8Kxhe6W7F4pm
 8NDcyPIRf9nBpbR2dcEkU2LbEtfLcjPh4b7mPKwcxSFEB5U7UF4IiBjW2EjmZsMna3zn
 S4LPSuTOGnQEGoke2MwgUKnQGNvQht9Nuutb84vT6GSeI7DbjUQNw+o7PgGKBlCtAipD
 wiaQei5Q6KLcjdi3ipXMhxKY/1gF+/+4bm4LLc/JMoJdfIKIo9YoyijshvDaydgxd6Ad
 pv+FapORXeSOh7RFXrRyYZ2bYWmm15GO/6RqR5HPE7ibWjLTT64x0R6Z9L6OJvHCKR5P
 tPFw==
X-Gm-Message-State: AOJu0YyJRmJ9yeM/ukSZLflsckPFtxrEr09ohWE6deY2Zr5SHGlCZa94
 DRKbS/JMAlF+tgRpO2RQb9Y9e0ll7GMqEt9VSaenC4zrqU5VPzq+0Vjq1rdoAp4GrxXbmRPvcB2
 qaJRKAInz6vteGHo=
X-Received: by 2002:a0c:abc6:0:b0:659:e6cb:cef9 with SMTP id
 k6-20020a0cabc6000000b00659e6cbcef9mr1398256qvb.35.1695805297379; 
 Wed, 27 Sep 2023 02:01:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu5LZV/JxHCTuc4728HKkiYfb/zyhEvcaowDjNWho8fIM2NSd/GOhVNCgh21QxjE8xVf/0WQ==
X-Received: by 2002:a0c:abc6:0:b0:659:e6cb:cef9 with SMTP id
 k6-20020a0cabc6000000b00659e6cbcef9mr1398235qvb.35.1695805297068; 
 Wed, 27 Sep 2023 02:01:37 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a0ce54f000000b0065b27fe4737sm1220801qvm.15.2023.09.27.02.01.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 02:01:35 -0700 (PDT)
Message-ID: <b1012c96-e76e-10eb-2080-af7d8ff606ee@redhat.com>
Date: Wed, 27 Sep 2023 11:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-7-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 9/26/23 13:32, Zhenzhong Duan wrote:
> From: Eric Auger <eric.auger@redhat.com>
>
> We want the VFIO devices to be able to use two different
> IOMMU backends, the legacy VFIO one and the new iommufd one.
>
> Introduce vfio_[attach/detach]_device which aim at hiding the
> underlying IOMMU backend (IOCTLs, datatypes, ...).
>
> Once vfio_attach_device completes, the device is attached
> to a security context and its fd can be used. Conversely
> When vfio_detach_device completes, the device has been
> detached from the security context.
>
> At the moment only the implementation based on the legacy
> container/group exists. Let's use it from the vfio-pci device.
> Subsequent patches will handle other devices.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  include/hw/vfio/vfio-common.h |  3 ++
>  hw/vfio/common.c              | 68 +++++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                 | 50 +++-----------------------
>  hw/vfio/trace-events          |  2 +-
>  4 files changed, 77 insertions(+), 46 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index c4e7c3b4a7..12fbfbc37d 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -225,6 +225,9 @@ void vfio_put_group(VFIOGroup *group);
>  struct vfio_device_info *vfio_get_device_info(int fd);
>  int vfio_get_device(VFIOGroup *group, const char *name,
>                      VFIODevice *vbasedev, Error **errp);
> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
> +                       AddressSpace *as, Error **errp);
> +void vfio_detach_device(VFIODevice *vbasedev);
>  
>  int vfio_kvm_device_add_fd(int fd, Error **errp);
>  int vfio_kvm_device_del_fd(int fd, Error **errp);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 959b1362bb..7f3798b152 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2611,3 +2611,71 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>      }
>      return vfio_eeh_container_op(container, op);
>  }
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
> +    trace_vfio_attach_device(vbasedev->name, groupid);
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
> index 3b2ca3c24c..fe56789893 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2828,10 +2828,10 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
>  
>  static void vfio_put_device(VFIOPCIDevice *vdev)
>  {
> +    vfio_detach_device(&vdev->vbasedev);
> +
>      g_free(vdev->vbasedev.name);
>      g_free(vdev->msix);
> -
> -    vfio_put_base_device(&vdev->vbasedev);
>  }
>  
>  static void vfio_err_notifier_handler(void *opaque)
> @@ -2978,13 +2978,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>      VFIODevice *vbasedev = &vdev->vbasedev;
> -    VFIODevice *vbasedev_iter;
> -    VFIOGroup *group;
> -    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
> +    char *tmp, *subsys;
>      Error *err = NULL;
> -    ssize_t len;
>      struct stat st;
> -    int groupid;
>      int i, ret;
>      bool is_mdev;
>      char uuid[UUID_FMT_LEN];
> @@ -3015,39 +3011,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>      vbasedev->dev = DEVICE(vdev);
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
> -
>      /*
>       * Mediated devices *might* operate compatibly with discarding of RAM, but
>       * we cannot know for certain, it depends on whether the mdev vendor driver
> @@ -3065,7 +3028,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      if (vbasedev->ram_block_discard_allowed && !is_mdev) {
>          error_setg(errp, "x-balloon-allowed only potentially compatible "
>                     "with mdev devices");
> -        vfio_put_group(group);
>          goto error;
>      }
>  
> @@ -3076,10 +3038,10 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>          name = g_strdup(vbasedev->name);
>      }
>  
> -    ret = vfio_get_device(group, name, vbasedev, errp);
> +    ret = vfio_attach_device(name, vbasedev,
> +                             pci_device_iommu_address_space(pdev), errp);
>      g_free(name);
>      if (ret) {
> -        vfio_put_group(group);
independently on this patch, I think in case of error we leak
vbasedev->name. Please have a look and if confirmed you can send a
separate patch.

Also I think if any subsequent action fail we shoudl properly detach the
detach the device so introduce an extra error goto label, my bad sorry.

Thanks

Eric
>          goto error;
>      }
>  
> @@ -3304,7 +3266,6 @@ error:
>  static void vfio_instance_finalize(Object *obj)
>  {
>      VFIOPCIDevice *vdev = VFIO_PCI(obj);
> -    VFIOGroup *group = vdev->vbasedev.group;
>  
>      vfio_display_finalize(vdev);
>      vfio_bars_finalize(vdev);
> @@ -3318,7 +3279,6 @@ static void vfio_instance_finalize(Object *obj)
>       * g_free(vdev->igd_opregion);
>       */
>      vfio_put_device(vdev);
> -    vfio_put_group(group);
>  }
>  
>  static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
> index e64ca4a019..e710026a73 100644
> --- a/hw/vfio/trace-events
> +++ b/hw/vfio/trace-events
> @@ -37,7 +37,7 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot, int function, int
>  vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot reset: %s"
>  vfio_populate_device_config(const char *name, unsigned long size, unsigned long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx, flags: 0x%lx"
>  vfio_populate_device_get_irq_info_failure(const char *errstr) "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
> -vfio_realize(const char *name, int group_id) " (%s) group %d"
> +vfio_attach_device(const char *name, int group_id) " (%s) group %d"
>  vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>  vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s 0x%x@0x%x"
>  vfio_pci_reset(const char *name) " (%s)"


