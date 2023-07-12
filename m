Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C70750CF9
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 17:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJc3V-000454-9O; Wed, 12 Jul 2023 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJc3G-00042H-NV; Wed, 12 Jul 2023 11:47:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJc3A-0004y2-Jh; Wed, 12 Jul 2023 11:46:50 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CFg0r3014260; Wed, 12 Jul 2023 15:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=URYayddAAoLBOT2mFubDD+YcUfU1qLeT9suZBiRFF3s=;
 b=NDlLpDIh8Gr/445/yvSCGEcfyv6Sp7d4C3qYw2zrIE+Ekoov3naABwa4iV5qBeJU2vi8
 9F4VnJjC8lP+QH/N8jVKSuZ4NipPvJo8/P8bDoqpR5UJrfcgAkKG3z7dMB+KO/VVIaZ5
 FdApNGo8gafwvh2GVpoVH3YoIaMtqtFe5ylEdM1gn1gUlZWphnK1VZQzBQ3IO+vCrLp4
 j7HiMuBjc+JhYZ41JfLG34Jh0NSHQjAxCopOSGBCdXKp3Bwlh/u13DAivNSNoVV21MtH
 OWNqDsezOVxM2GkJLfk58k9J6kbF62Ls5QB37sHoGxOeBXvXkiRQ/vYYIggvJ5/1ksDp sw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsxp0sb6c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 15:46:31 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CFg8n2014959;
 Wed, 12 Jul 2023 15:45:52 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsxp0s9kc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 15:45:52 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C4dLPq017376;
 Wed, 12 Jul 2023 15:44:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye5aqga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 15:44:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36CFiAcp3146246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jul 2023 15:44:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AE80820043;
 Wed, 12 Jul 2023 15:44:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 29BBB20040;
 Wed, 12 Jul 2023 15:44:10 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Jul 2023 15:44:10 +0000 (GMT)
Message-ID: <c8cc5d6c-d0fa-c475-07ec-da6b2894cee4@linux.ibm.com>
Date: Wed, 12 Jul 2023 17:44:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 09/20] machine: adding s390 topology to query-cpu-fast
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-10-pmorel@linux.ibm.com>
 <747a5678-6140-a0ca-b08c-841b2ae00802@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <747a5678-6140-a0ca-b08c-841b2ae00802@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IfSqUGhrUwnpW4IY6TsMkiE8UvSvRSoP
X-Proofpoint-ORIG-GUID: nJMNVdbHsDfr3eG8FIhWd03cv_9F7FeZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2307120141
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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


On 7/4/23 14:55, Thomas Huth wrote:
> On 30/06/2023 11.17, Pierre Morel wrote:
>> S390x provides two more topology attributes, entitlement and dedication.
>>
>> Let's add these CPU attributes to the QAPI command query-cpu-fast.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   qapi/machine.json  | 9 ++++++++-
>>   target/s390x/cpu.c | 4 ++++
>>   2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 08245beea1..a1920cb78d 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -56,10 +56,17 @@
>>   # Additional information about a virtual S390 CPU
>>   #
>>   # @cpu-state: the virtual CPU's state
>> +# @dedicated: the virtual CPU's dedication (since 8.1)
>> +# @entitlement: the virtual CPU's entitlement (since 8.1)
>>   #
>>   # Since: 2.12
>>   ##
>> -{ 'struct': 'CpuInfoS390', 'data': { 'cpu-state': 'CpuS390State' } }
>> +{ 'struct': 'CpuInfoS390',
>> +  'data': { 'cpu-state': 'CpuS390State',
>> +            'dedicated': 'bool',
>> +            'entitlement': 'CpuS390Entitlement'
>
> Would it make sense to make them optional and only report those if the 
> topology feature is enabled?
>
>  Thomas
>
I think you are right, I make them optional, it has no sense if the 
architecture does support topology.

Thanks,

Pierre


>
>> +  }
>> +}
>>     ##
>>   # @CpuInfoFast:
>> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
>> index 74405beb51..01938635eb 100644
>> --- a/target/s390x/cpu.c
>> +++ b/target/s390x/cpu.c
>> @@ -146,6 +146,10 @@ static void s390_query_cpu_fast(CPUState *cpu, 
>> CpuInfoFast *value)
>>       S390CPU *s390_cpu = S390_CPU(cpu);
>>         value->u.s390x.cpu_state = s390_cpu->env.cpu_state;
>> +#if !defined(CONFIG_USER_ONLY)
>> +    value->u.s390x.dedicated = s390_cpu->env.dedicated;
>> +    value->u.s390x.entitlement = s390_cpu->env.entitlement;
>> +#endif
>>   }
>>     /* S390CPUClass::reset() */
>

