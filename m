Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1937E77F5E6
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 14:02:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbhK-0004SW-4g; Thu, 17 Aug 2023 08:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qWbhG-0004GR-C7; Thu, 17 Aug 2023 08:01:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frankja@linux.ibm.com>)
 id 1qWbhC-0003fa-Ty; Thu, 17 Aug 2023 08:01:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HC0mVS026627; Thu, 17 Aug 2023 12:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : to : cc : references : from : subject : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cbmmiXQ0EtNB23pXi2Ny/HvQifoU0eE9EVBrosOSiK8=;
 b=cX3bxVErz4Bt+Q7/kwh5wYAVB+VLVQldYWqQL9p6W/bermST2G0QUlSIo8IbsL+8btVR
 Z+gsx68vLOIch7rF/WN3cu983J3uAyJQ2xw3pNtHh+cH8cli29iniowJFODAJFSk5FpC
 GjMHxCn3URncbOlToCYZVaFezV0zloPMfw8GafGkVDHUv/pQui5vhpzkSq6HsFsN/rJf
 qIkQfK63+DhRyZCZGjs+Xyo/Bd2yIh+wU+qqZ4h9jFOm0m1yosh4LSZrARJb52zbu67c
 7xPBuplLSjl6nVBUj/UKRLvNY26QobZ/1S1Y8vCph/rTlMq7glDlBPuElbUoMKJxncpf fw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shk6ag0n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 12:01:43 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37HC12jW027071;
 Thu, 17 Aug 2023 12:01:43 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3shk6ag0mw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 12:01:43 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37HBlf6S007871; Thu, 17 Aug 2023 11:56:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3senwknnmf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 17 Aug 2023 11:56:39 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37HBuatb42336936
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 17 Aug 2023 11:56:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 17FA72004B;
 Thu, 17 Aug 2023 11:56:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98C4020040;
 Thu, 17 Aug 2023 11:56:35 +0000 (GMT)
Received: from [9.171.23.254] (unknown [9.171.23.254])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 17 Aug 2023 11:56:35 +0000 (GMT)
Message-ID: <efbaaabe-7875-dbb5-fc98-9e9e0ff918d8@linux.ibm.com>
Date: Thu, 17 Aug 2023 13:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230810124719.2167260-1-seiden@linux.ibm.com>
 <20230810124719.2167260-4-seiden@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v2 3/3] target/s390x: AP-passthrough for PV guests
In-Reply-To: <20230810124719.2167260-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QncVCoA67tWzWpPfi8U9aogGX4637c70
X-Proofpoint-GUID: IJsGSKX1B2lqj930c1pX4AwRYyQ1roa8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170104
Received-SPF: pass client-ip=148.163.158.5; envelope-from=frankja@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 8/10/23 14:47, Steffen Eiden wrote:
> Enabling AP-passthrough(AP-pt) for PV-guest by using the new CPU
> features for PV-AP-pt of KVM.
> 
> As usual QEMU first checks which CPU features are available and then
> sets them if available and selected by user. An additional check is done
> to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
> as well. Note that KVM itself does not enforce this restriction.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.h.inc |  4 ++
>   target/s390x/cpu_models.c           |  2 +
>   target/s390x/gen-features.c         |  2 +
>   target/s390x/kvm/kvm.c              | 73 +++++++++++++++++++++++++++++
>   5 files changed, 82 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 87463f064d..40928c60e9 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -43,6 +43,7 @@ typedef enum {
>       S390_FEAT_TYPE_KDSA,
>       S390_FEAT_TYPE_SORTL,
>       S390_FEAT_TYPE_DFLTCC,
> +    S390_FEAT_TYPE_UV_CALL,

You've named them UV features in the KVM patches.
None of this is "call" related.

Also you made a point of having the word "guest" in the KVM features

>   } S390FeatType;
>   
>   /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e3cfe63735..9a2c5a9dfc 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
>   DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
>   DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
>   DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
> +
> +/* Features exposed via the UV-CALL instruction */
> +DEF_FEAT(UV_CALL_AP, "appv", UV_CALL, 4, "AP instructions installed for secure guests")
> +DEF_FEAT(UV_CALL_AP_INTR, "appvi", UV_CALL, 5, "AP instructions interpretation for secure guests")

