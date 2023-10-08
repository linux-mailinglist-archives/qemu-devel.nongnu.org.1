Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C057BCF6D
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 19:47:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpXqt-0000Lc-5l; Sun, 08 Oct 2023 13:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpXqe-0000ET-Pn
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 13:45:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qpXqa-00069J-SN
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 13:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696787141;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkCoGqW57woZ0Fx04l7WfrrbT40rsFvqrAR+QpqxTJA=;
 b=LQsrVHsftV9ZBiCq6oVcD/H/hOlMdHoDlfo8lzajG/aSq5eczT5oHoJpAVzksa+HsdTX+s
 A22k49JXvV+aDC9alIw8TvylBLpciOCkh/f1ZOYmCJrxx6Wwe+sPq941sXHPAUGlaGBWUd
 4bx8AP+h+6l8I7Qwjjv2OCeM7wJyBg8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-2PGAqz-cOu2rmINQS7XgWQ-1; Sun, 08 Oct 2023 13:45:38 -0400
X-MC-Unique: 2PGAqz-cOu2rmINQS7XgWQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7742eeceeacso469813785a.3
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 10:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696787138; x=1697391938;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vkCoGqW57woZ0Fx04l7WfrrbT40rsFvqrAR+QpqxTJA=;
 b=YHy2qyE58o2tXTsWdlVIgZGJFETxW9FDK+cVxYn7mH9z6gbv9wQJGCSpdrT0iuaJXL
 lzZjK+RXZRdmLtapDNH8t7U3VaEgaXU9PoBfnLC0s74XwMYE9aw81T7jYgMjXwxr44lV
 M2uHCanwpho4h1XXHAu7aJ+UuD4ZS1lx2tWp5XjdmuVQ3MRl7EM72HNCdch/BS0aQT5f
 QxLSUXXW7erkO1ptiBPkzsVLIaEQqramrdO2G0qfzOFTU4NyrzuOb470BzdNfc9rqhfx
 ryGLl5BCxMY5s95w+VX6bdgEEXrB2mfNmiOJl20oudVfOrQ5xetJ0LXDHNMadN5/ZMEk
 hnyA==
X-Gm-Message-State: AOJu0Yz2H7AVyPLqkFLYYvgweLJ1nPaWeXzKOg3/IxyrCBJihLwScIHu
 2B+YN7afV0X8mM8uVTXSrPaCsABOGFUEalObTCHWtKx/LyVeyVHg5PE0kIaQKNBt0nnxDjhBWNV
 zIPTu7fvMcRO8ssg=
X-Received: by 2002:a05:620a:470e:b0:775:8e55:3da7 with SMTP id
 bs14-20020a05620a470e00b007758e553da7mr16440949qkb.54.1696787138313; 
 Sun, 08 Oct 2023 10:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZqvrSsbguOCiY83hnD4mSyKSlNj41E5ydUCHgyaHp1bGhYuWlG0VZLUqPWwzuww4T70aJpQ==
X-Received: by 2002:a05:620a:470e:b0:775:8e55:3da7 with SMTP id
 bs14-20020a05620a470e00b007758e553da7mr16440933qkb.54.1696787138083; 
 Sun, 08 Oct 2023 10:45:38 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 v22-20020ae9e316000000b0076dacd14484sm2909869qkf.83.2023.10.08.10.45.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 10:45:36 -0700 (PDT)
Message-ID: <4ac0b36c-bf7e-4f00-52f2-1499e75413e7@redhat.com>
Date: Sun, 8 Oct 2023 19:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "aik@ozlabs.ru" <aik@ozlabs.ru>
References: <20231004154518.334760-1-eric.auger@redhat.com>
 <20231004154518.334760-11-eric.auger@redhat.com>
 <PH7PR11MB67220561760B1AE2DB9277AA92CFA@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB67220561760B1AE2DB9277AA92CFA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
On 10/8/23 12:21, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, October 4, 2023 11:44 PM
>> Subject: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
>>
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
>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>
>> ---
>>
>> v3:
>> - simplified vbasedev->dev setting
>>
>> v2 -> v3:
>> - Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>>  while keeping into account Matthew's comment
>>  https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-
>> 2b6b31678b53@linux.ibm.com/
>> ---
>> include/hw/vfio/vfio-common.h |   5 --
>> hw/vfio/ccw.c                 | 122 +++++++++-------------------------
>> hw/vfio/common.c              |  10 +--
>> 3 files changed, 37 insertions(+), 100 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index 12fbfbc37d..c486bdef2a 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -202,7 +202,6 @@ typedef struct {
>>     hwaddr pages;
>> } VFIOBitmap;
>>
>> -void vfio_put_base_device(VFIODevice *vbasedev);
>> void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>> void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>> void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>> void vfio_region_exit(VFIORegion *region);
>> void vfio_region_finalize(VFIORegion *region);
>> void vfio_reset_handler(void *opaque);
>> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>> -void vfio_put_group(VFIOGroup *group);
>> struct vfio_device_info *vfio_get_device_info(int fd);
>> -int vfio_get_device(VFIOGroup *group, const char *name,
>> -                    VFIODevice *vbasedev, Error **errp);
>> int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>                        AddressSpace *as, Error **errp);
>> void vfio_detach_device(VFIODevice *vbasedev);
>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>> index 1e2fce83b0..6ec35fedc9 100644
>> --- a/hw/vfio/ccw.c
>> +++ b/hw/vfio/ccw.c
>> @@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice
>> *vcdev)
>>     g_free(vcdev->io_region);
>> }
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
>> static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>> {
>> -    VFIOGroup *group;
>>     S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>>     VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>>     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>> +    VFIODevice *vbasedev = &vcdev->vdev;
>>     Error *err = NULL;
>> +    char *name;
>> +    int ret;
>>
>>     /* Call the class init function for subchannel. */
>>     if (cdc->realize) {
>> @@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error
>> **errp)
>>         }
>>     }
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
> Hoping not late for you to include this in v5.
> I think no need to re-assign sysfsdev as it's a user property, we'd better to
> keep the original user value. Also looks a memory leak here.
OK I removed it.
>
>> +    vbasedev->ops = &vfio_ccw_ops;
>> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
>> +    vbasedev->name = name;
> There will be a potential failure when a second mdev device under
> same cssid.ssid.devid attached. We can use cdev->mdevid as name.
But this mathes vfio_ccw_get_device() existing code where
vcdev->vdev.name = name; and
name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
                                 cdev->hostid.ssid,
                                 cdev->hostid.devid);

cdev->mdevid is passed as first arg of vfio_attach_device() instead .

i think this also matches
https://lore.kernel.org/all/PH7PR11MB67222DD282F98E03095FBA8A92C1A@PH7PR11MB6722.namprd11.prod.outlook.com/
no?

Thanks

Eric

>
> Maybe you can use v2 of this patch, I remember these two issues are already addressed in v2.
>
> Thanks
> Zhenzhong
>
>


