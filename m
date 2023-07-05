Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3E74867F
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3ch-0003G1-HE; Wed, 05 Jul 2023 10:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3cf-0003Fl-Ma
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:36:49 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3ce-0001Ng-6x
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:36:49 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b69ed7d050so110561901fa.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688567806; x=1691159806;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pVXXFyrrUQWj+YEFhNJ6H8UEs+ymG9N4wGF336xLcx8=;
 b=F3jvq5N8N6cPohU2VXiZWj+1EGIxYfm5lnuCO22e86K7kylXJ7Wy3puIauHK8SrYVi
 ts/9MC7xyMgRNB0UcReSgKpEcuBHoztaj2kog+3CTnuLm9y+DX+7FOPzXLw6i1Y+gast
 X2ssH3naI7gfvCMOOd91QachVtuVYsrUd/HYEpQI+0F6qdbP2Su/hCIkyJu/StlGD0Uf
 QAgWK3nzgVvQlWQHzij3MG0T5Hg1yeonXMQmmRfZg8fsHmZdEdQsZaUXzh1fWA1XLlPD
 R5CHhkrAE1pX/t1beimm8S/zVavNnUJybcnRvJdSL3EWCIvSeLr20gZn5os6VGTtUZvm
 Kd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688567806; x=1691159806;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pVXXFyrrUQWj+YEFhNJ6H8UEs+ymG9N4wGF336xLcx8=;
 b=YDdEb+deFMfhArll4v4wwOLa2eLXnozbCF6cG284YeJ/cRdO8h2TO4qjDoHQHa8y3X
 E0tYdiHyxWEgQpLx7Cxq34c7Ig67dCUnzwN9ZhxELrV1gdC6BgqZYOrLQ7dyMJVl5UKO
 VTosCrlDmFSTHCFXAB8B8VnbXxOb9m01L6NDNE2IwSJrn1TJmd2kggV70MkQ5nsKDLq1
 akAZoxqcBKaSt3HXIITI4gV3lLzcteFMoSFIzzsgiCJDrxZf3LgqKuaYXZi/bKIAG2VQ
 /PBdAHXHaTh0puyUHisWiUew8vT7J3Zx3NgwKdAooUYZvZII1lCNUt+1rljvhvpvkugq
 GN8Q==
X-Gm-Message-State: ABy/qLaDZeBTKJuSM/N2CeTRe93+IJbDyk4EXCf6sUrEe4eqoWcJ1NGL
 zJtVh4oGCfPp+SEHqzAKPsNU+n1ZoC84vCmeWJPd4Q==
X-Google-Smtp-Source: APBJJlHLPGijpsz6po2i6FDjZq0ZFrmceTpt+puLYb37BL3t5becUzFbTFPNjHjTQdYwS7Ed4eGi9g==
X-Received: by 2002:a2e:7318:0:b0:2b6:ec69:7c3b with SMTP id
 o24-20020a2e7318000000b002b6ec697c3bmr6248225ljc.46.1688567806259; 
 Wed, 05 Jul 2023 07:36:46 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 s18-20020a2e9c12000000b002b6df22f0edsm2596126lji.64.2023.07.05.07.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:36:45 -0700 (PDT)
Message-ID: <f6ec16da-f104-01b6-553b-2bebf0166759@linaro.org>
Date: Wed, 5 Jul 2023 16:36:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704154332.3014896-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 17:43, Peter Maydell wrote:
> If you build QEMU with the clang sanitizer enabled, you can see it
> fire when running the arm-cpu-features test:
> 
> $ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 ./build/arm-clang/tests/qtest/arm-cpu-features
> [...]
> ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too large for 64-bit type 'unsigned long long'
> [...]
> 
> This happens because the user can specify some incorrect SVE
> properties that result in our calculating a max_vq of 0.  We catch
> this and error out, but before we do that we calculate
> 
>   vq_mask = MAKE_64BIT_MASK(0, max_vq);$
> 
> and the MAKE_64BIT_MASK() call is only valid for lengths that are
> greater than zero, so we hit the undefined behaviour.
> 
> Change the logic so that if max_vq is 0 we specifically set vq_mask
> to 0 without going via MAKE_64BIT_MASK().  This lets us drop the
> max_vq check from the error-exit logic, because if max_vq is 0 then
> vq_map must now be 0.
> 
> The UB only happens in the case where the user passed us an incorrect
> set of SVE properties, so it's not a big problem in practice.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/cpu64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

