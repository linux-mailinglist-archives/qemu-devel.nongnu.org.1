Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0080582BAD6
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 06:25:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOA23-0005fb-TL; Fri, 12 Jan 2024 00:24:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rOA21-0005fP-Gv; Fri, 12 Jan 2024 00:24:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1rOA1z-0007Eu-8k; Fri, 12 Jan 2024 00:24:37 -0500
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40C57GvC022491; Fri, 12 Jan 2024 05:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ondc8cGuS3H591oPw+y/GRbmlrTaB7qXEc0B7iOmMxI=;
 b=LMtcU1E6JoVEwLpymYXtkjGZcfdm2hLyM4dqBq/MfdbzB3LjZqbwx8XyPGNV1X/sHsWy
 hoXAK7c57ZBYX2eEycpTCwMc+wmsnhSboPBr8D++4BBtn2zU03JEnYiXaBBexbLd9p7e
 nA4Yt9H+CXeosw4PGP+YFgwhlZ6nFrs3iO0cWe7Ztg+XFCqTUVFhZtzR1nA+m3o637H4
 ua2Xi5thcBAHZ+Xio1yUmjAh9e8eKKpzbjSSGR3bpxSB0a90SSoRPkRCJxIWpYMOn03L
 mSyhmAT44aIW6Mq14zX1GJdOFkCG+XzCtH8LZaZokGmtl+uG3J4+Fc/yEFsNTbFHRzJ6 Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjy0b88ue-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 05:24:15 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40C595w5028440;
 Fri, 12 Jan 2024 05:24:13 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vjy0b88fw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 05:24:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 40C4u6U9027006; Fri, 12 Jan 2024 05:21:31 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vfkw2fp1r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 12 Jan 2024 05:21:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 40C5LU7E23003746
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 05:21:30 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 276F758055;
 Fri, 12 Jan 2024 05:21:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AA37F58043;
 Fri, 12 Jan 2024 05:21:26 +0000 (GMT)
Received: from [9.179.24.49] (unknown [9.179.24.49])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 12 Jan 2024 05:21:26 +0000 (GMT)
Message-ID: <54b6ba59-8edc-4b9c-bd3f-88399127f60e@linux.ibm.com>
Date: Fri, 12 Jan 2024 10:51:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/ppc/cpu-models: Rename power5+ and power7+ for
 new QOM naming rules
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20240111164652.908182-1-thuth@redhat.com>
 <20240111164652.908182-2-thuth@redhat.com>
 <70fae07d-f6c1-4143-b632-a988ae53ccb0@linux.ibm.com>
 <27a311a8-f6db-48ea-8bbd-a09eb3c2e07e@redhat.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <27a311a8-f6db-48ea-8bbd-a09eb3c2e07e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: skICJeDC-wKt_bdyCxNbT-kF1Dj4gWGH
X-Proofpoint-ORIG-GUID: hAXoDY7S7lbtmxwmOGcNCpGcrxBfabpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_02,2024-01-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=970
 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401120038
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 1/12/24 10:42, Thomas Huth wrote:
> On 12/01/2024 05.57, Harsh Prateek Bora wrote:
>>
>>
>> On 1/11/24 22:16, Thomas Huth wrote:
>>> The character "+" is now forbidden in QOM device names (see commit
>>> b447378e1217 - "Limit type names to alphanumerical and some few special
>>> characters"). For the "power5+" and "power7+" CPU names, there is
>>> currently a hack in type_name_is_valid() to still allow them for
>>> compatibility reasons. However, there is a much nicer solution for this:
>>> Simply use aliases! This way we can still support the old names without
>>> the need for the ugly hack in type_name_is_valid().
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   hw/ppc/spapr_cpu_core.c |  4 ++--
>>>   qom/object.c            |  4 ----
>>>   target/ppc/cpu-models.c | 10 ++++++----
>>>   3 files changed, 8 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
>>> index 5aa1ed474a..214b7a03d8 100644
>>> --- a/hw/ppc/spapr_cpu_core.c
>>> +++ b/hw/ppc/spapr_cpu_core.c
>>> @@ -389,9 +389,9 @@ static const TypeInfo spapr_cpu_core_type_infos[] 
>>> = {
>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970_v2.2"),
>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.0"),
>>>       DEFINE_SPAPR_CPU_CORE_TYPE("970mp_v1.1"),
>>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power5+_v2.1"),
>>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power5plus_v2.1"),
>>>       DEFINE_SPAPR_CPU_CORE_TYPE("power7_v2.3"),
>>> -    DEFINE_SPAPR_CPU_CORE_TYPE("power7+_v2.1"),
>>> +    DEFINE_SPAPR_CPU_CORE_TYPE("power7plus_v2.1"),
>>
>> Will using Power5x, Power7x be a better naming than using 'plus' suffix ?
> 
> The "x" looks like a placeholder to me, so it could be confused with 
> power50, power51, power52, etc. ...?
> But actually, I was thinking about using "power5p" and "power7p" first, 
> so if the whole "plus" looks too long for you, would "p" be an option 
> instead?

Hmm .. I would certainly vote for 'p' over 'plus'.

regards,
Harsh
> 
>> Otherwise,
>> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> 
> Thanks!
> 
>   Thomas
> 

