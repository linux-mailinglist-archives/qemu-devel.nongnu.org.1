Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B107C7B2C40
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 08:19:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6qA-0004Za-48; Fri, 29 Sep 2023 02:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qm6q7-0004YX-7V; Fri, 29 Sep 2023 02:19:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qm6q5-0002pE-2A; Fri, 29 Sep 2023 02:19:02 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T6AH7e010493; Fri, 29 Sep 2023 06:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lA65SDORoyXV0b2aovFJKI7lsOnobOOf1ESMxgqiOBU=;
 b=qlUa5KXGAE4thzdl58+B5Nc2Iyk1FDN88KRTvIrZLafA/r0zcgUuf/rwj31c6N2HN+mg
 MU49dEgmhLx3/5uStxeW3yDODegOPBVq+yES7fUxbfvwXHw2y3qLOiqQz840fsSuLw9U
 WBS2cDzji4I/eHhbMvEXRiEyfhlMGYyiw4JNQQp1e434n9Hw4tMk256p1dfucY89WYAN
 Ub6vLq2Ztcp4A7+oh0RIgGFr2JpnsB9hzpTNyh5gFBcQaQbYxFXqUTtYcL/ogL9Oc2qs
 LfY+PXrohZc9hda4tVDZ7muSBci458I4Yof4fPIp82IAs4SKqLXgcJuBWOQnGCDI8bSL Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdrs9gbp0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 06:18:47 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38T6Agnc011792;
 Fri, 29 Sep 2023 06:18:46 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdrs9gbmt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 06:18:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T5qdM9008464; Fri, 29 Sep 2023 06:18:45 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtb0yh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 06:18:45 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38T6IiP71901172
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Sep 2023 06:18:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9370A5805A;
 Fri, 29 Sep 2023 06:18:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9D9715803F;
 Fri, 29 Sep 2023 06:18:40 +0000 (GMT)
Received: from [9.43.35.247] (unknown [9.43.35.247])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Sep 2023 06:18:40 +0000 (GMT)
Message-ID: <1c8225b4-75ba-eba1-be8e-d031a911088e@linux.ibm.com>
Date: Fri, 29 Sep 2023 11:48:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
 <660b5c89-d219-1e20-9fa5-1b7c390a2f1b@linux.ibm.com>
 <e5480b29-a1d0-8d6f-54b7-a8957f568ed9@kaod.org>
 <CAEuJdmqTUOS13mfxVKnMyoeE6vtLAkReohHn31+cz85ZV0s5pA@mail.gmail.com>
 <87v8btk07f.fsf@pond.sub.org> <b78b73c8-b45d-f4b3-b1e8-47171e9d4446@kaod.org>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <b78b73c8-b45d-f4b3-b1e8-47171e9d4446@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dvCY3aW2k8ID-JbYh9XMrXGGOvvnxHvf
X-Proofpoint-ORIG-GUID: 0_uvj9zObm0PkvNP8FSh9SeqhsZMObvi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1011 adultscore=0 mlxlogscore=811 suspectscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290052
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



On 9/29/23 11:37, Cédric Le Goater wrote:
> On 9/29/23 07:39, Markus Armbruster wrote:
>> Harsh Prateek Bora <harsh.prateek.bora@gmail.com> writes:
>>
>>> On Tue, 19 Sept, 2023, 5:39 pm Cédric Le Goater, <clg@kaod.org> wrote:
>>>
>>>> On 9/19/23 10:48, Harsh Prateek Bora wrote:
>>>>>
>>>>>
>>>>> On 9/18/23 20:28, Cédric Le Goater wrote:
>>>>>> Rename 'name' variable to avoid this warning :
>>>>>>
>>>>>>     ../hw/ppc/spapr_drc.c: In function ‘prop_get_fdt’:
>>>>>>     ../hw/ppc/spapr_drc.c:344:21: warning: declaration of ‘name’ 
>>>>>> shadows
>>>> a parameter [-Wshadow=compatible-local]
>>>>>>       344 |         const char *name = NULL;
>>>>>>           |                     ^~~~
>>>>>>     ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
>>>>>>       325 | static void prop_get_fdt(Object *obj, Visitor *v, 
>>>>>> const char
>>>> *name,
>>>>>>           |
>>>> ~~~~~~~~~~~~^~~~
>>>>>>
>>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>>> ---
>>>>>>    hw/ppc/spapr_drc.c | 10 +++++-----
>>>>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>>>>>> index 843e318312d3..2b99d3b4b1a6 100644
>>>>>> --- a/hw/ppc/spapr_drc.c
>>>>>> +++ b/hw/ppc/spapr_drc.c
>>>>>> @@ -341,7 +341,7 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>>>> const char *name,
>>>>>>        fdt_depth = 0;
>>>>>>        do {
>>>>>> -        const char *name = NULL;
>>>>>> +        const char *dt_name = NULL;
>>>>>
>>>>> I guess you wanted to use the input arg "name" here without
>>>> re-declaration.
>>>>
>>>> I don't understand. I don't want to use the input arg "name" here.
>>>> It seems useless in this case.
>>>>
>>>
>>> Yeh, I realize now. This patch can actually remove the unused arg 
>>> "name" as
>>> well?
>>
>> Cédric?
>>
>> Lose ends like this one make me reluctant to queue a series, even when
>> they look minor to me.
> 
> Unfortunately, we can not remove the unused arg "name" from the prototype.
> The routine is a ObjectPropertyAccessor argument of object_property_add().
> 

Hmm, I see ..
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

> Thanks,
> 
> C.
> 
> 
>>
>>>> C.
>>>>
>>>>> I do not see "name" being used elsewhere in this routine.
>>>>>
>>>>> regards,
>>>>> Harsh
>>>>>>            const struct fdt_property *prop = NULL;
>>>>>>            int prop_len = 0, name_len = 0;
>>>>>>            uint32_t tag;
>>>>>> @@ -351,8 +351,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>>>> const char *name,
>>>>>>            switch (tag) {
>>>>>>            case FDT_BEGIN_NODE:
>>>>>>                fdt_depth++;
>>>>>> -            name = fdt_get_name(fdt, fdt_offset, &name_len);
>>>>>> -            if (!visit_start_struct(v, name, NULL, 0, errp)) {
>>>>>> +            dt_name = fdt_get_name(fdt, fdt_offset, &name_len);
>>>>>> +            if (!visit_start_struct(v, dt_name, NULL, 0, errp)) {
>>>>>>                    return;
>>>>>>                }
>>>>>>                break;
>>>>>> @@ -369,8 +369,8 @@ static void prop_get_fdt(Object *obj, Visitor *v,
>>>> const char *name,
>>>>>>            case FDT_PROP: {
>>>>>>                int i;
>>>>>>                prop = fdt_get_property_by_offset(fdt, fdt_offset,
>>>> &prop_len);
>>>>>> -            name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>>>>>> -            if (!visit_start_list(v, name, NULL, 0, errp)) {
>>>>>> +            dt_name = fdt_string(fdt, fdt32_to_cpu(prop->nameoff));
>>>>>> +            if (!visit_start_list(v, dt_name, NULL, 0, errp)) {
>>>>>>                    return;
>>>>>>                }
>>>>>>                for (i = 0; i < prop_len; i++) {
>>
> 

