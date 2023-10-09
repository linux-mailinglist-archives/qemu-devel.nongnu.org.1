Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4B87BD4FB
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 10:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qplPk-0007Bb-Qq; Mon, 09 Oct 2023 04:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qplPc-00079T-56
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qplPa-0005Tl-0v
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 04:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696839285;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLxa3ED9xSLdRtghLwfjxCB1QqSPg/ga9Il9V/GthUI=;
 b=H2fcfW4mHep/H0XHnXBkqufgY1jE45ulbqqtiZ+7L3tqNatkmt13xG1AO2C73pHlqnYAko
 LbRNamVsnzJsBFEjY42ThowOg6FpaVCOKv3ZUxnWO3H/U/mEMxHVmP3bz5hyCmx00UT8O6
 TJ6elxP3sP8xenAXQsAo73RLMosNXqs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-4wi6kwRnMDKTj8Un-qFIFw-1; Mon, 09 Oct 2023 04:14:44 -0400
X-MC-Unique: 4wi6kwRnMDKTj8Un-qFIFw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7740517a478so545093285a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 01:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696839282; x=1697444082;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DLxa3ED9xSLdRtghLwfjxCB1QqSPg/ga9Il9V/GthUI=;
 b=tEgYusftsAUXwcrzCjYxiMje3t1Nq2ebdLrIJ/CDdQt3ZyaRsUQHMM4Yn44qpZRLiy
 rT5u/dAuovDQKtD9l186ta4aHZpD0sfx8BFltRUvjCKyyRZQKOoz96Jfey+N2RUF66PY
 lJ4SNZIFY9PWKw3aXOI3DKTVpaRJ+BUOtZIKq7JZgXK8byWkjMc97JoC6CfIF6Bf5wuj
 6VaUq5x5vswlUb95zhu7So+B1TNI/S5fZXNE7e1ZVoQaBKzH3ji1D/QgpHNTWtkP9Bwt
 stNLRZTtfCL0xhYhUav7avyFSC3FR81+qjVHpBEonX+6SRKsxTMo2a3+3Eayr6Uz9+tA
 D/LA==
X-Gm-Message-State: AOJu0YwGeTnWGCOQK55/39UBWipky8fkBzBKsT82ib3M+WJaBvnOuuLB
 rRauGIaIsVIjV6q3f5MUeTHMOGEPu3lcK0dPIX5r3ve9zRErzzRMo2t2IlMP5EmrGSnZfEgQe/h
 D2dgrlSyAjDIe00x8SD+BQcw=
X-Received: by 2002:a05:620a:2551:b0:775:6fcd:b7a6 with SMTP id
 s17-20020a05620a255100b007756fcdb7a6mr16768045qko.31.1696839282456; 
 Mon, 09 Oct 2023 01:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEU6TgVS+EC0c+oFB4VODlWl4jDFUb375TyFxaQP7IWAGBE7etLBAMtxaNhBQgUet3CaS/kw==
X-Received: by 2002:a05:620a:2551:b0:775:6fcd:b7a6 with SMTP id
 s17-20020a05620a255100b007756fcdb7a6mr16768030qko.31.1696839282091; 
 Mon, 09 Oct 2023 01:14:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 t30-20020a05620a035e00b007743446efd1sm3356190qkm.35.2023.10.09.01.14.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 01:14:40 -0700 (PDT)
Message-ID: <74d56985-3573-e01f-b6b4-5fc7829ddfc8@redhat.com>
Date: Mon, 9 Oct 2023 10:14:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
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
 <4ac0b36c-bf7e-4f00-52f2-1499e75413e7@redhat.com>
 <PH7PR11MB67224BDF9E0837B921827C9892CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB67224BDF9E0837B921827C9892CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.818, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
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

