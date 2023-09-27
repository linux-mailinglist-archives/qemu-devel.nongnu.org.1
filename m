Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88C67B055B
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUYZ-0000GH-QT; Wed, 27 Sep 2023 09:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qlUYO-0000FK-2R; Wed, 27 Sep 2023 09:26:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1qlUYH-0000K7-Rg; Wed, 27 Sep 2023 09:26:10 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RDLmb2001494; Wed, 27 Sep 2023 13:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=bT8mSmBwDzT+4luAwEqxXDmcRe7fE8iqUfqJowywTh0=;
 b=iid5B/KR/JU5CUHQrbm5JtwWda7n6R6+au4iW5GEcQVJRzyfr3f64MityQMsZRp3b6nQ
 gr904yiU3eemc4/c9R4OsKfm+c93f7vluB3iCMlPLtghvlwcIA0m6H3iMDiisz9bh5mB
 9tQ0nNgw5wwPDabjgNWvb0QlJxxXh57miR395Z/idUCyu20rmEAifc+SBEBeUXgsNuaF
 wRsVtpuBBMgXXBWGw71c6gKxHHc81aXKb2oV0eTD+yl+3/6F8cfJbIWcgq+lm4+5k+6D
 cc5F94DPfY93MAY3xEzGSPIpsKZrqU93hKiZL9HrQO35Qjx2bN3saVT8sLGLpg1ngqA7 tg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcn7703rb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 13:26:00 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38RDLkr2001434;
 Wed, 27 Sep 2023 13:25:59 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tcn7703r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 13:25:59 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38RB7Rin008143; Wed, 27 Sep 2023 13:25:58 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3taaqym1cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 27 Sep 2023 13:25:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38RDPvd264749844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Sep 2023 13:25:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 38D5758066;
 Wed, 27 Sep 2023 13:25:57 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B37E5806B;
 Wed, 27 Sep 2023 13:25:55 +0000 (GMT)
Received: from [9.61.175.8] (unknown [9.61.175.8])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 27 Sep 2023 13:25:55 +0000 (GMT)
Message-ID: <0c12d354-5600-6679-44b9-b5cbfbb4ca83@linux.ibm.com>
Date: Wed, 27 Sep 2023 09:25:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Farman <farman@linux.ibm.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>,
 "open list:S390 general arch..." <qemu-s390x@nongnu.org>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-10-zhenzhong.duan@intel.com>
 <66548ae7-3cc4-94d8-de46-c15f2e402ed1@redhat.com>
 <PH7PR11MB6722C385397F66D040C8BE5D92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <PH7PR11MB6722C385397F66D040C8BE5D92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vkQK-Fgs_fnnZYpV_d2K4fHNQm_lMnyV
