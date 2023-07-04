Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 437F2746B0B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:48:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGalM-0004lX-R1; Tue, 04 Jul 2023 03:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGalJ-0004l9-MX
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGalI-0004dH-1p
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688456867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0SbKCNe6BdHfKIlX4BvMGHq+RaGPfMPpELRYI6ofAX8=;
 b=OIHnaQ00vfdvquWCuZAf+wFqHMl+j5yPMuLX4ZDfxibWOMdyrrQx8A5JgaPY80FvMyW3JE
 SUmdKPqNNltJedLzJDNRQQWHB5EtSdrzNlG1gPk37V53I0aBr3p8kNv12Fm7rktFHjCckD
 ve4pTouxgD+2LGigTSTSaDdhUVCj0cY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-y3BORRStOI6VaMdN-hya9w-1; Tue, 04 Jul 2023 03:47:45 -0400
X-MC-Unique: y3BORRStOI6VaMdN-hya9w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa8d203eccso22554745e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688456864; x=1691048864;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0SbKCNe6BdHfKIlX4BvMGHq+RaGPfMPpELRYI6ofAX8=;
 b=g0sWOQKudKrLUdjJh55/uHsAlO/Ftxh8EG3jFKNS/zOhuxPzIVkwrHcxkUMxlj+reG
 CvT+tmpZ6NRKbv1CMC2TIa93O/4cK5CRpgBD+CPPAN4bSLColWkx3T3kAPJNnL1OnlNO
 1fqEf/nkO3glf8jiqlQJ0WxEDRU4jib10sBJTf5Z/lILk25VAZVVYyyvjXzkZDEa8u1e
 oFs/mAosKk3G9fcw/Q9U38EquWNcS5Ht8jLc0/hLKfbv0YMl03PUpHUD8jSjibvR+6Cd
 /tbX++bzFq/QWjHiDOk0uE3676e1CLh8keEK7D7q7sy7GEIqho0AvxuJSZhgXfeAKo6L
 SW9Q==
X-Gm-Message-State: ABy/qLb3fhvWUAyEACULwRNg6HQPpwUC677be5opni3mlgXLs2FR+Zp3
 SRHyTFZXqomHohoPUuli4L4YQbMrXOrKxW98Yy8cEeprwpl8tMwLCzTjZZqp7ESqvXSBM+LsmNh
 K1j+eS0uDytuiN2c=
X-Received: by 2002:a5d:4bd0:0:b0:314:423c:95a3 with SMTP id
 l16-20020a5d4bd0000000b00314423c95a3mr456595wrt.9.1688456864654; 
 Tue, 04 Jul 2023 00:47:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGc+GQHTCjEOAQlVVEzFBhqmTOzplJ6unKE+xas8wiYY8ipIfiFpT+cUl0serjYzzPTcXZjlQ==
X-Received: by 2002:a5d:4bd0:0:b0:314:423c:95a3 with SMTP id
 l16-20020a5d4bd0000000b00314423c95a3mr456582wrt.9.1688456864324; 
 Tue, 04 Jul 2023 00:47:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adff306000000b00311339f5b06sm27434780wro.57.2023.07.04.00.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:47:43 -0700 (PDT)
Message-ID: <b105761d-9602-030a-e578-12d9cd0a0283@redhat.com>
Date: Tue, 4 Jul 2023 09:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-6-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 05/12] target/s390x: Fix LRA overwriting the top 32 bits
 on DAT error
In-Reply-To: <20230703155801.179167-6-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
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
> index 84ad85212c9..94d93d7ea78 100644
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
> +        ret = (r1 & 0xFFFFFFFF00000000) | exc | 0x80000000;

ull missing for large constant?

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

Can't we use something like in1_r1 + wout_r1_32 instead ? *maybe* cleaner :)

-- 
Cheers,

David / dhildenb


