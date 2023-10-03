Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A77B7482
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnoVR-00031L-79; Tue, 03 Oct 2023 19:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qnoVM-00030m-1V
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:08:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qnoVH-0007Aa-NW
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:08:39 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 393MkX0R023364; Tue, 3 Oct 2023 23:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2IS/w4TSrGlG3f3kWJSMVVKt/rb+UqUBEuVCxwm2aZE=;
 b=iffEXylJdKZEuFfu+O8HEGqYXPpg+suwyyUeJOXlIHCQUT8ma0EsS8M0QFyhgShs6yak
 w4t6DGcsmEa8WzdAaVtdZUrtY8nwOWL8iwejcDQ1czeSJza90mbcIRMAw2ULHqtnzMGx
 bgIlL7gY7RhQHhMjEmolomFZRP9aFguVOf4AEvA329UFzIR+qSD1ZZ4Gx8HSu2tGLeKX
 OlrHOCrJCSct/tK8l4qJT1TV2iA1V+WDuydF1NOY2yZmFr2hCCBJ2wPw0ewLOQA7Ave8
 6uMjSVNWnjW4wnq1lcWDFBmf5zomCcoMZUl1dj29kBBtUkBIDjZZNVkzRxCI4WdBGvQo xQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgumw16gn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:08:31 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 393MMFwu015323;
 Tue, 3 Oct 2023 23:08:31 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tgumw16fy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:08:30 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 393MpHSu006684; Tue, 3 Oct 2023 23:08:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tf07jx35c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 03 Oct 2023 23:08:29 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 393N8Sbc656126
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 3 Oct 2023 23:08:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C7E18580E9;
 Tue,  3 Oct 2023 23:08:28 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C24BE580E4;
 Tue,  3 Oct 2023 23:08:27 +0000 (GMT)
Received: from [9.61.106.119] (unknown [9.61.106.119])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  3 Oct 2023 23:08:27 +0000 (GMT)
Message-ID: <606cfdd1-5ff1-b789-02c6-9a9237694f30@linux.ibm.com>
Date: Tue, 3 Oct 2023 19:08:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/15] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, peterx@redhat.com, kevin.tian@intel.com,
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-10-eric.auger@redhat.com>
 <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kVidl8mZQjaokqo_Cd9QSS-odbP39HGm
X-Proofpoint-ORIG-GUID: z9nRWmzrTDM9xZIYHnHOQ0_XM-BWu3uu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_18,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030175
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 10/3/23 11:25 AM, Cédric Le Goater wrote:
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
>> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev, gerror->message);
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
>> @@ -189,22 +155,15 @@ static void vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
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
>> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
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
>>         vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
>> @@ -225,25 +186,20 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
>>            * Report this error, but do not make it a failing condition.
>>            * Lack of this IRQ in the host does not prevent normal operation.
>>            */
>> +        vfio_detach_device(vbasedev);
>>           error_report_err(err);
>> +        g_free(vbasedev->name);

This patch overall looks good to me and passes basic tests with vfio-ap devices.  But I note that this addition of detach+free here runs counter to what the comment block above it states and prior behavior (where we did not goto out_get_dev_err for this case and expect the realize to complete successfully despite this error).  

In this error case, we only report the local 'err' contents and nothing is propagated into 'errp' -- which means that to the caller dc->realize() should be viewed as successful (errp is NULL) and so we should be able to assume a subsequent dc->unrealize() will do this g_free+detach later. 

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

So based on my comment above, I think you'd only need the 'error:' case now, but otherwise adding this error_prepend seems reasonable to me too. 

Thanks,
Matt

> 
> 
> and add the VFIO_MSG_PREFIX while we are at it.
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


