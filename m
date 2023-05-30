Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1090B716BD7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 20:03:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q43fl-00076x-8d; Tue, 30 May 2023 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43fY-0006T5-3W; Tue, 30 May 2023 14:02:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1q43fV-0002wx-P4; Tue, 30 May 2023 14:02:03 -0400
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34UHi2SB022403; Tue, 30 May 2023 18:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Wh+kMu8EQJoWKxAj5cFYK6VZ696NKs3phTijltqshTc=;
 b=D+RDTqQlJDejaB5K9I1lPsjTuFCWUQrZVkZqHm42iNMhS6DWSW1vdMpNazphascaFnVm
 OVBaGbymhmoQfIBQU9Xz+JFmnq1xoLY8ZJE3kzVkAwBVdOxE0/P/rVkG2N4f5VbuUqez
 vfCkbkrC5yJUZk24RqLBfauX11DeFYt0jgqPVwr1x8SlEQSagSJ77UGa79F0VeuVXl5i
 wX6R4DcYK7lo3DG+r3+5/0Y+S3nJrirtdtS3rxP6/S4vVQtIqdWcZa732FvjUHqV/VIl
 nxzY1ZiOcuI2/IgdsYnPiVwHQsu0+jYAzsTLrzkdqS5a2CmXhcn7UAZ+nefuA8yEr4vA Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwn3wsau0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 18:01:52 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UHiEax023497;
 Tue, 30 May 2023 18:01:51 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.102])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwn3wsate-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 18:01:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
 by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34TLXZwo001143;
 Tue, 30 May 2023 18:01:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1m0e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 18:01:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 34UI1lDS61997500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 May 2023 18:01:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D67F20043;
 Tue, 30 May 2023 18:01:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2791620040;
 Tue, 30 May 2023 18:01:47 +0000 (GMT)
Received: from [9.171.3.249] (unknown [9.171.3.249])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 May 2023 18:01:47 +0000 (GMT)
Message-ID: <bb54d3e2-3956-0e02-66aa-207734abb83f@linux.ibm.com>
Date: Tue, 30 May 2023 20:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] pnv/xive2: Add definition for TCTXT Config register
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230530161129.313258-1-fbarrat@linux.ibm.com>
 <20230530161129.313258-2-fbarrat@linux.ibm.com>
 <c46dd69a-4f7f-ac7c-67fc-2aad07e4c1ab@kaod.org>
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <c46dd69a-4f7f-ac7c-67fc-2aad07e4c1ab@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8UYUB-vsg_4Fnocu20q8OTq22JyCfrPR
X-Proofpoint-GUID: Kn1wCgOhpq53he06kMHSjhdAZaELN_Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300140
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



On 30/05/2023 18:31, Cédric Le Goater wrote:
> On 5/30/23 18:11, Frederic Barrat wrote:
>> Add basic read/write support for the TCTXT Config register on P10. qemu
>> doesn't do anything with it yet, but it avoids logging a guest error
>> when skiboot configures the fused-core state:
>>
>> qemu-system-ppc64 -machine powernv10 ... -d guest_errors
>>    ...
>> [    0.131670000,5] XIVE: [ IC 00  ] Initializing XIVE block ID 0...
>> XIVE[0] - TCTXT: invalid read @140
>> XIVE[0] - TCTXT: invalid write @140
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> 
> If you respin, please add the same kind of support to POWER9.


It's already in place for read and write:

static void pnv_xive_ic_reg_write()
...
       case PC_TCTXT_CFG:


Skiboot is using it and we don't get an error message, even with 
guest_errors. So it looks good.

  Fred


> 
> Thanks,
> 
> C.
> 
> 
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> ---
>>   hw/intc/pnv_xive2.c      | 8 +++++++-
>>   hw/intc/pnv_xive2_regs.h | 4 ++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index 7176d70234..889e409929 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -1265,6 +1265,9 @@ static uint64_t pnv_xive2_ic_tctxt_read(void 
>> *opaque, hwaddr offset,
>>       case TCTXT_EN1_RESET:
>>           val = xive->tctxt_regs[TCTXT_EN1 >> 3];
>>           break;
>> +    case TCTXT_CFG:
>> +        val = xive->tctxt_regs[reg];
>> +        break;
>>       default:
>>           xive2_error(xive, "TCTXT: invalid read @%"HWADDR_PRIx, offset);
>>       }
>> @@ -1276,6 +1279,7 @@ static void pnv_xive2_ic_tctxt_write(void 
>> *opaque, hwaddr offset,
>>                                        uint64_t val, unsigned size)
>>   {
>>       PnvXive2 *xive = PNV_XIVE2(opaque);
>> +    uint32_t reg = offset >> 3;
>>       switch (offset) {
>>       /*
>> @@ -1297,7 +1301,9 @@ static void pnv_xive2_ic_tctxt_write(void 
>> *opaque, hwaddr offset,
>>       case TCTXT_EN1_RESET:
>>           xive->tctxt_regs[TCTXT_EN1 >> 3] &= ~val;
>>           break;
>> -
>> +    case TCTXT_CFG:
>> +        xive->tctxt_regs[reg] = val;
>> +        break;
>>       default:
>>           xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, 
>> offset);
>>           return;
>> diff --git a/hw/intc/pnv_xive2_regs.h b/hw/intc/pnv_xive2_regs.h
>> index 0c096e4adb..8f1e0a1fde 100644
>> --- a/hw/intc/pnv_xive2_regs.h
>> +++ b/hw/intc/pnv_xive2_regs.h
>> @@ -405,6 +405,10 @@
>>   #define X_TCTXT_EN1_RESET                       0x307
>>   #define TCTXT_EN1_RESET                         0x038
>> +/* TCTXT Config register */
>> +#define X_TCTXT_CFG                             0x328
>> +#define TCTXT_CFG                               0x140
>> +
>>   /*
>>    * VSD Tables
>>    */
> 

