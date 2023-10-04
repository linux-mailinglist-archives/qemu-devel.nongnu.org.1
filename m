Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BA47B7CBC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:59:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnyeT-0006U2-2O; Wed, 04 Oct 2023 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnyeQ-0006TX-UM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qnyeP-0006Sj-3Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696413519;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bKd0jqYj8ppHuWQiac98yffGRitPAvdG7NNxSiUdQEg=;
 b=LxYV16E4c1+iRs4pOHves4O4WMFh/q3yEZ+8wC5a8tMkkYeGq23teINf+w7O2/agjmDdXn
 IqJ4/BOjLTw/CjDrZqtICuiQJvV4eWo1aNKbQ/FuhjFcacOVy5fQ5Ns8xQFLURTYYWn1cq
 L0ehG4Gvue8DwmtKUwOOi0j+/kmKYPQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-hfukYL9IP3yb6ULhrQJrHw-1; Wed, 04 Oct 2023 05:58:34 -0400
X-MC-Unique: hfukYL9IP3yb6ULhrQJrHw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77586b4ae08so108397985a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:58:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696413514; x=1697018314;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bKd0jqYj8ppHuWQiac98yffGRitPAvdG7NNxSiUdQEg=;
 b=OopIiJsy8LAGJjmU+bBBVWtpv3xrVCqMx85YAPNvwZFggC6IHzFMvUdn2KeDAAkShF
 6AVuSvh7W9RtrLgP1dKoTGdO+JXJNlSzHROV/xZNhdqX2BcMIzDBI91vDt+vpB+ppNU8
 xgVDOkh6mJXxljPAq7ohXO9T3KaNAoEK+O8xfdlTQZ3PqQBhcO/jlVUd0DpLfbroG6ZQ
 KZ2mjrpS1c/lmVfZK+CMpPhX8azjz6cjrr3bHnV4WWZttON1cI4hVGMoFTzqEGow6Hns
 dKMnLZtMBzjknba7OsUSTKmtaj+EwTskS2731V3zOFheNv7TeNKtZb1DfBPSz/JpkSIA
 173Q==
X-Gm-Message-State: AOJu0Yy7vvN3ZXfwSTnRxAlM4EuiVz9xBdFm6IFdjtpgTGLA8E1LimID
 ZzAVrj1RuXfg5YkUsgZG++LWWU0QhoM9BNrqJUmbeKjGq59WdZd12qVzTxnBfwWaOXZ69xYGQ3m
 ujblAwLGjdSaC1dA=
X-Received: by 2002:a05:6214:2627:b0:65a:feb1:ec46 with SMTP id
 gv7-20020a056214262700b0065afeb1ec46mr5943783qvb.6.1696413513980; 
 Wed, 04 Oct 2023 02:58:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5cF6s4ydLVyJ4cpb4Zrh/GVAbIYJ/7NYEyxrO6OL2H9RfteGtEXCjOBmlDqmSHLQ7qWADvg==
X-Received: by 2002:a05:6214:2627:b0:65a:feb1:ec46 with SMTP id
 gv7-20020a056214262700b0065afeb1ec46mr5943772qvb.6.1696413513725; 
 Wed, 04 Oct 2023 02:58:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a0ccb91000000b006585c7f64a3sm1205091qvk.14.2023.10.04.02.58.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 02:58:32 -0700 (PDT)
Message-ID: <7388f1ef-6af4-ce7d-f4db-853363289907@redhat.com>
Date: Wed, 4 Oct 2023 11:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/15] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com,
 mjrosato@linux.ibm.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-10-eric.auger@redhat.com>
 <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hi Cédric,

