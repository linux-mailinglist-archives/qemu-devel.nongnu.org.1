Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17522736EB3
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 16:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcOB-0001VF-O9; Tue, 20 Jun 2023 10:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBcO8-0001St-CB; Tue, 20 Jun 2023 10:31:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qBcO5-00054n-RX; Tue, 20 Jun 2023 10:31:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35KEEFBQ002711; Tue, 20 Jun 2023 14:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=TeFuEQvaUC+D2rEdn7AMITJyJP6mr516clm6/SeWh3U=;
 b=iLU55ao4qOBmSs4GiuwFCy+dNQBF7DYG+OOPK2dlOCxiVjhSvJLuL3jXDG9bm7lCOFH6
 O2IHIgWH2sR7DuzpR6xlsrYUhPSltoGJJklCi9CWzI1dJCnBJDCiH1pgg7NQEWxOjaSC
 yL1B8DeLrkQC1XwwgKjigYADAYlSuk9WuzZ0ZfW6a8GownyIiJm9KqtI6l0KV1z2Llc1
 hpbxyxOoqUZEPIos90NW86IbWH1vhA7qzc4CCvru8SbIg0gs5lNCxmwMftTCIvmg8zOc
 7s2FS99yGexa2t69JIeLOQosjHWrSoJK1ggN2Ix/QnPnEcCh/Ju0sKrAkdIJiBfbXKd2 uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbdpq8hg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 14:31:13 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35KEEWCt003554;
 Tue, 20 Jun 2023 14:31:12 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbdpq8hev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 14:31:12 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35K2R8Ra027827;
 Tue, 20 Jun 2023 14:31:10 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5248v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 20 Jun 2023 14:31:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35KEV7Rv31588646
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 Jun 2023 14:31:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C29C12004E;
 Tue, 20 Jun 2023 14:31:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7BEAD20040;
 Tue, 20 Jun 2023 14:31:07 +0000 (GMT)
Received: from [9.101.4.34] (unknown [9.101.4.34])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 20 Jun 2023 14:31:07 +0000 (GMT)
Message-ID: <9f71ffc4-2b37-d8b8-56c6-658d264242c4@linux.ibm.com>
Date: Tue, 20 Jun 2023 16:31:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PULL 05/29] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org
References: <20230610133132.290703-1-danielhb413@gmail.com>
 <20230610133132.290703-6-danielhb413@gmail.com>
 <CAFEAcA_KKSc=Ns9n1UJKdnhZ846EGK-nFbsG_e2mw_zwMoOJcw@mail.gmail.com>
 <4ad1a081-bf98-1b7d-05c9-82c230da34ce@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <4ad1a081-bf98-1b7d-05c9-82c230da34ce@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rkVhVBVbmELP8bwDlJll0c6Uv8QPipFl
X-Proofpoint-ORIG-GUID: 02ViZBRxSKo9rRK7b-8nmUlpdxKeQtqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_10,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=931 clxscore=1011
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200127
Received-SPF: pass client-ip=148.163.158.5; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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



On 20/06/2023 13:20, Cédric Le Goater wrote:
> On 6/20/23 12:45, Peter Maydell wrote:
>> On Sat, 10 Jun 2023 at 14:31, Daniel Henrique Barboza
>> <danielhb413@gmail.com> wrote:
>>>
>>> From: Frederic Barrat <fbarrat@linux.ibm.com>
>>>
>>> The Thread Interrupt Management Area (TIMA) can be accessed through 4
>>> ports, targeted by the address. The base address of a TIMA
>>> is using port 0 and the other ports are 0x80 apart. Using one port or
>>> another can be useful to balance the load on the snoop buses. With
>>> skiboot and linux, we currently use port 0, but as it tends to be
>>> busy, another hypervisor is using port 1 for TIMA access.
>>>
>>> The port address bits fall in between the special op indication
>>> bits (the 2 MSBs) and the register offset bits (the 6 LSBs). They are
>>> "don't care" for the hardware when processing a TIMA operation. This
>>> patch filters out those port address bits so that a TIMA operation can
>>> be triggered using any port.
>>>
>>> It is also true for indirect access (through the IC BAR) and it's
>>> actually nothing new, it was already the case on P9. Which helps here,
>>> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>> Message-Id: <20230601121331.487207-6-fbarrat@linux.ibm.com>
>>> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
>>> ---
>>
>> Hi -- Coverity points out that there's a problem with this
>> change (CID 1512997, 1512998):
>>
>>> --- a/hw/intc/pnv_xive2.c
>>> +++ b/hw/intc/pnv_xive2.c
>>> @@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, 
>>> hwaddr offset,
>>>       bool gen1_tima_os =
>>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>>>
>>> +    offset &= TM_ADDRESS_MASK;
>>
>> Here we now mask off most of the bytes of 'offset',
>> because TM_ADDRESS_MASK is 0xC3F...
>>
>>> +
>>>       /* TODO: should we switch the TM ops table instead ? */
>>>       if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
>>
>> ...but here we compare offset against HV_PUSH_OS_CTX_OFFSET,
>> which is defined as
>> #define HV_PUSH_OS_CTX_OFFSET  (HV_PAGE_OFFSET | (TM_QW1_OS + TM_WORD2))
>> and since
>> #define HV_PAGE_OFFSET         (XIVE_TM_HV_PAGE << TM_SHIFT)
>> #define XIVE_TM_HV_PAGE         0x1
>> #define TM_SHIFT                16
>>
>> that means HV_PUSH_OS_CTX_OFFSET has bits defined in the
>> upper 16 bits, and the comparison can now never be true,
>> making the if() dead code.
>>
>>>           xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
>>> @@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, 
>>> hwaddr offset, unsigned size)
>>>       bool gen1_tima_os =
>>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>>>
>>> +    offset &= TM_ADDRESS_MASK;
>>> +
>>>       /* TODO: should we switch the TM ops table instead ? */
>>>       if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
>>>           return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
>>
>> Similarly here.
> 
> 
> yes. I think this went unnoticed because the push/pull os context
> commands are only used by the HV when a vCPU is dipatched on a HW
> thread. We would need a test for a KVM guest running under the QEMU
> PowerNV POWER10 machine. This requires an image with some tuning
> because emulation is a bit slow. I use to have a buildroot image
> including a qemu and smaller buildroot image for it.


Working on a fix. It's true that I hadn't run a guest within the powernv 
machine for quite a while. I'm dusting off my buildroot repo to test it 
this time...

   Fred


> 
> So, offset is within the full TIMA region (4 pages) and
> TM_ADDRESS_MASK is a mask within a page. This needs a fix.
> 
> Thanks,
> 
> C.
> 

