Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F0CA8494B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Apr 2025 18:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2uS1-0003vy-9p; Thu, 10 Apr 2025 12:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u2uRx-0003vZ-8q; Thu, 10 Apr 2025 12:08:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u2uRu-0002kc-Vq; Thu, 10 Apr 2025 12:08:20 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AEet5E003298;
 Thu, 10 Apr 2025 16:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DhnNxg
 ZGRXG3/bw/P50//vbg8cEzQGbFUk4DYVb57eY=; b=TAKpmZoJ3uMgWC3PYa3bmj
 3bg1KLZNBM/0w+YT1wapq55wUuT/b3LlAdTL1abRZplw+CFh/1eEtOCv0rAZnbwe
 YXzInbZb97x0x5Fynypn7In9youLKI8E+Q1W7+gkxhVkMklwosBJmW/14EX+bfHz
 XBrlQZx8aW0bE3dx7JBIlPbB+WFiDYL/2pe0A6IDJzoMX0It7NYDlzp2PHf06AX3
 3p4bh4+cHc153PfSPZorCd9J0ICt/AtqQCjlGyHWLDbiw450dAuMSTQjmHLYslZL
 1qfOqvFL8I78brPQDkz62leD9sDKorB5HSNgdehKbmn/ET1iV+RzU9t31HlQHmXg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0405rs6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 16:07:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53AG4NoU005658;
 Thu, 10 Apr 2025 16:07:57 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0405rs4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 16:07:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53AFZHA2024651;
 Thu, 10 Apr 2025 16:07:56 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutq0jw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Apr 2025 16:07:56 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53AG7tT028115592
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 10 Apr 2025 16:07:55 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A65CC58052;
 Thu, 10 Apr 2025 16:07:55 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 65CFA5805A;
 Thu, 10 Apr 2025 16:07:54 +0000 (GMT)
Received: from [9.61.249.150] (unknown [9.61.249.150])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 10 Apr 2025 16:07:54 +0000 (GMT)
Message-ID: <efa82601-4775-4b9f-9d7f-49f788d2f13f@linux.ibm.com>
Date: Thu, 10 Apr 2025 09:07:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Enable QEMU NVMe userspace driver on s390x
To: Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, fam@euphon.net,
 philmd@linaro.org, kwolf@redhat.com, hreitz@redhat.com,
 thuth@redhat.com, mjrosato@linux.ibm.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, venture@google.com,
 crauer@google.com, pefoley@google.com, david@redhat.com
References: <20250401172246.2688-1-alifm@linux.ibm.com>
 <20250402155152.GE304512@fedora>
 <2c11a602415f0780030d4e68a28eee7ffcdd8cb7.camel@linux.ibm.com>
 <20250403154442.GA349582@fedora>
 <20250403102704.7e1f4452.alex.williamson@redhat.com>
 <2c244588-b37b-4e86-863e-ef462343edad@linux.ibm.com>
 <20250403120504.2f660171.alex.williamson@redhat.com>
 <d9e4feb3-351c-4c0b-8c8e-a5141e80ed5e@linux.ibm.com>
 <20250403152402.1373f0b2.alex.williamson@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250403152402.1373f0b2.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JKMFcdLO3P3JJfRtOBLyjRw3iPAftU-X
