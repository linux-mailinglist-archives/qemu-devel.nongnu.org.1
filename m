Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5F87B7F31
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:34:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo13y-0001ux-FC; Wed, 04 Oct 2023 08:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo13w-0001se-7g
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qo13u-0008Vg-0z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696422789;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UBYib8C0uYK1lkD7+oskvdnuTyCj4oD6RVK35EHcUAc=;
 b=Gb7Xy3c3i/g7qoB3Xs3GrzNS8EHCn+mK3SbjgUHiStZ0HlzXWNC+64l2mODvZvYx31YCx9
 bEZbC6PpL2pw9LSna1zyQrfihf7VEUgl4m43I+eQox3YRY+NXaA05K28nyX+HMdrjgzR0g
 pVoD/O2uxvb1BuAZMetNvOU5g4dNOHg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-SIeen5FpNjeOCJMVvRAN8A-1; Wed, 04 Oct 2023 08:33:05 -0400
X-MC-Unique: SIeen5FpNjeOCJMVvRAN8A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-77578227e4bso239537285a.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696422785; x=1697027585;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UBYib8C0uYK1lkD7+oskvdnuTyCj4oD6RVK35EHcUAc=;
 b=FgjeAxrcohmvNqjzv0ukaVPKdqros3XKuo2N0YOtZeSiC2XUN296tjO+wpE5Inr8Xu
 w/4gjZ38x3BTVMGmIWvylR+K6UqHVqEsjp79MvuZ9qUlSOb8DdgzFGcWISE+eIkV3fRc
 haMC85OjJARJO4ha8ckf0UQm9dkWPb58yY7kLkHhu5HaNTLOsviuAmjaSEIcLn+4nJtN
 h8SIOgBOIP1Q9y4b+Ta9D9MBXGaPYihQBz8r0lT/kOVqvcC0I1Dwfy4GAlLEcq9TrQDu
 FI9V5qyyUwfDcpQ1QfDukw50j/UXY+DoZX/WRQ/3KqRpTlVW0GS5fzYR1RyFwPXhvvLw
 JbyQ==
X-Gm-Message-State: AOJu0YxYhicc8ge880owQYW0H2o92EH5v1ndbWZ4AHuSYYcJplJvGsJp
 KqvrPerfs5PRwCj0W4Kbf+vJ82crg/PoEKh5SR6004KK53B15mjoV6xuk/5uxOIojJMqh5w131o
 vt6T6V8Al7ab83BM=
X-Received: by 2002:a0c:8c44:0:b0:656:3ed4:ffe9 with SMTP id
 o4-20020a0c8c44000000b006563ed4ffe9mr1766513qvb.58.1696422785287; 
 Wed, 04 Oct 2023 05:33:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA54nsohukrrWbuLFUmSatrDkuW6CXciR1BQhnj1YJnqlbqjiY3M7mBXwgQ3HzybiB8rpe+Q==
X-Received: by 2002:a0c:8c44:0:b0:656:3ed4:ffe9 with SMTP id
 o4-20020a0c8c44000000b006563ed4ffe9mr1766485qvb.58.1696422784950; 
 Wed, 04 Oct 2023 05:33:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a0c8c4d000000b00655e2005350sm1308616qvb.9.2023.10.04.05.33.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 05:33:03 -0700 (PDT)
Message-ID: <33b7803c-f231-d4fb-d9d9-26a097a89e93@redhat.com>
Date: Wed, 4 Oct 2023 14:32:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com, alex.williamson@redhat.com,
 clg@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-11-eric.auger@redhat.com>
 <99a623d9-c161-fa3e-24fe-3e7b5795718f@linux.ibm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <99a623d9-c161-fa3e-24fe-3e7b5795718f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Hi Matthew,

On 10/4/23 01:01, Matthew Rosato wrote:
> On 10/3/23 6:14 AM, Eric Auger wrote:
>> Let the vfio-ccw device use vfio_attach_device() and
>> vfio_detach_device(), hence hiding the details of the used
>> IOMMU backend.
>>
>> Note that the migration reduces the following trace
>> "vfio: subchannel %s has already been attached" (featuring
>> cssid.ssid.devid) into "device is already attached"
>>
>> Also now all the devices have been migrated to use the new
>> vfio_attach_device/vfio_detach_device API, let's turn the
>> legacy functions into static functions, local to container.c.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> ---
>> v2 -> v3:
>> - Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>>   while keeping into account Matthew's comment
>>   https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>
> Tested out using some vfio-ccw devices and verified attach/detach worked / sysfsdev was correct.

