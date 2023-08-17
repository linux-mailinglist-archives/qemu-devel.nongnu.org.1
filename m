Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB37B77F6A0
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWcMH-0004Ek-Ck; Thu, 17 Aug 2023 08:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mimu@linux.ibm.com>)
 id 1qWcMF-0004EO-Ij; Thu, 17 Aug 2023 08:44:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mimu@linux.ibm.com>)
 id 1qWcMC-0008Qr-Lm; Thu, 17 Aug 2023 08:44:11 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HCaiuH008945; Thu, 17 Aug 2023 12:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ziVAZDh+iUU2eWm4TIwty/UTRfnL9sED1ZGENRE1xDI=;
 b=Aak5pw3JguDHBmkVFX7J8eFs4wx7pb2sevCXPhw10M08yk6rwFQsawjpb6twt1VWrrKm
 CnrCXxBAZHq3XrJVGiJLAsN/misIjquemyGH28f9PnLiRuHkvdh+xF336P0w3ljoCUyK
 aUGT5GmrR1fWWOaKYpP3ECRSBGprv9PeuRU81DljxJzaJRNS6yDYvfssqtj8EnfJAJUj
 FyQhzwM3oPXZlBat95VU9+bytIADIZhLxcgnoB9Oygyyk4l5oaQ61DuxeWJbxoLkae2K
 5SD6ve1pBYMW14WwWErHtWc1Z/ljffqrhh3mY9xpv4mOwZ0Uxq+NeP4wx0qXs4Njdbjg 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shkm8g8rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 12:44:04 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HCatUC010741;
 Thu, 17 Aug 2023 12:44:04 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shkm8g8qv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 12:44:04 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HBHkxD018848; Thu, 17 Aug 2023 12:44:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3seq41wg67-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 12:44:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37HCi0i038404534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 12:44:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B351720043;
 Thu, 17 Aug 2023 12:44:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 660A220040;
 Thu, 17 Aug 2023 12:44:00 +0000 (GMT)
Received: from [9.152.224.236] (unknown [9.152.224.236])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Aug 2023 12:44:00 +0000 (GMT)
Message-ID: <e8320e83-0b5d-f397-6a32-a48ecb8be5b0@linux.ibm.com>
Date: Thu, 17 Aug 2023 14:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] target/s390x/kvm: Refactor AP functionalities
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230810124719.2167260-1-seiden@linux.ibm.com>
 <20230810124719.2167260-3-seiden@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
In-Reply-To: <20230810124719.2167260-3-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dg3RphfmryCoJhigTIoZgJigUsfNlqxl
X-Proofpoint-ORIG-GUID: hAom12Mj7BoiJy7kqWOTRCTXb-pW5eiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_06,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170114
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mimu@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 10.08.23 14:47, Steffen Eiden wrote:
> kvm_s390_set_attr() is a misleading name as it only sets attributes for
> the KVM_S390_VM_CRYPTO group. Therefore, rename it to
> kvm_s390_set_crypto_attr().
> 
> Add new functions ap_available() and ap_enabled() to avoid code
> duplication later.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Michael Mueller <mimu@linux.ibm.com>

> ---
>   target/s390x/kvm/kvm.c | 24 +++++++++++++++++-------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a9e5880349..a7e2cdf668 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -250,7 +250,7 @@ static void kvm_s390_enable_cmma(void)
>       trace_kvm_enable_cmma(rc);
>   }
> 
> -static void kvm_s390_set_attr(uint64_t attr)
> +static void kvm_s390_set_crypto_attr(uint64_t attr)
>   {
>       struct kvm_device_attr attribute = {
>           .group = KVM_S390_VM_CRYPTO,
> @@ -275,7 +275,7 @@ static void kvm_s390_init_aes_kw(void)
>       }
> 
>       if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
> -            kvm_s390_set_attr(attr);
> +            kvm_s390_set_crypto_attr(attr);
>       }
>   }
> 
> @@ -289,7 +289,7 @@ static void kvm_s390_init_dea_kw(void)
>       }
> 
>       if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
> -            kvm_s390_set_attr(attr);
> +            kvm_s390_set_crypto_attr(attr);
>       }
>   }
> 
> @@ -2296,6 +2296,17 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>       return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>   }
> 
> +static bool ap_available(void)
> +{
> +    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> +                             KVM_S390_VM_CRYPTO_ENABLE_APIE);
> +}
> +
> +static bool ap_enabled(const S390FeatBitmap features)
> +{
> +    return test_bit(S390_FEAT_AP, features);
> +}
> +
>   static int kvm_to_feat[][2] = {
>       { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
>       { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
> @@ -2475,8 +2486,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           return;
>       }
>       /* for now, we can only provide the AP feature with HW support */
> -    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> -        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
> +    if (ap_available()) {
>           set_bit(S390_FEAT_AP, model->features);
>       }
> 
> @@ -2502,7 +2512,7 @@ static void kvm_s390_configure_apie(bool interpret)
>                                   KVM_S390_VM_CRYPTO_DISABLE_APIE;
> 
>       if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
> -        kvm_s390_set_attr(attr);
> +        kvm_s390_set_crypto_attr(attr);
>       }
>   }
> 
> @@ -2556,7 +2566,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>           kvm_s390_enable_cmma();
>       }
> 
> -    if (test_bit(S390_FEAT_AP, model->features)) {
> +    if (ap_enabled(model->features)) {
>           kvm_s390_configure_apie(true);
>       }
>   }