X-Proofpoint-GUID: 5wz9zgorEurr5EEApkFwqfUAG2-yrxWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100116
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 4/3/2025 2:24 PM, Alex Williamson wrote:
> On Thu, 3 Apr 2025 13:33:17 -0700
> Farhan Ali <alifm@linux.ibm.com> wrote:
>
>> On 4/3/2025 11:05 AM, Alex Williamson wrote:
>>> On Thu, 3 Apr 2025 10:33:52 -0700
>>> Farhan Ali <alifm@linux.ibm.com> wrote:
>>>   
>>>> On 4/3/2025 9:27 AM, Alex Williamson wrote:
>>>>> On Thu, 3 Apr 2025 11:44:42 -0400
>>>>> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>>>>      
>>>>>> On Thu, Apr 03, 2025 at 09:47:26AM +0200, Niklas Schnelle wrote:
>>>>>>> On Wed, 2025-04-02 at 11:51 -0400, Stefan Hajnoczi wrote:
>>>>>>>> On Tue, Apr 01, 2025 at 10:22:43AM -0700, Farhan Ali wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> Recently on s390x we have enabled mmap support for vfio-pci devices [1].
>>>>>>>> Hi Alex,
>>>>>>>> I wanted to bring this to your attention. Feel free to merge it through
>>>>>>>> the VFIO tree, otherwise I will merge it once you have taken a look.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Stefan
>>>>>>>>          
>>>>>>>>> This allows us to take advantage and use userspace drivers on s390x. However,
>>>>>>>>> on s390x we have special instructions for MMIO access. Starting with z15
>>>>>>>>> (and newer platforms) we have new PCI Memory I/O (MIO) instructions which
>>>>>>>>> operate on virtually mapped PCI memory spaces, and can be used from userspace.
>>>>>>>>> On older platforms we would fallback to using existing system calls for MMIO access.
>>>>>>>>>
>>>>>>>>> This patch series introduces support the PCI MIO instructions, and enables s390x
>>>>>>>>> support for the userspace NVMe driver on s390x. I would appreciate any review/feedback
>>>>>>>>> on the patches.
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> Farhan
>>>>>>> Hi Stefan,
>>>>>>>
>>>>>>> the kernel patch actually made it into Linus' tree for v6.15 already as
>>>>>>> commit aa9f168d55dc ("s390/pci: Support mmap() of PCI resources except
>>>>>>> for ISM devices") plus prerequisites. This went via the PCI tree
>>>>>>> because they included a change to struct pci_dev and also enabled
>>>>>>> mmap() on PCI resource files. Alex reviewed an earlier version and was
>>>>>>> the one who suggested to also enable mmap() on PCI resources.
>>>>>> The introduction of a new QEMU API for accessing MMIO BARs in this
>>>>>> series is something Alex might be interested in as QEMU VFIO maintainer.
>>>>>> That wouldn't have been part of the kernel patch review.
>>>>>>
>>>>>> If he's aware of the new API he can encourage other VFIO users to use it
>>>>>> in the future so that you won't need to convert them to work on s390x
>>>>>> again.
>>>>> I don't claim any jurisdiction over the vfio-nvme driver.  In general
>>>>> vfio users should be using either vfio_region_ops, ram_device_mem_ops,
>>>>> or directly mapping MMIO into the VM address space.  The first uses
>>>>> pread/write through the region offset, irrespective of the type of
>>>>> memory, the second provides the type of access used here where we're
>>>>> dereferencing into an mmap, and the last if of course the preferred
>>>>> mechanism where available.
>>>>>
>>>>> It is curious that the proposal here doesn't include any changes to
>>>>> ram_device_mem_ops for more generically enabling MMIO access on s390x.
>>>>> Thanks,
>>>>>
>>>>> Alex
>>>> Hi Alex,
>>>>    From my understanding the ram_device_mem_ops sets up the BAR access for
>>>> a guest passthrough device. Unfortunately today an s390x KVM guest
>>>> doesn't use and have support for these MIO instructions. We wanted to
>>>> use this series as an initial test vehicle of the mmap support.
>>> Right, ram_device_mem_ops is what we'll use to access a BAR that
>>> supports mmap but for whatever reason we're accessing it directly
>>> through the mmap.  For instance if an overlapping quirk prevents the
>>> page from being mapped to the VM or we have some back channel mechanism
>>> where the VMM is interacting with the BAR.
>>>
>>> I bring it up here because it's effectively the same kind of access
>>> you're adding with these helpers and would need to be addressed if this
>>> were generically enabling vfio mmap access on s390x.
>> On s390x the use of the MIO instructions is limited to only PCI access.
>> So i am not sure if we should generically apply this to all vfio mmap
>> access (for non PCI devices).
>>
>>
>>> Prior to commit 2b8fe81b3c2e ("system/memory: use ldn_he_p/stn_he_p")
>>> the mmio helpers here might have been a drop-in replacement for the
>>> dereferencing of mmap offsets, but something would need to be done
>>> about the explicit PCI assumption introduced here and the possibility
>>> of unaligned accesses that the noted commit tries to resolve.  Thanks,
>>>
>>> Alex
>> AFAICT in qemu today the ram_device_mem_ops is used for non PCI vfio
>> mmap cases. For s390x these helpers should be restricted to PCI
>> accesses. For the unaligned accesses (thanks for pointing out that
>> commmit!), are you suggesting we use the ld*_he_p/st*_he_p functions in
>> the helpers i defined? Though those functions don't seem to be doing
>> volatile accesses.
> TBH, it's not clear to me that 2b8fe81b3c2e is correct.  We implemented
> the ram_device MemoryRegion specifically to avoid memory access
> optimizations that are not compatible with MMIO, but I see that these
> {ld,st}*_he_pe operations are using __builtin_memcpy.  I'm not a
> compiler aficionado, but is __builtin_memcpy guaranteed to use an
> instruction set compatible with MMIO?
>
> Cc: folks related to that commit.
>
> The original issue that brought us ram_device was a very obscure
> alignment of a memory region versus a device quirk only seen with
> assignment of specific RTL NICs.
>
> The description for commit 4a2e242bbb30 ("memory: Don't use memcpy for
> ram_device regions") also addresses unaligned accesses, we don't expect
> drivers to use them and we don't want them to work differently in a VM
> than they might on bare metal.  We can debate whether that's valid or
> not, but that was the intent.
>
> Have we re-introduced the chance that we're using optimized
> instructions only meant to target RAM here or is __builtin_memcpy
> implicitly safe for MMIO?  Thanks,
>
> Alex


Hi Stefan, Alex


Polite ping. Following up to understand how we should proceed with this 
series. Please let me know if there are any concerns that i haven't 
addressed?

Thanks

Farhan