X-Proofpoint-ORIG-GUID: zjuPzsKZe3r76Lme7knXZyKH5xcZdTHj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_07,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270110
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/27/23 8:09 AM, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Wednesday, September 27, 2023 6:00 PM
>> Subject: Re: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
>>
>>
>>
>> On 9/26/23 13:32, Zhenzhong Duan wrote:
>>> From: Eric Auger <eric.auger@redhat.com>
>>>
>>> Let the vfio-ccw device use vfio_attach_device() and
>>> vfio_detach_device(), hence hiding the details of the used
>>> IOMMU backend.
>>>
>>> Also now all the devices have been migrated to use the new
>>> vfio_attach_device/vfio_detach_device API, let's turn the
>>> legacy functions into static functions, local to container.c.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  include/hw/vfio/vfio-common.h |   5 --
>>>  hw/vfio/ccw.c                 | 115 ++++++++--------------------------
>>>  hw/vfio/common.c              |  10 +--
>>>  3 files changed, 30 insertions(+), 100 deletions(-)
>>>
>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>>> index 12fbfbc37d..c486bdef2a 100644
>>> --- a/include/hw/vfio/vfio-common.h
>>> +++ b/include/hw/vfio/vfio-common.h
>>> @@ -202,7 +202,6 @@ typedef struct {
>>>      hwaddr pages;
>>>  } VFIOBitmap;
>>>
>>> -void vfio_put_base_device(VFIODevice *vbasedev);
>>>  void vfio_disable_irqindex(VFIODevice *vbasedev, int index);
>>>  void vfio_unmask_single_irqindex(VFIODevice *vbasedev, int index);
>>>  void vfio_mask_single_irqindex(VFIODevice *vbasedev, int index);
>>> @@ -220,11 +219,7 @@ void vfio_region_unmap(VFIORegion *region);
>>>  void vfio_region_exit(VFIORegion *region);
>>>  void vfio_region_finalize(VFIORegion *region);
>>>  void vfio_reset_handler(void *opaque);
>>> -VFIOGroup *vfio_get_group(int groupid, AddressSpace *as, Error **errp);
>>> -void vfio_put_group(VFIOGroup *group);
>>>  struct vfio_device_info *vfio_get_device_info(int fd);
>>> -int vfio_get_device(VFIOGroup *group, const char *name,
>>> -                    VFIODevice *vbasedev, Error **errp);
>>>  int vfio_attach_device(char *name, VFIODevice *vbasedev,
>>>                         AddressSpace *as, Error **errp);
>>>  void vfio_detach_device(VFIODevice *vbasedev);
>>> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
>>> index 1e2fce83b0..6893a30ab1 100644
>>> --- a/hw/vfio/ccw.c
>>> +++ b/hw/vfio/ccw.c
>>> @@ -572,88 +572,14 @@ static void vfio_ccw_put_region(VFIOCCWDevice
>> *vcdev)
>>>      g_free(vcdev->io_region);
>>>  }
>>>
>>> -static void vfio_ccw_put_device(VFIOCCWDevice *vcdev)
>>> -{
>>> -    g_free(vcdev->vdev.name);
>>> -    vfio_put_base_device(&vcdev->vdev);
>>> -}
>>> -
>>> -static void vfio_ccw_get_device(VFIOGroup *group, VFIOCCWDevice *vcdev,
>>> -                                Error **errp)
>>> -{
>>> -    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
>>> -    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>>> -                                 cdev->hostid.ssid,
>>> -                                 cdev->hostid.devid);
>> Digging into that few months later,
>>
>> new vfio_device_groupid uses
>>
>> +    tmp = g_strdup_printf("%s/iommu_group", vbasedev->sysfsdev);
>>
>> which is set as a prop here
>>    DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
>> we need to double check if this matches, this is not obvious at first sight. At least
>> if this is true this needs to be documented in the commit msg
> 
> Good finding. Indeed, there is a gap here if we use a symbol link as sysfsdev.
> See s390_ccw_get_dev_info() for details. But if it's not a symbol link, I think
> they are same.
> 
>>
>> then the subchannel name is
>>    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
>>                                 cdev->hostid.ssid,
>>                                 cdev->hostid.devid);
>>    QLIST_FOREACH(vbasedev, &group->device_list, next) {
>>        if (strcmp(vbasedev->name, name) == 0) {
>>            error_setg(errp, "vfio: subchannel %s has already been attached",
>>                       name);
>>            goto out_err;
>>        }
>>    }
>>
>> while new code use
>> +    QLIST_FOREACH(vbasedev_iter, &group->device_list, next) {
>> +        if (strcmp(vbasedev_iter->name, vbasedev->name) == 0) {
>> +            error_setg(errp, "device is already attached");
>> +            vfio_put_group(group);
>> +            return -EBUSY;
>> +        }
>> +    }
>>
>> We really need to double check the names, ie.
>> name, vbasedev->name. That's a mess and that's my bad.
> 
> Thanks for catching, I think below change will make it same as original code:
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6893a30ab1..a8ea0a6fa8 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -580,6 +580,9 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>      VFIODevice *vbasedev = &vcdev->vdev;
>      Error *err = NULL;
>      int ret;
> +    char *name = g_strdup_printf("%x.%x.%04x", cdev->hostid.cssid,
> +                                 cdev->hostid.ssid,
> +                                 cdev->hostid.devid);
> 
>      /* Call the class init function for subchannel. */
>      if (cdc->realize) {
> @@ -591,7 +594,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
> 
>      vbasedev->ops = &vfio_ccw_ops;
>      vbasedev->type = VFIO_DEVICE_TYPE_CCW;
> -    vbasedev->name = g_strdup(cdev->mdevid);
> +    vbasedev->name = name;
>      vbasedev->dev = &vcdev->cdev.parent_obj.parent_obj;
> 
>      /*
> @@ -604,7 +607,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
>       */
>      vbasedev->ram_block_discard_allowed = true;
> 
> -    ret = vfio_attach_device(vbasedev->name, vbasedev,
> +    ret = vfio_attach_device(cdev->mdevid, vbasedev,
>                               &address_space_memory, errp);
>      if (ret) {
>          goto out_attach_dev_err;
> 
> Thanks
> Zhenzhong

I haven't tried this particular version of the patches yet (either Eric F. or I will), but it looks like this change would re-introduce at least part of the breakage I reported during the RFC?

https://lore.kernel.org/qemu-devel/6e04ab8f-dc84-e9c2-deea-2b6b31678b53@linux.ibm.com/

Thanks,
Matt


