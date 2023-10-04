Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 266667B8138
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo28M-0007Gb-Um; Wed, 04 Oct 2023 09:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qo28E-0007Fc-Ku
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:41:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qo28C-0007O5-Dq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:41:42 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 394DdK2i012511; Wed, 4 Oct 2023 13:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RwEQr28QaVBldBldgCDTI6lH+mwGHUifJG/k8UIQxpo=;
 b=ZAiIqHKTADK7oE/FIlb9WFx7ebLHoyAWIKBOGBF2lCuZS6pkEDnHuerqEK+/JLT6AIav
 iECI+c7HPKLtXiU1tj1cGKEQ4fRiM73WzDlQNgf4t6rorKWy2Ga8xXoPOzdXJne8S8PE
 DXaUzwiamjaiQ0M6roW1kPzl7FFeHQAaeFKZIv8CVnEr+aKB89icyjuhx+t0NW3ApYWP
 ZEn1bKWkgeXsosZFX1qQwZ8Rrpg4qpeK0/u+R5z2/SG3G1fPXsKQU/kEfAk8nZCdMNXZ
 xckKIt4Vnmja+47KjEyz8PC/JrQ4GZFgraaiOJofNOroTx/UBS3PdOdnsCi3PGEekfNa lA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th7nray79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:41:32 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 394Ddb3L013935;
 Wed, 4 Oct 2023 13:41:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3th7nraxxr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:41:27 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 394DCxN7025110; Wed, 4 Oct 2023 13:41:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3texcyd8m3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 13:41:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 394DfI7q918110
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Oct 2023 13:41:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1164B58063;
 Wed,  4 Oct 2023 13:41:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0C5658064;
 Wed,  4 Oct 2023 13:41:16 +0000 (GMT)
Received: from [9.61.106.119] (unknown [9.61.106.119])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Oct 2023 13:41:16 +0000 (GMT)
Message-ID: <1365437a-d858-6a5f-3690-cf77454d2985@linux.ibm.com>
Date: Wed, 4 Oct 2023 09:41:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/15] vfio/ap: Use vfio_[attach/detach]_device
Content-Language: en-US
To: eric.auger@redhat.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org,
 zhenzhong.duan@intel.com, alex.williamson@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com, peterx@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
References: <20231003101530.288864-1-eric.auger@redhat.com>
 <20231003101530.288864-10-eric.auger@redhat.com>
 <952d6ce5-8523-0337-8bb9-ba45b728172e@redhat.com>
 <7388f1ef-6af4-ce7d-f4db-853363289907@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <7388f1ef-6af4-ce7d-f4db-853363289907@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qyZkEY_8AH1MtCxpJUTPyn0YXXB6FqtM
X-Proofpoint-ORIG-GUID: EtZxEnlBY7s6MZWp7A4rr5FN9Vvb99LT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_05,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310040099
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
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

On 10/4/23 5:58 AM, Eric Auger wrote:
> Hi Cédric,
> 
> On 10/3/23 17:25, Cédric Le Goater wrote:
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
>>> -                   TYPE_VFIO_AP_DEVICE, vapdev->vdev.sysfsdev,
>>> gerror->message);
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
>>> @@ -189,22 +155,15 @@ static void
>>> vfio_ap_unregister_irq_notifier(VFIOAPDevice *vapdev,
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
>>> @@ -214,9 +173,11 @@ static void vfio_ap_realize(DeviceState *dev,
>>> Error **errp)
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
>>>         vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX,
>>> &err);
>>> @@ -225,25 +186,20 @@ static void vfio_ap_realize(DeviceState *dev,
>>> Error **errp)
>>>            * Report this error, but do not make it a failing condition.
>>>            * Lack of this IRQ in the host does not prevent normal
>>> operation.
>>>            */
>>> +        vfio_detach_device(vbasedev);
>>>           error_report_err(err);
>>> +        g_free(vbasedev->name);
>>>       }
>>> -
>>> -    return;
>>> -
>>> -out_get_dev_err:
>>> -    vfio_ap_put_device(vapdev);
>>> -    vfio_put_group(vfio_group);
>>>   }
>>
>>
>> To be consistent with vfio_(pci)_realize(), I would introduce the same
>> failure path at the end the routine :
>>
>>   out_detach:
>>       vfio_detach_device(vbasedev);
>>   error:
>>       error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
>>       g_free(vbasedev->name);
>>
>>
>> and add the VFIO_MSG_PREFIX while we are at it.
> 
> following Matthew's comment we do not have any need for error handling
> in vfio_ap_realize() anymore.
> 
> so just removing the improper additions:
> +        vfio_detach_device(vbasedev);
> +        g_free(vbasedev->name);
> 
> Thanks

Just to clarify, there is still a little error handling needed for the error case on vfio_attach_device(), in that case you are passing errp into vfio_attach_device and that should have an error propogated when ret!=0, meaning we won't get the dc->unrealize() later.  Device wasn't attached, but we did allocate memory for vbasedev->name already so we need to undo that part ourselves.  That could be inline (as you do already in this patch) or, if you choose to add the VFIO_MSG_PREFIX it might make sense to put it in an error: label as Cedric suggested for additional later use.  FWIW, I'm fine with either but here's a snippet of what I mean for the sake of clarity:


Approach 1 (w/ new prepend):

    ret = vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp);
    if (ret) {
        goto error;
    }

    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
    if (err) {
        /*
         * Report this error, but do not make it a failing condition.
         * Lack of this IRQ in the host does not prevent normal operation.
         */
        error_report_err(err);
    }

    return;

error:
    error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->name);
    g_free(vbasedev->name);


Approach 2 (no prepend):

    ret = vfio_attach_device(vbasedev->name, vbasedev,
                             &address_space_memory, errp);
    if (ret) {
        g_free(vbasedev->name);
        return;
    }

    vfio_ap_register_irq_notifier(vapdev, VFIO_AP_REQ_IRQ_INDEX, &err);
    if (err) {
        /*
         * Report this error, but do not make it a failing condition.
         * Lack of this IRQ in the host does not prevent normal operation.
         */
        error_report_err(err);
    }

    return;


With either of these approaches:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Thanks,
Matt

> 
> Eric
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
>>
> 


