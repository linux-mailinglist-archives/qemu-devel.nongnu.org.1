Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635849B2A8F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 09:42:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5LJm-00076G-HB; Mon, 28 Oct 2024 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LJW-00074b-Dt
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5LJU-0002os-Uq
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 04:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730104884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1iXUFwt0qqJJD1gEo8JfaHTVjJrF7vv8mzvggylZaVI=;
 b=ZFFsAPotTOaYvGaGvt1f6sYstoZl4tOdrHLhvLNG2/NyCifWYwBfaWz4rz7u76MmXdBafG
 T2D+EWEXB/u3Az0RsygDd2XUls+aOLiLnk9G09veKhn9zxT9wP2b6lgP6UTwPhFF4AI51U
 L51AGQ6oclplHuGmS3yUA98HmY1T81E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-HUwmuZV7N5iF3kQAo7eL7g-1; Mon, 28 Oct 2024 04:41:21 -0400
X-MC-Unique: HUwmuZV7N5iF3kQAo7eL7g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431518e6d8fso30058685e9.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 01:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730104880; x=1730709680;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1iXUFwt0qqJJD1gEo8JfaHTVjJrF7vv8mzvggylZaVI=;
 b=tju4Uz1dqcS8A5wvbyld55WmKV4vu3lBhgBq8X0BnlzqCR/8twfENvj4g3qJRDeDtx
 8k+RLVWE9jki+5LOojTUP0IJlSmJ7+zWJxQcmIUJjX8NZS6MAAA9qXXorHVXFHYkzHh8
 t6xmxJG6TuQxY4pFYHKANXa2ha/M4h4zqf9uzLTokOdeMnOsE31r73on6WUpZsFJecEO
 lrLgVs6nWEr37FbTgF4Rwg/eMlxnG/nUNk+FqosEbZARiMcPmOsLMQKxhvG3rFfV+Lkk
 Fy8X+epvJk69jrrNA58XGOFruXColZVKjkpcszD8a4Ui/Njbq6gRPCTvXOFqwhqBJGpd
 od0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsKnDU1guVFPdxeZrKCJFqSsY0TUFmKVU4dqrcsSTcNr2+di2gc88lm2hthUHwj4fuwSa7Y0v3HFUt@nongnu.org
X-Gm-Message-State: AOJu0YwsGUCOjIKccvcU0boAv8wR4EtOSxr28OM8SGJ6yNSS0c/wrQgg
 yObW49vmxhmLewIjviG8Rzn1F8E1Y+jbRzhQ9sq+0a3YHP61rWFIdhBCD7o7n8MYDXOzXZXB8nj
 m2e/UMOnMnjopL4ruz9+meezjeuglghc0UpqB2aQUUESh10/sZBCk
X-Received: by 2002:a05:600c:19d3:b0:431:58c4:2eb9 with SMTP id
 5b1f17b1804b1-4319ac78f0cmr66124285e9.3.1730104878381; 
 Mon, 28 Oct 2024 01:41:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd+k0tsAIdgsyRxb3u9QEYAbKijzCZpR1Dme8HAZuOYEYBuZ6Pzo77eZ85GI5uS00f5fOUSQ==
X-Received: by 2002:a05:600c:19d3:b0:431:58c4:2eb9 with SMTP id
 5b1f17b1804b1-4319ac78f0cmr66123385e9.3.1730104876429; 
 Mon, 28 Oct 2024 01:41:16 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4318b567fe8sm131443385e9.28.2024.10.28.01.41.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 01:41:15 -0700 (PDT)
Message-ID: <3adc6dab-25c2-4303-b382-153e843123bf@redhat.com>
Date: Mon, 28 Oct 2024 09:41:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] target/i386: Add AVX512 state when AVX10 is supported
To: Tao Su <tao1.su@linux.intel.com>, qemu-devel@nongnu.org
Cc: mtosatti@redhat.com, xiaoyao.li@intel.com, xuelian.guo@intel.com
References: <20241028024512.156724-1-tao1.su@linux.intel.com>
 <20241028024512.156724-2-tao1.su@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241028024512.156724-2-tao1.su@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/24 03:45, Tao Su wrote:
> AVX10 state enumeration in CPUID leaf D and enabling in XCR0 register
> are identical to AVX512 state regardless of the supported vector lengths.
> 
> Given that some E-cores will support AVX10 but not support AVX512, add
> AVX512 state components to guest when AVX10 is enabled.
> 
> Tested-by: Xuelian Guo <xuelian.guo@intel.com>
> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
> ---
>   target/i386/cpu.c | 14 ++++++++++++++
>   target/i386/cpu.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1ff1af032e..d845ff5e4e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7177,6 +7177,13 @@ static void x86_cpu_reset_hold(Object *obj, ResetType type)
>           }
>           if (env->features[esa->feature] & esa->bits) {
>               xcr0 |= 1ull << i;
> +            continue;
> +        }
> +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> +            i == XSTATE_Hi16_ZMM_BIT) {

Can you confirm that XSTATE_ZMM_Hi256_BIT depends on AVX10 and not 
AVX10-512?

Thanks,

Paolo

> +            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +                xcr0 |= 1ull << i;
> +            }
>           }
>       }
>   
> @@ -7315,6 +7322,13 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
>           const ExtSaveArea *esa = &x86_ext_save_areas[i];
>           if (env->features[esa->feature] & esa->bits) {
>               mask |= (1ULL << i);
> +            continue;
> +        }
> +        if (i == XSTATE_OPMASK_BIT || i == XSTATE_ZMM_Hi256_BIT ||
> +            i == XSTATE_Hi16_ZMM_BIT) {
> +            if (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_AVX10) {
> +                mask |= (1ULL << i);
> +            }
>           }
>       }
>   
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 74886d1580..280bec701c 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -972,6 +972,8 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define CPUID_7_1_EDX_AMX_COMPLEX       (1U << 8)
>   /* PREFETCHIT0/1 Instructions */
>   #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
> +/* Support for Advanced Vector Extensions 10 */
> +#define CPUID_7_1_EDX_AVX10             (1U << 19)
>   /* Flexible return and event delivery (FRED) */
>   #define CPUID_7_1_EAX_FRED              (1U << 17)
>   /* Load into IA32_KERNEL_GS_BASE (LKGS) */


