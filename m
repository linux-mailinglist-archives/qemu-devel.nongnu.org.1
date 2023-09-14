Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE95D7A0E5C
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 21:30:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgs1M-0005CK-AC; Thu, 14 Sep 2023 15:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qgs1F-0005Bv-Lz
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:28:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1qgs19-00088g-J5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 15:28:53 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EJC2Gx020309
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=qDXPVFMT77A7SWyP/a2SnMqwkQRKrNh6gJONEMH9toQ=;
 b=fYpauxsDhyxIZ+gr/mvwf5Ic/+5xhsjiOqRSXzKQsuSx+m7cVTHML0eQa4PXzgPgRfx7
 4GFhtnVp0g5x9yLsembV2XUmXXXio/jvkKYwSVwKVMd4AvuAeJuA0d9lhnTbgvrpdpYK
 z5a8vWVLYq8dzcYssb54iTQvft6UlCXJkgk1XRhc0/d5ecww3XIBV5fgfF9PK0cQEh7B
 3P954ELlfrI6G4zyT2QuVykYdetBBsrgfkak7rAdXBthR81R5iTZAPUbl4VfpYqcHubl
 5S6Sf+ftF4AgiuSox0i4oqWruGX+09FPabPYgmEyryy9/y8y6f+7A5Epnyxqc2all8u2 Yw== 
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t4848rduk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EJK8Pf002478
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:41 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158kmx8n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:41 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 38EJSetp23528112
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B057358053
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 78C4358043
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:40 +0000 (GMT)
Received: from [9.67.14.133] (unknown [9.67.14.133])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 19:28:40 +0000 (GMT)
Message-ID: <ea93b16f-f295-1108-ebe7-543bb7070489@linux.ibm.com>
Date: Thu, 14 Sep 2023 15:28:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] target/s390x: introduce "host-recommended" option
 for model expansion
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230911205232.71735-1-walling@linux.ibm.com>
 <bbf67ab2-2868-7c3a-0e8e-8f53fd62c1fb@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
In-Reply-To: <bbf67ab2-2868-7c3a-0e8e-8f53fd62c1fb@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SLZCcKhHUFqi-9d4fWrLxtW8Y-oQ1cxM
X-Proofpoint-GUID: SLZCcKhHUFqi-9d4fWrLxtW8Y-oQ1cxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_11,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309140166
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

On 9/12/23 02:57, David Hildenbrand wrote:
> On 11.09.23 22:52, Collin Walling wrote:
> 
> Patch subject is wrong (should contain "static-recommended")
> 
>> Newer S390 machines may drop support for features completely, rendering
>> guests operating with older CPU models incapable of running on said
>> machines. A manual effort to disable certain CPU features would be
>> required.
>>
>> To alleviate this issue, a list of "deprecated" features are now
>> retained within QEMU, and a new "static-recommended" CPU model expansion
>> type has been created to allow a query of the host-model with deprecated
>> features explicitly disabled.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   qapi/machine-target.json         |  8 +++++++-
>>   target/s390x/cpu_features.c      | 14 ++++++++++++++
>>   target/s390x/cpu_features.h      |  1 +
>>   target/s390x/cpu_models_sysemu.c | 26 +++++++++++++++++++++-----
>>   4 files changed, 43 insertions(+), 6 deletions(-)
>>
>> diff --git a/qapi/machine-target.json b/qapi/machine-target.json
>> index f0a6b72414..4dc891809d 100644
>> --- a/qapi/machine-target.json
>> +++ b/qapi/machine-target.json
>> @@ -42,6 +42,12 @@
>>   #     to be migration-safe, but allows tooling to get an insight and
>>   #     work with model details.
>>   #
>> +# @static-recommended: Expand to a static CPU model with property
>> +#     changes suggested by the architecture. This is useful for
>> +#     expanding a CPU model expected to operate in mixed
>> +#     CPU-generation environments. The @static-recommended CPU
>> +#     models are migration-safe.
>> +#
> 
> Can we instead make this a new parameter for query-cpu-model-expansion 
> ("no-deprecated-features" ? ), that properly gets rejected from other 
> archs when not supported?
> 
> [...]
> 

So instead of a "type": "static-recommended" add an entirely new
(optional) parameter key-value to the command?
"disable-deprecated-features": "true|false"?

>>   /* convert S390CPUDef into a static CpuModelInfo */
>>   static void cpu_info_from_model(CpuModelInfo *info, const S390CPUModel *model,
>> -                                bool delta_changes)
>> +                                bool delta_changes, bool disable_dep_feats)
> 
> "dep" can be misleading ("depended")
> 
> "no_deprecated_feat" ?
> 
> 

Good call. Tricky one to short-hand :)

With respect to labeling this as "no-deprecated-features", I think that
may also be misleading: it sounds like an exclusion, when in fact we
*want* the deprecated feats to show up paired with the false value. So I
think "disable-deprecated-features" is a better label. Would you agree?

-- 
Regards,
  Collin


