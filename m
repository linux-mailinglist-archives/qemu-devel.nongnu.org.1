Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E39B573DD6C
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDkLt-0002r7-HC; Mon, 26 Jun 2023 07:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qDkLq-0002qD-VC; Mon, 26 Jun 2023 07:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fbarrat@linux.ibm.com>)
 id 1qDkLo-0003vD-CF; Mon, 26 Jun 2023 07:25:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QBGPWK012433; Mon, 26 Jun 2023 11:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4UC+0kCIY7O3VKmo7/CzrL8jrjSmy+xIlVws0grDQYQ=;
 b=SH2OUJl2zs3U9i/vGMBt6l4u5wFInt09N3LdFo9aJUWuHVX+ma6qUcTGmnPB6ZLwX4Ft
 uv86xyVv8+6MjHhFOLAKvf/wMsGKbkuKGZmrASm/eqC2luCg7ptKYHeeW7DdiK3mMW1F
 3ZJt6vnk7fFUwBTdKQ7EMva+4KvZtgcQUV1EOLvaXUmf7TeQCy/2u25rB9aEefK/JM3z
 g4T1wJ551KHzleLJ4NhZnDd1EbhWSOTWK555CrM9FNn6PPhVfKQAUGCdE8bkHnXvmLj/
 L+7YAG9uMih3VSbwN9cWaTxzZbdbIFH9xtVbwoNwyHfL8WVIDTBZhseeAG5yi70LkkLc 5A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf9nhr6cb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 11:25:38 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35QBGrtq014444;
 Mon, 26 Jun 2023 11:25:37 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com
 [149.81.74.107])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rf9nhr6bq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 11:25:37 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
 by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35Q7uvXY032598;
 Mon, 26 Jun 2023 11:25:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3rdr450vmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Jun 2023 11:25:34 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35QBPWdl21693142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 11:25:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9909520043;
 Mon, 26 Jun 2023 11:25:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 19EFB20040;
 Mon, 26 Jun 2023 11:25:32 +0000 (GMT)
Received: from [9.171.45.146] (unknown [9.171.45.146])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Jun 2023 11:25:31 +0000 (GMT)
Message-ID: <e808c49d-2ea0-6773-a524-1b5939fec90a@linux.ibm.com>
Date: Mon, 26 Jun 2023 13:25:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] pnv/xive2: Allow indirect TIMA accesses of all sizes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>, clg@kaod.org, 
 danielhb413@gmail.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com
References: <20230626094057.1192473-1-fbarrat@linux.ibm.com>
 <b7a68894-c992-3845-754c-1fdf655ad3fe@linaro.org>
Content-Language: en-US
From: Frederic Barrat <fbarrat@linux.ibm.com>
In-Reply-To: <b7a68894-c992-3845-754c-1fdf655ad3fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gbSXzDoz_CvBPYMJzUuG0deLxAlwCQRX
X-Proofpoint-GUID: ZpRvR_En4HxD_3rkTyuQonYFudAa544t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_07,2023-06-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=917 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306260100
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



On 26/06/2023 11:48, Philippe Mathieu-Daudé wrote:
> On 26/6/23 11:40, Frederic Barrat wrote:
>> Booting linux on the powernv10 machine logs a few errors like:
>>
>> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>> reason: invalid size (min:8 max:8)
>> Invalid write at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>> reason: invalid size (min:8 max:8)
>> Invalid read at addr 0x38, size 1, region 'xive-ic-tm-indirect', 
>> reason: invalid size (min:8 max:8)
>>
>> Those errors happen when linux is resetting XIVE. We're trying to
>> read/write the enablement bit for the hardware context and qemu
>> doesn't allow indirect TIMA accesses of less than 8 bytes. Direct TIMA
>> access can go through though, as well as indirect TIMA accesses on P9.
>> So even though there are some restrictions regarding the address/size
>> combinations for TIMA access, the example above is perfectly valid.
>>
>> This patch lets indirect TIMA accesses of all sizes go through. The
>> special operations will be intercepted and the default "raw" handlers
>> will pick up all other requests and complain about invalid sizes as
>> appropriate.
>>
>> Tested-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
>> ---
>>   hw/intc/pnv_xive2.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
>> index ed438a20ed..e8ab176de6 100644
>> --- a/hw/intc/pnv_xive2.c
>> +++ b/hw/intc/pnv_xive2.c
>> @@ -1644,11 +1644,11 @@ static const MemoryRegionOps 
>> pnv_xive2_ic_tm_indirect_ops = {
>>       .write = pnv_xive2_ic_tm_indirect_write,
>>       .endianness = DEVICE_BIG_ENDIAN,
>>       .valid = {
>> -        .min_access_size = 8,
>> +        .min_access_size = 1,
> 
> Maybe. Is there a bus involved in between?
> 
> What about other I/O regions?


XIVE is attached to the main system bus and the CPU can trigger 1, 2, 4 
and 8-byte accesses. The TIMA is a part of XIVE which supports various 
size of mmio operations, all the way down to byte operations. It 
actually relies on it.

There are 2 memory regions where we want to allow byte-access. One, 
known as TIMA direct access, already allows access with min size = 1. 
I'm just aligning the other one, known as TIMA indirect access, to do 
the same, since it's what the hardware allows.
This is similar to what we had on P9 and both regions are already 
defined with min size = 1 there. So it really looks like what I'm 
changing here was just an oversight.


>>           .max_access_size = 8,
>>       },
>>       .impl = {
>> -        .min_access_size = 8,
>> +        .min_access_size = 1,
> 
> Unlikely. This is for the handler implementation, not related to HW.


The handlers for the TIMA regions are aware of the size of the access, 
and behave differently based on it (see xive_tm_find_op() for example). 
So I think this is correct. Let me know if I'm missing something here.

   Fred



>>           .max_access_size = 8,
>>       },
>>   };
> 

