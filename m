Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4EB785340
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 10:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYjeM-0004yL-EG; Wed, 23 Aug 2023 04:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mimu@linux.ibm.com>)
 id 1qYjdy-0004cW-58; Wed, 23 Aug 2023 04:55:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mimu@linux.ibm.com>)
 id 1qYjdv-00008h-TA; Wed, 23 Aug 2023 04:55:13 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37N8Vrae006423; Wed, 23 Aug 2023 08:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1Ymh8D0zhjj4UYuRLDQlgwYzZyTriWvKg9F+r1RZxqU=;
 b=Z8c+4tIFBkX0ck6tDc4ATXmjM+Xf5IBzlFYgrHQMv5Dz9yVoDEKleBJjrFjYBQ5AozZn
 G6qY+bHuXgRpqq89axJVzkj97pPT6Q3T4nyrL6clpRwa+sMd/hqDtwGY3w8OBzqSTFyT
 hdBalcK1eE0j5p1XBcxkv7Jegm/BaMUuuysiQSeGlxmGgWRwl+aPPKa6A/0StrSWGZin
 84tYryH822zl8cGxPPeYxH33xBRFjPDh/gj9rYSiKDtGLmQEqtp3RDj8ASoT8gOZ+lAW
 JQTXIN8jRV/mTG2UYuApE87/+D0uHk+VMGA4Po7aUcutIwHT4nqgboGROpsEIc4XCxpr IA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snepbgqp9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 08:55:07 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37N8X0cd012416;
 Wed, 23 Aug 2023 08:55:06 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snepbgqp3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 08:55:06 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 37N7AEBU010305; Wed, 23 Aug 2023 08:55:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sn21smyw6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 23 Aug 2023 08:55:05 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 37N8t2oi45154716
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 23 Aug 2023 08:55:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5F4492004B;
 Wed, 23 Aug 2023 08:55:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B7BAE20040;
 Wed, 23 Aug 2023 08:55:01 +0000 (GMT)
Received: from [9.179.28.253] (unknown [9.179.28.253])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 23 Aug 2023 08:55:01 +0000 (GMT)
Message-ID: <08f3ffbc-2af6-8c4c-0152-3358d514e91e@linux.ibm.com>
Date: Wed, 23 Aug 2023 10:55:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 5/5] target/s390x: AP-passthrough for PV guests
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230818111520.698615-1-seiden@linux.ibm.com>
 <20230818111520.698615-6-seiden@linux.ibm.com>
From: Michael Mueller <mimu@linux.ibm.com>
In-Reply-To: <20230818111520.698615-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XlaXfSDxd9VNCVBSKvFnaSbXG4fAr4AY
X-Proofpoint-GUID: 5azIjCfkkQQfjwDAFFkwaAN1XSgMobFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230077
Received-SPF: pass client-ip=148.163.156.1; envelope-from=mimu@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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



On 18.08.23 13:15, Steffen Eiden wrote:
> Enabling AP-passthrough(AP-pt) for PV-guest by using the new CPU
> features for PV-AP-pt of KVM.
> 
> As usual QEMU first checks which CPU features are available and then
> sets them if available and selected by user. An additional check is done
> to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
> as well. Note that KVM itself does not enforce this restriction.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Signed-off-by: Michael Mueller <sMIMU@linux.ibm.com>

with the findings from Thomas H. integrated

> ---
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.h.inc |  4 ++
>   target/s390x/cpu_models.c           |  2 +
>   target/s390x/gen-features.c         |  2 +
>   target/s390x/kvm/kvm.c              | 71 +++++++++++++++++++++++++++++
>   5 files changed, 80 insertions(+)
> 
> diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
> index 87463f064d..a9bd68a2e1 100644
> --- a/target/s390x/cpu_features.h
> +++ b/target/s390x/cpu_features.h
> @@ -43,6 +43,7 @@ typedef enum {
>       S390_FEAT_TYPE_KDSA,
>       S390_FEAT_TYPE_SORTL,
>       S390_FEAT_TYPE_DFLTCC,
> +    S390_FEAT_TYPE_UV_FEAT_GUEST,
>   } S390FeatType;
> 
>   /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e3cfe63735..e68da9b8ff 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
>   DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
>   DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
>   DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
> +
> +/* Features exposed via the UV-CALL instruction */
> +DEF_FEAT(UV_FEAT_AP, "appv", UV_FEAT_GUEST, 4, "AP instructions installed for secure guests")
> +DEF_FEAT(UV_FEAT_AP_INTR, "appvi", UV_FEAT_GUEST, 5, "AP instructions interruption support for secure guests")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 42b52afdb4..65331c37a3 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -483,6 +483,8 @@ static void check_consistency(const S390CPUModel *model)
>           { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
>           { S390_FEAT_NNPA, S390_FEAT_VECTOR },
>           { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
> +        { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
> +        { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
>       };
>       int i;
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 1e3b7c0dc9..2b2bfc3736 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -576,6 +576,8 @@ static uint16_t full_GEN16_GA1[] = {
>       S390_FEAT_RDP,
>       S390_FEAT_PAI,
>       S390_FEAT_PAIE,
> +    S390_FEAT_UV_FEAT_AP,
> +    S390_FEAT_UV_FEAT_AP_INTR,
>   };
> 
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index a7e2cdf668..937387a768 100644
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
> +    // AP support check is currently the only user of the UV feature test.
> +    if (!(uv_feat_supported() && ap_available())) {
> +        return 0;
> +    }
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +    if (rc) {
> +        return  rc;
> +    }
> +
> +    if (prop.ap) {
> +        set_bit(S390_FEAT_UV_FEAT_AP, features);
> +    }
> +    if (prop.ap_intr) {
> +        set_bit(S390_FEAT_UV_FEAT_AP_INTR, features);
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_to_feat[][2] = {
>       { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
>       { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
> @@ -2501,11 +2537,39 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
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
> +static int configure_uv_feat_guest(const S390FeatBitmap features)
> +{
> +
> +    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CPU_MODEL,
> +        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
> +        .addr = (__u64) &uv_feat,
> +    };
> +
> +    // AP support check is currently the only user of the UV feature test.
> +    if (!(uv_feat_supported() && ap_enabled(features))) {
> +        return 0;
> +    }
> +
> +    if (test_bit(S390_FEAT_UV_FEAT_AP, features)) {
> +        uv_feat.ap = 1;
> +    }
> +    if (test_bit(S390_FEAT_UV_FEAT_AP_INTR, features)) {
> +        uv_feat.ap_intr = 1;
> +    }
> +
> +    return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attribute);
> +}
> +
>   static void kvm_s390_configure_apie(bool interpret)
>   {
>       uint64_t attr = interpret ? KVM_S390_VM_CRYPTO_ENABLE_APIE :
> @@ -2569,6 +2633,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>       if (ap_enabled(model->features)) {
>           kvm_s390_configure_apie(true);
>       }
> +
> +    /* configure UV-features for the guest indicated via query / test_bit */
> +    rc = configure_uv_feat_guest(model->features);
> +    if (rc) {
> +        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
> +        return;
> +    }
>   }
> 
>   void kvm_s390_restart_interrupt(S390CPU *cpu)

