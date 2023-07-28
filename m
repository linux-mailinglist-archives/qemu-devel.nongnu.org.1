Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50888766B0F
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 12:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPKqB-0007vl-PJ; Fri, 28 Jul 2023 06:36:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPKqA-0007vN-9H
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:36:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qPKq6-0001Jl-6l
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 06:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690540613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4+WD+oJa8nYd+z0ky9FsDiaESJOf6xk5ImQHMWwd1Q=;
 b=APsnwPemazFXkSN6+5yG8QR6RXXSOHiI4v9yVbAMykGSg9pPStu/rVXp2plwzCkcxVsRLF
 tynsGd2m8D0RMCUXEUNknwj4MKk4vISupPEwcXBcyajCXmhWnilJbp0PrnYmgwWxO92BwY
 imAF1/SCN2Dnck5A7Yt7/9yApv7OgUI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-Qbp427OtO_KoBFth9RU1sQ-1; Fri, 28 Jul 2023 06:36:51 -0400
X-MC-Unique: Qbp427OtO_KoBFth9RU1sQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fab61bb53bso2212494e87.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 03:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690540610; x=1691145410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c4+WD+oJa8nYd+z0ky9FsDiaESJOf6xk5ImQHMWwd1Q=;
 b=MxvMpDNwQrh12qg5WpNg1DUdUKmCse9atyYmRt5MJegLFYqNVtmRG53VNvDh9LtiRE
 ZVJ861tmvzp7ZqhWMVDTRaJI5hjPD2emrtv0Tq9hXvZPJLLLGGLGSENKPYtNfaVranVH
 O+nHK6YmLXrdtb1kyIpPZ7iCwsUzAJl2o4ErYdrivkbRqclWXjPoL+3befPaFiMCeKNg
 5kLyLfd6oTobHTw+q6zjIFFGTpOUiyzPgCtxedm80I8nvnDcIbr02AaSj+LbBF5FMWN3
 PHQI9fcGokikiRJj4DeXb6dWWkhQE1mx4z/nHsIgMa9QPKLNsOwmwcMUYQyHklbfqvQV
 Ci6w==
X-Gm-Message-State: ABy/qLaCdikYJu4nGQDAEKnh4jboLsBEEwM1cTGNnXldGadLiiSqnioU
 sJTUG1mRX0y+wIqqG/DoTxBmrYn6KrL99mbX3PddFK56acA++XlbBBznVhGotNOcrUPeLLptxnV
 2CwRQ0mntJ9twlxU=
X-Received: by 2002:a05:6512:1105:b0:4f9:570c:7b28 with SMTP id
 l5-20020a056512110500b004f9570c7b28mr1639939lfg.32.1690540610324; 
 Fri, 28 Jul 2023 03:36:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFe8wAX8ZdJkMwX6KemC6YSUlfj2CdJr8zigXg+ooE7FsZ8+AO8exX922Z1fhTxeBe+I3+Mwg==
X-Received: by 2002:a05:6512:1105:b0:4f9:570c:7b28 with SMTP id
 l5-20020a056512110500b004f9570c7b28mr1639920lfg.32.1690540609993; 
 Fri, 28 Jul 2023 03:36:49 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-20.web.vodafone.de.
 [109.43.178.20]) by smtp.gmail.com with ESMTPSA id
 r5-20020a056000014500b00314367cf43asm4388952wrx.106.2023.07.28.03.36.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 03:36:49 -0700 (PDT)
Message-ID: <6c81ff42-bcf4-367d-e34b-d3ab8e80c058@redhat.com>
Date: Fri, 28 Jul 2023 12:36:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/3] target/s390x: refractor AP functionalities
Content-Language: en-US
To: Steffen Eiden <seiden@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Marc Hartmayer <mhartmay@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20230727122503.775084-1-seiden@linux.ibm.com>
 <20230727122503.775084-3-seiden@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230727122503.775084-3-seiden@linux.ibm.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

In the subject: s/refractor/refactor/

Please also add a short patch description why you are doing these changes.

> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   target/s390x/kvm/kvm.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 3ac7ec9acf..bd62a7f606 100644
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

I'd maybe move the renaming into a separate patch.

> @@ -2296,6 +2296,11 @@ static int configure_cpu_subfunc(const S390FeatBitmap features)
>       return kvm_vm_ioctl(kvm_state, KVM_SET_DEVICE_ATTR, &attr);
>   }
>   
> +static bool ap_available(void)
> +{
> +    return kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, KVM_S390_VM_CRYPTO_ENABLE_APIE);

The line is already quite long ... maybe put it on two lines to avoid 
checkpatch.pl warnings.

> +}
> +
>   static int kvm_to_feat[][2] = {
>       { KVM_S390_VM_CPU_FEAT_ESOP, S390_FEAT_ESOP },
>       { KVM_S390_VM_CPU_FEAT_SIEF2, S390_FEAT_SIE_F2 },
> @@ -2475,8 +2480,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *model, Error **errp)
>           return;
>       }
>       /* for now, we can only provide the AP feature with HW support */
> -    if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO,
> -        KVM_S390_VM_CRYPTO_ENABLE_APIE)) {
> +    if (ap_available()) {
>           set_bit(S390_FEAT_AP, model->features);
>       }
>   
> @@ -2502,7 +2506,7 @@ static void kvm_s390_configure_apie(bool interpret)
>                                   KVM_S390_VM_CRYPTO_DISABLE_APIE;
>   
>       if (kvm_vm_check_attr(kvm_state, KVM_S390_VM_CRYPTO, attr)) {
> -        kvm_s390_set_attr(attr);
> +        kvm_s390_set_crypto_attr(attr);
>       }
>   }
>   
> @@ -2556,7 +2560,7 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
>           kvm_s390_enable_cmma();
>       }
>   
> -    if (test_bit(S390_FEAT_AP, model->features)) {
> +    if (ap_enabled(model->features)) {

You only introduce ap_enabled() in the next patch ... please move it here to 
avoid breaking bisection later.

  Thomas


>           kvm_s390_configure_apie(true);
>       }
>   }


