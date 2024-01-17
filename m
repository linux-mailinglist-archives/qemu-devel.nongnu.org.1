Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43636830999
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:20:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7i4-0007qA-Gk; Wed, 17 Jan 2024 10:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7i3-0007pV-0h; Wed, 17 Jan 2024 10:20:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rQ7i1-00070b-1e; Wed, 17 Jan 2024 10:20:06 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HF77BN029980; Wed, 17 Jan 2024 15:20:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hATQFl/zLF/kgoD5u+D0i7kvse4FJV+AbdRr7shAvOw=;
 b=jwnGr9LYiw7jtvcqwvypepxK2jDhYLyegyltXL5yzciZ3In5zP2oQJWU4BARR6jYyhuF
 TMfGvhxPwNL15g5yEKd9E6d/P2h9qrug5xGd1GxxUjd5qTkXnuheRaZqJhx2AE2Xv7zT
 A2nteXACbEvitHmHyY8a5GSHV44pMKBs89kW3uG4jMSVKR9e2+5e+s3Obw/5xELiPiG7
 7HZA+2Cmo1gGkpEEEb9cITbmNlg7idWmHl2i/ilaZe2WnWt3Jqp/j8s2StMUtQiLM8ax
 XYsoo0034MOrdNlNI+OUd1J9F/rSwfB1Tyi7P9k3rkMihRBGNruA06uiRxH339MUTKvA PA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph8k0gf7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:19:57 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40HF7TPO031829;
 Wed, 17 Jan 2024 15:19:46 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vph8k0ga1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:19:46 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40HEUahJ010833; Wed, 17 Jan 2024 15:19:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vm57yp90e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jan 2024 15:19:32 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40HFJVIB35193286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jan 2024 15:19:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A94E58056;
 Wed, 17 Jan 2024 15:19:31 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DDC75803F;
 Wed, 17 Jan 2024 15:19:30 +0000 (GMT)
Received: from [9.61.163.245] (unknown [9.61.163.245])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jan 2024 15:19:30 +0000 (GMT)
Message-ID: <0131acaf-6daf-46b3-9368-e491766e2825@linux.ibm.com>
Date: Wed, 17 Jan 2024 10:19:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-s390x@nongnu.org
Cc: farman@linux.ibm.com, thuth@redhat.com, frankja@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
References: <20240116223157.73752-1-mjrosato@linux.ibm.com>
 <20240116223157.73752-4-mjrosato@linux.ibm.com>
 <66735e9f-a4fb-474f-abec-6c83d36f921e@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <66735e9f-a4fb-474f-abec-6c83d36f921e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wQuh_0NAzLbNzguNNLcUg3Et4rh0XOqL
X-Proofpoint-ORIG-GUID: DbwuBucCUoYQOIFGpuYy3yBhAFY8HtOO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-17_09,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401170111
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=mjrosato@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 1/17/24 6:01 AM, Cédric Le Goater wrote:
> Adding Alex,
> 
> On 1/16/24 23:31, Matthew Rosato wrote:
>> ISM devices are sensitive to manipulation of the IOMMU, so the ISM device
>> needs to be reset before the vfio-pci device is reset (triggering a full
>> UNMAP).  In order to ensure this occurs, trigger ISM device resets from
>> subsystem_reset before triggering the PCI bus reset (which will also
>> trigger vfio-pci reset).  This only needs to be done for ISM devices
>> which were enabled for use by the guest.
>> Further, ensure that AIF is disabled as part of the reset event.
>>
>> Fixes: ef1535901a ("s390x: do a subsystem reset before the unprotect on reboot")
>> Fixes: 03451953c7 ("s390x/pci: reset ISM passthrough devices on shutdown and system reset")
>> Reported-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
>> ---
>>   hw/s390x/s390-pci-bus.c         | 26 +++++++++++++++++---------
>>   hw/s390x/s390-virtio-ccw.c      |  2 ++
>>   include/hw/s390x/s390-pci-bus.h |  1 +
>>   3 files changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
>> index 347580ebac..3e57d5faca 100644
>> --- a/hw/s390x/s390-pci-bus.c
>> +++ b/hw/s390x/s390-pci-bus.c
>> @@ -151,20 +151,12 @@ static void s390_pci_shutdown_notifier(Notifier *n, void *opaque)
>>       pci_device_reset(pbdev->pdev);
>>   }
>>   -static void s390_pci_reset_cb(void *opaque)
>> -{
>> -    S390PCIBusDevice *pbdev = opaque;
>> -
>> -    pci_device_reset(pbdev->pdev);
>> -}
>> -
>>   static void s390_pci_perform_unplug(S390PCIBusDevice *pbdev)
>>   {
>>       HotplugHandler *hotplug_ctrl;
>>         if (pbdev->pft == ZPCI_PFT_ISM) {
>>           notifier_remove(&pbdev->shutdown_notifier);
>> -        qemu_unregister_reset(s390_pci_reset_cb, pbdev);
>>       }
>>         /* Unplug the PCI device */
>> @@ -1132,7 +1124,6 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
>>               if (pbdev->pft == ZPCI_PFT_ISM) {
>>                   pbdev->shutdown_notifier.notify = s390_pci_shutdown_notifier;
>>                   qemu_register_shutdown_notifier(&pbdev->shutdown_notifier);
>> -                qemu_register_reset(s390_pci_reset_cb, pbdev);
>>               }
>>           } else {
>>               pbdev->fh |= FH_SHM_EMUL;
>> @@ -1279,6 +1270,23 @@ static void s390_pci_enumerate_bridge(PCIBus *bus, PCIDevice *pdev,
>>       pci_default_write_config(pdev, PCI_SUBORDINATE_BUS, s->bus_no, 1);
>>   }
>>   +void s390_pci_ism_reset(void)
>> +{
>> +    S390pciState *s = s390_get_phb();
>> +
>> +    S390PCIBusDevice *pbdev, *next;
>> +
>> +    /* Trigger reset event for each passthrough ISM device currently in-use */
>> +    QTAILQ_FOREACH_SAFE(pbdev, &s->zpci_devs, link, next) {
>> +        if (pbdev->interp && pbdev->pft == ZPCI_PFT_ISM &&
>> +            pbdev->fh & FH_MASK_ENABLE) {
>> +            s390_pci_kvm_aif_disable(pbdev);
>> +
>> +            pci_device_reset(pbdev->pdev);
>> +        }
>> +    }
>> +}
> 
> 
> Could we instead define a VFIOPCIDevice::resetfn handler for these
> ISM devices (1014:04ed) ? This would be cleaner if possible.
> 
> If so, as a prerequisite, we would need to introduce in a little VFIO
> helper to define custom reset handlers.
> 
> Thanks,
> 
> C.
>

Oh interesting, I had not noticed that.  This may well work -- resetfn is currently setup via vfio_setup_resetfn_quirk but it would probably be easier to have a helper that takes the vdev and a function pointer so that we can provide a platform-specific reset handler (rather than having hw/vfio/pci-quirks.c worry about CONFIG_S390 etc).  I'll have to play around with this.
 


