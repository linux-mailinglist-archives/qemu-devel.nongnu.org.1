Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F77740C7A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 11:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qERGE-0001wr-If; Wed, 28 Jun 2023 05:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERGB-0001wU-KH
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:14:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qERG8-0005oo-4b
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 05:14:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa99f6a4a1so32445415e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687943680; x=1690535680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ARYV02Jdpox+u+co30Tt5vOPwjF2ZX3ItzKd8SZDTLc=;
 b=MT7NtfztkhwxQND4mW0nfkBSZGkjdaFlEoJv9gBeHX74IKTT7L4n6WaI8Uffd27EVS
 yuYFkhtectwyGxE0nUxRE2lESXW8HG4GRpjVeDS0swdoVJZenPaGVem2kT0swoU6HMPC
 saZks8vEWsMPA/agAfLWxX+0koecC0JXCad9R3pV2EIWWJx2KExANetKfXAdc1N1NcAr
 vQXBOd1Jm0m47foUysNGMVTSUrYE7T31qf+JaZgGlX0ctBvcRG8FPBlR9Cg3blKq1hjy
 nLplD9PNwFBxlkFG4uoEEpLhXBtxjJ/BYWs8055jzytMJTFMXVJtAs+6gGxrpXnf1rO5
 SWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687943680; x=1690535680;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ARYV02Jdpox+u+co30Tt5vOPwjF2ZX3ItzKd8SZDTLc=;
 b=MlwT6ktrWqIdbkiQbMUWPCIT+oGEcz5I8jlLxVe+fiXbR/aPMAFadZCWv09A0VmNSP
 7A/kR8p/7/2UKRMg+jYO6vEcUOmfdZnxbGhuWRSMvywKsx6UfqpbdKXGT6Is1naKZ0N9
 sGO3hYhUCgQMQ0rAbsbTQJnvUSHbOhtZcp8cmJwHpLKOmuEszdhDAXwCZjEl4YdfZHs5
 xA64NhGBQhALp6Y/rirEUHbXc5wIChc8fxmwZjI9pjgkpwhgFTrcKUOItTBjTJa53K7q
 r1hZp5E9RPjLVvo8aIroKX8cbyHGl5dO++FPPx40Bun4Jz0xAD0JkVtBxIKqTqrbK9nV
 B0uQ==
X-Gm-Message-State: AC+VfDzefcpH/wU1B+Dqw2SJpm/evMHUf/aMlEWGRWqDJh4cthZI7DW9
 e0dYfOlUYXC27QrVGLZ6q4xSUQ==
X-Google-Smtp-Source: ACHHUZ7+R7+hvko6P1WTlaocnzqZoyTFtXGoiVXpDfao6l4Z3+C0o3YCoBtFGjJA66COfnwGzxF1eg==
X-Received: by 2002:a7b:c852:0:b0:3fb:415a:d07 with SMTP id
 c18-20020a7bc852000000b003fb415a0d07mr4775640wml.36.1687943679910; 
 Wed, 28 Jun 2023 02:14:39 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a7bc399000000b003fa96fe2bebsm8198909wmj.41.2023.06.28.02.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 02:14:39 -0700 (PDT)
Message-ID: <1aef4266-e196-ccfb-6631-bbefef96111b@linaro.org>
Date: Wed, 28 Jun 2023 11:14:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 10/15] target/riscv: Add Zvknh ISA extension support
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: dbarboza@ventanamicro.com,
 Kiran Ostrolenk <kiran.ostrolenk@codethink.co.uk>,
 Nazar Kazakov <nazar.kazakov@codethink.co.uk>,
 Lawrence Hunter <lawrence.hunter@codethink.co.uk>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20230627174551.65498-1-max.chou@sifive.com>
 <20230627174551.65498-11-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627174551.65498-11-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/27/23 19:45, Max Chou wrote:
> +void HELPER(vsha2cl_vv)(void *vd, void *vs1, void *vs2, CPURISCVState *env,
> +                        uint32_t desc)
> +{
> +    uint32_t sew = FIELD_EX64(env->vtype, VTYPE, VSEW);
> +    uint32_t esz = sew == MO_64 ? 8 : 4;
> +    uint32_t total_elems;
> +    uint32_t vta = vext_vta(desc);
> +
> +    for (uint32_t i = env->vstart / 4; i < env->vl / 4; i++) {
> +        if (sew == MO_64) {
> +            vsha2c_64(((uint64_t *)vs2) + 4 * i, ((uint64_t *)vd) + 4 * i,
> +                      (((uint64_t *)vs1) + 4 * i));
> +        } else {
> +            vsha2c_32(((uint32_t *)vs2) + 4 * i, ((uint32_t *)vd) + 4 * i,
> +                      (((uint32_t *)vs1) + 4 * i));
> +        }
> +    }

You should have two separate functions for two separate VSEW, so that you do not need to 
pass the value nor decode the value here.  The selection of SEW should happen during 
translation using DisasContext.sew.


r~