On 10/9/23 03:25, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, October 9, 2023 1:46 AM
>> Subject: Re: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
>>
>> Hi Zhenzhong,
>> On 10/8/23 12:21, Duan, Zhenzhong wrote:
>>> Hi Eric,
>>>
>>>> -----Original Message-----
>>>> From: Eric Auger <eric.auger@redhat.com>
>>>> Sent: Wednesday, October 4, 2023 11:44 PM
>>>> Subject: [PATCH v4 10/15] vfio/ccw: Use vfio_[attach/detach]_device
>>>>
>>>> Let the vfio-ccw device use vfio_attach_device() and
>>>> vfio_detach_device(), hence hiding the details of the used
>>>> IOMMU backend.
>>>>
>>>> Note that the migration reduces the following trace
>>>> "vfio: subchannel %s has already been attached" (featuring
>>>> cssid.ssid.devid) into "device is already attached"
>>>>
>>>> Also now all the devices have been migrated to use the new
>>>> vfio_attach_device/vfio_detach_device API, let's turn the
>>>> legacy functions into static functions, local to container.c.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>>>
>>>> ---
>>>>
>>>> v3:
>>>> - simplified vbasedev->dev setting
>>>>
>>>> v2 -> v3:
>>>> - Hopefully fix confusion beteen vbasedev->name, mdevid and sysfsdev
>>>>  while keeping into account Matthew's comment
>>>>  https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-
>>>> 2b6b31678b53@linux.ibm.com/
>>>> ---
>>>> include/hw/vfio/vfio-common.h |   5 --
>>>> hw/vfio/ccw.c                 | 122 +++++++++-------------------------
>>>> hw/vfio/common.c              |  10 +--
>>>> 3 files changed, 37 insertions(+), 100 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>>> index 12fbfbc37d..c486bdef2a 100644
>>>> --- a/include/hw/vfio/vfio-common.h
>>>> +++ b/include/hw/vfio/vfio-common.h
>>>> @@ -202,7 +202,6 @@ typedef struct {
>>>>     hwaddr pages;
>>>> } VFIOBitmap;
>>>>
>>>> -void vfio_put_base_device(VFIODevice *vbasedev);
>>>> void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>>>> void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>>>> void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>>>> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>>>> void vfio_region_exit(VFIORegion *region);
>>>> void vfio_region_finalize(VFIORegion *region);
>>>> void vfio_reset_handler(void *opaque);
>>>> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>>>> -void vfio_put_group(VFIOGroup *group);
>>>> struct vfio_device_info *vfio_get_device_info(int fd);
>>>> -int vfio_get_device(VFIOGroup *group, const char *name,
>>>> -                    VFIODevice *vbasedev, Error **errp);
>>>> int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>>                        AddressSpace *as, Error **errp);
>>>> void vfio_detach_device(VFIODevice *vbasedev);
>>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>>> index 1e2fce83b0..6ec35fedc9 100644
>>>> --- a/hw/vfio/ccw.c
>>>> +++ b/hw/vfio/ccw.c
>>>> @@ -572,88 +572,15 @@ static void vfio_ccw_put_region(VFIOCCWDevice
>>>> *vcdev)
>>>>     g_free(vcdev->io_region);
>>>> }
>>>>
>>>> -static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
>>>> -{
>>>> -    g_free(vcdev->vdev.name);
>>>> -    vfio_put_base_device(&vcdev->vdev);
>>>> -}
>>>> -
>>>> -static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
>>>> -                                Error **errp)
>>>> -{
>>>> -    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
>>>> -    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>>>> -                                 cdev->hostid.ssid,
>>>> -                                 cdev->hostid.devid);
>>>> -    VFIODevice *vbasedev;
>>>> -
>>>> -    QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>>> -        if (strcmp(vbasedev->name, name) == 0) {
>>>> -            error_setg(errp, "vfio: subchannel %s has already been attached",
>>>> -                       name);
>>>> -            goto out_err;
>>>> -        }
>>>> -    }
>>>> -
>>>> -    /*
>>>> -     * All vfio-ccw devices are believed to operate in a way compatible with
>>>> -     * discarding of memory in RAM blocks, ie. pages pinned in the host are
>>>> -     * in the current working set of the guest driver and therefore never
>>>> -     * overlap e.g., with pages available to the guest balloon driver.  This
>>>> -     * needs to be set before vfio_get_device() for vfio common to handle
>>>> -     * ram_block_discard_disable().
>>>> -     */
>>>> -    vcdev->vdev.ram_block_discard_allowed = true;
>>>> -
>>>> -    if (vfio_get_device(group, cdev->mdevid, &vcdev->vdev, errp)) {
>>>> -        goto out_err;
>>>> -    }
>>>> -
>>>> -    vcdev->vdev.ops = &vfio_ccw_ops;
>>>> -    vcdev->vdev.type = VFIO_DEVICE_TYPE_CCW;
>>>> -    vcdev->vdev.name = name;
>>>> -    vcdev->vdev.dev = DEVICE(vcdev);
>>>> -
>>>> -    return;
>>>> -
>>>> -out_err:
>>>> -    g_free(name);
>>>> -}
>>>> -
>>>> -static VFIOGroup *vfio_ccw_get_group(S390CCWDevice *cdev, Error **errp)
>>>> -{
>>>> -    char *tmp, group_path[PATH_MAX];
>>>> -    ssize_t len;
>>>> -    int groupid;
>>>> -
>>>> -    tmp =
>> g_strdup_printf("/sys/bus/css/devices/%x.%x.%04x/%s/iommu_group",
>>>> -                          cdev->hostid.cssid, cdev->hostid.ssid,
>>>> -                          cdev->hostid.devid, cdev->mdevid);
>>>> -    len = readlink(tmp, group_path, sizeof(group_path));
>>>> -    g_free(tmp);
>>>> -
>>>> -    if (len <= 0 || len >= sizeof(group_path)) {
>>>> -        error_setg(errp, "vfio: no iommu_group found");
>>>> -        return NULL;
>>>> -    }
>>>> -
>>>> -    group_path[len] = 0;
>>>> -
>>>> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>>>> -        error_setg(errp, "vfio: failed to read %s", group_path);
>>>> -        return NULL;
>>>> -    }
>>>> -
>>>> -    return vfio_get_group(groupid, &address_space_memory, errp);
>>>> -}
>>>> -
>>>> static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>>>> {
>>>> -    VFIOGroup *group;
>>>>     S390CCWDevice *cdev = S390_CCW_DEVICE(dev);
>>>>     VFIOCCWDevice *vcdev = VFIO_CCW(cdev);
>>>>     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
>>>> +    VFIODevice *vbasedev = &vcdev->vdev;
>>>>     Error *err = NULL;
>>>> +    char *name;
>>>> +    int ret;
>>>>
>>>>     /* Call the class init function for subchannel. */
>>>>     if (cdc->realize) {
>>>> @@ -663,14 +590,31 @@ static void vfio_ccw_realize(DeviceState *dev, Error
>>>> **errp)
>>>>         }
>>>>     }
>>>>
>>>> -    group = vfio_ccw_get_group(cdev, &err);
>>>> -    if (!group) {
>>>> -        goto out_group_err;
>>>> -    }
>>>> +    name = g_strdup_printf("%x.%x.%04x", vcdev->cdev.hostid.cssid,
>>>> +                           vcdev->cdev.hostid.ssid,
>>>> +                           vcdev->cdev.hostid.devid);
>>>> +    vbasedev->sysfsdev = g_strdup_printf("/sys/bus/css/devices/%s/%s",
>>>> +                                         name,
>>>> +                                         cdev->mdevid);
>>> Hoping not late for you to include this in v5.
>>> I think no need to re-assign sysfsdev as it's a user property, we'd better to
>>> keep the original user value. Also looks a memory leak here.
>> OK I removed it.
>>>> +    vbasedev->ops = &vfio_ccw_ops;
>>>> +    vbasedev->type = VFIO_DEVICE_TYPE_CCW;
>>>> +    vbasedev->name = name;
>>> There will be a potential failure when a second mdev device under
>>> same cssid.ssid.devid attached. We can use cdev->mdevid as name.
>> But this mathes vfio_ccw_get_device() existing code where
>> vcdev->vdev.name = name; and
>> name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>>                                  cdev->hostid.ssid,
>>                                  cdev->hostid.devid);
> I suspect this is a bug of the existing code.
Then I would prefer we fix it separately. This patch migrates the
existing code without functional change intended.

