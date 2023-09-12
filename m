Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0179D337
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:07:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg42B-0002YY-V0; Tue, 12 Sep 2023 10:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg429-0002FY-Bv
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg426-0004yu-Me
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694527583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se7hqQXQMKrYV5KqZThGeZ3NRXLMJ2EyFNldKIrj/Kc=;
 b=etc0LjeWyAcSdGoa/wUmm0YDfaCC3tIMSnHp5PxyA/FaZ5p2LtaW+6eQ00Kol8dXIbFyNb
 2y+KHOH3DaQ1WRX0rPG75bKpqcJOVi1vwhzWiS4CX3k5r2tyJWmVH00m75x+aqxTCXndqh
 uCzNFVtHMMlwnSoQT3v2vhEulqKocs8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-O0sQyZ9jMqug_0SmUbvYIQ-1; Tue, 12 Sep 2023 10:05:32 -0400
X-MC-Unique: O0sQyZ9jMqug_0SmUbvYIQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31facb07f53so859641f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527522; x=1695132322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Se7hqQXQMKrYV5KqZThGeZ3NRXLMJ2EyFNldKIrj/Kc=;
 b=pQ5nRBJyNEWQ5o8x5+8cXx/xFiwj6ICijh+o8ceCrx1n1KnZaAFXlDXQhswWrggEb4
 APfYJ0xwioXEdo/G7qszhh1hMGyXHNTVJul5fOVZFjs+bI6M+wJlbH5gjreMuzY7QT+N
 Ay/EAldBOAQg4t1/E+CkG72zKqBo7q1b1pvByoGPK3T9NrPJqh0Co4nez7AlUYHxaRiT
 6LY51ZTUgc2tbih8WjHIWI2tZzRAEvm39Hlw/T1GGggV4dYSts98x/jZviRv0tLQydr3
 3hk1S5HY69gNviT4HxyzFF74r8pXOVxhpP2N7Fd8D3EUWGbDUDelEqM2TjgXleuSYUlH
 Sv6w==
X-Gm-Message-State: AOJu0YzkOiw6dL1Lc4U0M34vL8L84+TYGPmkniUJ2hZA6mjiVbEeauxg
 S/8HC7DV1uVJb2XiKDfppzZj4DceQ3rFMzMLCS4d0Qe0Y3shySvXC+KPnp5l70luDr84Q+mD4tM
 JFwJR1/MI9K6mz3bYVx/xvbU=
X-Received: by 2002:a5d:60cf:0:b0:319:6ed2:a5c4 with SMTP id
 x15-20020a5d60cf000000b003196ed2a5c4mr1981263wrt.26.1694527521947; 
 Tue, 12 Sep 2023 07:05:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwvhGWr+8e/BfJGS8trosITGG6jjfK+GccPrMCMaQFMHkG9Oz3yizJcHxtDxGBOSe4tBw8yg==
X-Received: by 2002:a5d:60cf:0:b0:319:6ed2:a5c4 with SMTP id
 x15-20020a5d60cf000000b003196ed2a5c4mr1981205wrt.26.1694527520907; 
 Tue, 12 Sep 2023 07:05:20 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 v17-20020a5d6791000000b00318147fd2d3sm12934675wru.41.2023.09.12.07.05.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 07:05:20 -0700 (PDT)
Message-ID: <c33130ec-661a-a1ed-c285-eeaa52365358@redhat.com>
Date: Tue, 12 Sep 2023 16:05:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v4 2/3] target/i386: Restrict system-specific features
 from user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20230911211317.28773-1-philmd@linaro.org>
 <20230911211317.28773-3-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230911211317.28773-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/11/23 23:13, Philippe Mathieu-Daudé wrote:
>   /*
>    * Only for builtin_x86_defs models initialized with x86_register_cpudef_types.
>    */
> @@ -6163,6 +6195,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>               }
>               *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
>   
> +#ifndef CONFIG_USER_ONLY
>               /*
>                * SGX cannot be emulated in software.  If hardware does not
>                * support enabling SGX and/or SGX flexible launch control,
> @@ -6181,6 +6214,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>                       CPUID_7_0_ECX_SGX_LC))) {
>                   *ecx &= ~CPUID_7_0_ECX_SGX_LC;
>               }
> +#endif

This can use a variant of x86_cpu_get_supported_cpuid that returns a 
single register; or it can be rewritten to use x86_cpu_get_supported_cpuid.

In general, a lot of checks for accel_uses_host_cpuid() are unnecessary, 
and the code can be modified to not depend on either KVM or HVF.

>           } else if (count == 1) {
>               *eax = env->features[FEAT_7_1_EAX];
>               *edx = env->features[FEAT_7_1_EDX];
> @@ -6876,6 +6910,8 @@ static void mce_init(X86CPU *cpu)
>       }
>   }
>   
> +#ifndef CONFIG_USER_ONLY
> +
>   static void x86_cpu_adjust_level(X86CPU *cpu, uint32_t *min, uint32_t value)
>   {
>       if (*min < value) {
> @@ -6948,6 +6984,8 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>       env->features[FEAT_XSAVE_XSS_HI] = mask >> 32;
>   }
>   
> +#endif /* !CONFIG_USER_ONLY */

These functions should all be used in user-mode emulation as well.

>   /***** Steps involved on loading and filtering CPUID data
>    *
>    * When initializing and realizing a CPU object, the steps
> @@ -7040,6 +7078,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           }
>       }
>   
> +#ifndef CONFIG_USER_ONLY
>       if (!kvm_enabled() || !cpu->expose_kvm) {
>           env->features[FEAT_KVM] = 0;
>       }

This is "!kvm_enabled()" so it should be kept for user-mode emulation.

> @@ -7111,6 +7150,8 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>           return;
>       }
>   
> +#endif /* !CONFIG_USER_ONLY */
>       /* Set cpuid_*level* based on cpuid_min_*level, if not explicitly set */
>       if (env->cpuid_level_func7 == UINT32_MAX) {
>           env->cpuid_level_func7 = env->cpuid_min_level_func7;
> @@ -7152,6 +7193,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>           mark_unavailable_features(cpu, w, unavailable_features, prefix);
>       }
>   
> +#ifndef CONFIG_USER_ONLY
>       if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) &&
>           kvm_enabled()) {
>           KVMState *s = CPU(cpu)->kvm_state;
> @@ -7179,6 +7221,7 @@ static void x86_cpu_filter_features(X86CPU *cpu, bool verbose)
>               mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_INTEL_PT, prefix);
>           }
>       }
> +#endif

This need not be limited to KVM, it can likewise use 
x86_cpu_get_supported_cpuid.

Paolo

>   }
>   
>   static void x86_cpu_hyperv_realize(X86CPU *cpu)


