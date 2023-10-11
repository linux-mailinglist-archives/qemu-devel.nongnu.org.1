Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC3A7C5E11
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfYl-0007gm-US; Wed, 11 Oct 2023 16:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqfYg-0007gL-3T
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqfYd-0006N1-MC
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697055110;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LPa8IxRMOddZqxvf3O+6EtyKv9baT5AAtj3mloAc6MY=;
 b=cril0C1IuDA1nbbTg2R+SVnuCqjJmpkwhnfVWioRd4u2i61hgnPcto8FMxfPVSzI0w9s0A
 FnzLHFfqGpmosdIrJvhe09k8Ep/LdijHSuF6G7XUlumEuGJiM+r6Zxju0zPtInoLkjwMeJ
 NVbT+IsB18aJy+tfXjvTLjYS89+gQSw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-8DWzDpgvMOm_MYKuHWpqyw-1; Wed, 11 Oct 2023 16:11:47 -0400
X-MC-Unique: 8DWzDpgvMOm_MYKuHWpqyw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41b1f81f3f1so2699551cf.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697055107; x=1697659907;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LPa8IxRMOddZqxvf3O+6EtyKv9baT5AAtj3mloAc6MY=;
 b=hdg/lAQ04eN4usZQHnlJj+P+DTEdooNsqnMEPq7HiE8h1XL+fIGYsed/za7WLMUA+y
 dYDdtHEkM8i4X9oP5yo1Kd63XZWhrEAAsM/V4ghYr+lg1qdZSWFmVYa/KHew9pPF0sA9
 Ljer1s1jh+JTg6XgROCiXdHQGnzvtMSicFDrHPQCwxAp+7bHmSx9rttwJNaOY5nyT5ZK
 PiHNNe5pcmgST3vbxedOAcmc4H9O/UgLN/HT30eMwfTcYdCEacMpZWXMyY5EIFwU6y8T
 QKNzVQa1UXjPFBPwtgQdIDCVRiwSaNB7nC/gjPNxBbnBGcEJSYjvRbcSwqKQ/VB7rIWL
 QLkg==
X-Gm-Message-State: AOJu0YwGQtFm7LlUkBAJBvk/EHuwhJMbFvDh5Iedjdfu2w6xQAD//j4W
 N0C7Xy7y1Lw3w3efsx7kPzEH8jDV2rjBgp9ePxlsby0nWEyfmxDYd2oBix4mYeBBQ98Fa9oZbmu
 Kkez6sEzoyj3bvho=
X-Received: by 2002:a05:622a:1388:b0:418:1194:42f2 with SMTP id
 o8-20020a05622a138800b00418119442f2mr26680912qtk.46.1697055106886; 
 Wed, 11 Oct 2023 13:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFf7o7O6MvzdAf4ZwJG46pCQyavrd0NvW/sktqA40Zzp7Z7zHkY++F3Fbj+9rS5suYuu2Om7A==
X-Received: by 2002:a05:622a:1388:b0:418:1194:42f2 with SMTP id
 o8-20020a05622a138800b00418119442f2mr26680896qtk.46.1697055106588; 
 Wed, 11 Oct 2023 13:11:46 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 hg3-20020a05622a610300b0041977932fc6sm5545396qtb.18.2023.10.11.13.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 13:11:45 -0700 (PDT)
Message-ID: <f6ee408c-e012-903a-158a-94d1a0de74b0@redhat.com>
Date: Wed, 11 Oct 2023 22:11:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 07/15] vfio/pci: Introduce vfio_[attach/detach]_device
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
References: <20231009091035.433329-1-eric.auger@redhat.com>
 <20231009091035.433329-8-eric.auger@redhat.com>
 <PH7PR11MB6722220A69C973A55006558292CCA@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB6722220A69C973A55006558292CCA@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