>
>> cdev->mdevid is passed as first arg of vfio_attach_device() instead .
> vfio_attach_device() uses cdev->mdevid to get device FD, nothing more.
>
> If we use cssid.ssid.devid as name, then different mdev under same cssid.ssid.devid will have same name, and the second mdev attachment will fail to attach in vfio_attach_device():
>
>     QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>         if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>             error_setg(errp, "device is already attached");
>             vfio_put_group(group);
>             return -EBUSY;
>         }
>     }
I get your point but this conversion matches the existing
vfio_ccw_get_device() code:
    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
                                 cdev->hostid.ssid,
                                 cdev->hostid.devid);
    VFIODevice *vbasedev;

    QLIST_FOREACH(vbasedev, &group->device_list, next) {
        if (strcmp(vbasedev->name, name) == 0) {
            error_setg(errp, "vfio: subchannel %s has already been
attached",
                       name);
            goto out_err;
        }
    }

>
>> i think this also matches
>> https://lore.kernel.org/all/PH7PR11MB67222DD282F98E03095FBA8A92C1A@PH
>> 7PR11MB6722.namprd11.prod.outlook.com/
>> no?
> It doesn't match what Mattew suggested: https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/
this was RFC v3. At that time we did not pass any "name" arg to

vfio_attach_device(VFIODevice *vbasedev, AddressSpace *as, Error **errp)
and vbasedev->name was used when calling vfio_get_device() while we now
use cdev->mdevid. Besides Mattew ran some basic tests on PATCH v3:
https://lore.kernel.org/all/33b7803c-f231-d4fb-d9d9-26a097a89e93@redhat.com/
So I would be tempted to leave it as is (without the sysfsdev overwrite
which came from Mattew's suggestion in
https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/
). Thanks Eric

>
> Thanks
> Zhenzhong
>


