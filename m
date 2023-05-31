Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C05718128
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LdH-0006MU-C1; Wed, 31 May 2023 09:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4LdC-0006Ld-RL; Wed, 31 May 2023 09:12:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4Ld8-0001zE-2w; Wed, 31 May 2023 09:12:50 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VDC2DD027700; Wed, 31 May 2023 13:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=tPa06KQtGdo6oAUxzNa4shpttE7tEiMZBACIlindqOg=;
 b=Q1J0ME5i8s6iWDq72YKOI1VhHCXrgInt2vexn0AvnHgyWESFW//AkEzZQcV2FQ47FWNV
 0Gt20o3dXhYe6EHjK7kpwuybSfTMzKTEbukHMKGEX/WmHsc5RBoocbaxz6eFCi40z+6Y
 YV1A7RzUS+rUyDCQGAZLBdbCGB5YMH2A2pW1b4mpdpbdqmhGhW6OlbNGUKcwUK2JxFAN
 BpE7KgMbwbyUYw9G9ZLnLnCJLMY8jO4YZKoFMFAfqaIPYHYS3tA92aV+WBQP/ghqwMWp
 o8Bk3tpSfHdQz/r1Txb8wJG59VI3+F7hZD1zfz6Obr3/b8O0Hfec2bO0kGG8MuimxAsr 0g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx6ans8qj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:12:43 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCuitu008814;
 Wed, 31 May 2023 13:12:43 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx6ans8q3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:12:43 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34V5wVJl017372;
 Wed, 31 May 2023 13:12:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
 by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3qu9g570j2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 13:12:42 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34VDCeOU34472478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 13:12:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4715858059;
 Wed, 31 May 2023 13:12:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 913D758043;
 Wed, 31 May 2023 13:12:39 +0000 (GMT)
Received: from [9.61.88.233] (unknown [9.61.88.233])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 May 2023 13:12:39 +0000 (GMT)
Message-ID: <4896ed7a-74d1-522e-a1aa-b11357438a72@linux.ibm.com>
Date: Wed, 31 May 2023 09:12:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] linux-headers: Update with vfio_ap IRQ index mapping
Content-Language: en-US
To: Matthew Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 fiuczy@linux.ibm.com, thuth@redhat.com, farman@linux.ibm.com,
 borntraeger@linux.ibm.com
References: <20230530225544.280031-1-akrowiak@linux.ibm.com>
 <20230530225544.280031-2-akrowiak@linux.ibm.com>
 <06630472-57c8-89dd-ad80-75fb4d0d7de9@linux.ibm.com>
 <76dd7f44-56a5-91fd-13c2-fb1579c588ab@linux.ibm.com>
 <7f5589ad-3062-4087-6272-a55ffa05f10b@linux.ibm.com>
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <7f5589ad-3062-4087-6272-a55ffa05f10b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K5ia4R1qIC7HmF-QwSOuiMf_EEBaMtKF
X-Proofpoint-ORIG-GUID: CbGOrr0830DKBxbS8dTBLfKITSMdA54U
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310112
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=akrowiak@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 5/31/23 9:07 AM, Matthew Rosato wrote:
> On 5/31/23 8:52 AM, Anthony Krowiak wrote:
>>
>>
>> On 5/30/23 8:56 PM, Matthew Rosato wrote:
>>> On 5/30/23 6:55 PM, Tony Krowiak wrote:
>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    linux-headers/linux/vfio.h | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>
>>> Worth nothing here that linux-headers patches should be generated using scripts/update-linux-headers.sh.
>>>
>>> Since this linux-headers update includes changes that aren't merged into the kernel yet, I would still use update-linux-headers.sh -- but also include in the commit message that this is a placeholder patch that includes unmerged uapi changes.  Then once the kernel changes merge you can just have a proper linux-headers update patch in a subsequent qemu series.
>>
>> I guess I do not understand the procedure here. I first determined the latest kernel release in which the vfio.h file was updated with the following command:
>> git log --oneline origin/master -- linux-headers/linux/vfio.h
>>
>> According to the git log, the vfio.h file was last updated in kernel v6.3-rc5. I cloned that kernel from git.kernel.org/pub/scm/linux/kernel/git/stable and checked out kernel 6.3-rc5. I then made the changes to the linux-headers/linux/vfio.h file and ran the update-linux-headers.sh script and created this patch from that. Where did I go wrong?
> 
> Presumably your kernel series that you just posted was built on top of 6.4-rc4, not v6.3-rc5 (if it's not, you should rebase onto a recent kernel like 6.4-rc4).  Then, you want to point update-linux-headers.sh at that source repository which includes your changes.  This will pull in all of the changes to the uapi up to kernel 6.4-rc* + your additional unmerged changes.  FWIW, I just pointed update-linux-headers.sh at kernel master from today and I got the following:
> 
> ---
>   include/standard-headers/linux/const.h        |  2 +-
>   include/standard-headers/linux/virtio_blk.h   | 18 +++----
>   .../standard-headers/linux/virtio_config.h    |  6 +++
>   include/standard-headers/linux/virtio_net.h   |  1 +
>   linux-headers/asm-arm64/kvm.h                 | 33 ++++++++++++
>   linux-headers/asm-riscv/kvm.h                 | 53 ++++++++++++++++++-
>   linux-headers/asm-riscv/unistd.h              |  9 ++++
>   linux-headers/asm-s390/unistd_32.h            |  1 +
>   linux-headers/asm-s390/unistd_64.h            |  1 +
>   linux-headers/asm-x86/kvm.h                   |  3 ++
>   linux-headers/linux/const.h                   |  2 +-
>   linux-headers/linux/kvm.h                     | 12 +++--
>   linux-headers/linux/psp-sev.h                 |  7 +++
>   linux-headers/linux/userfaultfd.h             | 17 +++++-
>   14 files changed, 149 insertions(+), 16 deletions(-)
> ---
> 
> In your case you would also see an additional line for linux-headers/linux/vfio.h, which would be your unmerged kernel uapi changes.
> 
> Then you can include a cover letter something like:
> 
> This is a placeholder that pulls in 6.4-rc4 + unmerged kernel changes
> required by this series.  A proper header sync can be done once the
> associated kernel code merges.
> 
> Here's an example from an old series where I did this before:
> 
> https://lore.kernel.org/qemu-devel/20220606203614.110928-2-mjrosato@linux.ibm.com/
> 
> One of the main advantages of doing it this way is that if there are any uapi breakages unrelated to your patch we catch them now.  That helps whoever might take your series (e.g. Thomas) avoid having to deal with the fallout later when sending a pull request.

Thanks Matt, I'll do this for v2.

> 
>>
>>>
>>>>
>>>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>>>> index 4a534edbdcba..2658fda219e8 100644
>>>> --- a/linux-headers/linux/vfio.h
>>>> +++ b/linux-headers/linux/vfio.h
>>>> @@ -646,6 +646,15 @@ enum {
>>>>        VFIO_CCW_NUM_IRQS
>>>>    };
>>>>    +/*
>>>> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
>>>> + * Unimplemented IRQ types return a count of zero.
>>>> + */
>>>> +enum {
>>>> +    VFIO_AP_REQ_IRQ_INDEX,
>>>> +    VFIO_AP_NUM_IRQS
>>>> +};
>>>> +
>>>>    /**
>>>>     * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>>>>     *                          struct vfio_pci_hot_reset_info)
>>>
> 

