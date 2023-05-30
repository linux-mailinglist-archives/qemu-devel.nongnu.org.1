Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7159C716AFF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 19:30:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43Ab-0002Xs-LA; Tue, 30 May 2023 13:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43AY-0002Xa-ME; Tue, 30 May 2023 13:30:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43AW-0003y8-9o; Tue, 30 May 2023 13:30:02 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UGfjel028804; Tue, 30 May 2023 17:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=XinLNa5ZnaZcb+Q2yxYemxURJHzfL0X/Ma8uyHpdXZQ=;
 b=QGB4rPM/FIk6eDP4YlOR7f+VAUUs1PuhlAn4dXVOZzMOa4IJUA/47+sofgyHLcYO1jDJ
 nx3vnp3/SEbJXWITwXRR5IhlxTCxwWoEQqZPUytSurPSyFRDdmCdtObiGy4oPy0HRvxo
 Cev9Dcy+XMd0RZC1FHQ++JwjBYjwO0VA4V8LTa6PibyLlZza+f2rUWveYvQPR4lSHwX+
 9eSl3eZodGPiQypf2tSTbYEQvqLwxrHZwv4QAdRBuKQip4rgO7JQWaTmiU5lZVaGuTpu
 75HzpMSMdkeCbWkiuubmAmFzbeZrxuhq8F0p/2up7JR0OHRTxNlXv4C211N/Kyl3Z2Eu Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwmf2215q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:29:49 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHMmdX006140;
 Tue, 30 May 2023 17:29:48 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwmf22159-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:29:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U20u2m016148;
 Tue, 30 May 2023 17:29:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1kp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 17:29:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UHTinS10289786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 17:29:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F66320043;
 Tue, 30 May 2023 17:29:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C444420040;
 Tue, 30 May 2023 17:29:43 +0000 (GMT)
Received: from [9.171.3.249] (unknown [9.171.3.249])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 17:29:43 +0000 (GMT)
Message-ID: <9a7932b6-38f0-1bd5-633c-643cda0433c8@linux.ibm.com>
Date: Tue, 30 May 2023 19:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/4] pnv/xive2: Handle TIMA access through all ports
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-5-fbarrat@linux.ibm.com>
 <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <be9a5a3a-a46a-6317-dd2b-cd442f019158@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NmMNqBLrXI4x_6uUTGrrTdh0vAg-zJBW
X-Proofpoint-ORIG-GUID: 67qqk6AQwTx-dineVF_BnJIaq6x8mwdc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_12,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=fbarrat@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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



On 30/05/2023 18:40, Cédric Le Goater wrote:
> On 5/30/23 18:11, Frederic Barrat wrote:
>> The Thread Interrupt Management Area (TIMA) can be accessed through 4
>> ports/snoop buses, targeted by the address. The base address of a TIMA
>> is using port 0 and the other ports are 0x80 apart. Using one port or
>> another can be useful to balance the load on the snoop buses.
> 
> and can we have some nice examples of how these ports are used ? only for
> snooping or also for balancing operations ? which ones ?


This is really "static" balancing. The snoop bus 0 and 3 are known to be 
the busiest, for various kind of operations. We found out recently that 
another hypervisor is always using snoop bus 1 for TIMA accesses, to 
spread the load. So it is really empirical.

xive_tm_raw_write/read() were actually working (by chance?), since they 
only retain the least significant bits, so the snoop address bits were 
dropped. The problem was really for the special op detection, which 
matches on the full address.

   Fred


>> The TIMA registers are in the 0x0 -> 0x3F range and there are 2
>> indication bits for special operations (bits 10 and 11; everything
>> fits on a 4k page). So the port address bits fall in between and are
>> "don't care" for the hardware when processing the TIMA operation. So
>> this patch filters out those port address bits so that a TIMA
>> operation can be triggered using any port.
>>
>> It is also true for indirect access (through the IC BAR) and it's
>> actually nothing new, it was already the case on P9. Which helps here,
>> as the TIMA handling code is common between P9 (xive) and P10 (xive2).
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> Thanks,
> 
> C.
> 
>> ---
>>   hw/intc/pnv_xive2.c |  4 ++++
>>   hw/intc/xive.c      | 18 ++++++++++++++++++
>>   2 files changed, 22 insertions(+)
>>
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index 132f82a035..c80316657a 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -1662,6 +1662,8 @@ static void pnv_xive2_tm_write(void *opaque, 
>> hwaddr offset,
>>       bool gen1_tima_os =
>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>> +    offset &= 0xC3F; /* See comment in xive_tctx_tm_write() */
>> +
>>       /* TODO: should we switch the TM ops table instead ? */
>>       if (!gen1_tima_os && offset == HV_PUSH_OS_CTX_OFFSET) {
>>           xive2_tm_push_os_ctx(xptr, tctx, offset, value, size);
>> @@ -1681,6 +1683,8 @@ static uint64_t pnv_xive2_tm_read(void *opaque, 
>> hwaddr offset, unsigned size)
>>       bool gen1_tima_os =
>>           xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS;
>> +    offset &= 0xC3F; /* See comment in xive_tctx_tm_read() */
>> +
>>       /* TODO: should we switch the TM ops table instead ? */
>>       if (!gen1_tima_os && offset == HV_PULL_OS_CTX_OFFSET) {
>>           return xive2_tm_pull_os_ctx(xptr, tctx, offset, size);
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index a986b96843..c1abfae31d 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -527,6 +527,15 @@ void xive_tctx_tm_write(XivePresenter *xptr, 
>> XiveTCTX *tctx, hwaddr offset,
>>       trace_xive_tctx_tm_write(offset, size, value);
>> +    /*
>> +     * The TIMA can be accessed through 4 ports/snoop buses, with
>> +     * addresses 0x80 apart.
>> +     * However, the offset bits between the "special op" bits and the
>> +     * MSB of the range used for the TIMA registers are "don't care"
>> +     * for the hardware, so we filter them out.
>> +     */
>> +    offset &= 0xC3F;
>> +
>>       /*
>>        * TODO: check V bit in Q[0-3]W2
>>        */
>> @@ -566,6 +575,15 @@ uint64_t xive_tctx_tm_read(XivePresenter *xptr, 
>> XiveTCTX *tctx, hwaddr offset,
>>       const XiveTmOp *xto;
>>       uint64_t ret;
>> +    /*
>> +     * The TIMA can be accessed through 4 ports/snoop buses, with
>> +     * addresses 0x80 apart.
>> +     * However, the offset bits between the "special op" bits and the
>> +     * MSB of the range used for the TIMA registers are "don't care"
>> +     * for the hardware, so we filter them out.
>> +     */
>> +    offset &= 0xC3F;
>> +
>>       /*
>>        * TODO: check V bit in Q[0-3]W2
>>        */
> 

