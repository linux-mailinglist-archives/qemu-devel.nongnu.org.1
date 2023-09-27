Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E60C7B0131
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRLU-0008LJ-RD; Wed, 27 Sep 2023 06:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlRLM-0008FR-LN
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qlRLK-0001K2-Bv
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695808829;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/HTL1JVUddt16p4WDfMlb+WJLBQ/jCz2Tqri5hq7wuo=;
 b=Cs/XqxnpivGXx3AEjDBGPhee+FSDDvIDtD/kmnE+DdtMGynivaKeDQVyy+gNgVKtz+MVj3
 EdqurYpCiQwure2puuywHmom7+38S81tQpzMlDsOWH4zIMAJbSBaZc9IMIhPfpkvqpvrC4
 AvKTDttG9DBoEoEYrAgbCwU35LYcn8c=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-KwP_3jNpMfSdJCeZIDa6-Q-1; Wed, 27 Sep 2023 06:00:27 -0400
X-MC-Unique: KwP_3jNpMfSdJCeZIDa6-Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4194eb910f5so56003321cf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695808827; x=1696413627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HTL1JVUddt16p4WDfMlb+WJLBQ/jCz2Tqri5hq7wuo=;
 b=MB/5FOnQy4d+KvhziyUGrp6CMYWw0zWlCtbR5G/V7UXKyxactf88XqPqh4CSXoGWUi
 lIFbsg3KGnUsQs70JlMiNTh2G7g022xycPPi8/YeqD/Y0WycCbM6wKoS6wxAV5FYRid2
 d3PSgwcB3JG4TsZ+UdKBuaiHSkoB2tMbWcbMs1GSOPpzVH+QBODs9Q6msLOJvPTbzeeU
 G4TAP0t3+aN6dghLcLUw408CpJOOpn07fR1qH7xjz1V/DELBEGDWKwvBRScOJKle7Y48
 rUqOwbhzF9CIAGbSFFXgcZjD6KUO6eNzDY7sNAHEZo8tUwtiNrvnWAhiHV9VrQ4wz4bm
 CKEA==
X-Gm-Message-State: AOJu0YxshZHYh5RgZBeJOVLqNwcvU4DvjwqRWAtCSqvJqxouddwSbXO+
 5u/XcPcJAHmd/1kOjr+cH1X8nGB1svrhpoI3zaOJwi+GWAIve7f8b0TOv+qQgxdPMlI1RgrpZnT
 FbVAwmoiS52j9RIs=
X-Received: by 2002:a05:622a:1647:b0:418:af4c:1853 with SMTP id
 y7-20020a05622a164700b00418af4c1853mr1891679qtj.25.1695808827400; 
 Wed, 27 Sep 2023 03:00:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQxdK0dBdN9BAjRGhG1Zk34uCrFAAIQQNQ8CGLtggysQzVSjHY/filnNSyh5LDj2Urb44dkg==
X-Received: by 2002:a05:622a:1647:b0:418:af4c:1853 with SMTP id
 y7-20020a05622a164700b00418af4c1853mr1891651qtj.25.1695808827036; 
 Wed, 27 Sep 2023 03:00:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 jj2-20020a05622a740200b004054b435f8csm5195922qtb.65.2023.09.27.03.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:00:25 -0700 (PDT)
Message-ID: <66548ae7-3cc4-94d8-de46-c15f2e402ed1@redhat.com>
Date: Wed, 27 Sep 2023 12:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-10-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230926113255.1177834-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/26/23 13:32, Zhenzhong Duan wrote:
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
> ---
>  include/hw/vfio/vfio-common.h |   5 --
>  hw/vfio/ccw.c                 | 115 ++++++++--------------------------
>  hw/vfio/common.c              |  10 +--
>  3 files changed, 30 insertions(+), 100 deletions(-)
>
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 12fbfbc37d..c486bdef2a 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -202,7 +202,6 @@ typedef struct {
>      hwaddr pages;
>  } VFIOBitmap;
>  
> -void vfio_put_base_device(VFIODevice *vbasedev);
>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>  void vfio_region_exit(VFIORegion *region);
>  void vfio_region_finalize(VFIORegion *region);
>  void vfio_reset_handler(void *opaque);
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
> -void vfio_put_group(VFIOGroup *group);
>  struct vfio_device_info *vfio_get_device_info(int fd);
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp);
>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>                         AddressSpace *as, Error **errp);
>  void vfio_detach_device(VFIODevice *vbasedev);
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 1e2fce83b0..6893a30ab1 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -572,88 +572,14 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>      g_free(vcdev->io_region);
>  }
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
Digging into that few months later,

