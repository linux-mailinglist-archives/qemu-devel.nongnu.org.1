Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2832C830E64
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:13:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDC0-00010Q-Q3; Wed, 17 Jan 2024 16:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQDBy-000106-T9; Wed, 17 Jan 2024 16:11:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQDBw-0005EN-D9; Wed, 17 Jan 2024 16:11:22 -0500
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HKa0SX016162; Wed, 17 Jan 2024 21:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XysA1hHT6U7LDmNGM44fhqUFcI5nP2iMheS+oMDp3ZM=;
 b=O9LvLcVc5dUR0Hkh+VPcHwavnBq7lW5CxK1Z8uLTm+m+u/TYPb6nyvj4nbzAYvrCAa/S
 dK84Ld0SPc0DdbXKOev4+Yz0f/Ld6BAUHYbr/yVM0nGovL+UAwDl9DdHmD3Wc/oe4bCI
 YHePQ8U5rJfA0+dLtC/r4sOGk6FgMvNJqJ0dy2OONCiDw77rggGsQG+vfURc758q1DuT
 OufNIpzeEuC1O3Lyf+FNlQeUqRTfLJ8AEyleRGC8OogSQkhfRA1xop9sDlVUvFDqnghU
 R4R9qWe1qjuGFr/oWtIxglBaEzQoEWuoCAMZh399/+CAkUAvFKj9LBybz2pIEcIHm/mf 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpmmr2s8m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 21:11:17 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HLBHBU015047;
 Wed, 17 Jan 2024 21:11:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vpmmr2s8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 21:11:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HJlgLt005820; Wed, 17 Jan 2024 21:11:16 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm6bkqhpb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 21:11:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HLBFvB66126316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 21:11:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 33B6958053;
 Wed, 17 Jan 2024 21:11:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E490558043;
 Wed, 17 Jan 2024 21:11:13 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 21:11:13 +0000 (GMT)
Message-ID: <04379048-1ff0-482b-8fc7-74cc13bb5a21@linux.ibm.com>
Date: Wed, 17 Jan 2024 16:11:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
 <66735e9f-a4fb-474f-abec-6c83d36f921e@redhat.com>
 <0131acaf-6daf-46b3-9368-e491766e2825@linux.ibm.com>
In-Reply-To: <0131acaf-6daf-46b3-9368-e491766e2825@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GVeG9D_GTw1JOOn4j25x2q-5E3tYleeR
X-Proofpoint-ORIG-GUID: zgkRUB5uqKdbXcVhatxKHjzGxb9m3rra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_12,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=999
 mlxscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170150
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/17/24 10:19 AM, Matthew Rosato wrote:
> On 1/17/24 6:01 AM, Cédric Le Goater wrote:
>> Adding Alex,
>>
>> On 1/16/24 23:31, Matthew Rosato wrote:
>>> ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
>>> needs to be reset before the vfio-pci device is reset (triggering a full
>>> UNMAP).  In order to ensure this occurs, trigger ISM device resets from
>>> subsystem_reset before triggering the PCI bus reset (which will also
>>> trigger vfio-pci reset).  This only needs to be done for ISM devices
>>> which were enabled for use by the guest.
>>> Further, ensure that AIF is disabled as part of the reset event.
>>>
>>> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
>>> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
>>> Reported-by: Cédric Le Goater <clg@redhat.com>
>>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>>> ---
>>>   hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
>>>   hw/s390x/s390-virtio-ccw.c      |  2 ++
>>>   include/hw/s390x/s390-pci-bus.h |  1 +
>>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>>> index 347580ebac..3e57d5faca 100644
>>> --- a/hw/s390x/s390-pci-bus.c
>>> +++ b/hw/s390x/s390-pci-bus.c
>>> @@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
>>>       pci_device_reset(pbdev->pdev);
>>>   }
>>>   -static void s390_pci_reset_cb(void *opaque)
>>> -{
>>> -    S390PCIBusDevice *pbdev = opaque;
>>> -
>>> -    pci_device_reset(pbdev->pdev);
>>> -}
>>> -
>>>   static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>>   {
>>>       HotplugHandler *hotplug_ctrl;
>>>         if (pbdev->pft == ZPCI_PFT_ISM) {
>>>           notifier_remove(&pbdev->shutdown_notifier);
>>> -        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
>>>       }
>>>         /* Unplug the PCI device */
>>> @@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>>               if (pbdev->pft == ZPCI_PFT_ISM) {
>>>                   pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
>>>                   qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
>>> -                qemu_register_reset(s390_pci_reset_cb, pbdev);
>>>               }
>>>           } else {
>>>               pbdev->fh |= FH_SHM_EMUL;
>>> @@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>>>       pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
>>>   }
>>>   +void s390_pci_ism_reset(void)
>>> +{
>>> +    S390pciState *s = s390_get_phb();
>>> +
>>> +    S390PCIBusDevice *pbdev, *next;
>>> +
>>> +    /* Trigger reset event for each passthrough ISM device currently in-use */
>>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>>> +        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
>>> +            pbdev->fh & FH_MASK_ENABLE) {
>>> +            s390_pci_kvm_aif_disable(pbdev);
>>> +
>>> +            pci_device_reset(pbdev->pdev);
>>> +        }
>>> +    }
>>> +}
>>
>>
>> Could we instead define a VFIOPCIDevice::resetfn handler for these
>> ISM devices (1014:04ed) ? This would be cleaner if possible.
>>
>> If so, as a prerequisite, we would need to introduce in a little VFIO
>> helper to define custom reset handlers.
>>
>> Thanks,
>>
>> C.
>>
> 
> Oh interesting, I had not noticed that.  This may well work -- resetfn is currently setup via vfio_setup_resetfn_quirk but it would probably be easier to have a helper that takes the vdev and a function pointer so that we can provide a platform-specific reset handler (rather than having hw/vfio/pci-quirks.c worry about CONFIG_S390 etc).  I'll have to play around with this.
>  
> 

Hmm, it was a good idea but I don't think this will work.  I tried to hack something together today but I'm definitely seeing paths where the vfio_listener_region_del happens before the call to vfio_pci_reset (which would ultimately trigger the new custom resetfn).

Perhaps we should stick with the call from subsystem_reset -- it will ensure that the ISM cleanup happens after guest CPUs are stopped but before vfio does its cleanup.

