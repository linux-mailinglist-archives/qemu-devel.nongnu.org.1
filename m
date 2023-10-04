Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED37B7CAC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnybn-0004EM-TV; Wed, 04 Oct 2023 05:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnybj-00044n-Qx
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnybh-0005zh-UY
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696413352;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=auP+tOu8j5Ebqd14QnwlEpj/R+AXePEwvA0BRASuz0k=;
 b=FGZ0jFQEG0/XLhlY6BKr0Pxw0Ln4WGRY1f3XnMLSxdeKDi6B9CXE2yo3bgYFle+AeQDzcM
 +gDG7EHK0Wm/m3VRf8l6uc2rj5W5QFZM4itbJX6JUbgKUUd+tSVvgNaexg1OeJTpXGvI/0
 FQibZQrItJTtdzfdmLaVpE5MYiwjl+g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-_zWw-6pFPSKx6OfRPdqx8w-1; Wed, 04 Oct 2023 05:55:36 -0400
X-MC-Unique: _zWw-6pFPSKx6OfRPdqx8w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b107812f0so20967756d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696413336; x=1697018136;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auP+tOu8j5Ebqd14QnwlEpj/R+AXePEwvA0BRASuz0k=;
 b=IvIllUstj16gY4yugQZcw2kfsy6puoxcxrbQttALlon0315aJEVMf6EFBAE/8WeLtu
 74iUxbxbtbiWBRQJef3mhxEtypc9+HRjiub6h6FR/Ut8+pWVMKqUmMJ8gXPGXUNKoKyW
 T8RDlkVJ15AJtfRMkDLnCUoDAT29mHnio1h165tzO7/Xka175nycxYGcTrP5KYW1n5Bw
 8sbaNEFACx8Ysz1QcEiTNfyVcLjzTK4iVY6Ba5f1wyXK7OPzFqZhzcriNTcRmv0H7ZZ7
 a7grqdHk64Uc9ADLqX5fIbn34sCKgQMfu86IRb1gNU1ZUJYXZV6IWI/2KJqk511KTZ5T
 qu3A==
X-Gm-Message-State: AOJu0Yw9O0UkQf4Esjo9Os5aTVqWHdtCh9upp1I4HQWTjOeZ2eycbWGm
 6rk5lrUVASKl/cm/rlrnMeCKZaGun56ac1Fga7zjo5Xw6y+R6Sed71A/4HokGIlxGRvZ1hglUEm
 7+NrPfpmxHcsOeI8=
X-Received: by 2002:a05:6214:4402:b0:649:8f20:5528 with SMTP id
 oj2-20020a056214440200b006498f205528mr1640481qvb.60.1696413335837; 
 Wed, 04 Oct 2023 02:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW+166sDOpW6qH7e4aZrxzcTcWfhjnwwUM8JujHvjIKwlNZjbURBD4jioBJWIZ4qq5387hpA==
X-Received: by 2002:a05:6214:4402:b0:649:8f20:5528 with SMTP id
 oj2-20020a056214440200b006498f205528mr1640461qvb.60.1696413335564; 
 Wed, 04 Oct 2023 02:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a0cab09000000b006616fbcc077sm1209940qvb.129.2023.10.04.02.55.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:55:34 -0700 (PDT)
Message-ID: <b6cf121e-1356-d382-0ada-fca5e2311c56@redhat.com>
Date: Wed, 4 Oct 2023 11:55:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/15] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-10-eric.auger@redhat.com>
 <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
 <606cfdd1-5ff1-b789-02c6-9a9237694f30@linux.ibm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <606cfdd1-5ff1-b789-02c6-9a9237694f30@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

Hi Matthew,

