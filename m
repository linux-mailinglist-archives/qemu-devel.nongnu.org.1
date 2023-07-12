Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2C4750DC5
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 18:14:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJcSk-0005s4-W4; Wed, 12 Jul 2023 12:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJcSi-0005qF-0O; Wed, 12 Jul 2023 12:13:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qJcSg-00088Z-E7; Wed, 12 Jul 2023 12:13:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36CG31UH004957; Wed, 12 Jul 2023 16:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hL1QscgM8TzuEZOPUOJWa2p8IobIBw8mwwqBPp9Zx6Q=;
 b=A9ho07o6NmWaBgnqRX3APK7ARCNHqfZ/dJ366LswEwBFCoSYB2otHymQiit8NZP3h83D
 4FpxFjkn5PhfqJYNTMuhX08AIJ0D5Hw6F6a38dLy2tYKRqeVCKl3cZhJ0R3ANLGYl+Hb
 J4+aET4yo83plT6JkMh4IT+9Emb6BPK+Mp0ZWWD1WfumQKdK7rBciQv1pz+l0d5JTrLr
 LuQshxOb3TDdA/PtpTtm62KyvKvXlf9WVmG2Yt7bDttikijHhODb1lTXu4eXMFTpiHmZ
 6V8toZBCR5+DjGazpbtTCaZyHgvy8dmNsiR2JIpjXr6dEJGFHGJOqQwYExQ1E/HekwQo lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsybv8cfh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:12:56 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36CGC4lU019191;
 Wed, 12 Jul 2023 16:12:55 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.99])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rsybv8cev-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:12:55 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
 by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36C2jAgf015105;
 Wed, 12 Jul 2023 16:12:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rpye5aquk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Jul 2023 16:12:52 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36CGCmFI31523158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Jul 2023 16:12:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 22CC420040;
 Wed, 12 Jul 2023 16:12:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 88F1A20043;
 Wed, 12 Jul 2023 16:12:47 +0000 (GMT)
Received: from [9.152.222.242] (unknown [9.152.222.242])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 12 Jul 2023 16:12:47 +0000 (GMT)
Message-ID: <47a7518e-2ca6-e2a1-2130-ddf21163ba5e@linux.ibm.com>
Date: Wed, 12 Jul 2023 18:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 12/20] qapi/s390x/cpu topology: query-cpu-polarization
 qmp command
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 nsg@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-13-pmorel@linux.ibm.com>
 <3d4d0349-45c1-28c7-1da1-3c66f03025a0@redhat.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <3d4d0349-45c1-28c7-1da1-3c66f03025a0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yI3WLEd3lB3400EyHay7aRzl37KU9K5z
X-Proofpoint-ORIG-GUID: RbsFEQxUxlM4QMvoo8OCVmdPuXbNI-3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120144
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


On 7/5/23 09:58, Thomas Huth wrote:
> On 30/06/2023 11.17, Pierre Morel wrote:
>> The query-cpu-polarization qmp command returns the current
>> CPU polarization of the machine.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   qapi/machine-target.json | 29 +++++++++++++++++++++++++++++
>>   hw/s390x/cpu-topology.c  |  8 ++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index 1362e43983..1e4b8976aa 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -445,3 +445,32 @@
>>     'features': [ 'unstable' ],
>>     'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
>>   }
>> +
>> +##
>> +# @CpuPolarizationInfo:
>> +#
>> +# The result of a cpu polarization
>> +#
>> +# @polarization: the CPU polarization
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'struct': 'CpuPolarizationInfo',
>> +  'data': { 'polarization': 'CpuS390Polarization' },
>> +  'if': { 'all': [ 'TARGET_S390X', 'CONFIG_KVM' ] }
>> +}
>> +
>> +##
>> +# @query-cpu-polarization:
>> +#
>> +# Features:
>> +# @unstable: This command may still be modified.
>> +#
>> +# Returns: the machine polarization
>> +#
>> +# Since: 8.1
>> +##
>> +{ 'command': 'query-cpu-polarization', 'returns': 
>> 'CpuPolarizationInfo',
>
> Since this is very specific to s390x, I wonder whether we want to have 
> a "s390x" in the command name? 'query-s390x-cpu-polarization'? ... or 
> is this getting too long already?
>
> Anyway,
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
I do not know.I prefer short commands but the interface will mostly be 
used by a program, so...

I let it like that unless there is more pressure to change it.

Thanks,

Pierre



