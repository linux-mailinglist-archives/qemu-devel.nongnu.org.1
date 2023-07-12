Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CADF7501BB
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:37:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJVKL-0007hR-N3; Wed, 12 Jul 2023 04:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qJVKI-0007gY-MG; Wed, 12 Jul 2023 04:35:58 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.vnet.ibm.com>)
 id 1qJVKG-0007eM-8l; Wed, 12 Jul 2023 04:35:58 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36C8VXBw024287; Wed, 12 Jul 2023 08:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=L0SVpxriRWMFKVEd/sctR26ekFXxiBYM1e6DHYPpnR0=;
 b=DmCCTnyXzyV6z4JgjLQbsuOX+/WOD5n35Pdp0Sd/ZX8UYlIO6jjOo0wahNux35bXTxRN
 g4LR0TRx40iuJ1Lq7ZRm+nWfBIeAq0I2Krhi/6iOnvimcb/Dr4gBscTHNtMuOm57iXfb
 OaAMwDGg/IpcTo3La36ywYC/twCU8Gs7sg3UQW/toaR6PkXZLFHvf+PzIfIUJzpq4vJP
 5rqI6CZ69m34MaU+Jw5AfDa/FQmiY/5s9FqGqmedodeIa+D+ozrkwYPXpSdv18rGLQXo
 Ez6uGYW++G7aQWXwaaYMq6SBc4otBwnWuU/UaJC2adNrF6wG/wgO2hT+h01bnkwKvRrU Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsrr8r2un-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 08:34:45 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36C8VspK025260;
 Wed, 12 Jul 2023 08:34:44 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsrr8r2uc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 08:34:44 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36C2MaNL011484; Wed, 12 Jul 2023 08:34:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rqk4mh9f7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 08:34:43 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36C8Yh8831719978
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jul 2023 08:34:43 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 419035803F;
 Wed, 12 Jul 2023 08:34:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 222895805A;
 Wed, 12 Jul 2023 08:34:40 +0000 (GMT)
Received: from [9.171.52.107] (unknown [9.171.52.107])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Jul 2023 08:34:39 +0000 (GMT)
Message-ID: <a213011e-9dc7-194f-47c2-696ee867e0f1@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2023 14:04:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: qemu-system-ppc64 option -smp 2 broken with commit
 20b6643324a79860dcdfe811ffe4a79942bca21e
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com
References: <8780abd9-59ef-c452-bfee-c3bfbf275e51@linux.vnet.ibm.com>
 <a474146f-cd1d-b91a-eefd-596a1d08f772@kaod.org> <87y1kadwqz.fsf@linaro.org>
From: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
In-Reply-To: <87y1kadwqz.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fmdtspU7paul-r_0efzWVNK8LtqMJqt8
X-Proofpoint-GUID: nzLYcHE6HGKDwkyJf4JZ9ksvpEEiUorL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_05,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120075
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.vnet.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Alex,

On 6/23/23 20:52, Alex Bennée wrote:
> Cédric Le Goater <clg@kaod.org> writes:
>
>> Hello Anushree,
>>
>> On 6/23/23 13:09, Anushree Mathur wrote:
>>> Hi everyone,
>>> I was trying to boot rhel9.3 image with upstream qemu-system-ppc64
>>> -smp 2 option and observed a segfault (qemu crash).
>>> qemu command line used:
>>> qemu-system-ppc64 -name Rhel9.3.ppc64le -smp 2 -m 16G -vga none
>>> -nographic -machine pseries -cpu POWER10 -accel tcg -device
>>> virtio-scsi-pci -drive
>>> file=/home/rh93.qcow2,if=none,format=qcow2,id=hd0 -device
>>> scsi-hd,drive=hd0 -boot c
>>> After doing a git bisect, I found the first bad commit which
>>> introduced this issue is below:
>> Could you please open a gitlab issue on QEMU project ?
>>
>>   https://gitlab.com/qemu-project/qemu/-/issues
> Is it broken generated code that faults or does the goto_tb code break
> the execution sequence in some subtle way further down the line?
>
> If you can isolate the guest address the output from:
>
>    -dfilter 0xBADADDR+0x100 -d in_asm,op,out_asm

I tried as suggested above but didn't get much info collected.

I have shared my observation on the gitlab issue page.

https://gitlab.com/qemu-project/qemu/-/issues/1726


Thanks,

Anushree-Mathur

> would be useful for the bug report. Although conceivably the out_asm
> output might make sense at translation time and then be broken when it
> is patched. Having rr on power would be really useful to debug this sort
> of thing.
>
>> Thanks,
>>
>> C.
>>
>>> [qemu]# git bisect good
>>> 20b6643324a79860dcdfe811ffe4a79942bca21e is the first bad commit
>>> commit 20b6643324a79860dcdfe811ffe4a79942bca21e
>>> Author: Richard Henderson <richard.henderson@linaro.org>
>>> Date:   Mon Dec 5 17:45:02 2022 -0600
>>>       tcg/ppc: Reorg goto_tb implementation
>>>       The old ppc64 implementation replaces 2 or 4 insns, which
>>> leaves a race
>>>       condition in which a thread could be stopped at a PC in the middle of
>>>       the sequence, and when restarted does not see the complete address
>>>       computation and branches to nowhere.
>>>       The new implemetation replaces only one insn, swapping between
>>>               b       <dest>
>>>       and
>>>               mtctr   r31
>>>       falling through to a general-case indirect branch.
>>>       Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
>>>       Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>    tcg/ppc/tcg-target.c.inc | 152
>>> +++++++++++++----------------------------------
>>>    tcg/ppc/tcg-target.h     |   3 +-
>>>    2 files changed, 41 insertions(+), 114 deletions(-)
>>> [qemu]#
>>> Can someone please take a look and suggest a fix to resolve this
>>> issue?
>>> Thanks in advance.
>>> Regards,
>>> Anushree-Mathur
>>>
>

