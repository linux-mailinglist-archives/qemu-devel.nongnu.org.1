Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 335767BF9F6
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:41:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqB7A-0002Ze-84; Tue, 10 Oct 2023 07:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqB74-0002Yj-HO; Tue, 10 Oct 2023 07:41:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqB6y-00056m-Rp; Tue, 10 Oct 2023 07:41:21 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ABf9rm023732; Tue, 10 Oct 2023 11:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=2KJohtrXE1S4tzfOg5Ny6hdml5q2E6CpFvZ5IMeu+mY=;
 b=gEDltXDlOu2MiSJwdStNjR3jnjXNYGmt53xyfF5PuBm5MLRaRXUhiLEXSQQPS4kZ/ELr
 zcff6WILGCqy/yEHg5v7efQejooAzDFgVVGdQQ+qh2mQw/fJsL6QjnYwEROrIEK1fqRe
 pl1sFtIcfvko2luK5hAyKb82ZC6PidpPtsv4FmGfvayAXThGsBTRtUnZBTf3OemgOi37
 AI0b0BsI5SRlgAkfq70YBo2+OPCr07MPnwyESviqauhmKqsJSJB7kyLyTA7Llu3KTXKo
 oC45BwfGvyn5JGLsbrEbFAlF7w+6nxjmiV1+Qx8OuPnMDzKpWysEPAocLUuTbNkicCh5 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5m2gdy5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:41:14 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39ABfDw3024213;
 Tue, 10 Oct 2023 11:41:13 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5m2gddm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:41:12 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39A9KBlX001147; Tue, 10 Oct 2023 11:36:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvjqkkr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:36:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39ABabI433751394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 11:36:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C16F42004B;
 Tue, 10 Oct 2023 11:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A3B9320049;
 Tue, 10 Oct 2023 11:36:37 +0000 (GMT)
Received: from [9.152.224.53] (unknown [9.152.224.53])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Oct 2023 11:36:37 +0000 (GMT)
Message-ID: <a3dbcec6-e0ef-74e7-fa20-6846caf156a6@linux.ibm.com>
Date: Tue, 10 Oct 2023 13:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/2] target/s390x/kvm: Turn KVM_CAP_SYNC_REGS into a
 hard requirement
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
References: <20231009170745.63446-1-thuth@redhat.com>
 <20231009170745.63446-2-thuth@redhat.com>
 <e33a387a-215b-cc39-3552-16e67f8984e8@linux.ibm.com>
 <2f6dcd26-9a53-390a-5acc-b8021b6190c5@redhat.com>
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <2f6dcd26-9a53-390a-5acc-b8021b6190c5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wI-yDTOByoEruRfVahGrf9SmJ-vGc3jH
X-Proofpoint-GUID: PRAzUoneEAjGZHCF0LZ1x-AK8jSp8iLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_07,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100084
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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



Am 10.10.23 um 13:12 schrieb Thomas Huth:
> On 10/10/2023 13.02, Christian Borntraeger wrote:
>>
>>
>> Am 09.10.23 um 19:07 schrieb Thomas Huth:
>>> Since we already require at least kernel 3.15 in the s390x KVM code,
>>> we can assume that the KVM_CAP_SYNC_REGS capability is always there.
>>> Thus turn this into a hard requirement now.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   target/s390x/kvm/kvm.c | 20 ++++++++++++++------
>>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
>>> index bc5c56a305..b3e2eaa2eb 100644
>>> --- a/target/s390x/kvm/kvm.c
>>> +++ b/target/s390x/kvm/kvm.c
>>> @@ -337,21 +337,29 @@ int kvm_arch_get_default_type(MachineState *ms)
>>>   int kvm_arch_init(MachineState *ms, KVMState *s)
>>>   {
>>> +    int required_caps[] = {
>>> +        KVM_CAP_DEVICE_CTRL,
>>> +        KVM_CAP_SYNC_REGS,
>>> +    };
>>> +
>>> +    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
>>> +        if (!kvm_check_extension(s, required_caps[i])) {
>>> +            error_report("KVM is missing capability #%d - "
>>> +                         "please use kernel 3.15 or newer", required_caps[i]);
>>> +            return -1;
>>> +        }
>>> +    }
>>> +
>>>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>>>                            false, NULL);
>>> -    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
>>> -        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
>>> -                     "please use kernel 3.15 or newer");
>>> -        return -1;
>>> -    }
>>>       if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
>>>           error_report("KVM is missing capability KVM_CAP_S390_COW - "
>>>                        "unsupported environment");
>>>           return -1;
>>>       }
>>
>> Not sure if we also want to move KVM_CAP_S390_COW somehow. The message would be different.
> 
> IIRC that error could happen when you ran KVM within an older version of z/VM, so the "please use kernel 3.15 or newer" message would be completely misleading there.

Yes, thats what I was trying to say, we would need a different message.
Lets go with this patch.
> 
>> Aparch from that:
>> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Thanks,
>    Thomas
> 
> 

