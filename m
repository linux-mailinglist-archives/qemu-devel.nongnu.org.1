Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D33766A9B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJwv-0006Fn-4c; Fri, 28 Jul 2023 05:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qPJws-0006Et-HS; Fri, 28 Jul 2023 05:39:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seiden@linux.ibm.com>)
 id 1qPJwq-0004Uh-Cd; Fri, 28 Jul 2023 05:39:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36S9c0XA024713; Fri, 28 Jul 2023 09:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=VHK1LVFTUni/dq44FULBMmBw36Nn7CGUI7tutYo/Qs0=;
 b=Ocrqb6Ck270ckG3ake11n31zGEC2Wf5quNRhpRbtMGRqytqxtGDAe60ivDuBFpYXW6Gt
 fh0Kll4MBNz4tYUrYHmf9OO/nVFV2IQVfcFe5JRSrG/iK+BBwc6yQPfyyF8aS9SFGCyC
 1g1hg69V6gnYzhgNoD7MipJu7Q7X6WxLQEhmioMDIZ88AIgLQS21bk4sneylk9JaAwtY
 0ntA3It/bNWW0OtZUbGeiVEJVtOP1CfSebT+9pGNfspVCOhL4RpnC9klkfjBeMDQV/s+
 NrfcDv6rYFeWVxlSlnCdcUIU2aEbEz8FuTSE3y7IZd02xtJWSkFP2IIthawvNIi+By5P iA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4av28pcn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:39:46 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36S9cg4C028337;
 Fri, 28 Jul 2023 09:39:43 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s4av28p8e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:39:42 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 36S7wwKr002181; Fri, 28 Jul 2023 09:39:35 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0unk4hnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 28 Jul 2023 09:39:35 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 36S9dYfE34210290
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jul 2023 09:39:34 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3420A58062;
 Fri, 28 Jul 2023 09:39:34 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEE0E58052;
 Fri, 28 Jul 2023 09:39:32 +0000 (GMT)
Received: from [9.171.58.222] (unknown [9.171.58.222])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Jul 2023 09:39:32 +0000 (GMT)
Message-ID: <c1c7fd52-2584-415d-78ef-8ffa71668687@linux.ibm.com>
Date: Fri, 28 Jul 2023 11:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/3] KVM: s390: Enable AP instructions for pv-guests
From: Steffen Eiden <seiden@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20230727122503.775084-1-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0nyStWpDb0vcK1R4kimWT6crr1cfTAh1
X-Proofpoint-GUID: FzCEgt2SSfukZxNIzDu6zGeaZjl3RUAS
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=473 impostorscore=0 clxscore=1015 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280087
Received-SPF: pass client-ip=148.163.158.5; envelope-from=seiden@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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


On 7/27/23 14:25, Steffen Eiden wrote:
> This series enables general QEMU support for AP pass-through for Secure
> Execution guests (pv-guests).
> 
> To enable AP-PT on pv-guests QEMU has to turn on the corresponding bits
> in the KVM CPU-model[1] if the CPU firmware supports it. However, it
> only makes sense to turn on AP-PT if the QEMU user enabled (general) AP
> for that guest. If AP is turned on (ap=on) QEMU also turns on AP-PT for
> secure execution guests(appv=on) if the CPU supports it.
> 
> The series consists of three patches:
>   1) update kvm-s390 header for this series
>   2) small cleanup for kvm_s390_set_attr()
>      refactor code to add ap_available()
>   3) Add UV_CALL CPU model enablement
> 
> There is **one** problem with the current implementation:
> If the user does not enable AP in the cpu model QEMU produces the
> following warning:
> ```
> qemu-system-s390x: warning: 'appv' requires 'ap'.
> ```
> 
> During `check_consistency()` the model has appv=on and ap=offi, hence
> the warning. However, appv is not turned on during the model
> realization, as the code checks for AP in beforehand.
> 
> appv is in the default z16 model so that it is automatically enabled if
> ap=on was specified.
> 
> I did not find a concept of dynamic defaults to model this behavior
> (ap=on -> appv=on -> appvi=on). So I hope someone on the list can help
> me and give some pointers on how to implement that.
> 
> 
> Steffen

[1] v2 KVM series:
https://lore.kernel.org/linux-s390/20230728092341.1131787-1-seiden@linux.ibm.com/T/#t

> 
> Steffen Eiden (3):
>    linux-headers: update asm-s390/kvm.h
>    target/s390x: refractor AP functionalities
>    target/s390x: AP-passthrough for PV guests
> 
>   linux-headers/asm-s390/kvm.h        | 21 +++++++
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.h.inc |  4 ++
>   target/s390x/cpu_models.c           |  2 +
>   target/s390x/gen-features.c         |  4 ++
>   target/s390x/kvm/kvm.c              | 91 ++++++++++++++++++++++++++---
>   6 files changed, 116 insertions(+), 7 deletions(-)
> 

