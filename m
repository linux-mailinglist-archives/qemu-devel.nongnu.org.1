Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0241F753A3E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKHO6-00020l-K5; Fri, 14 Jul 2023 07:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKHO3-0001zp-JY
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:55:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qKHO1-0002ph-T7
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689335701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfkiYUL728MDCvndIk8b+5CA3jKluY50D3rtm9bCJXA=;
 b=ag3p+14eCOaBKWDPUQ9fTpBD67RZAjOG+NPluXbetc5kVi7OojY4j3BHs8Nz9xPA9tqXv/
 znH6WXP/9w0F2tlIsxbo+oEwDf85Qz5mLdBdW+RZ43REMZn3lETL8xWodSbc7Q20mOoufF
 Wrm8dgyddiPHZ7UvRTXLCQAp0mn+WGU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-PMgifD8_PVGaBryYwm4kSA-1; Fri, 14 Jul 2023 07:55:00 -0400
X-MC-Unique: PMgifD8_PVGaBryYwm4kSA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7656c94fc4eso229662985a.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 04:55:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689335699; x=1691927699;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bfkiYUL728MDCvndIk8b+5CA3jKluY50D3rtm9bCJXA=;
 b=dtQ+GyLSk0LVDx6ezYVnnMpMPgNSY5lkmWCPqmmPg+DT2CWiODSWR4axda6Sq/k4Ok
 Cyl/9rUgNTEY9ZTxylUp4Bm+/9AbaUZj1Uh02rR8rj1VUkCbTdH+6+EmElb8lrqYOFTS
 7n1yiwNukc9QLGXdrNKsV99XEBG26UIsHxmT62S7ZjpvN/Ja5woSLj6uRMcQ6/tyz+gG
 AGfcOnMSfnsJ03yL2Ssc36B3sGt+kna4bUmLVE4HnELiFBsrgac8dszmnXjKGdXgfn8A
 a/gMqzr0pJjLaIiva/2GbNf1MV9YlQksfjVy+pJ60g0mFiPrD8kaIMmVi4vOA/+V0U9j
 A38w==
X-Gm-Message-State: ABy/qLbkSHIcN42IpS3Lpz2XOg5PAPbRmA9qiej6LDglH/OQ1FfZY4c6
 QhBKNFC9YKG2xjKbtgitEsi0XNDtTzWAup+CyLP+3N2EVitFWs/a4KIPzOW2qFz31m5zLd0TR+E
 cFzA17n1N075xjSSm73n1kus=
X-Received: by 2002:a05:620a:280d:b0:765:9f15:c324 with SMTP id
 f13-20020a05620a280d00b007659f15c324mr4372123qkp.48.1689335699705; 
 Fri, 14 Jul 2023 04:54:59 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHxSH037V+eORMPeEl3XFxkgOaoqTLf8p52tyCFqOnN9ty4IvLqcCVAjbRR8IxkKzooqaPIZw==
X-Received: by 2002:a05:620a:280d:b0:765:9f15:c324 with SMTP id
 f13-20020a05620a280d00b007659f15c324mr4372114qkp.48.1689335699404; 
 Fri, 14 Jul 2023 04:54:59 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-249.web.vodafone.de.
 [109.43.177.249]) by smtp.gmail.com with ESMTPSA id
 c16-20020a05620a11b000b0076738337cd1sm3755764qkk.1.2023.07.14.04.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 04:54:58 -0700 (PDT)
