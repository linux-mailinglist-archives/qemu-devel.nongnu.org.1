Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA57738418
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 14:52:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxIw-0003LI-SG; Wed, 21 Jun 2023 08:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qBxIu-0003JM-6B; Wed, 21 Jun 2023 08:51:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qBxIs-000872-74; Wed, 21 Jun 2023 08:51:19 -0400
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35LClHLA001975; Wed, 21 Jun 2023 12:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YB4kzhv/xpKSXoMnzqgu79e1KIJL1KKrkd2UB7OvKiU=;
 b=iZpCWJkzkYh6LqLxjOMMll9imU3lEvPSoqU1bfdq8D0xXOZDUC0ahCiasfq0sn4FM5YW
 PkPVo8xK2s6TkGz/ljvhMrlEvcmKU7jBsl+DKh36GSdyn8POkbLSaz7rst2qWQb8eFbT
 7GdofbswvC8ZZUwiZrqYZ5xT51bUtK44vL46MvWG4Wfn6wdKtAy3Z8r+4V3mMrkFQDxQ
 pK5y55AOopaPHO/KEoVSqz8F0vLuKj0Lu0DRx+ne35Z9lZPZQj9M3lhUvCZ1KUda6aPh
 HM7djmxCDYB3BpvXV7GAosaZwiN75DVBUo8GZknQYHtoSHRfAbruc5VzFidbvOqQnpE4 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc1gw02pa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:50:34 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35LCliLO002709;
 Wed, 21 Jun 2023 12:50:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rc1gw02my-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:50:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35LChIH5018300;
 Wed, 21 Jun 2023 12:50:31 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3r94f5arvy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 21 Jun 2023 12:50:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 35LCoP6a13501038
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 Jun 2023 12:50:25 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A7F62004B;
 Wed, 21 Jun 2023 12:50:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA1CF2004E;
 Wed, 21 Jun 2023 12:50:24 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 21 Jun 2023 12:50:24 +0000 (GMT)
Message-ID: <ee80dd30-08cf-476e-028b-b93e489a502c@linux.ibm.com>
Date: Wed, 21 Jun 2023 14:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v20 09/21] machine: adding s390 topology to query-cpu-fast
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, nsg@linux.ibm.com, frankja@linux.ibm.com,
 berrange@redhat.com
References: <20230425161456.21031-1-pmorel@linux.ibm.com>
 <20230425161456.21031-10-pmorel@linux.ibm.com>
 <14168a66-38ba-82e6-08d2-830f6216b4e1@kaod.org>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <14168a66-38ba-82e6-08d2-830f6216b4e1@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eUbnt1RKx-csockpGbOgCT98DYauoT2V
X-Proofpoint-GUID: EtcnIg1RvE6kX58-wZ7AKCGRDeR220MS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_08,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306210105
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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


On 6/12/23 09:55, Cédric Le Goater wrote:
> Hello Pierre,
>
> On 4/25/23 18:14, Pierre Morel wrote:
>> S390x provides two more topology attributes, entitlement and dedication.
>>
>> Let's add these CPU attributes to the QAPI command query-cpu-fast.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   qapi/machine.json          | 9 ++++++++-
>>   hw/core/machine-qmp-cmds.c | 2 ++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 1cdd83f3fd..c6a12044e0 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -55,10 +55,17 @@
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
>> +  }
>> +}
>>     ##
>>   # @CpuInfoFast:
>> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
>> index b98ff15089..3f35ed83a6 100644
>> --- a/hw/core/machine-qmp-cmds.c
>> +++ b/hw/core/machine-qmp-cmds.c
>> @@ -35,6 +35,8 @@ static void cpustate_to_cpuinfo_s390(CpuInfoS390 
>> *info, const CPUState *cpu)
>>       CPUS390XState *env = &s390_cpu->env;
>>         info->cpu_state = env->cpu_state;
>> +    info->dedicated = env->dedicated;
>> +    info->entitlement = env->entitlement;
>
> When you resend, please protect these assignments with :
>
>  #if !defined(CONFIG_USER_ONLY)
>
> Thanks,
>
> C.


Hello Cedric,

Yes, thanks.

(I though I already answered but can not find a trace of it)

Regards,

Pierre



