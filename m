Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6307B8366DD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 16:08:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRvu9-0001wq-7Y; Mon, 22 Jan 2024 10:08:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rRvu6-0001v7-FC; Mon, 22 Jan 2024 10:08:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjrosato@linux.ibm.com>)
 id 1rRvu4-00036f-Nr; Mon, 22 Jan 2024 10:08:02 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MF2A7G013469; Mon, 22 Jan 2024 15:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mg9RnBPcPMRmocLeAjJ4n0mULqGc2AufAMhhPJ7nr9s=;
 b=Xt9ecPqXXXxTE2Eyw8qshjURfoK3VzJYxL2X2BZFtUVZe7Xp9EoA8WYJsi/y0o+XM3//
 FdcvJK9XRuIJw9LT0eR6rJ4i7Zx2OTLwkHyqW8K22sQlhzGyQaPxwIae3M8nxZPCY2Th
 AmCJDjqWMoPPdISm+4L2/Rl0Ko9kevwv8tuV22l47inK8EL/0AQv9FKXa/wvXHK56w2Y
 QizxN/jHlAcUxm8n8UDWTkxY6801kp9Fsd5saLB6/X+aOXJXX5BggkDocWUQ03wOmGLx
 F8vmek0n4SnGtD6ndCBoJiRX4pkSvT/ke15PVSwCIeqVhfNzCCRyvO67XpJR3T70qgyB Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vstn60516-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:07:56 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40MF3Xoi021252;
 Mon, 22 Jan 2024 15:07:27 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vstn604fx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:07:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40MDCMLA026876; Mon, 22 Jan 2024 15:06:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vrrgt18m2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Jan 2024 15:06:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40MF6efB49742306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Jan 2024 15:06:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F36B058055;
 Mon, 22 Jan 2024 15:06:39 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EAC6E58043;
 Mon, 22 Jan 2024 15:06:38 +0000 (GMT)
Received: from [9.61.119.211] (unknown [9.61.119.211])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Jan 2024 15:06:38 +0000 (GMT)
Message-ID: <c206887f-7bca-4c5a-a416-88951902ff21@linux.ibm.com>
Date: Mon, 22 Jan 2024 10:06:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] s390x/pci: drive ISM reset from subsystem reset
Content-Language: en-US
To: Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, farman@linux.ibm.com, thuth@redhat.com,
 clg@redhat.com, frankja@linux.ibm.com, borntraeger@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240118185151.265329-1-mjrosato@linux.ibm.com>
 <20240118185151.265329-4-mjrosato@linux.ibm.com>
 <20240119220739.0f5739b3.pasic@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20240119220739.0f5739b3.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: i5p3691OXZHv-y8q5jtgqmJTsP97hv54
X-Proofpoint-ORIG-GUID: KFk79RHIY1vPq1De6M441QdK00WiV8GM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_05,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401220103
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

On 1/19/24 4:07 PM, Halil Pasic wrote:
> On Thu, 18 Jan 2024 13:51:51 -0500
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
>> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
>> index eaf61d3640..c99682b07d 100644
>> --- a/hw/s390x/s390-virtio-ccw.c
>> +++ b/hw/s390x/s390-virtio-ccw.c
>> @@ -118,6 +118,14 @@ static void subsystem_reset(void)
>>      DeviceState *dev;
>>      int i;
>>  
>> +    /*
>> +     * ISM firmware is sensitive to unexpected changes to the IOMMU, which can
>> +     * occur during reset of the vfio-pci device (unmap of entire aperture).
>> +     * Ensure any passthrough ISM devices are reset now, while CPUs are paused
>> +     * but before vfio-pci cleanup occurs.
>> +     */
>> +    s390_pci_ism_reset();
> 
> Hm I'm not sure about special casing ISM in here. In my opinion the loop
> below shall take care of all the reset.
> 
> For TYPE_AP_BRIDGE and TYPE_VIRTUAL_CSS_BRIDGE AFAIU a
> device_cold_reset() on all objects of those types results in the resets
> of objects that hang below these buses.
> 
> I guess this also happens for the S390PCIBusDevices, but not for the
> actual PCI devices.

PCI is a bit different because we have both the PCI root bus and the s390 pci bus --  When we reset the s390-pcihost in the device_cold_reset() loop, the root pci bus will also receive a reset and in practice this causes the vfio-pci devices to get cleaned up (this includes an unmap of the entire iommu aperture) and this happens before we get to the reset of S390PCIBusDevices.  This order is OK for other device types who are not sensitive to the IOMMU being wiped out in this manner, but ISM is effectively treating some portion of the IOMMU as state data and is not expecting this UNMAP.  Triggering the reset as we do here causes the host device to throw out the existing state data, so we want to do that at a point in time after CPU pause and before vfio-pci cleanup; this is basically working around a quirk of ISM devices.

FWIW, this series of fixes was already pulled.  I think for a fix, this location in code was the safe bet -- But if we can figure out a way to ensure the reset targeted S390PCIBusDevices first before the root PCI bus then I could see a follow-on cleanup patch that moves this logic back into s390 pci bus code (e.g. allowing the loop to take care of all the reset once again). 

Thanks,
Matt

