Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A404670AD96
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:22:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0h8E-0006kn-1S; Sun, 21 May 2023 07:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0h8B-0006jy-Pk
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:21:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0h8A-00066C-9E
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:21:43 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-306dbad5182so3137415f8f.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684668100; x=1687260100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dCh+hlTdEWNjJQJKuUCqGkPVAOw7rrMFajVBY7eVVvQ=;
 b=waUiS0AKM2I5Y5F/DqPysrAgcH7cEPo0AaBlLAqaDhJlmFLF5GU7abE8NjD79Fehpk
 x8zie3Ww1GLQucOCIwcdFcxyfHg66FWdF/lwR/kT/IHX9CNdU4hfpQyfkUJ91UOMv2cR
 OAfVfNAGgMkN1o8G2lD07a+xaE4mgFsxEcK8AeAXKq0IPRa8nEXLPQn/VBfLZFcvYvyq
 TTLYqtpBKwTAepk4bGBtew/oYpIGNxRgpYOzN4U/jSY7Rz/1isMp7fcWQyF30L5D1NZD
 BSqs0vfrlHvwDeuCubkaPW3S3xKJOuIIrNLHvK/xXUJWcovUuXj/ULAJXbZtCYUd/eSt
 i+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684668100; x=1687260100;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dCh+hlTdEWNjJQJKuUCqGkPVAOw7rrMFajVBY7eVVvQ=;
 b=ACVXe1miAVwQCuQheGXo7YJavli92ruuVipTA4T5YBKcxutC6EiGNsCI7DWLAISJmv
 v9VLRlaXAf4fZtYd29KX8tukyRPbrrhSn49UscRX0Bg0QGYyOt3taM/0IgVtZ2iUpHbx
 12vBd9FRO+3juhxRJKCx5zlEizAp1wabaQb7xo4fR5BmTENo1B9NsmfZ86SN/awhji5l
 4RBAqOIXyC9wtEwd4dJQQaTFGuXJYGTtn/CD0qg5XkphKxZX3exCMtEdoBr2+y8cBQX6
 LhHFIfsQTSLJpB93qprH+QuFAkKc9fhSWCUWEo9/bWKMYzbpp2c7pQwoo0t13C4Fdpye
 F0gg==
X-Gm-Message-State: AC+VfDwbP6U1By/g3txhd7vAY7wxb9j+lwKZmhNx2E+WMdYVnwdtx7W8
 4zNYhSpYVOeOrtBLaDnpLRBVBg+Kch3tS9ijWHA=
X-Google-Smtp-Source: ACHHUZ4UvtiFg1kkBIMfDdnJOpc84NfASjzE4uLdHsGLql7ThoMPzBQIewCOpbulVgGHrQz1zQjwRA==
X-Received: by 2002:a5d:5448:0:b0:2f5:8e8b:572c with SMTP id
 w8-20020a5d5448000000b002f58e8b572cmr4663335wrv.49.1684668100557; 
 Sun, 21 May 2023 04:21:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 z16-20020a5d4d10000000b002f6176cc6desm4370836wrt.110.2023.05.21.04.21.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 04:21:40 -0700 (PDT)
Message-ID: <a56f5acc-5716-8598-e49c-d1f6c19e144f@linaro.org>
Date: Sun, 21 May 2023 13:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 17/27] target/s390x: Use cpu_{ld,st}*_mmu in do_csst
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-18-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230520162634.3991009-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Richard,

On 20/5/23 18:26, Richard Henderson wrote:
> Use cpu_ld16_mmu and cpu_st16_mmu to eliminate the special case,
> and change all of the *_data_ra functions to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: qemu-s390x@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/mem_helper.c | 65 ++++++++++++++---------------------
>   1 file changed, 26 insertions(+), 39 deletions(-)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index 0e0d66b3b6..b6cf24403c 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -1737,6 +1737,9 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>                           uint64_t a2, bool parallel)
>   {
>       uint32_t mem_idx = cpu_mmu_index(env, false);
> +    MemOpIdx oi16 = make_memop_idx(MO_TE | MO_128, mem_idx);
> +    MemOpIdx oi8 = make_memop_idx(MO_TE | MO_64, mem_idx);


>               if (parallel) {
>   #ifdef CONFIG_ATOMIC64
> -                MemOpIdx oi = make_memop_idx(MO_TEUQ | MO_ALIGN, mem_idx);
> -                ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi, ra);
> +                ov = cpu_atomic_cmpxchgq_be_mmu(env, a1, cv, nv, oi8, ra);

Why is it safe to remove MO_ALIGN here?

>   #else
>                   /* Note that we asserted !parallel above.  */
>                   g_assert_not_reached();
>   #endif