On 10/3/23 17:25, Cédric Le Goater wrote:
> On 10/3/23 12:14, Eric Auger wrote:
>> Let the vfio-ap device use vfio_attach_device() and
>> vfio_detach_device(), hence hiding the details of the used
>> IOMMU backend.
>>
>> We take the opportunity to use g_path_get_basename() which
>> is prefered, as suggested by
>> 3e015d815b ("use g_path_get_basename instead of basename")
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>> ---
>>
>> v2 -> v3:
>> - Mention g_path_get_basename in commit message and properly free
>>    vbasedev->name, call vfio_detach_device
>> ---
>>   hw/vfio/ap.c | 70 ++++++++++------------------------------------------
>>   1 file changed, 13 insertions(+), 57 deletions(-)
>>
>> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
>> index 6e21d1da5a..d0b587b3b1 100644
>> --- a/hw/vfio/ap.c
>> +++ b/hw/vfio/ap.c
>> @@ -53,40 +53,6 @@ struct VFIODeviceOps vfio_ap_ops = {
>>       .vfio_compute_needs_reset = vfio_ap_compute_needs_reset,
>>   };
>>   -static void vfio_ap_put_device(VFIOAPDevice *vapdev)
>> -{
>> -    g_free(vapdev->vdev.name);
>> -    vfio_put_base_device(&vapdev->vdev);
>> -}
>> -
>> -static VFIOGroup *vfio_ap_get_group(VFIOAPDevice *vapdev, Error **errp)
>> -{
>> -    GError *gerror = NULL;
>> -    char *symlink, *group_path;
>> -    int groupid;
>> -
>> -    symlink = g_strdup_printf("%s/iommu_group", vapdev->vdev.sysfsdev);
>> -    group_path = g_file_read_link(symlink, &gerror);
>> -    g_free(symlink);
>> -
>> -    if (!group_path) {
>> -        error_setg(errp, "%s: no iommu_group found for %s: %s",
>> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev,
>> gerror->message);
>> -        g_error_free(gerror);
>> -        return NULL;
>> -    }
>> -
>> -    if (sscanf(basename(group_path), "%d", &groupid) != 1) {
>> -        error_setg(errp, "vfio: failed to read %s", group_path);
>> -        g_free(group_path);
>> -        return NULL;
>> -    }
>> -
>> -    g_free(group_path);
>> -
>> -    return vfio_get_group(groupid, &address_space_memory, errp);
>> -}
>> -
>>   static void vfio_ap_req_notifier_handler(void *opaque)
>>   {
>>       VFIOAPDevice *vapdev = opaque;
>> @@ -189,22 +155,15 @@ static void
>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
>>   static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>   {
>>       int ret;
>> -    char *mdevid;
>>       Error *err = NULL;
>> -    VFIOGroup *vfio_group;
>>       APDevice *apdev = AP_DEVICE(dev);
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>> +    VFIODevice *vbasedev = &vapdev->vdev;
>>   -    vfio_group = vfio_ap_get_group(vapdev, errp);
>> -    if (!vfio_group) {
>> -        return;
>> -    }
>> -
>> -    vapdev->vdev.ops = &vfio_ap_ops;
>> -    vapdev->vdev.type = VFIO_DEVICE_TYPE_AP;
>> -    mdevid = basename(vapdev->vdev.sysfsdev);
>> -    vapdev->vdev.name = g_strdup_printf("%s", mdevid);
>> -    vapdev->vdev.dev = dev;
>> +    vbasedev->name = g_path_get_basename(vbasedev->sysfsdev);
>> +    vbasedev->ops = &vfio_ap_ops;
>> +    vbasedev->type = VFIO_DEVICE_TYPE_AP;
>> +    vbasedev->dev = dev;
>>         /*
>>        * vfio-ap devices operate in a way compatible with discarding of
>> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev,
>> Error **errp)
>>        */
>>       vapdev->vdev.ram_block_discard_allowed = true;
>>   -    ret = vfio_get_device(vfio_group, mdevid, &vapdev->vdev, errp);
>> +    ret = vfio_attach_device(vbasedev->name, vbasedev,
>> +                             &address_space_memory, errp);
>>       if (ret) {
>> -        goto out_get_dev_err;
>> +        g_free(vbasedev->name);
>> +        return;
>>       }
>>         vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX,
>> &err);
>> @@ -225,25 +186,20 @@ static void vfio_ap_realize(DeviceState *dev,
>> Error **errp)
>>            * Report this error, but do not make it a failing condition.
>>            * Lack of this IRQ in the host does not prevent normal
>> operation.
>>            */
>> +        vfio_detach_device(vbasedev);
>>           error_report_err(err);
>> +        g_free(vbasedev->name);
>>       }
>> -
>> -    return;
>> -
>> -out_get_dev_err:
>> -    vfio_ap_put_device(vapdev);
>> -    vfio_put_group(vfio_group);
>>   }
>
>
> To be consistent with vfio_(pci)_realize(), I would introduce the same
> failure path at the end the routine :
>
>   out_detach:
>       vfio_detach_device(vbasedev);
>   error:
>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>       g_free(vbasedev->name);
>
>
> and add the VFIO_MSG_PREFIX while we are at it.

following Matthew's comment we do not have any need for error handling
in vfio_ap_realize() anymore.

so just removing the improper additions:
+        vfio_detach_device(vbasedev);
+        g_free(vbasedev->name);

Thanks

Eric
>
> This is minor, so :
>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
>
> Thanks,
>
> C.
>
>
>
>>     static void vfio_ap_unrealize(DeviceState *dev)
>>   {
>>       APDevice *apdev = AP_DEVICE(dev);
>>       VFIOAPDevice *vapdev = VFIO_AP_DEVICE(apdev);
>> -    VFIOGroup *group = vapdev->vdev.group;
>>         vfio_ap_unregister_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX);
>> -    vfio_ap_put_device(vapdev);
>> -    vfio_put_group(group);
>> +    vfio_detach_device(&vapdev->vdev);
>> +    g_free(vapdev->vdev.name);
>>   }
>>     static Property vfio_ap_properties[] = {
>


