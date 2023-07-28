Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD03B766B61
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 13:08:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPLAk-0006vx-7F; Fri, 28 Jul 2023 06:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPLAe-0006vY-C0
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPLAc-0006gO-7h
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690541884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x6+On16pMWu4HbzOqczv2P/KK6BvXP+Wey6IL2hzO4Q=;
 b=BPpHek1/qqi7oRzF4/WCnayRR2a2wYPWPsqYRa04tq6Pv9OfQvUeq1yfs+3FWwlHMMcaUd
 WCwNrJX70KgqVEltoH8PHzGXJuG54DQZD4/8Do9MXBezAklTdwugPq9YsSE06b0FcTiAYE
 +/MLhMjvUiRblsY0AgJss3X7G2Us5TY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-kOlPVx_eNHG8EwdJmJGJkQ-1; Fri, 28 Jul 2023 06:58:03 -0400
X-MC-Unique: kOlPVx_eNHG8EwdJmJGJkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so10982855e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 03:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690541882; x=1691146682;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6+On16pMWu4HbzOqczv2P/KK6BvXP+Wey6IL2hzO4Q=;
 b=RfSqxlknqY+XG6dCt1kJ4b2gqwHneSz1loXj5iFtUdUieDTHgqixjEOhE6oB0+NbNB
 RDT4qOStcA90MlhQsE28iwJnzheQJjBuln7MXkZxpFWjptwNHLkjptgWOikp61Oq0WTc
 +jGR6/rCJN2t/gzPJEGszt0nf0/VKmv1L5JUUBLewmki9LTd8SO6hXJV/h6A/DdgCEZ/
 pq6MzrvxLoQvTt41IHoxba3x407s2aM1Izs+CVkMnwuWGCBABHoFEbuVD4o/gVvvCDKU
 ZzZpsk8UNv7oRVRMWoeP1aJVO3dor6F6uxDLge2oYFaVs8QVvZc3DytMpdpvklJPXuq7
 3OcA==
X-Gm-Message-State: ABy/qLYaEcOaEi6/rLaAlhmzGsJaRGV8QqPq0OSydSWinW7Z9Sz3gR+n
 HnR2Oj3J6wLGXZ+FWBBoj/UvNzfrd105BLgAqATJIhjqv1qL6U0nYTJun32P4yD7kOJOnZcncBA
 Bo7gOMP9dEICmisE=
X-Received: by 2002:a05:600c:2213:b0:3fd:e94f:1283 with SMTP id
 z19-20020a05600c221300b003fde94f1283mr1667711wml.1.1690541882655; 
 Fri, 28 Jul 2023 03:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHwgH4TdB+szaKSS572+p7M4h0P44cKBwb6OsFZmlVzWXivj6MdyN5N8gBufD+rVhzwxzfHug==
X-Received: by 2002:a05:600c:2213:b0:3fd:e94f:1283 with SMTP id
 z19-20020a05600c221300b003fde94f1283mr1667689wml.1.1690541882281; 
 Fri, 28 Jul 2023 03:58:02 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 k8-20020a056000004800b003141a3c4353sm4543056wrx.30.2023.07.28.03.58.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 03:58:01 -0700 (PDT)
Message-ID: <292db65f-3a91-4aeb-d154-7cf2cf689781@redhat.com>
Date: Fri, 28 Jul 2023 12:58:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
 <20230727122503.775084-4-seiden@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/3] target/s390x: AP-passthrough for PV guests
In-Reply-To: <20230727122503.775084-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 27/07/2023 14.25, Steffen Eiden wrote:
> Enabling AP-passthrough(AP-pt) for PV-guest via using the new CPU

Either "via the new" or "by using the new", but "via using" sounds weird to me.

