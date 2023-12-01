Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723C380030E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 06:36:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8wBL-0001DM-Tj; Fri, 01 Dec 2023 00:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r8wBG-0001CN-Tu; Fri, 01 Dec 2023 00:35:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1r8wBF-0006Xx-6E; Fri, 01 Dec 2023 00:35:14 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B15Ppjc027312; Fri, 1 Dec 2023 05:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=tstBnKcG5D59d6UjYBqGuOCinYOCAcz8WnkJxejjwG8=;
 b=rRzxcn5gZdWZUMeuCyDPBXF3f47Q8wpQhiUXJSnimUNfzYibRgjTsP/Y8J1ul1l1QcEz
 qqxPnMculURryzNL3m/b1L806ybZ2wJV3v/GCEPRr4g7FNwjomPmPnN3iwZ7JKOFp7hq
 8+J1lpIPZ3zHpcwkFWrVHOBGhcqQiJLC8z51w1dWSUk/ORDB1QE+1tYuLoFxHxDyuqZ9
 mxa2WDLO0hYDZJVlNBP0n1OoD2JUC2EYZSOtohRF1SwshrdFiga5YaSzuqxO/7pL05PJ
 tvRaSdQbZ3j6YvmfgL72pM9dZdQDdo9dALYr3otMmq5YxBMGMD5CihU7H2yyJMdoM8vQ DA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq9b2g5jr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 05:35:07 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B15QciY028659;
 Fri, 1 Dec 2023 05:35:07 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uq9b2g5jf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 05:35:07 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B12JTst015443; Fri, 1 Dec 2023 05:35:06 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ukwy2am3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 01 Dec 2023 05:35:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 3B15Z59666126134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 1 Dec 2023 05:35:05 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 864AE58064;
 Fri,  1 Dec 2023 05:35:05 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D2A45805A;
 Fri,  1 Dec 2023 05:35:01 +0000 (GMT)
Received: from [9.43.126.227] (unknown [9.43.126.227])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  1 Dec 2023 05:35:00 +0000 (GMT)
Message-ID: <94412d60-6026-8225-19fb-7801c6e18303@linux.ibm.com>
Date: Fri, 1 Dec 2023 11:04:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 04/14] spapr: nested: Introduce cap-nested-papr for
 Nested PAPR API
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: clegoate@redhat.com, qemu-devel@nongnu.org, mikey@neuling.org,
 vaibhav@linux.ibm.com, jniethe5@gmail.com, sbhat@linux.ibm.com,
 kconsul@linux.vnet.ibm.com, danielhb413@gmail.com
References: <20231012104951.194876-1-harshpb@linux.ibm.com>
 <20231012104951.194876-5-harshpb@linux.ibm.com>
 <CXAZVME5KCFG.32WTQX49G8W7B@wheely>
 <614cb3f5-454a-c83b-47b1-a0387a8aa187@linux.ibm.com>
 <CXC3NJMX3IHH.LY7HE54F29I@wheely>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <CXC3NJMX3IHH.LY7HE54F29I@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DsK6dEPWchso5_j2XEHk702_om5bylgk
X-Proofpoint-ORIG-GUID: G6tn4tP0EIClJ3cFQIwZfBg8ppwoXssJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_03,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0
 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=726
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312010031
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.177,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 11/30/23 16:41, Nicholas Piggin wrote:
> On Thu Nov 30, 2023 at 4:19 PM AEST, Harsh Prateek Bora wrote:
>>
>>
>> On 11/29/23 09:31, Nicholas Piggin wrote:
>>> On Thu Oct 12, 2023 at 8:49 PM AEST, Harsh Prateek Bora wrote:
>>>> Introduce a SPAPR capability cap-nested-papr which provides a nested
>>>> HV facility to the guest. This is similar to cap-nested-hv, but uses
>>>> a different (incompatible) API and so they are mutually exclusive.
>>>> This new API is to enable support for KVM on PowerVM and recently the
>>>> Linux kernel side patches have been accepted upstream as well [1].
>>>> Support for related hcalls is being added in next set of patches.
>>>
>>> We do want to be able to support both APIs on a per-guest basis. It
>>> doesn't look like the vmstate bits will be a problem, both could be
>>> enabled if the logic permitted it and that wouldn't cause a
>>> compatibility problem I think?
>>>
>>
>> I am not sure if it makes sense to have both APIs working in parallel
>> for a nested guest.
> 
> Not for the nested guest, but for the nested KVM host (i.e., the direct
> pseries guest running QEMU). QEMU doesn't know ahead of time which API
> might be used by the OS.
> 
>> Former uses h_enter_guest and expects L1 to store
>> most of the regs, and has no concept like GSB where the communication
>> between L1 and L0 takes place in a standard format which is used at
>> nested guest exit also. Here, we have separate APIs for guest/vcpu
>> create and then do a run_vcpu for a specific vcpu. So, we cant really
>> use both APIs interchangeably while running a nested guest. BTW, L1
>> kernel uses only either of the APIs at a time, preferably this one if
>> supported.
> 
> Yeah not on the same guest. And it's less about running two different
> APIs on different guests with the same L1 simultaneously (although we
> could probably change KVM to support that fairly easily, and we might
> want to for testing purposes), but more about compatibility. What if
> we boot or exec into an old kernel that doesn't support the new API?

Hmm, ok, that's a possible use case, will drop the mutual exclusion in v3.

regards,
Harsh

>>
>>> And it's a bit of a nitpick, but the capability should not be permitted
>>> before the actual APIs are supported IMO. You could split this into
>>> adding .api first, so the implementation can test it, and add the spapr
>>> caps at the end.
>>>
>>
>> Agree, I shall update as suggested.
> 
> Thanks,
> Nick

