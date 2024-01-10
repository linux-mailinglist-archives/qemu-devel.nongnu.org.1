Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D88E482A2C9
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 21:50:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNfUx-0000l5-Hf; Wed, 10 Jan 2024 15:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNfUs-0000im-Mk
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 15:48:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rNfUj-0003kb-P4
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 15:48:16 -0500
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AKQCeE029617
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 20:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=awUgeT3nlJvDdllIJSYMbY8e1zu6OoGE6C/sYO0x7pI=;
 b=WHXww3MJU0+ILkyVAUPl6Q8c3gw42+ERdLWAiR6pkRL8nG5kEWIYnFf4Sc7hPZYN/K3D
 snusp9893ee5P0MeqB+eJp/dTZGkpLQyLE8pzrGJIJAFX9672d6Zyk7Llp8W5DiaUZ2U
 LIOFycFH+V4xPkdtcXngYNQNpjNa3aN8/A7aO856cGzjRavgKoLWpQDHkxt8DAbmsgCf
 AMbSKkZKGXnJOmrw0gFDq2eLxynKyBWSyJTPrttao5JB9zX3ynFEvNL9TKUP6HgL3goa
 1AKx3dU556jIhNp58f+J3j4/JljUmKkogUZtxNEkCirOylV1JclNC21L1TijDVZc/1Mr qQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj0qk2f5y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 20:48:07 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40AKm6a6031011
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 20:48:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vj0qk2f5r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 20:48:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AJUf2e026992; Wed, 10 Jan 2024 20:28:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw27191-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jan 2024 20:28:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40AKSi5H42271204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 20:28:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C16258056;
 Wed, 10 Jan 2024 20:28:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 866265803F;
 Wed, 10 Jan 2024 20:28:43 +0000 (GMT)
Received: from [9.61.0.193] (unknown [9.61.0.193])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 10 Jan 2024 20:28:43 +0000 (GMT)
Message-ID: <287dbe42-5a10-4667-b3fa-111270242b1d@linux.ibm.com>
Date: Wed, 10 Jan 2024 15:28:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] s390x: do a subsystem reset before the unprotect on
 reboot
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
References: <20230912114112.296428-1-thuth@redhat.com>
 <20230912114112.296428-3-thuth@redhat.com>
 <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <6aec238b-b983-4b24-9bd9-a90f840d060c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2JQ1SmAzW62EFoqYp4NbVeaRLRKqjZif
X-Proofpoint-ORIG-GUID: uumtAHFdY_ESQ_u4VqmUKub2WmJcfKiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_11,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2401100164
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

On 1/10/24 1:30 PM, Cédric Le Goater wrote:
> On 9/12/23 13:41, Thomas Huth wrote:
>> From: Janosch Frank <frankja@linux.ibm.com>
>>
>> Bound APQNs have to be reset before tearing down the secure config via
>> s390_machine_unprotect(). Otherwise the Ultravisor will return a error
>> code.
>>
>> So let's do a subsystem_reset() which includes a AP reset before the
>> unprotect call. We'll do a full device_reset() afterwards which will
>> reset some devices twice. That's ok since we can't move the
>> device_reset() before the unprotect as it includes a CPU clear reset
>> which the Ultravisor does not expect at that point in time.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> Message-ID: <20230901114851.154357-1-frankja@linux.ibm.com>
>> Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index 3dd0b2372d..2d75f2131f 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
>>       switch (reset_type) {
>>       case S390_RESET_EXTERNAL:
>>       case S390_RESET_REIPL:
>> +        /*
>> +         * Reset the subsystem which includes a AP reset. If a PV
>> +         * guest had APQNs attached the AP reset is a prerequisite to
>> +         * unprotecting since the UV checks if all APQNs are reset.
>> +         */
>> +        subsystem_reset();
> 
> 
> This commit introduced a regression with pass-though ISM devices.
> 
> After startup, a reboot will generate extra device resets (vfio-pci in
> this case) which break the pass-though ISM device in a subtle way,

Hi Cedric, thanks for reporting this...  I was able to reproduce just now, and it looks like ISM firmware is unhappy specifically with this susbystem_reset call added by ef1535901a0, not necessarily the multiple attempts at reset -- I verified that reverting ef1535901a0 resolves the ISM issue, but if I instead try reverting the older 03451953c79e while leaving ef1535901a0 in place then ISM devices still break on guest reboot.


> probably related to IOMMU mapping according to 03451953c79e
> ("s390x/pci: reset ISM passthrough devices on shutdown and system
> reset"). After poweroff, the device is left in a sort-of-a-use state
> on the host and the LPAR has to be rebooted to clear the invalid state
> of the device. To be noted, that standard PCI devices are immune to
> this change.

As a bit of background, ISM firmware is very sensitive re: the contents of the (host) IOMMU and attempts at manipulation that it deems to be out-of-order; the point of 03451953c79e was to ensure that the device gets a reset before we attempt at unmapping anything that wasn't cleaned up in an orderly fashion by the (guest) ism driver at the time of shutdown/reset (e.g. underlying firmware may view guest SBAs in the IOMMU as still registered for use and will throw an error condition at attempts to remove their entries in the IOMMU without first going through an unregistration process).

The unmap that would make ISM upset would generally be coming out of vfio_listener_region_del where we just do one big vfio_dma_unmap -- a quick trace shows that the subsystem_reset call added by ef1535901a0 is causing the vfio_listener_region_del to once again trigger before the pci reset of the ISM device, effectively re-introducing the condition that 03451953c79e was trying to resolve.

> 
> The extra resets should avoided in some ways, (a shutdown notifier and
> a reset callback are already registered for ISM devices by 03451953c79e)

So as mentioned above, it's not the extra resets that are the issue, it's the order of operations.  Basically, we need to drive pci_device_reset for any ISM device associated with the guest before we destroy the vfio memory listener (now triggered in this case via subsystem_reset).  So if we must drive this subsystem_reset before we trigger the device reset callbacks then it might require a s390 pci bus routine that is called before or during subystem_reset just to reset the ISM devices associated with this guest first; I'm not sure yet.

As an aside:  I wonder why we are always doing the subsystem_reset here unconditionally rather than only when s390_is_pv() since that seems to be the only case that requires it.

> and, most important, once the VM terminates, the device resources
> should be cleared in the host kernel. So there seem to be two issues
> to address in mainline QEMU and in Linux AFAICT.

Because of the condition detected by ISM firmware as described above, the host device was placed in an error state and remains in that state.  After shutting down the guest, you should be able to use zpcictl --reset on the affected host device(s) to clear the error condition and re-enable it for use.

Thanks,
Matt

