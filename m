Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7A5746BAE
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbD0-0005C4-C6; Tue, 04 Jul 2023 04:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbCv-0005AD-Ev
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:16:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGbCt-0002oD-Mo
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688458578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t4xxOJDAzd2LO5tzQ5BcfVjqxcGWCRldLx3zkcpNxSc=;
 b=NrEi0rl0UzYjhHvqUq90Jwv/FMJsBltKPXO57Gx/X14yjbxXaRodmZO6RziOr8z9clsB7k
 WaL5sSu2Chax7lEi30Zpz7M0ZZoXvddMT3RJVHNuU5fAlk5a/ER1rYN1PBreVpy3GjMqXH
 gZ+6q9Ap+jrzIIxGb/ZdzOkKFy9Ad84=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-cC2Yjup5OJC15ZJZRsmopA-1; Tue, 04 Jul 2023 04:16:17 -0400
X-MC-Unique: cC2Yjup5OJC15ZJZRsmopA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e6153f0eeso3016713f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458576; x=1691050576;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t4xxOJDAzd2LO5tzQ5BcfVjqxcGWCRldLx3zkcpNxSc=;
 b=VXgJOWWtq3xvb5sVK0YTjjUdd5ssahzBoXWJAdlm2Jutx8kTSDvL9L7pv6XSRg4TrO
 VFm6SdO3nRq8RNOlLb0X1ISwLQHrJHFzSvoyHrDnOiHi0wqkJOtrF9NqR9B50EoMkdMA
 pa+0jaBghXxbfar2noh/ITozRb+OTWBKa97RszWmcHEh8S1osPu0OjDfmiH8gcvCRze8
 bWdt4KYNxsmEK8w8vQTaMaOcabI1IJqWw2gO7tuCMs/8L1SvJ/9BD3fyH8pUCfEPsOnv
 y7CrdEAzenzLBEZv0Bz/xv+8PZjfhsFS9N7cHmOY3o9p0e4HwK4lmBkkk0U85NTGZT5w
 iENg==
X-Gm-Message-State: ABy/qLZnP6fCMK2TLntDilcGAqPJNtn2uxpj/MVbeozND0JYzKitkRkl
 1CYa6dgUmG4R+0L458nlPa6vsQzyk/XrM8/XAHR3bl/7dDFPkd8ZKsEBzuOkTM4bLToUXfIFbD+
 Xwfkjh6fyJ7tC3jA=
X-Received: by 2002:adf:fec3:0:b0:314:1318:18b7 with SMTP id
 q3-20020adffec3000000b00314131818b7mr8452503wrs.19.1688458574563; 
 Tue, 04 Jul 2023 01:16:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFp6lujHaD30MrIenNWNjzoVaRPAT3IQSw8Aa2b2cB53s8mwvbNASwK5bbAITNlAXDi9i8C1A==
X-Received: by 2002:adf:fec3:0:b0:314:1318:18b7 with SMTP id
 q3-20020adffec3000000b00314131818b7mr8452447wrs.19.1688458571573; 
 Tue, 04 Jul 2023 01:16:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 v11-20020adff68b000000b0031424950a99sm10459405wrp.81.2023.07.04.01.16.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 01:16:11 -0700 (PDT)
Message-ID: <770132f6-be52-c310-167f-c438b6d0bf70@redhat.com>
Date: Tue, 4 Jul 2023 10:16:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 05/12] target/s390x: Fix LRA overwriting the top 32
 bits on DAT error
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230704081506.276055-1-iii@linux.ibm.com>
 <20230704081506.276055-6-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230704081506.276055-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 04.07.23 10:12, Ilya Leoshkevich wrote:
> When a DAT error occurs, LRA is supposed to write the error information
> to the bottom 32 bits of R1, and leave the top 32 bits of R1 alone.
> 
> Fix by passing the original value of R1 into helper and copying the
> top 32 bits to the return value.
> 
> Fixes: d8fe4a9c284f ("target-s390: Convert LRA")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/helper.h         | 2 +-
>   target/s390x/tcg/mem_helper.c | 4 ++--
>   target/s390x/tcg/translate.c  | 2 +-
>   3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 6bc01df73d7..05102578fc9 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -355,7 +355,7 @@ DEF_HELPER_FLAGS_4(idte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
>   DEF_HELPER_FLAGS_4(ipte, TCG_CALL_NO_RWG, void, env, i64, i64, i32)
>   DEF_HELPER_FLAGS_1(ptlb, TCG_CALL_NO_RWG, void, env)
>   DEF_HELPER_FLAGS_1(purge, TCG_CALL_NO_RWG, void, env)
> -DEF_HELPER_2(lra, i64, env, i64)
> +DEF_HELPER_3(lra, i64, env, i64, i64)
>   DEF_HELPER_1(per_check_exception, void, env)
>   DEF_HELPER_FLAGS_3(per_branch, TCG_CALL_NO_RWG, void, env, i64, i64)
>   DEF_HELPER_FLAGS_2(per_ifetch, TCG_CALL_NO_RWG, void, env, i64)
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 84ad85212c9..f417fb1183c 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -2356,7 +2356,7 @@ void HELPER(purge)(CPUS390XState *env)
>   }
>   
>   /* load real address */
> -uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
> +uint64_t HELPER(lra)(CPUS390XState *env, uint64_t r1, uint64_t addr)
>   {
>       uint64_t asc = env->psw.mask & PSW_MASK_ASC;
>       uint64_t ret, tec;
> @@ -2370,7 +2370,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
>       exc = mmu_translate(env, addr, MMU_S390_LRA, asc, &ret, &flags, &tec);
>       if (exc) {
>           cc = 3;
> -        ret = exc | 0x80000000;
> +        ret = (r1 & 0xFFFFFFFF00000000ULL) | exc | 0x80000000;
>       } else {
>           cc = 0;
>           ret |= addr & ~TARGET_PAGE_MASK;
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 0cef6efbef4..a6079ab7b4f 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -2932,7 +2932,7 @@ static DisasJumpType op_lctlg(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_lra(DisasContext *s, DisasOps *o)
>   {
> -    gen_helper_lra(o->out, cpu_env, o->in2);
> +    gen_helper_lra(o->out, cpu_env, o->out, o->in2);
>       set_cc_static(s);
>       return DISAS_NEXT;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


