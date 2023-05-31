Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFBB718066
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 14:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4LK5-0006D0-42; Wed, 31 May 2023 08:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4LK2-0006Ce-4y; Wed, 31 May 2023 08:53:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akrowiak@linux.ibm.com>)
 id 1q4LK0-0006Sp-CI; Wed, 31 May 2023 08:53:01 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VCbUx1014401; Wed, 31 May 2023 12:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4CGDojlVgYF+V/sONprKjy1P+w+As001BW8hlPv5D5w=;
 b=Zb7KL1JIPPzYPrTFkyh5v+H/H3PJxMbLczOE+C1BW4p6Q27HLIuPFxfsRHvIrpZgOxtu
 azGQ0SAI3o7NGYH6/Eiksl5xfEOFJfG/Ew9T4LioIOZ49ULSSkL/IAnnNk1IAAvfFOPI
 0ifGKaOJot2U47eCEagkBRIK4YHW5D2CUbj2rJKOF6r1K4Q+AZVpLHUHrWX4V4AxndOi
 QM7rMDcvo6ie/qJdcfLL3+/zt6RuVj0JZyBOf74eGrIQpW1xgGFzvLFsSyhn/pPSgtt5
 qh6/mELrI6/Ga3HfabvWvXeJf4vSgNmmP+A+4vmLn1jNjXp+aeJ+uZCgSBlY+wQuSXrm eg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx62d91uh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:52:58 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34VCdKQO025870;
 Wed, 31 May 2023 12:52:57 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qx62d91u6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:52:57 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34VBhOHa012710;
 Wed, 31 May 2023 12:52:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
 by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3qu9g5umqc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 May 2023 12:52:57 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34VCqunC37421808
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 12:52:56 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA53158055;
 Wed, 31 May 2023 12:52:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 48F3058043;
 Wed, 31 May 2023 12:52:55 +0000 (GMT)
Received: from [9.61.88.233] (unknown [9.61.88.233])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 31 May 2023 12:52:55 +0000 (GMT)
Message-ID: <76dd7f44-56a5-91fd-13c2-fb1579c588ab@linux.ibm.com>
Date: Wed, 31 May 2023 08:52:54 -0400
MIME-Version: 1.0
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
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <06630472-57c8-89dd-ad80-75fb4d0d7de9@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UEkkoFL-9z4FNTLh1oBgPxAtq6Qw4myW
X-Proofpoint-ORIG-GUID: zrmG-RGIUmynrzrsiYYX3KG6X-lDb3wx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305310108
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



On 5/30/23 8:56 PM, Matthew Rosato wrote:
> On 5/30/23 6:55 PM, Tony Krowiak wrote:
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   linux-headers/linux/vfio.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Worth nothing here that linux-headers patches should be generated using scripts/update-linux-headers.sh.
> 
> Since this linux-headers update includes changes that aren't merged into the kernel yet, I would still use update-linux-headers.sh -- but also include in the commit message that this is a placeholder patch that includes unmerged uapi changes.  Then once the kernel changes merge you can just have a proper linux-headers update patch in a subsequent qemu series.

I guess I do not understand the procedure here. I first determined the 
latest kernel release in which the vfio.h file was updated with the 
following command:
git log --oneline origin/master -- linux-headers/linux/vfio.h

According to the git log, the vfio.h file was last updated in kernel 
v6.3-rc5. I cloned that kernel from 
git.kernel.org/pub/scm/linux/kernel/git/stable and checked out kernel 
6.3-rc5. I then made the changes to the linux-headers/linux/vfio.h file 
and ran the update-linux-headers.sh script and created this patch from 
that. Where did I go wrong?

> 
>>
>> diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
>> index 4a534edbdcba..2658fda219e8 100644
>> --- a/linux-headers/linux/vfio.h
>> +++ b/linux-headers/linux/vfio.h
>> @@ -646,6 +646,15 @@ enum {
>>   	VFIO_CCW_NUM_IRQS
>>   };
>>   
>> +/*
>> + * The vfio-ap bus driver makes use of the following IRQ index mapping.
>> + * Unimplemented IRQ types return a count of zero.
>> + */
>> +enum {
>> +	VFIO_AP_REQ_IRQ_INDEX,
>> +	VFIO_AP_NUM_IRQS
>> +};
>> +
>>   /**
>>    * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
>>    *					      struct vfio_pci_hot_reset_info)
> 

