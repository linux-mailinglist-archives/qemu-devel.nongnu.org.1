Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 436DC7B2BED
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 07:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm6IR-0008PD-LB; Fri, 29 Sep 2023 01:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qm6IN-0008OZ-5H; Fri, 29 Sep 2023 01:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1qm6IB-0003dG-LJ; Fri, 29 Sep 2023 01:44:09 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T5giUx022302; Fri, 29 Sep 2023 05:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lv4CU1cob6wch5Z4iNCsADlTBsmPdSqM6xUXQD+JtAs=;
 b=Dtno8uOU3Vyc3RyZaU9oe64ml0Y6WxJX+xSt57iEEwFja8hRWBj+MYJuUUIyCqOwfU7z
 PHr0fy6F00CRcrXf3SgbD+WzgDq8uMvcOnd6OKL8msRPnXL4JlRzfc6KEVDfaKrGOYiH
 BXLIQaM2efxoKyXjZvzetqshSTdVyxJK+P7ABsZ4xabB8XwDa7WtpzS9r6g6xGwj8eHi
 McEQHWLNj6QyIMDUaovNBMzQRGRB/pyB6PIvthAObzzrtpWC3Mdf0Zmohrn6Wp5hlfXj
 uNXGuMMJArMNKTtFZ/nVCHwGmbu8X3zwwLY5XsyvgtVdJmJ6XPmHgURzS50awEfdO7G+ 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdrnxr0sa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 05:43:44 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38T5hARG024659;
 Fri, 29 Sep 2023 05:43:43 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdrnxr0ry-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 05:43:43 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38T5XnTY008399; Fri, 29 Sep 2023 05:43:42 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtau8y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 29 Sep 2023 05:43:42 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38T5hgGe37421708
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Sep 2023 05:43:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4C558056;
 Fri, 29 Sep 2023 05:43:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A57255803F;
 Fri, 29 Sep 2023 05:43:38 +0000 (GMT)
Received: from [9.43.35.247] (unknown [9.43.35.247])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 29 Sep 2023 05:43:38 +0000 (GMT)
Message-ID: <beedf872-8aca-1584-20a4-29ccd3276cd4@linux.ibm.com>
Date: Fri, 29 Sep 2023 11:13:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 6/8] spapr/drc: Clean up local variable shadowing in
 rtas_ibm_configure_connector()
To: Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harsh.prateek.bora@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-7-clg@kaod.org>
 <9e061471-931c-daf8-ab8f-567ce99f5057@linux.ibm.com>
 <0f407c08-fb59-4a41-e134-4f184b5ec758@kaod.org>
 <CAEuJdmqPg2TnOBE2q3c+FaP5y9g+fwk=9SG+_u17J8d=5mgp+w@mail.gmail.com>
 <87zg15k0f7.fsf@pond.sub.org>
Content-Language: en-US
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87zg15k0f7.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: v6XG5qCyO1XN1bgq2QZHaF7A5i8g1Q6X
X-Proofpoint-GUID: FWXT7zmd13Aef-5y87HsJS3QAqOLr1yF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=858 priorityscore=1501 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290047
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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



On 9/29/23 11:04, Markus Armbruster wrote:
> Harsh Prateek Bora <harsh.prateek.bora@gmail.com> writes:
> 
>> On Tue, 19 Sept, 2023, 5:33 pm Cédric Le Goater, <clg@kaod.org> wrote:
>>
>>> On 9/19/23 10:29, Harsh Prateek Bora wrote:
>>>>
>>>>
>>>> On 9/18/23 20:28, Cédric Le Goater wrote:
>>>>> Remove extra 'drc_index' variable to avoid this warning :
>>>>>
>>>>>     ../hw/ppc/spapr_drc.c: In function ‘rtas_ibm_configure_connector’:
>>>>>     ../hw/ppc/spapr_drc.c:1240:26: warning: declaration of ‘drc_index’
>>> shadows a previous local [-Wshadow=compatible-local]
>>>>>      1240 |                 uint32_t drc_index = spapr_drc_index(drc);
>>>>>           |                          ^~~~~~~~~
>>>>>     ../hw/ppc/spapr_drc.c:1155:14: note: shadowed declaration is here
>>>>>      1155 |     uint32_t drc_index;
>>>>>           |              ^~~~~~~~~
>>>>>
>>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>>> ---
>>>>>    hw/ppc/spapr_drc.c | 2 --
>>>>>    1 file changed, 2 deletions(-)
>>>>>
>>>>> diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
>>>>> index b5c400a94d1c..843e318312d3 100644
>>>>> --- a/hw/ppc/spapr_drc.c
>>>>> +++ b/hw/ppc/spapr_drc.c
>>>>> @@ -1237,8 +1237,6 @@ static void
>>> rtas_ibm_configure_connector(PowerPCCPU *cpu,
>>>>>            case FDT_END_NODE:
>>>>>                drc->ccs_depth--;
>>>>>                if (drc->ccs_depth == 0) {
>>>>> -                uint32_t drc_index = spapr_drc_index(drc);
>>>>> -
>>>> I guess you only wanted to remove re-declaration part. Assigning the
>>>
>>> value returned by this function doesnt seem to happen before.
>>>
>>> drc_index is assigned at the top of this large routine with :
>>>
>>>       drc_index = rtas_ld(wa_addr, 0);
>>>       drc = spapr_drc_by_index(drc_index);
>>>
>>>
>>> So, the extra local variable 'drc_index' is simply redundant because
>>> there are no reason for it to change. The drc object is the same AFAICT.
>>> Correct ? I should have explained that better in the commit log.
>>>
>>
>> Okay, since both routines were implemented differently, I wasn't sure about
>> the impact of reassignment. Better commit log is always welcome.
> 
> Do you expect a respin?  If not, would you like to give your R-by?
> 
Oh sure,
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

