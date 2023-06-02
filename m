Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDC5720114
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q53Vc-0001Rt-38; Fri, 02 Jun 2023 08:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53VZ-0001RU-1f
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:03:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q53VU-0002WL-B5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685707427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y9FYgijqbdPVdOHd7sBUthps96NEZKryTUtg66M2yv8=;
 b=Ul1OgLiXffREwGZ/52Lb+EI0dF1aCFqqBUqHJlgM6yhptE8nhClgRy1WLxG0NX69U7mPwQ
 Ur7YmUOtD9EujAhv7IkI83G3H4ok/CmrS6S4AVEnrRemQXfLu141ubU95P036yK08uewg6
 i6es4dPxiDjjPUMflbmPKKWfXDVIi/I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-wiLeL_hlMoKB2oWRSavpAw-1; Fri, 02 Jun 2023 08:03:45 -0400
X-MC-Unique: wiLeL_hlMoKB2oWRSavpAw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30ad0812151so1005568f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:03:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685707424; x=1688299424;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y9FYgijqbdPVdOHd7sBUthps96NEZKryTUtg66M2yv8=;
 b=iyvxznK/gCJk50szjAFNeSqFNNACvdsrnpyV2Hg8iUA4BTX7veuhzfihJ6BEt131/n
 y4+gjheY8tkQvTPeGb4C7+KZVyNdhfqXZT+0ArmQ33DvCjGxI9aLTagTMWoqnNmS+KeM
 uQGWZflEG8x7/PYy++GjMSE29LooEMIhpm9hfO2hmS8M/lECD6AAX540Ln6mikOKMdGW
 kA9a3Qr1HxdaAt94pRCM/Sc4/2/uUsR4FT0FzyjkR8yDAbxib4sQrzRoEDB2lGRaJLQc
 kjRR8sA3EYed/3IdfTkOBfjDy5dKmjW5kuVEhRsL6PiujNuaaaUosBNWAlHxbdRxT09t
 Aapw==
X-Gm-Message-State: AC+VfDyMfQoSNfKvR2r4U8ooS+KUgbwnjPKoIr4poElNv77Jmk3uD1CF
 yEjdeRdKjI6/6bOhLMGioNSwiWPD4gHMzKDUNehsqE0964Cnuqyp0C+jo1gCA8St04q+L8autxw
 iyzgdDpLvSSjbnkM=
X-Received: by 2002:a5d:6542:0:b0:2f7:8f62:1a45 with SMTP id
 z2-20020a5d6542000000b002f78f621a45mr4450176wrv.66.1685707424430; 
 Fri, 02 Jun 2023 05:03:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7942bzxQHxzTl8cCQFlVLHcTDIkHkf51cG9OFo+AmdgygPpwDfPUZU9YGhnuKPoPzE4WE1XA==
X-Received: by 2002:a5d:6542:0:b0:2f7:8f62:1a45 with SMTP id
 z2-20020a5d6542000000b002f78f621a45mr4450157wrv.66.1685707424058; 
 Fri, 02 Jun 2023 05:03:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a5d6786000000b003078cd719ffsm1502741wru.95.2023.06.02.05.03.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:03:43 -0700 (PDT)
Message-ID: <70d4cda5-d87a-0582-0b86-f180f27584b3@redhat.com>
Date: Fri, 2 Jun 2023 14:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/4] s390x/tcg: Fix CPU address returned by STIDP
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
References: <20230601162541.689621-1-iii@linux.ibm.com>
 <20230601162541.689621-2-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601162541.689621-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 01.06.23 18:25, Ilya Leoshkevich wrote:
> In qemu-user-s390x, /proc/cpuinfo contains:
> 
>      cpu number      : 0
>      identification  : 000000
> 
>      cpu number      : 1
>      identification  : 400000
> 
> The highest nibble is supposed to contain the CPU address, but it's off
> by 2 bits. Fix the shift value and provide a symbolic constant for it.
> 

Would be helpful to show the output with this fix.

> Fixes: 076d4d39b65f ("s390x/cpumodel: wire up cpu type + id for TCG")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/cpu_models.c |  4 ++--
>   target/s390x/cpu_models.h | 10 +++++++++-
>   2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 457b5cb10c4..ae8880e81dc 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -607,8 +607,8 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
>   #if !defined(CONFIG_USER_ONLY)
>       cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
>       if (tcg_enabled()) {
> -        /* basic mode, write the cpu address into the first 4 bit of the ID */
> -        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
> +        cpu->env.cpuid = deposit64(cpu->env.cpuid, CPU_PHYS_ADDR_SHIFT,
> +                                   CPU_PHYS_ADDR_BITS, cpu->env.core_id);
>       }
>   #endif
>   }
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index fb1adc8b210..cc7305ec213 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -96,10 +96,18 @@ static inline bool s390_known_cpu_type(uint16_t type)
>   {
>       return s390_get_gen_for_cpu_type(type) != 0;
>   }
> +#define CPU_ID_SHIFT 32
> +#define CPU_ID_BITS 24
> +/*
> + * When cpu_id_format is 0 (basic mode), the leftmost 4 bits of cpu_id contain
> + * the rightmost 4 bits of the physical CPU address.
> + */
> +#define CPU_PHYS_ADDR_BITS 4
> +#define CPU_PHYS_ADDR_SHIFT (CPU_ID_SHIFT + CPU_ID_BITS - CPU_PHYS_ADDR_BITS)
>   static inline uint64_t s390_cpuid_from_cpu_model(const S390CPUModel *model)
>   {
>       return ((uint64_t)model->cpu_ver << 56) |
> -           ((uint64_t)model->cpu_id << 32) |
> +           ((uint64_t)model->cpu_id << CPU_ID_SHIFT) |
>              ((uint64_t)model->def->type << 16) |
>              (model->def->gen == 7 ? 0 : (uint64_t)model->cpu_id_format << 15);
>   }

Thanks!

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb


