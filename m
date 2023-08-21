Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E880F782578
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 10:32:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY0Jj-0005SO-FM; Mon, 21 Aug 2023 04:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qY0Jc-0005Pe-0Q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qY0JW-0001RI-RP
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 04:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692606666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=osShmlhSLm6as0q0/K5ahFfuxapUA1DPWiguusUWPn8=;
 b=PRqIpua5QhnvwMyTjKh7AjogNVRnZ8djEjDthr06jkopxSU16hnV+SDskouOg1NLNYwTxF
 W9qTB1GfTXtg63Ok3fGKfV6GgwjWdhK7TqHQvIsx8GNr0VNqtVGajcWbj1CLc0jYUJAjH6
 SfXl49ax18t2tkmEJDZPzv88cMnmUtg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-1A8Fx_XgMyiXRf8OW7cPxA-1; Mon, 21 Aug 2023 04:31:04 -0400
X-MC-Unique: 1A8Fx_XgMyiXRf8OW7cPxA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b710c5677eso32335371fa.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692606663; x=1693211463;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=osShmlhSLm6as0q0/K5ahFfuxapUA1DPWiguusUWPn8=;
 b=Fapk5qOCDK25WGeV5iDpqjroHqb/TUE1ekNVmWrZGqthJq3FJPaaFnI9u9JwKWjLbM
 PtpEHfRXGQ635C4j+KGQSptwL0IcitHPutflBJgNcyAgAs8BqbSsDLZJ2rnAmBPB/etv
 BplyuqqpgS92evulJvfiKSr1cgq5anw8M2PBCrQIQ1QjM4Icj1nJi+6ZbRKQBCo1GX5d
 8JS4WJUV4nkfAiSHPFpLXker5XUU8Sad4XS+SngA4OcjwBp23AGKdOfF6dJnvqdcxLPS
 rZ0DAQ3MVlwh9SmCRc8YjIAKARR+Atlw1cVMgDBPt2kMjcjQKFpI+o72lcHE98l5Wp0p
 oDAA==
X-Gm-Message-State: AOJu0YykyHW5CJNzCeLTK4UXOdrMyUERQjQc0K03DjL6ZBaZzpU8uqSD
 K+m+TRFXL6QY07QE9vC73bqzrOvKLzmMXwChq0uV+4WIAGBC2c208hmBBNlKXJM/BQF2I13S0kJ
 XJktMCd570VDJjtQ=
X-Received: by 2002:a05:651c:14f:b0:2bc:c4af:36b9 with SMTP id
 c15-20020a05651c014f00b002bcc4af36b9mr289337ljd.52.1692606663184; 
 Mon, 21 Aug 2023 01:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF6drYz7yvz7YdUTHjtBy52bEREn41lFz+l7y/8u/T1VnaBRX89otvv8n+I/9GhD1cUmfMJg==
X-Received: by 2002:a05:651c:14f:b0:2bc:c4af:36b9 with SMTP id
 c15-20020a05651c014f00b002bcc4af36b9mr289312ljd.52.1692606662771; 
 Mon, 21 Aug 2023 01:31:02 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 15-20020a05600c028f00b003fee8793911sm6009011wmk.44.2023.08.21.01.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 01:31:02 -0700 (PDT)
Message-ID: <a68102e5-bc67-52b0-c72b-5bca9c472c4e@redhat.com>
Date: Mon, 21 Aug 2023 10:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/5] target/s390x: AP-passthrough for PV guests
Content-Language: en-US
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230818111520.698615-1-seiden@linux.ibm.com>
 <20230818111520.698615-6-seiden@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230818111520.698615-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.279, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On 18/08/2023 13.15, Steffen Eiden wrote:
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
...
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

Cosmetical nit: QEMU coding style mandates /* ... */ comments

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

Nit: Please remove the empty line.

> +    struct kvm_s390_vm_cpu_uv_feat uv_feat = {};
> +    struct kvm_device_attr attribute = {
> +        .group = KVM_S390_VM_CPU_MODEL,
> +        .attr = KVM_S390_VM_CPU_PROCESSOR_UV_FEAT_GUEST,
> +        .addr = (__u64) &uv_feat,
> +    };
> +
> +    // AP support check is currently the only user of the UV feature test.

Nit: /* ... */ comment, please

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

With the nits fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