On 10/4/23 01:08, Matthew Rosato wrote:
> On 10/3/23 11:25 AM, Cédric Le Goater wrote:
>> On 10/3/23 12:14, Eric Auger wrote:
>>> Let the vfio-ap device use vfio_attach_device() and
>>> vfio_detach_device(), hence hiding the details of the used
>>> IOMMU backend.
>>>
>>> We take the opportunity to use g_path_get_basename() which
>>> is prefered, as suggested by
>>> 3e015d815b ("use g_path_get_basename instead of basename")
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>
>>> ---
>>>
>>> v2 -> v3:
>>> - Mention g_path_get_basename in commit message and properly free
>>>    vbasedev->name, call vfio_detach_device
>>> ---
>>>   hw/vfio/ap.c | 70 ++++++++++------------------------------------------
>>>   1 file changed, 13 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>>> index 6e21d1da5a..d0b587b3b1 100644
>>> --- a/hw/vfio/ap.c
>>> +++ b/hw/vfio/ap.c
>>> @@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
>>>       .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>>>   };
>>>   -static void vfio_ap_put_device(VFIOAPDevice *vapdev)
>>> -{
>>> -    g_free(vapdev->vdev.name);
>>> -    vfio_put_base_device(&vapdev->vdev);
>>> -}
>>> -
>>> -static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>>> -{
>>> -    GError *gerror = NULL;
>>> -    char *symlink, *group_path;
>>> -    int groupid;
>>> -
>>> -    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>>> -    group_path = g_file_read_link(symlink, &gerror);
>>> -    g_free(symlink);
>>> -
>>> -    if (!group_path) {
>>> -        error_setg(errp, "%s: no iommu_group found for %s: %s",
>>> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
>>> -        g_error_free(gerror);
>>> -        return NULL;
>>> -    }
>>> -
>>> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>>> -        error_setg(errp, "vfio: failed to read %s", group_path);
>>> -        g_free(group_path);
>>> -        return NULL;
>>> -    }
>>> -
>>> -    g_free(group_path);
>>> -
>>> -    return vfio_get_group(groupid, &address_space_memory, errp);
>>> -}
>>> -
>>>   static void vfio_ap_req_notifier_handler(void *opaque)
>>>   {
>>>       VFIOAPDevice *vapdev = opaque;
>>> @@ -189,22 +155,15 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>   {
>>>       int ret;
>>> -    char *mdevid;
>>>       Error *err = NULL;
>>> -    VFIOGroup *vfio_group;
>>>       APDevice *apdev = AP_DEVICE(dev);
>>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>>> +    VFIODevice *vbasedev = &vapdev->vdev;
>>>   -    vfio_group = vfio_ap_get_group(vapdev, errp);
>>> -    if (!vfio_group) {
>>> -        return;
>>> -    }
>>> -
>>> -    vapdev->vdev.ops = &vfio_ap_ops;
>>> -    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>>> -    mdevid = basename(vapdev->vdev.sysfsdev);
>>> -    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>>> -    vapdev->vdev.dev = dev;
>>> +    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>>> +    vbasedev->ops = &vfio_ap_ops;
>>> +    vbasedev->type = VFIO_DEVICE_TYPE_AP;
>>> +    vbasedev->dev = dev;
>>>         /*
>>>        * vfio-ap devices operate in a way compatible with discarding of
>>> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>        */
>>>       vapdev->vdev.ram_block_discard_allowed = true;
>>>   -    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
>>> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
>>> +                             &address_space_memory, errp);
>>>       if (ret) {
>>> -        goto out_get_dev_err;
>>> +        g_free(vbasedev->name);
>>> +        return;
>>>       }
>>>         vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
>>> @@ -225,25 +186,20 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>>            * Report this error, but do not make it a failing condition.
>>>            * Lack of this IRQ in the host does not prevent normal operation.
>>>            */
>>> +        vfio_detach_device(vbasedev);
>>>           error_report_err(err);
>>> +        g_free(vbasedev->name);
> This patch overall looks good to me and passes basic tests with vfio-ap devices.  But I note that this addition of detach+free here runs counter to what the comment block above it states and prior behavior (where we did not goto out_get_dev_err for this case and expect the realize to complete successfully despite this error).  
>
> In this error case, we only report the local 'err' contents and nothing is propagated into 'errp' -- which means that to the caller dc->realize() should be viewed as successful (errp is NULL) and so we should be able to assume a subsequent dc->unrealize() will do this g_free+detach later. 

yes you totally right. Just need to do the error_report_err(err); in
that case.

Thanks!

Eric
>
>>>       }
>>> -
>>> -    return;
>>> -
>>> -out_get_dev_err:
>>> -    vfio_ap_put_device(vapdev);
>>> -    vfio_put_group(vfio_group);
>>>   }
>>
>> To be consistent with vfio_(pci)_realize(), I would introduce the same
>> failure path at the end the routine :
>>
>>   out_detach:
>>       vfio_detach_device(vbasedev);
>>   error:
>>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>>       g_free(vbasedev->name);
> So based on my comment above, I think you'd only need the 'error:' case now, but otherwise adding this error_prepend seems reasonable to me too. 
>
> Thanks,
> Matt
>
>>
>> and add the VFIO_MSG_PREFIX while we are at it.
>>
>> This is minor, so :
>>
>> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>>     static void vfio_ap_unrealize(DeviceState *dev)
>>>   {
>>>       APDevice *apdev = AP_DEVICE(dev);
>>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>>> -    VFIOGroup *group = vapdev->vdev.group;
>>>         vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
>>> -    vfio_ap_put_device(vapdev);
>>> -    vfio_put_group(group);
>>> +    vfio_detach_device(&vapdev->vdev);
>>> +    g_free(vapdev->vdev.name);
>>>   }
>>>     static Property vfio_ap_properties[] = {


