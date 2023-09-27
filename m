Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A77AFC2D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 09:37:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlP5M-0005eU-Rs; Wed, 27 Sep 2023 03:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlP5I-0005e3-5m
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:35:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlP5G-0005Y6-3X
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 03:35:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695800145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoHt+shEsZinNBHxa1q2vq2arlVvyzyoRrqZJUolfqA=;
 b=cdj9a9E4WhPYNMEXhuqczoJ3xgqay9oaecs58Kp+yeyjvJcwEN0DnSVBFWKbu3N1HUpbC3
 glS13W3piRygN4VV77/4y2aNemf0vNACjNe1WA/Nb04H/kURefk/FThlhyvRE47AYe8Mum
 sXBNmJQXQCiKR5uEUKjs9MbZjmcqdXc=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-e9bc6bdvMT25gmLnPE38MA-1; Wed, 27 Sep 2023 03:35:43 -0400
X-MC-Unique: e9bc6bdvMT25gmLnPE38MA-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-34ca7a685afso114533045ab.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 00:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695800142; x=1696404942;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XoHt+shEsZinNBHxa1q2vq2arlVvyzyoRrqZJUolfqA=;
 b=RNR/wx+7f5KfugLcrXEAz7tscBj4M1RqzIIsJBI8CW2CfMrNPdt3de1B6Y/br/8baB
 6y2i1pRHBUJv5BFgG6SiNgSI3v9mLXifFZs9RH0qVEPp1DlKYwys9X5jRv9b2gUYBdRJ
 8YIWJzFAtz8u0g6+404r65bITnmNuLvTWbdJRnDuNTXOxot+Iks/AJ/5KJrB1Y0Jtdck
 AeEwOxQxpr/bPxK6O/jIzgHYCeePnSyW/Zd0mYtR1UmDD0p/pZxq4W/OnPK4URPnAcL7
 Cvkp6i8LbU47913I0ZroHXvuYgk3FZ1hK3LiARrvq7jZShxgfC4cRMVuYVzcwpxaVw1v
 yEsQ==
X-Gm-Message-State: AOJu0YyZ6evlW4REUuefb6psnbc69WgLr7WHulxIYTmzGYgdeYUB4TPg
 aIluR3mbGfib+sTJWzZ5Jyk0ylAa/5vPVK5I1SDqaGUj3W4fR4idfsSZZzXXOsU41djbgmM73hP
 xPME5hpUZHTxXIRs=
X-Received: by 2002:a05:6e02:f94:b0:34f:f6d1:ef2a with SMTP id
 v20-20020a056e020f9400b0034ff6d1ef2amr1228864ilo.13.1695800142621; 
 Wed, 27 Sep 2023 00:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8yx2VCiOTE1qzTbqaXPF4cZ8vGliEeq8ORlK7Ymn8CuvnR+xL7WBB4ET3YvyDGIg6ZIgMZg==
X-Received: by 2002:a05:6e02:f94:b0:34f:f6d1:ef2a with SMTP id
 v20-20020a056e020f9400b0034ff6d1ef2amr1228854ilo.13.1695800142260; 
 Wed, 27 Sep 2023 00:35:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p8-20020a92da48000000b0034cd2c0afe8sm1819569ilq.56.2023.09.27.00.35.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 00:35:41 -0700 (PDT)
Message-ID: <0c11b6c6-1ae5-c116-7938-0c99ccfc87ae@redhat.com>
Date: Wed, 27 Sep 2023 09:35:37 +0200
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
Content-Transfer-Encoding: 8bit
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

you may add: no functional change intended
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
hum looking at that again, I was confused by the fact we passed the name
arg in

vfio_attach_device() whereas vbasedev->name was already filled. Looking at pci vfio_realize()
both are sometimes different

    if (!qemu_uuid_is_null(&vdev->vf_token)) {
        qemu_uuid_unparse(&vdev->vf_token, uuid);
        name = g_strdup_printf("%s vf_token=%s", vbasedev->name, uuid);
    } else {
        name = g_strdup(vbasedev->name);
    }
This may be worth a doc comment.


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
nit we could add a  trace_vfio_detach_device tracepoint here for symetry
sake
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
Thanks

Eric