Thank you very much for the testing and teh review. I dare to keep your
R-b despite the vbasedev->dev = dev setting simplification as pointed
out by Cédric.

Eric

>
>> ---
>>  include/hw/vfio/vfio-common.h |   5 --
>>  hw/vfio/ccw.c                 | 122 +++++++++-------------------------
>>  hw/vfio/common.c              |  10 +--
>>  3 files changed, 37 insertions(+), 100 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 12fbfbc37d..c486bdef2a 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -202,7 +202,6 @@ typedef struct {
>>      hwaddr pages;
>>  } VFIOBitmap;
>>  
>> -void vfio_put_base_device(VFIODevice *vbasedev);
>>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>>  void vfio_region_exit(VFIORegion *region);
>>  void vfio_region_finalize(VFIORegion *region);
>>  void vfio_reset_handler(void *opaque);
>> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>> -void vfio_put_group(VFIOGroup *group);
>>  struct vfio_device_info *vfio_get_device_info(int fd);
>> -int vfio_get_device(VFIOGroup *group, const char *name,
>> -                    VFIODevice *vbasedev, Error **errp);
>>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                         AddressSpace *as, Error **errp);
>>  void vfio_detach_device(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 1e2fce83b0..84eafb2e87 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
>>      g_free(vcdev->io_region);
>>  }
>>  
>> -static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
>> -{
>> -    g_free(vcdev->vdev.name);
>> -    vfio_put_base_device(&vcdev->vdev);
>> -}
>> -
>> -static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
>> -                                Error **errp)
>> -{
>> -    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
>> -    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>> -                                 cdev->hostid.ssid,
>> -                                 cdev->hostid.devid);
>> -    VFIODevice *vbasedev;
>> -
>> -    QLIST_FOREACH(vbasedev, &group->device_list, next) {
>> -        if (strcmp(vbasedev->name, name) == 0) {
>> -            error_setg(errp, "vfio: subchannel %s has already been attached",
>> -                       name);
>> -            goto out_err;
>> -        }
>> -    }
>> -
>> -    /*
>> -     * All vfio-ccw devices are believed to operate in a way compatible with
>> -     * discarding of memory in RAM blocks, ie. pages pinned in the host are
>> -     * in the current working set of the guest driver and therefore never
>> -     * overlap e.g., with pages available to the guest balloon driver.  This
>> -     * needs to be set before vfio_get_device() for vfio common to handle
>> -     * ram_block_discard_disable().
>> -     */
>> -    vcdev->vdev.ram_block_discard_allowed = true;
>> -
>> -    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
>> -        goto out_err;
>> -    }
>> -
>> -    vcdev->vdev.ops = &vfio_ccw_ops;
>> -    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
>> -    vcdev->vdev.name = name;
>> -    vcdev->vdev.dev = DEVICE(vcdev);
>> -
>> -    return;
>> -
>> -out_err:
>> -    g_free(name);
>> -}
>> -
>> -static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>> -{
>> -    char *tmp, group_path[PATH_MAX];
>> -    ssize_t len;
>> -    int groupid;
>> -
>> -    tmp = g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
>> -                          cdev->hostid.cssid, cdev->hostid.ssid,
>> -                          cdev->hostid.devid, cdev->mdevid);
>> -    len = readlink(tmp, group_path, sizeof(group_path));
>> -    g_free(tmp);
>> -
>> -    if (len <= 0 || len >= sizeof(group_path)) {
>> -        error_setg(errp, "vfio: no iommu_group found");
>> -        return NULL;
>> -    }
>> -
>> -    group_path[len] = 0;
>> -
>> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>> -        error_setg(errp, "vfio: failed to read %s", group_path);
>> -        return NULL;
>> -    }
>> -
>> -    return vfio_get_group(groupid, &address_space_memory, errp);
>> -}
>> -
>>  static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>>  {
>> -    VFIOGroup *group;
>>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>> +    VFIODevice *vbasedev = &vcdev->vdev;
>>      Error *err = NULL;
>> +    char *name;
>> +    int ret;
>>  
>>      /* Call the class init function for subchannel. */
>>      if (cdc->realize) {
>> @@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>>          }
>>      }
>>  
>> -    group = vfio_ccw_get_group(cdev, &err);
>> -    if (!group) {
>> -        goto out_group_err;
>> -    }
>> +    name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
>> +                           vcdev->cdev.hostid.ssid,
>> +                           vcdev->cdev.hostid.devid);
>> +    vbasedev->sysfsdev = g_strdup_printf("/sys/bus/css/devices/%s/%s",
>> +                                         name,
>> +                                         cdev->mdevid);
>> +    vbasedev->ops = &vfio_ccw_ops;
>> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
>> +    vbasedev->name = name;
>> +    vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;
>>  
>> -    vfio_ccw_get_device(group, vcdev, &err);
>> -    if (err) {
>> -        goto out_device_err;
>> +    /*
>> +     * All vfio-ccw devices are believed to operate in a way compatible with
>> +     * discarding of memory in RAM blocks, ie. pages pinned in the host are
>> +     * in the current working set of the guest driver and therefore never
>> +     * overlap e.g., with pages available to the guest balloon driver.  This
>> +     * needs to be set before vfio_get_device() for vfio common to handle
>> +     * ram_block_discard_disable().
>> +     */
>> +    vbasedev->ram_block_discard_allowed = true;
>> +
>> +    ret = vfio_attach_device(cdev->mdevid, vbasedev,
>> +                             &address_space_memory, errp);
>> +    if (ret) {
>> +        goto out_attach_dev_err;
>>      }
>>  
>>      vfio_ccw_get_region(vcdev, &err);
>> @@ -708,10 +652,9 @@ out_irq_notifier_err:
>>  out_io_notifier_err:
>>      vfio_ccw_put_region(vcdev);
>>  out_region_err:
>> -    vfio_ccw_put_device(vcdev);
>> -out_device_err:
>> -    vfio_put_group(group);
>> -out_group_err:
>> +    vfio_detach_device(vbasedev);
>> +out_attach_dev_err:
>> +    g_free(vbasedev->name);
>>      if (cdc->unrealize) {
>>          cdc->unrealize(cdev);
>>      }
>> @@ -724,14 +667,13 @@ static void vfio_ccw_unrealize(DeviceState *dev)
>>      S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>>      VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>>      S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>> -    VFIOGroup *group = vcdev->vdev.group;
>>  
>>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_REQ_IRQ_INDEX);
>>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_CRW_IRQ_INDEX);
>>      vfio_ccw_unregister_irq_notifier(vcdev, VFIO_CCW_IO_IRQ_INDEX);
>>      vfio_ccw_put_region(vcdev);
>> -    vfio_ccw_put_device(vcdev);
>> -    vfio_put_group(group);
>> +    vfio_detach_device(&vcdev->vdev);
>> +    g_free(vcdev->vdev.name);
>>  
>>      if (cdc->unrealize) {
>>          cdc->unrealize(cdev);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index f4c33c9858..56cfe94d97 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -2335,7 +2335,7 @@ static void vfio_disconnect_container(VFIOGroup *group)
>>      }
>>  }
>>  
>> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>> +static VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp)
>>  {
>>      VFIOGroup *group;
>>      char path[32];
>> @@ -2402,7 +2402,7 @@ free_group_exit:
>>      return NULL;
>>  }
>>  
>> -void vfio_put_group(VFIOGroup *group)
>> +static void vfio_put_group(VFIOGroup *group)
>>  {
>>      if (!group || !QLIST_EMPTY(&group->device_list)) {
>>          return;
>> @@ -2447,8 +2447,8 @@ retry:
>>      return info;
>>  }
>>  
>> -int vfio_get_device(VFIOGroup *group, const char *name,
>> -                    VFIODevice *vbasedev, Error **errp)
>> +static int vfio_get_device(VFIOGroup *group, const char *name,
>> +                           VFIODevice *vbasedev, Error **errp)
>>  {
>>      g_autofree struct vfio_device_info *info = NULL;
>>      int fd;
>> @@ -2506,7 +2506,7 @@ int vfio_get_device(VFIOGroup *group, const char *name,
>>      return 0;
>>  }
>>  
>> -void vfio_put_base_device(VFIODevice *vbasedev)
>> +static void vfio_put_base_device(VFIODevice *vbasedev)
>>  {
>>      if (!vbasedev->group) {
>>          return;