*INTERRUPTION* support

The AP instructions are nearly fully interpreted in secure guests for 
security reasons. The only time we see an AP instruction is for defining 
the notification byte for the interrupt support since we need to pin the 
page on which the byte resides.

Have a look what the feature for STFLE 65 says and either keep the INTR 
or use the suffix that's defined there

> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 42b52afdb4..a7900a8a5c 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -483,6 +483,8 @@ static void check_consistency(const S390CPUModel *model)
>           { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>           { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>           { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
> +        { S390_FEAT_UV_CALL_AP, S390_FEAT_AP },
> +        { S390_FEAT_UV_CALL_AP_INTR, S390_FEAT_UV_CALL_AP },
>       };
>       int i;
>   
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 1e3b7c0dc9..6ae10a2cd8 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -576,6 +576,8 @@ static uint16_t full_GEN16_GA1[] = {
>       S390_FEAT_RDP,
>       S390_FEAT_PAI,
>       S390_FEAT_PAIE,
> +    S390_FEAT_UV_CALL_AP,
> +    S390_FEAT_UV_CALL_AP_INTR,
>   };
>   
>   
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a7e2cdf668..500b9d894d 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2307,6 +2307,42 @@ static bool ap_enabled(const S390FeatBitmap features)
>       return test_bit(S390_FEAT_AP, features);
>   }
>   
> +static bool uv_feat_supported(void)
> +{
> +    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CPU_MODEL,
> +                             KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST);
> +}
> +
> +static int query_uv_feat_guest(S390FeatBitmap features)
> +{
> +    struct kvm_s390_vm_cpu_uv_feat prop = {};
> +    struct kvm_device_attr attr = {
> +        .group = KVM_S390_VM_CPU_MODEL,
> +        .attr = KVM_S390_VM_CPU_MACHINE_UV_FEAT_GUEST,
> +        .addr = (uint64_t) &prop,
> +    };
> +    int rc;
> +
> +    if (!uv_feat_supported()) {
> +        return 0;
> +    }
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +    if (rc) {
> +        return  rc;
> +    }
> +
> +    if (ap_available()) {

Can this be made into an early return?

> +        if (prop.ap) {
> +            set_bit(S390_FEAT_UV_CALL_AP, features);
> +        }
> +        if (prop.ap_intr) {
> +            set_bit(S390_FEAT_UV_CALL_AP_INTR, features);
> +        }
> +    }
> +    return 0;
> +}
> +
>   static int kvm_to_feat[][2] = {
>       { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
>       { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
> @@ -2501,11 +2537,41 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           set_bit(S390_FEAT_DIAG_318, model->features);
>       }
>   
> +    /* Test for Ultravisor features that influence secure guest behavior */
> +    query_uv_feat_guest(model->features);
> +
>       /* strip of features that are not part of the maximum model */
>       bitmap_and(model->features, model->features, model->def->full_feat,
>                  S390_FEAT_MAX);
>   }
>   
> +static int configure_uv_feat_guest(const S390FeatBitmap features,
> +                                   bool interpret)
> +{
> +
> +    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CPU_MODEL,
> +        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
> +        .addr = (__u64) &uv_feat,
> +    };
> +
> +    if (!uv_feat_supported()) {
> +        return 0;
> +    }
> +
> +    if (ap_enabled(features)) {

Same early return check please

> +        if (test_bit(S390_FEAT_UV_CALL_AP, features)) {
> +            uv_feat.ap = 1;
> +        }
> +        if (test_bit(S390_FEAT_UV_CALL_AP_INTR, features) && interpret) {
> +            uv_feat.ap_intr = 1;
> +        }
> +    }
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
> +}
> +
>   static void kvm_s390_configure_apie(bool interpret)
>   {
>       uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
> @@ -2569,6 +2635,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>       if (ap_enabled(model->features)) {
>           kvm_s390_configure_apie(true);
>       }
> +
> +    /* configure UV-features for the guest indicated via query / test_bit */
> +    rc = configure_uv_feat_guest(model->features, true);
> +    if (rc) {
> +        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
> +        return;
> +    }
>   }
>   
>   void kvm_s390_restart_interrupt(S390CPU *cpu)