Message-ID: <dbec4d9b-b3d8-0b39-9be9-2e3fb312b39a@redhat.com>
Date: Fri, 14 Jul 2023 13:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH, trivial 13/29] tree-wide spelling fixes in comments and
 some messages: s390x
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <20230714113834.1186117-15-mjt@tls.msk.ru>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230714113834.1186117-15-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 14/07/2023 13.38, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   hw/intc/s390_flic_kvm.c          | 2 +-
>   include/hw/s390x/s390-pci-bus.h  | 2 +-
>   include/hw/s390x/sclp.h          | 2 +-
>   target/s390x/cpu_features.c      | 2 +-
>   target/s390x/cpu_models.c        | 2 +-
>   target/s390x/tcg/fpu_helper.c    | 2 +-
>   target/s390x/tcg/insn-data.h.inc | 2 +-
>   target/s390x/tcg/translate.c     | 2 +-
>   tests/tcg/s390x/mvc.c            | 2 +-
>   9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
> index 4e86d2d436..28364b22d6 100644
> --- a/hw/intc/s390_flic_kvm.c
> +++ b/hw/intc/s390_flic_kvm.c
> @@ -382,3 +382,3 @@ static void kvm_s390_release_adapter_routes(S390FLICState *fs,
>    * Note: Pass buf and len to kernel. Start with one page and
> - * increase until buffer is sufficient or maxium size is
> + * increase until buffer is sufficient or maximum size is
>    * reached
> diff --git a/include/hw/s390x/s390-pci-bus.h b/include/hw/s390x/s390-pci-bus.h
> index e0a9f9385b..b1bdbeaeb5 100644
> --- a/include/hw/s390x/s390-pci-bus.h
> +++ b/include/hw/s390x/s390-pci-bus.h
> @@ -186,3 +186,3 @@ enum ZpciIoatDtype {
>    *           state and enabled via clp enable/disable
> - * enbaled: device is ready for use; transition to disabled via clp disable;
> + * enabled: device is ready for use; transition to disabled via clp disable;
>    *          may enter an error state
> diff --git a/include/hw/s390x/sclp.h b/include/hw/s390x/sclp.h
> index d3ade40a5a..cf1f2efae2 100644
> --- a/include/hw/s390x/sclp.h
> +++ b/include/hw/s390x/sclp.h
> @@ -89,3 +89,3 @@
>    *   alter the structure while we parse it. We cannot use ldl_p and friends
> - *   either without doing pointer arithmetics
> + *   either without doing pointer arithmetic
>    * So we have to double check that all users of sclp data structures use the
> diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
> index ebb155ce1c..d28eb65845 100644
> --- a/target/s390x/cpu_features.c
> +++ b/target/s390x/cpu_features.c
> @@ -251,3 +251,3 @@ static void init_groups(void)
>   
> -    /* init all bitmaps from gnerated data initially */
> +    /* init all bitmaps from generated data initially */
>       for (i = 0; i < ARRAY_SIZE(s390_feature_groups); i++) {
> diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
> index 42b52afdb4..91ce896491 100644
> --- a/target/s390x/cpu_models.c
> +++ b/target/s390x/cpu_models.c
> @@ -977,3 +977,3 @@ static void register_types(void)
>   
> -    /* init all bitmaps from gnerated data initially */
> +    /* init all bitmaps from generated data initially */
>       s390_init_feat_bitmap(qemu_max_init, qemu_max_cpu_feat);
> diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
> index 4b7fa58af3..5364372c8b 100644
> --- a/target/s390x/tcg/fpu_helper.c
> +++ b/target/s390x/tcg/fpu_helper.c
> @@ -88,3 +88,3 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
>        * FIXME:
> -     * 1. Right now, all inexact conditions are inidicated as
> +     * 1. Right now, all inexact conditions are indicated as
>        *    "truncated" (0) and never as "incremented" (1) in the DXC.
> diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
> index 457ed25d2f..555c147c7c 100644
> --- a/target/s390x/tcg/insn-data.h.inc
> +++ b/target/s390x/tcg/insn-data.h.inc
> @@ -531,3 +531,3 @@
>       C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
> -/* LOAD LOGICAL IMMEDATE */
> +/* LOAD LOGICAL IMMEDIATE */
>       D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 6661b27efa..94c8c1f9aa 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -431,3 +431,3 @@ static void gen_program_exception(DisasContext *s, int code)
>   {
> -    /* Remember what pgm exeption this was.  */
> +    /* Remember what pgm exception this was.  */
>       tcg_gen_st_i32(tcg_constant_i32(code), cpu_env,
> diff --git a/tests/tcg/s390x/mvc.c b/tests/tcg/s390x/mvc.c
> index 7ae4c44550..b572aa3ced 100644
> --- a/tests/tcg/s390x/mvc.c
> +++ b/tests/tcg/s390x/mvc.c
> @@ -87,3 +87,3 @@ int main(void)
>   
> -    /* test if MVC works now correctly accross page boundaries */
> +    /* test if MVC works now correctly across page boundaries */
>       mvc_256(dst + 4096 - 128, src + 4096 - 128);

Reviewed-by: Thomas Huth <thuth@redhat.com>