new vfio_device_groupid uses

+    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);

which is set as a prop here
    DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
we need to double check if this matches, this is not obvious at first sight. At least if this is true this needs to be documented in the commit msg

then the subchannel name is
    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
                                 cdev->hostid.ssid,
                                 cdev->hostid.devid);
    QLIST_FOREACH(vbasedev, &group->device_list, next) {
        if (strcmp(vbasedev->name, name) == 0) {
            error_setg(errp, "vfio: subchannel %s has already been attached",
                       name);
            goto out_err;
        }
    }

while new code use 
+    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
+        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
+            error_setg(errp, "device is already attached");
+            vfio_put_group(group);
+            return -EBUSY;
+        }
+    }

We really need to double check the names, ie.
name, vbasedev->name. That's a mess and that's my bad.

Thanks

Eric


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
>  static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>  {
> -    VFIOGroup *group;
>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> +    VFIODevice *vbasedev = &vcdev->vdev;
>      Error *err = NULL;
> +    int ret;
>  
>      /* Call the class init function for subchannel. */
>      if (cdc->realize) {
> @@ -663,14 +589,25 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>          }
>      }
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
>      }
>  
>      vfio_ccw_get_region(vcdev, &err);
> @@ -708,10 +645,9 @@ out_irq_notifier_err:
>  out_io_notifier_err:
>      vfio_ccw_put_region(vcdev);
>  out_region_err:
> -    vfio_ccw_put_device(vcdev);
> -out_device_err:
> -    vfio_put_group(group);
> -out_group_err:
> +    vfio_detach_device(vbasedev);
> +out_attach_dev_err:
> +    g_free(vbasedev->name);
>      if (cdc->unrealize) {
>          cdc->unrealize(cdev);
>      }
> @@ -724,14 +660,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
> -    VFIOGroup *group = vcdev->vdev.group;
>  
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX);
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>      vfio_ccw_put_region(vcdev);
> -    vfio_ccw_put_device(vcdev);
> -    vfio_put_group(group);
> +    vfio_detach_device(&vcdev->vdev);
> +    g_free(vcdev->vdev.name);
>  
>      if (cdc->unrealize) {
>          cdc->unrealize(cdev);
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7f3798b152..65516b319e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -2335,7 +2335,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>      }
>  }
>  
> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
> +static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>  {
>      VFIOGroup *group;
>      char path[32];
> @@ -2402,7 +2402,7 @@ free_group_exit:
>      return NULL;
>  }
>  
> -void vfio_put_group(VFIOGroup *group)
> +static void vfio_put_group(VFIOGroup *group)
>  {
>      if (!group || !QLIST_EMPTY(&group->device_list)) {
>          return;
> @@ -2447,8 +2447,8 @@ retry:
>      return info;
>  }
>  
> -int vfio_get_device(VFIOGroup *group, const char *name,
> -                    VFIODevice *vbasedev, Error **errp)
> +static int vfio_get_device(VFIOGroup *group, const char *name,
> +                           VFIODevice *vbasedev, Error **errp)
>  {
>      g_autofree struct vfio_device_info *info = NULL;
>      int fd;
> @@ -2506,7 +2506,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>      return 0;
>  }
>  
> -void vfio_put_base_device(VFIODevice *vbasedev)
> +static void vfio_put_base_device(VFIODevice *vbasedev)
>  {
>      if (!vbasedev->group) {
>          return;