> features for PV-AP-pt of kvm.
> 
> As usual QEMU first checks which CPU features are available and then
> sets them if available and selected by user. An additional check is done
> to verify that PV-AP can only be enabled if "regular" AP-pt is enabled
> as well. Note that KVM itself does not enforce this restriction.
> 
> If regular AP-pt is enabled and kvm/firmware supports PV-AP-pt it is
> also turned on by default.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   target/s390x/cpu_features.h         |  1 +
>   target/s390x/cpu_features_def.h.inc |  4 ++
>   target/s390x/cpu_models.c           |  2 +
>   target/s390x/gen-features.c         |  4 ++
>   target/s390x/kvm/kvm.c              | 73 +++++++++++++++++++++++++++++
>   5 files changed, 84 insertions(+)
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
>   } S390FeatType;
>   
>   /* Definition of a CPU feature */
> diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
> index e3cfe63735..4b659d4064 100644
> --- a/target/s390x/cpu_features_def.h.inc
> +++ b/target/s390x/cpu_features_def.h.inc
> @@ -379,3 +379,7 @@ DEF_FEAT(DEFLATE_GHDT, "dfltcc-gdht", DFLTCC, 1, "DFLTCC GDHT")
>   DEF_FEAT(DEFLATE_CMPR, "dfltcc-cmpr", DFLTCC, 2, "DFLTCC CMPR")
>   DEF_FEAT(DEFLATE_XPND, "dfltcc-xpnd", DFLTCC, 4, "DFLTCC XPND")
>   DEF_FEAT(DEFLATE_F0, "dfltcc-f0", DFLTCC, 192, "DFLTCC format 0 parameter-block")
> +
> +/* Features exposed via the UV-CALL instruction */
> +DEF_FEAT(UV_CALL_AP, "appv", UV_CALL, 4, "AP instructions installed for secure guests")
> +DEF_FEAT(UV_CALL_AP_INTR, "appvi", UV_CALL, 5, "AP instructions interpretion for secure guests")
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index ae8880e81d..6d703b3c55 100644
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
> index 1e3b7c0dc9..0220864d89 100644
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
> @@ -671,6 +673,8 @@ static uint16_t default_GEN16_GA1[] = {
>       S390_FEAT_RDP,
>       S390_FEAT_PAI,
>       S390_FEAT_PAIE,
> +    S390_FEAT_UV_CALL_AP,
> +    S390_FEAT_UV_CALL_AP_INTR,
>   };

If you want to change the default model, you need to disable the bits again 
in older machine types, otherwise we'll run into migration issues later. See 
for example commit 1d41de5f0524b00a3e for how to do this correctly.

You might also want to pull in
  https://lore.kernel.org/qemu-devel/20230718142235.135319-1-cohuck@redhat.com/
to avoid contextual conflicts later.

>   /* QEMU (CPU model) features */
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index bd62a7f606..cf11bfb0fa 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -2301,6 +2301,39 @@ static bool ap_available(void)
>       return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, KVM_S390_VM_CRYPTO_ENABLE_APIE);
>   }
>   
> +static bool uv_feat_supported(void)
> +{
> +    return kvm_vm_check_attr(
> +            kvm_state, KVM_S390_VM_CPU_MODEL, KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST);
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
> +    if (!uv_feat_supported())
> +        return 0;
> +
> +    rc = kvm_vm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
> +    if (rc) {
> +        return  rc;
> +    }
> +
> +    if (ap_available()) {
> +        if (prop.ap)
> +            set_bit(S390_FEAT_UV_CALL_AP, features);
> +        if (prop.ap_intr)
> +            set_bit(S390_FEAT_UV_CALL_AP_INTR, features);

Missing curly braces. Please check your patches with "scripts/checkpatch.pl".

> +    }
> +    return 0;
> +}
> +
>   static int kvm_to_feat[][2] = {
>       { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
>       { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
> @@ -2495,11 +2528,44 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
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
> +static bool ap_enabled(const S390FeatBitmap features)
> +{
> +    return test_bit(S390_FEAT_AP, features);
> +}
> +
> +static int configure_uv_feat_guest(const S390FeatBitmap features, bool interpret)
> +{
> +
> +    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CPU_MODEL,
> +        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
> +        .addr = (__u64)&uv_feat,
> +    };
> +
> +    if (!uv_feat_supported())
> +        return 0;
> +
> +    if (ap_enabled(features)) {
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
> @@ -2563,6 +2629,13 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>       if (ap_enabled(model->features)) {
>           kvm_s390_configure_apie(true);
>       }
> +
> +    /* configure uv features for the guest indicated via query / test_bit*/
> +    rc = configure_uv_feat_guest(model->features, true);
> +    if (rc) {
> +        error_setg(errp, "KVM: Error configuring CPU UV features %d", rc);
> +        return;
> +    }
>   }
>   
>   void kvm_s390_restart_interrupt(S390CPU *cpu)

  Thomas


