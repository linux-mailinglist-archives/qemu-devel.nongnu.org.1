Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E387BF923
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqAW5-0000ed-Vd; Tue, 10 Oct 2023 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqAW3-0000e3-7N; Tue, 10 Oct 2023 07:03:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <borntraeger@linux.ibm.com>)
 id 1qqAW1-0002Us-DR; Tue, 10 Oct 2023 07:03:06 -0400
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39AAsiCO012492; Tue, 10 Oct 2023 11:02:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Pt/p3hBhF7GmtIjC9SYKtpRerGVMWWZ5TpHv3QI/40o=;
 b=Iz/ZM0tDahPUkRBzUakbj28W4bpwwEW7VfRIUFufvv/Wmv0H135+gnVg0gz5KovL02sT
 FK22awGZVOJiYn3c8fTYjBg/2VtLyy/XLQ53bfl13xvURvIINa/I3mqnBq5o7tBQZiwq
 4US3M76mzVwoMQDEy7h5VTQTx++rmWNY/2b6emG+VBmUI0mZwIE39t2PGgqFeCwbkfHT
 CmJx9xEZajo2gI3ss34LSxmR3TBQAZz+Bva9LI4NLZkDcrfHFb94Rsw6DQEMh4AMjvhG
 ZN/piDFxcY0H40CpzQKSFJnSpisrpDnCcL2St7Q6lUHn/Lzc34pGiCwqWeVOfMQ+Y7cg wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5950bxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:02:49 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AAtKm7014391;
 Tue, 10 Oct 2023 11:02:36 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tn5950bap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:02:36 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 39A9U94O024452; Tue, 10 Oct 2023 11:02:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnsg4xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Oct 2023 11:02:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 39AB2I0L44237536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Oct 2023 11:02:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 00CCC20049;
 Tue, 10 Oct 2023 11:02:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCC5820040;
 Tue, 10 Oct 2023 11:02:17 +0000 (GMT)
Received: from [9.152.224.53] (unknown [9.152.224.53])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Oct 2023 11:02:17 +0000 (GMT)
Message-ID: <e33a387a-215b-cc39-3552-16e67f8984e8@linux.ibm.com>
Date: Tue, 10 Oct 2023 13:02:17 +0200
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
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20231009170745.63446-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TE8Wg-jKdc69ZAeotRnBxgAsVtGap0YB
X-Proofpoint-GUID: shABGvty1ZcjdANw6y23t12uKKGIzOF0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_06,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100080
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=borntraeger@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



Am 09.10.23 um 19:07 schrieb Thomas Huth:
> Since we already require at least kernel 3.15 in the s390x KVM code,
> we can assume that the KVM_CAP_SYNC_REGS capability is always there.
> Thus turn this into a hard requirement now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   target/s390x/kvm/kvm.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index bc5c56a305..b3e2eaa2eb 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -337,21 +337,29 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> +    int required_caps[] = {
> +        KVM_CAP_DEVICE_CTRL,
> +        KVM_CAP_SYNC_REGS,
> +    };
> +
> +    for (int i = 0; i < ARRAY_SIZE(required_caps); i++) {
> +        if (!kvm_check_extension(s, required_caps[i])) {
> +            error_report("KVM is missing capability #%d - "
> +                         "please use kernel 3.15 or newer", required_caps[i]);
> +            return -1;
> +        }
> +    }
> +
>       object_class_foreach(ccw_machine_class_foreach, TYPE_S390_CCW_MACHINE,
>                            false, NULL);
>   
> -    if (!kvm_check_extension(kvm_state, KVM_CAP_DEVICE_CTRL)) {
> -        error_report("KVM is missing capability KVM_CAP_DEVICE_CTRL - "
> -                     "please use kernel 3.15 or newer");
> -        return -1;
> -    }
>       if (!kvm_check_extension(s, KVM_CAP_S390_COW)) {
>           error_report("KVM is missing capability KVM_CAP_S390_COW - "
>                        "unsupported environment");
>           return -1;
>       }

Not sure if we also want to move KVM_CAP_S390_COW somehow. The message would be different.
Aparch from that:
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


>   
> -    cap_sync_regs = kvm_check_extension(s, KVM_CAP_SYNC_REGS);
> +    cap_sync_regs = true;
>       cap_async_pf = kvm_check_extension(s, KVM_CAP_ASYNC_PF);
>       cap_mem_op = kvm_check_extension(s, KVM_CAP_S390_MEM_OP);
>       cap_mem_op_extension = kvm_check_extension(s, KVM_CAP_S390_MEM_OP_EXTENSION);

