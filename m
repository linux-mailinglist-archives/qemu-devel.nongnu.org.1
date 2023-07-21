Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7187575C5D5
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 13:26:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMoG0-0002K9-3Z; Fri, 21 Jul 2023 07:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qMoFx-0002Jf-IS; Fri, 21 Jul 2023 07:25:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qMoFt-0004Jm-JN; Fri, 21 Jul 2023 07:25:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36LB84P1011007; Fri, 21 Jul 2023 11:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+nnfAzBXxDVcNYAj7Bjd85nwurG3s+jjCOU+BAQ7Pi8=;
 b=qpPJ2ZJ9y7Z4M5bYsWGGDF09NgjO4qeZwlqKag/kEiIIHyC1bdCH3yVyN0HKLk+KoWqS
 Jt98slZaqPZl20zZUaCqUkt8DDhrTsMpCmoEmEPkqhMArWySKH5njZ0ihtWxSOCvUqAb
 T+3CoHTE36zP152l9eqpeBXKha33VRYZt4ygghsKZ3GA7K7iJe+GFCEr7rQWI1vcdKKn
 TJFNRKhmDUe3PutDxiPJA+DCv9c5Sj2hAtZfP8UZ+iXDPi7dyJ4RIzQTFloOaQ1sIOR7
 ssR4RhH2eS+osnWUMCbhoLzmdDfg6bpTaumfOWxXB0QQhjT0px/xPlaXTr3YrkiHbNiY Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rykd87fru-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 11:24:58 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36LB8LNk013931;
 Fri, 21 Jul 2023 11:24:58 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rykd87frj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 11:24:58 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36L97Wpf003171; Fri, 21 Jul 2023 11:24:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv65xx1vy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 21 Jul 2023 11:24:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36LBOrXp16908940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 21 Jul 2023 11:24:53 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 231F720043;
 Fri, 21 Jul 2023 11:24:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9343620040;
 Fri, 21 Jul 2023 11:24:51 +0000 (GMT)
Received: from [9.179.4.120] (unknown [9.179.4.120])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 21 Jul 2023 11:24:51 +0000 (GMT)
Message-ID: <29268e39-49ba-588a-022d-30b0882fea37@linux.ibm.com>
Date: Fri, 21 Jul 2023 13:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 01/20] s390x/cpu topology: add s390 specifics to CPU
 topology
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, thuth@redhat.com,
 cohuck@redhat.com, mst@redhat.com, pbonzini@redhat.com,
 kvm@vger.kernel.org, ehabkost@redhat.com, marcel.apfelbaum@gmail.com,
 eblake@redhat.com, armbru@redhat.com, seiden@linux.ibm.com,
 nrb@linux.ibm.com, frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-2-pmorel@linux.ibm.com>
 <9c8847ad9d8e07c2e41f9c20716ba3ed6dd6b3dc.camel@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <9c8847ad9d8e07c2e41f9c20716ba3ed6dd6b3dc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wBiGb-E4L2PgYXdPKcYsG8FMx9iuktd0
X-Proofpoint-ORIG-GUID: nFOucpWDEjuZJ35GHlKyNwxD66r9yi1U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_06,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210099
Received-SPF: pass client-ip=148.163.158.5; envelope-from=pmorel@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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


On 7/18/23 18:31, Nina Schoetterl-Glausch wrote:
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
>
> Some notes below.
>
> The s390x/ prefix in the title might suggest that this patch
> is s390 specific, but it touches common files.


Right.

What do you suggest?

I can cut it in two or squash it with patch number 2.

The first idea was to separate the patch to ease the review but the
functionality introduced in patch 1 do only make sense with patch 2.

So I would be for squashing the first two patches.

?


>
> On Fri, 2023-06-30 at 11:17 +0200, Pierre Morel wrote:
>> S390 adds two new SMP levels, drawers and books to the CPU
>> topology.
>> The S390 CPU have specific topology features like dedication
> S390 CPUs have specific topology features like dedication and
> entitlement. These indicate to the guest information on host
> vCPU scheduling and help the guest make better scheduling decisions.
>
>> and entitlement to give to the guest indications on the host
>> vCPUs scheduling and help the guest take the best decisions
>> on the scheduling of threads on the vCPUs.
>>
>> Let us provide the SMP properties with books and drawers levels
>> and S390 CPU with dedication and entitlement,
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   qapi/machine-common.json            | 22 +++++++++++++
>>   qapi/machine.json                   | 21 ++++++++++---
>>   include/hw/boards.h                 | 10 +++++-
>>   include/hw/qdev-properties-system.h |  4 +++
>>   target/s390x/cpu.h                  |  6 ++++
>>   hw/core/machine-smp.c               | 48 ++++++++++++++++++++++++---
>> --
>>   hw/core/machine.c                   |  4 +++
>>   hw/core/qdev-properties-system.c    | 13 ++++++++
>>   hw/s390x/s390-virtio-ccw.c          |  2 ++
>>   softmmu/vl.c                        |  6 ++++
>>   target/s390x/cpu.c                  |  7 +++++
>>   qapi/meson.build                    |  1 +
>>   qemu-options.hx                     |  7 +++--
>>   13 files changed, 137 insertions(+), 14 deletions(-)
>>   create mode 100644 qapi/machine-common.json
>>
>> diff --git a/qapi/machine-common.json b/qapi/machine-common.json
>> new file mode 100644
>> index 0000000000..bc0d76829c
>> --- /dev/null
>> +++ b/qapi/machine-common.json
>> @@ -0,0 +1,22 @@
>> +# -*- Mode: Python -*-
>> +# vim: filetype=python
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> later.
>> +# See the COPYING file in the top-level directory.
>> +
>> +##
>> +# = Machines S390 data types
> Common definitions for machine.json and machine-target.json
>
>
> [...]

