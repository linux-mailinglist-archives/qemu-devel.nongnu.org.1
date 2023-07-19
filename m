Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F547597BD
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:09:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7rh-0006wt-Gs; Wed, 19 Jul 2023 10:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM7re-0006vs-LN; Wed, 19 Jul 2023 10:09:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pmorel@linux.ibm.com>)
 id 1qM7rc-0003sj-Bt; Wed, 19 Jul 2023 10:09:14 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JDv2P4000673; Wed, 19 Jul 2023 14:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=WQdJO92qLaHQSPBHRu+cQWsFeYGKeFOM4Jt8tzxvNGA=;
 b=AZm9KTR/+f97IEHAZUsfQ6NrGvMw/m/H1jYiYyCOLZItAjKytzccGX3i34Ufha1pdTGs
 heG/g6X5e/STiNLQO6OERdjka9m+w3/OXhl2AdvYOZvtxER/iz2sC0Q6TeZ7eWjMxE9H
 OF0axZ7OdsBPDkBJXcEFXeSmVVfJxvqkWkYDsdsnHZ++Bew20hUYaQb735gdOLmtkS6f
 NShc08mh9x7scbLAHKdOlYXIy4pfOSJGo3M3EvK5ufYleESsu/csB6Mus89p4xy+rSgl
 agpYDe+A1Y8YUYzQIaknZrYtlPboO3K2zlGgv4fJGZjxYj+3XoHHoDKuYgO8HHljWCgV 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxgqt90b7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:08:56 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36JDcIrS025352;
 Wed, 19 Jul 2023 14:08:56 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rxgqt900h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:08:56 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36JCcnAS016886; Wed, 19 Jul 2023 14:08:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv5srtwg0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 19 Jul 2023 14:08:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36JE8dJk11076310
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 19 Jul 2023 14:08:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9230F20043;
 Wed, 19 Jul 2023 14:08:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2BBEF20040;
 Wed, 19 Jul 2023 14:08:39 +0000 (GMT)
Received: from [9.155.200.205] (unknown [9.155.200.205])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 19 Jul 2023 14:08:39 +0000 (GMT)
Message-ID: <ba0767b8-0273-898e-6aaa-1e2318b09304@linux.ibm.com>
Date: Wed, 19 Jul 2023 16:08:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v21 16/20] tests/avocado: s390x cpu topology entitlement
 tests
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.ibm.com,
 richard.henderson@linaro.org, david@redhat.com, cohuck@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org,
 ehabkost@redhat.com, marcel.apfelbaum@gmail.com, eblake@redhat.com,
 armbru@redhat.com, seiden@linux.ibm.com, nrb@linux.ibm.com,
 frankja@linux.ibm.com, berrange@redhat.com, clg@kaod.org
References: <20230630091752.67190-1-pmorel@linux.ibm.com>
 <20230630091752.67190-17-pmorel@linux.ibm.com>
 <dfeeeaa1-0994-9e1e-1f10-6c6618daacff@redhat.com>
 <aa1fbe820f23bc487752ee29ee114f5d4185352a.camel@linux.ibm.com>
 <88070b30-36ea-8112-41c4-0d93fc76cf80@redhat.com>
 <dbb17fa6239774d80e697ed771514b345faf5486.camel@linux.ibm.com>
From: Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <dbb17fa6239774d80e697ed771514b345faf5486.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0bDfF9a2zDSbShFld_L-J3LIVNWoNgVO
X-Proofpoint-ORIG-GUID: HWkHPtIHi09NT0DLtsZY54pW-UNkDjjz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_09,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307190126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=pmorel@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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


On 7/14/23 18:30, Nina Schoetterl-Glausch wrote:
> On Wed, 2023-07-12 at 22:11 +0200, Thomas Huth wrote:
>> On 12/07/2023 21.37, Nina Schoetterl-Glausch wrote:
>>> On Wed, 2023-07-05 at 12:22 +0200, Thomas Huth wrote:
>>>> On 30/06/2023 11.17, Pierre Morel wrote:
>>>>> This test takes care to check the changes on different
>>>>> entitlements
>>>>> when the guest requests a polarization change.
>>>>>
>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>> ---
>>>>>     tests/avocado/s390_topology.py | 47
>>>>> ++++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 47 insertions(+)
>>>>>
>>>>> diff --git a/tests/avocado/s390_topology.py
>>>>> b/tests/avocado/s390_topology.py
>>>>> index 2cf731cb1d..4855e5d7e4 100644
>>>>> --- a/tests/avocado/s390_topology.py
>>>>> +++ b/tests/avocado/s390_topology.py
>>>>> @@ -240,3 +240,50 @@ def test_polarisation(self):
>>>>>             res = self.vm.qmp('query-cpu-polarization')
>>>>>             self.assertEqual(res['return']['polarization'],
>>>>> 'horizontal')
>>>>>             self.check_topology(0, 0, 0, 0, 'medium', False)
>>>>> +
>>>>> +    def test_entitlement(self):
>>>>> +        """
>>>>> +        This test verifies that QEMU modifies the polarization
>>>>> +        after a guest request.
>>>> ...
>>>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>>>> +
>>>>> +        self.guest_set_dispatching('1');
>>>>> +
>>>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>>>> +
>>>>> +        self.guest_set_dispatching('0');
>>>>> +
>>>>> +        self.check_topology(0, 0, 0, 0, 'low', False)
>>>>> +        self.check_topology(1, 0, 0, 0, 'medium', False)
>>>>> +        self.check_topology(2, 1, 0, 0, 'high', False)
>>>>> +        self.check_topology(3, 1, 0, 0, 'high', False)
>>>> Sorry, I think I'm too blind to see it, but what has changed
>>>> after
>>>> the guest
>>>> changed the polarization?
>>> Nothing, the values are retained, they're just not active.
>>> The guest will see a horizontal polarization until it changes back
>>> to
>>> vertical.
>> But then the comment in front of it ("This test verifies that QEMU
>> *modifies* the polarization...") does not quite match, does it?
> Yeah, it tests that QEMU reports it's own state changed when using
> set-cpu-topology.
> I think it would be a good idea to get the guests view from the sysfs,
> also.
>
>>    Thomas
>>
>>

Yes, I think you are right, I rewrite this to check the guest view of 
the changes.

As you said the values are retained when not used by horizontal 
polarization so it is a non sense to check from host view.

Thanks

Pierre


