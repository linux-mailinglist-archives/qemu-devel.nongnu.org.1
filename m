Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D27B9C97
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 12:47:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoLsF-0007wV-GB; Thu, 05 Oct 2023 06:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoLsC-0007or-U1
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:46:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoLsA-0002O3-Cc
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 06:46:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3215f19a13aso823758f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 03:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696502784; x=1697107584; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jOGI1vHsiW0fZviMZDwPzetoQKljIsCMO+n79K4VLIc=;
 b=PFnJpfCUCBDZ45LnEsDg4UkyDC60cPVoBm1RV8ughRQdBEiSfeXLVIgqqwcUr26ciF
 etpYa9RF+QYcvsFkwUqZiR0IG9IYKb78Iw6Q04hBU9RiqARnAFZ45D+sjn2fvDdmzUPQ
 41lnCCgZO9Ay4Z3oUeKxOM09Vx/8J0GrBhNXbKnvqrvHDqdSYLLaoAO6Rk3bzWkn0hvo
 sSJdVPmQBLyxEGo0knoDflU5xqKX6lijcfwO78WgHBfK9OmzTbVZOnOf+yO/qFSnMgDd
 /Q4XNuKRFowMKU8xjk+XMk2Dp5v4rKFb+fv91uIp+iQfsCOyFlMreA/NG7SCutb5+sXt
 HxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696502784; x=1697107584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jOGI1vHsiW0fZviMZDwPzetoQKljIsCMO+n79K4VLIc=;
 b=ck1XX3oprPp7jFmjAWxBCPQ5Wpu/PTsO8zvaf+F+zzsLSK0vkkTVZ/B1F2U6nge6WH
 sHn/LtI8CAWjhwyO0yItZ6Ui7Hvg5TWbvlAiSj5M8uro4lgaVDxqCAxM5YB04CCRAQwa
 iR3Gci/iBbzLod8WAZUvR8lJHiMaDpsk3NLTZMC+Q2RKNjAdUZghKuH822VXfW1+XpVR
 DjxUuE6FCrz2DKzJW6p7F6eoDMI2onmytF0kFVvTmaGKuS0oD1dJfSiRdiO8gaLD/KlF
 L2if1DooYwKnDE6rkW6TVKyYAwX5DaBqW11YphjNHxQWebaRjyIj3Sn1mzy2FDnL0QHO
 A8kg==
X-Gm-Message-State: AOJu0YwT1WmVO9hpjvsc3wfl9TEF9kOlQbWrAXChTA5oD6dmWGrNDNwI
 Te+bx8ac7T12Oa3auVOMYne5PQ==
X-Google-Smtp-Source: AGHT+IHYDF4MiL9jC+lP9GCbZHy/x+Yuk/CjoBYTRKN+2UxFI18RVx4E/ANzJUhXtL9OPoEwEBioaw==
X-Received: by 2002:a5d:5903:0:b0:323:2c39:bb3d with SMTP id
 v3-20020a5d5903000000b003232c39bb3dmr4516276wrd.64.1696502784307; 
 Thu, 05 Oct 2023 03:46:24 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a5d62c3000000b003179b3fd837sm1485808wrv.33.2023.10.05.03.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 03:46:23 -0700 (PDT)
Message-ID: <f8439658-27fc-f27a-6c99-27eb33d3cada@linaro.org>
Date: Thu, 5 Oct 2023 12:46:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] target/riscv: Fix vfwmaccbf16.vf
Content-Language: en-US
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20231005095734.567575-1-max.chou@sifive.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231005095734.567575-1-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.528,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/23 11:57, Max Chou wrote:
> The operator (fwmacc16) of vfwmaccbf16.vf helper function should be
> replaced by fwmaccbf16.
> 

Fixes: adf772b0f7 ("target/riscv: Add support for Zvfbfwma extension")

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/vector_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 3fb05cc3d6e..c45d94c165c 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -3361,7 +3361,7 @@ static uint32_t fwmaccbf16(uint16_t a, uint16_t b, uint32_t d, float_status *s)
>   
>   RVVCALL(OPFVV3, vfwmaccbf16_vv, WOP_UUU_H, H4, H2, H2, fwmaccbf16)
>   GEN_VEXT_VV_ENV(vfwmaccbf16_vv, 4)
> -RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmacc16)
> +RVVCALL(OPFVF3, vfwmaccbf16_vf, WOP_UUU_H, H4, H2, fwmaccbf16)
>   GEN_VEXT_VF(vfwmaccbf16_vf, 4)
>   
>   static uint32_t fwnmacc16(uint16_t a, uint16_t b, uint32_t d, float_status *s)