On 10/11/23 03:33, Duan, Zhenzhong wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Monday, October 9, 2023 5:09 PM
>> Subject: [PATCH v5 07/15] vfio/pci: Introduce vfio_[attach/detach]_device
>>
>> We want the VFIO devices to be able to use two different
>> IOMMU backends, the legacy VFIO one and the new iommufd one.
>>
>> Introduce vfio_[attach/detach]_device which aim at hiding the
>> underlying IOMMU backend (IOCTLs, datatypes, ...).
>>
>> Once vfio_attach_device completes, the device is attached
>> to a security context and its fd can be used. Conversely
>> When vfio_detach_device completes, the device has been
>> detached from the security context.
>>
>> At the moment only the implementation based on the legacy
>> container/group exists. Let's use it from the vfio-pci device.
>> Subsequent patches will handle other devices.
>>
>> We also take benefit of this patch to properly free
>> vbasedev->name on failure.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> ---
>>
>> v4 -> v5:
>> - remove vbasedev->name g_free as it is done on instance_finalize
>>
>> v2 -> v3:
>> - added trace_vfio_detach_device
>> - added a comment explaining why we pass @name to vfio_attach_device
>>  although vbasedev->name is populated
>> - free vbasedev->name and detach_device if needed
>> ---
>> include/hw/vfio/vfio-common.h |  3 ++
>> hw/vfio/common.c              | 74 +++++++++++++++++++++++++++++++++++
>> hw/vfio/pci.c                 | 66 +++++++------------------------
>> hw/vfio/trace-events          |  3 +-
>> 4 files changed, 93 insertions(+), 53 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index c4e7c3b4a7..12fbfbc37d 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -225,6 +225,9 @@ void vfio_put_group(VFIOGroup *group);
>> struct vfio_device_info *vfio_get_device_info(int fd);
>> int vfio_get_device(VFIOGroup *group, const char *name,
>>                     VFIODevice *vbasedev, Error **errp);
>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>> +                       AddressSpace *as, Error **errp);
>> +void vfio_detach_device(VFIODevice *vbasedev);
>>
>> int vfio_kvm_device_add_fd(int fd, Error **errp);
>> int vfio_kvm_device_del_fd(int fd, Error **errp);
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index d8ed432cb6..f4c33c9858 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -2611,3 +2611,77 @@ int vfio_eeh_as_op(AddressSpace *as, uint32_t op)
>>     }
>>     return vfio_eeh_container_op(container, op);
>> }
>> +
>> +static int vfio_device_groupid(VFIODevice *vbasedev, Error **errp)
>> +{
>> +    char *tmp, group_path[PATH_MAX], *group_name;
>> +    int ret, groupid;
>> +    ssize_t len;
>> +
>> +    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>> +    len = readlink(tmp, group_path, sizeof(group_path));
>> +    g_free(tmp);
>> +
>> +    if (len <= 0 || len >= sizeof(group_path)) {
>> +        ret = len < 0 ? -errno : -ENAMETOOLONG;
>> +        error_setg_errno(errp, -ret, "no iommu_group found");
>> +        return ret;
>> +    }
>> +
>> +    group_path[len] = 0;
>> +
>> +    group_name = basename(group_path);
>> +    if (sscanf(group_name, "%d", &groupid) != 1) {
>> +        error_setg_errno(errp, errno, "failed to read %s", group_path);
>> +        return -errno;
>> +    }
>> +    return groupid;
>> +}
>> +
>> +/*
>> + * vfio_attach_device: attach a device to a security context
>> + * @name and @vbasedev->name are likely to be different depending
>> + * on the type of the device, hence the need for passing @name
>> + */
>> +int vfio_attach_device(char *name, VFIODevice *vbasedev,
>> +                       AddressSpace *as, Error **errp)
>> +{
>> +    int groupid = vfio_device_groupid(vbasedev, errp);
>> +    VFIODevice *vbasedev_iter;
>> +    VFIOGroup *group;
>> +    int ret;
>> +
>> +    if (groupid < 0) {
>> +        return groupid;
>> +    }
>> +
>> +    trace_vfio_attach_device(vbasedev->name, groupid);
>> +
>> +    group = vfio_get_group(groupid, as, errp);
>> +    if (!group) {
>> +        return -ENOENT;
>> +    }
>> +
>> +    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>> +        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>> +            error_setg(errp, "device is already attached");
>> +            vfio_put_group(group);
>> +            return -EBUSY;
>> +        }
>> +    }
>> +    ret = vfio_get_device(group, name, vbasedev, errp);
>> +    if (ret) {
>> +        vfio_put_group(group);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +void vfio_detach_device(VFIODevice *vbasedev)
>> +{
>> +    VFIOGroup *group = vbasedev->group;
>> +
>> +    trace_vfio_detach_device(vbasedev->name, group->groupid);
>> +    vfio_put_base_device(vbasedev);
>> +    vfio_put_group(group);
>> +}
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 898296fd54..40ae46266e 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -2895,10 +2895,10 @@ static void vfio_populate_device(VFIOPCIDevice
>> *vdev, Error **errp)
>>
>> static void vfio_pci_put_device(VFIOPCIDevice *vdev)
>> {
>> +    vfio_detach_device(&vdev->vbasedev);
>> +
>>     g_free(vdev->vbasedev.name);
>>     g_free(vdev->msix);
>> -
>> -    vfio_put_base_device(&vdev->vbasedev);
>> }
>>
>> static void vfio_err_notifier_handler(void *opaque)
>> @@ -3045,13 +3045,9 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>> {
>>     VFIOPCIDevice *vdev = VFIO_PCI(pdev);
>>     VFIODevice *vbasedev = &vdev->vbasedev;
>> -    VFIODevice *vbasedev_iter;
>> -    VFIOGroup *group;
>> -    char *tmp, *subsys, group_path[PATH_MAX], *group_name;
>> +    char *tmp, *subsys;
>>     Error *err = NULL;
>> -    ssize_t len;
>>     struct stat st;
>> -    int groupid;
>>     int i, ret;
>>     bool is_mdev;
>>     char uuid[UUID_FMT_LEN];
>> @@ -3082,39 +3078,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     vbasedev->type = VFIO_DEVICE_TYPE_PCI;
>>     vbasedev->dev = DEVICE(vdev);
>>
>> -    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>> -    len = readlink(tmp, group_path, sizeof(group_path));
>> -    g_free(tmp);
>> -
>> -    if (len <= 0 || len >= sizeof(group_path)) {
>> -        error_setg_errno(errp, len < 0 ? errno : ENAMETOOLONG,
>> -                         "no iommu_group found");
>> -        goto error;
>> -    }
>> -
>> -    group_path[len] = 0;
>> -
>> -    group_name = basename(group_path);
>> -    if (sscanf(group_name, "%d", &groupid) != 1) {
>> -        error_setg_errno(errp, errno, "failed to read %s", group_path);
>> -        goto error;
>> -    }
>> -
>> -    trace_vfio_realize(vbasedev->name, groupid);
>> -
>> -    group = vfio_get_group(groupid, pci_device_iommu_address_space(pdev),
>> errp);
>> -    if (!group) {
>> -        goto error;
>> -    }
>> -
>> -    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>> -        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>> -            error_setg(errp, "device is already attached");
>> -            vfio_put_group(group);
>> -            goto error;
>> -        }
>> -    }
>> -
>>     /*
>>      * Mediated devices *might* operate compatibly with discarding of RAM, but
>>      * we cannot know for certain, it depends on whether the mdev vendor driver
>> @@ -3132,7 +3095,6 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (vbasedev->ram_block_discard_allowed && !is_mdev) {
>>         error_setg(errp, "x-balloon-allowed only potentially compatible "
>>                    "with mdev devices");
>> -        vfio_put_group(group);
>>         goto error;
>>     }
>>
>> @@ -3143,17 +3105,17 @@ static void vfio_realize(PCIDevice *pdev, Error
>> **errp)
>>         name = g_strdup(vbasedev->name);
>>     }
>>
>> -    ret = vfio_get_device(group, name, vbasedev, errp);
>> +    ret = vfio_attach_device(name, vbasedev,
>> +                             pci_device_iommu_address_space(pdev), errp);
>>     g_free(name);
>>     if (ret) {
>> -        vfio_put_group(group);
>>         goto error;
>>     }
>>
>>     vfio_populate_device(vdev, &err);
>>     if (err) {
>>         error_propagate(errp, err);
>> -        goto error;
>> +        goto out_detach;
>>     }
>>
>>     /* Get a copy of config space */
>> @@ -3163,7 +3125,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (ret < (int)MIN(pci_config_size(&vdev->pdev), vdev->config_size)) {
>>         ret = ret < 0 ? -errno : -EFAULT;
>>         error_setg_errno(errp, -ret, "failed to read device config space");
>> -        goto error;
>> +        goto out_detach;
>>     }
>>
>>     /* vfio emulates a lot for us, but some bits need extra love */
>> @@ -3182,7 +3144,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (vdev->vendor_id != PCI_ANY_ID) {
>>         if (vdev->vendor_id >= 0xffff) {
>>             error_setg(errp, "invalid PCI vendor ID provided");
>> -            goto error;
>> +            goto out_detach;
>>         }
>>         vfio_add_emulated_word(vdev, PCI_VENDOR_ID, vdev->vendor_id, ~0);
>>         trace_vfio_pci_emulated_vendor_id(vbasedev->name, vdev->vendor_id);
>> @@ -3193,7 +3155,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (vdev->device_id != PCI_ANY_ID) {
>>         if (vdev->device_id > 0xffff) {
>>             error_setg(errp, "invalid PCI device ID provided");
>> -            goto error;
>> +            goto out_detach;
>>         }
>>         vfio_add_emulated_word(vdev, PCI_DEVICE_ID, vdev->device_id, ~0);
>>         trace_vfio_pci_emulated_device_id(vbasedev->name, vdev->device_id);
>> @@ -3204,7 +3166,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (vdev->sub_vendor_id != PCI_ANY_ID) {
>>         if (vdev->sub_vendor_id > 0xffff) {
>>             error_setg(errp, "invalid PCI subsystem vendor ID provided");
>> -            goto error;
>> +            goto out_detach;
>>         }
>>         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_VENDOR_ID,
>>                                vdev->sub_vendor_id, ~0);
>> @@ -3215,7 +3177,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     if (vdev->sub_device_id != PCI_ANY_ID) {
>>         if (vdev->sub_device_id > 0xffff) {
>>             error_setg(errp, "invalid PCI subsystem device ID provided");
>> -            goto error;
>> +            goto out_detach;
>>         }
>>         vfio_add_emulated_word(vdev, PCI_SUBSYSTEM_ID, vdev->sub_device_id,
>> ~0);
>>         trace_vfio_pci_emulated_sub_device_id(vbasedev->name,
>> @@ -3248,7 +3210,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>>     vfio_msix_early_setup(vdev, &err);
>>     if (err) {
>>         error_propagate(errp, err);
>> -        goto error;
>> +        goto out_detach;
>>     }
>>
>>     vfio_bars_register(vdev);
>> @@ -3364,6 +3326,8 @@ out_deregister:
>> out_teardown:
>>     vfio_teardown_msi(vdev);
>>     vfio_bars_exit(vdev);
>> +out_detach:
>> +    vfio_detach_device(vbasedev);
> I just reproduced a regression here with hot-unplug:
>
> (qemu) device_add vfio-pci,host=81:11.0,id=vfio0,bus=root0
> vfio: error disconnecting group 447 from container
> Error: vfio 0000:81:11.0: does not support requested IGD OpRegion feature
>
> Reason is there are some resources only released in finalize(),
> so UNSET_CONTAINER call fails here.
> IMHO, we can drop this vfio_detach_device call and let the same call in
> finalize() do the real work as original.
>
> After fix:
> (qemu) device_add vfio-pci,host=81:11.0,id=vfio0,bus=root0
> Error: vfio 0000:81:11.0: does not support requested IGD OpRegion feature
I just sent
[PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize error path

Please have a check and confirm this is the fix you expected

Thanks!

Eric
>
> Thanks
> Zhenzhong
>> error:
>>     error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>> }
>> @@ -3371,7 +3335,6 @@ error:
>> static void vfio_instance_finalize(Object *obj)
>> {
>>     VFIOPCIDevice *vdev = VFIO_PCI(obj);
>> -    VFIOGroup *group = vdev->vbasedev.group;
>>
>>     vfio_display_finalize(vdev);
>>     vfio_bars_finalize(vdev);
>> @@ -3385,7 +3348,6 @@ static void vfio_instance_finalize(Object *obj)
>>      * g_free(vdev->igd_opregion);
>>      */
>>     vfio_pci_put_device(vdev);
>> -    vfio_put_group(group);
>> }
>>
>> static void vfio_exitfn(PCIDevice *pdev)
>> diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
>> index 0ba3c5a0e2..8ac13eb106 100644
>> --- a/hw/vfio/trace-events
>> +++ b/hw/vfio/trace-events
>> @@ -37,7 +37,8 @@ vfio_pci_hot_reset_dep_devices(int domain, int bus, int slot,
>> int function, int
>> vfio_pci_hot_reset_result(const char *name, const char *result) "%s hot
>> reset: %s"
>> vfio_populate_device_config(const char *name, unsigned long size, unsigned
>> long offset, unsigned long flags) "Device %s config:\n  size: 0x%lx, offset: 0x%lx,
>> flags: 0x%lx"
>> vfio_populate_device_get_irq_info_failure(const char *errstr)
>> "VFIO_DEVICE_GET_IRQ_INFO failure: %s"
>> -vfio_realize(const char *name, int group_id) " (%s) group %d"
>> +vfio_attach_device(const char *name, int group_id) " (%s) group %d"
>> +vfio_detach_device(const char *name, int group_id) " (%s) group %d"
>> vfio_mdev(const char *name, bool is_mdev) " (%s) is_mdev %d"
>> vfio_add_ext_cap_dropped(const char *name, uint16_t cap, uint16_t offset) "%s
>> 0x%x@0x%x"
>> vfio_pci_reset(const char *name) " (%s)"
>> --
>> 2.41.0


