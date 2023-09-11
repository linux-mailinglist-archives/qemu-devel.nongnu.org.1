Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF979A373
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:23:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfaJK-0000mp-16; Mon, 11 Sep 2023 02:22:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfaJ6-0000lx-Cn; Mon, 11 Sep 2023 02:22:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qfaJ2-00011S-OH; Mon, 11 Sep 2023 02:22:00 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B5chd0015831; Mon, 11 Sep 2023 06:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cxeHIe2CQibCwsuOLWjBeavD7t1rLpaQooKE/6PzEGk=;
 b=qC/wBJUr65IlFjJJQoddHwDryc/QLNXh/hmL9zXi8rr03MD87a1GKFexcTcyGgCjBkHl
 f7dlboejmNSe0QHBkanWit/2hyBQQwamOVo+PUQdlcd71Iyjr1xV7QNl8DK+0W7E07Mq
 X2xEOGD8PYDigVyp0NaTBExV7A/1lkU8eEXXKYF3Y/NqDUwoA6Np3PnqoTut7P/YKVCN
 3SCu3bo7GzUIoURTtxa3oRHYRx6378hM4eh89CH4g6jiV1hmM1UZ/bdDgj8fHGqOsPFu
 qxhC0BfZTuxFRpQ279qNihh71+x5mMibkvNYK8dtxiQPMTF2OmCIeYHSYa+LiU6++TsM QA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1uy225vq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:21:42 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B5wSMS013809;
 Mon, 11 Sep 2023 06:21:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1uy225vf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:21:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38B4AL8S012064; Mon, 11 Sep 2023 06:21:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dy8jpp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Sep 2023 06:21:40 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38B6Ld7q1376918
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Sep 2023 06:21:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AA3358052;
 Mon, 11 Sep 2023 06:21:39 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E0AC58050;
 Mon, 11 Sep 2023 06:21:35 +0000 (GMT)
Received: from [9.195.37.7] (unknown [9.195.37.7])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 Sep 2023 06:21:34 +0000 (GMT)
Message-ID: <ebb367d9-5941-c4bc-f2e0-8bae039ea97f@linux.ibm.com>
Date: Mon, 11 Sep 2023 11:51:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH RESEND 01/15] ppc: spapr: Introduce Nested PAPR API
 related macros
To: Nicholas Piggin <npiggin@gmail.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, mikey@neuling.org, vaibhav@linux.ibm.com,
 jniethe5@gmail.com, sbhat@linux.ibm.com, kconsul@linux.vnet.ibm.com
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-2-harshpb@linux.ibm.com>
 <CVC8IO1HGU4Y.1RDSLZSOCVFN9@wheely>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CVC8IO1HGU4Y.1RDSLZSOCVFN9@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jqUXvsFRU2r-5H6FV4XdIqaECQZD5hzw
X-Proofpoint-ORIG-GUID: EbZnbXHjYYXVnB0f7s7CUkHbCcVkfYg1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110054
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 9/7/23 05:18, Nicholas Piggin wrote:
> On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
>> Adding new macros for the new hypercall op-codes, their return codes,
>> Guest State Buffer (GSB) element IDs and few registers which shall be
>> used in following patches to support Nested PAPR API.
>>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   include/hw/ppc/spapr.h        |  23 ++++-
>>   include/hw/ppc/spapr_nested.h | 186 ++++++++++++++++++++++++++++++++++
>>   target/ppc/cpu.h              |   2 +
>>   3 files changed, 209 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index 538b2dfb89..3990fed1d9 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -367,6 +367,16 @@ struct SpaprMachineState {
>>   #define H_NOOP            -63
>>   #define H_UNSUPPORTED     -67
>>   #define H_OVERLAP         -68
>> +#define H_STATE           -75
> 
> [snip]
> 
> I didn't go through to make sure all the numbers are correct, but
> generally looks okay. Are these just copied from KVM sources (or
> vice versa)?

I have mostly referred PAPR spec for the numbers. I hope KVM sources 
follows the same.

> 
>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
>> index 25fac9577a..6f7f9b9d58 100644
>> --- a/target/ppc/cpu.h
>> +++ b/target/ppc/cpu.h
>> @@ -1587,9 +1587,11 @@ void ppc_compat_add_property(Object *obj, const char *name,
>>   #define SPR_PSPB              (0x09F)
>>   #define SPR_DPDES             (0x0B0)
>>   #define SPR_DAWR0             (0x0B4)
>> +#define SPR_DAWR1             (0x0B5)
>>   #define SPR_RPR               (0x0BA)
>>   #define SPR_CIABR             (0x0BB)
>>   #define SPR_DAWRX0            (0x0BC)
>> +#define SPR_DAWRX1            (0x0BD)
>>   #define SPR_HFSCR             (0x0BE)
>>   #define SPR_VRSAVE            (0x100)
>>   #define SPR_USPRG0            (0x100)
> 
> Stray change? Should be in 2nd DAWR patch, presumably.

This was introduced here following the PAPR ACR spec for nested API 
initially to support GSB get/set requests. However, I can update the 
patch once the 2nd DAWR patch gets merged.

Thanks for reviewing the series.

regards,
Harsh

> 
> Thanks,
> Nick

