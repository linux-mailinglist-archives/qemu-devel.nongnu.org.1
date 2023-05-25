Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5DF710AF8
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:32:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29Ck-0004tn-05; Thu, 25 May 2023 07:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q29Ce-0004su-54
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:32:20 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1q29Ca-0001ro-IS
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:32:19 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-19a308a045aso683896fac.0
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1685014333; x=1687606333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8d9J6tlT/clGvujmhcFZWasgpps2lZcyhFN3pP4zcsI=;
 b=UiHKz/nfiWAeWIKSYEdGHw8EeIW3YrHHSt+q8U/VfnHqNPXRKqfWtdjb+tRnrz/Y9/
 Y4QEJzbBCoOl2KNWMYah0ona59rAqjUxlUzwn85tqKW6J9n6FGEjYZWR73yakiSMnEKK
 kIjng+JCU0MewBoxd08ReWukJhYM4rhJfCgmZ/Uuz07JaGfzA9Kpv0AhBGQI1agRbY6a
 wz/0YNkXm/MGbkhirvi3cTQBhVObiXKMA4JnMmGBXJssuJdKgfaRLav+507EyHGQgapw
 984vkXeOLYx4iYUEibo3fEweskygrtvHn0nhS3RBfEYJw1P9iQ1QmpbEjs0gt8KMsizX
 3WFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685014333; x=1687606333;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8d9J6tlT/clGvujmhcFZWasgpps2lZcyhFN3pP4zcsI=;
 b=WOsnns+NzWKK+JudseHhp/+h1FCLGruEtdvAkAqCHjrASHCeAJVdfYfWzxNR74oQLa
 niLV1WXfYynWXswpY1LM5L6uTzh3GgNS7smkMZzIFc/b70QVA10G9M75z9lfpz0eeBTJ
 w/4DY9BHFRidKFU7sCc9Z0D5n5RMi+tF7H4GTeZe49WZOgNO/Pj/rDjsYp+HnTQdxM+U
 y0LBqnxaSWOID1hn2P+btbh2lSFmfxAgtwS6GgVr24pkgQu8kdrKRojZ1iwkgIsAWkYo
 NSxWFEhefz+Ay7Zgs1b44zfx7aiEPZ1GKoQtSDUYljpz6kZ6JGhcK8NmTO/LevZlBvA1
 v02g==
X-Gm-Message-State: AC+VfDxmiwF4USP0jdVj5efpRANQXhHjwi9RujPkXAA/WxX2S7LqggpZ
 3IqzFWi81551i+5aX33ODaBTUw==
X-Google-Smtp-Source: ACHHUZ6szCkQYQLjnzI8zjIn+B1k3ZJP2kNHt5Gux5t5T9tw5EPUOn0K79cEAl13vXpZBmARtMrpJg==
X-Received: by 2002:a05:6870:d243:b0:192:7320:ce with SMTP id
 h3-20020a056870d24300b00192732000cemr1685827oac.40.1685014333469; 
 Thu, 25 May 2023 04:32:13 -0700 (PDT)
Received: from [192.168.68.107] (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 b5-20020a056870b24500b00172428894e0sm519919oam.28.2023.05.25.04.32.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 04:32:12 -0700 (PDT)
Message-ID: <5c251e47-dc63-5aa4-87c3-818f471b709c@ventanamicro.com>
Date: Thu, 25 May 2023 08:32:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] checkpatch: Prefer DEFINE_TYPES() over type_init /
 type_register_static
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230524145444.32820-1-philmd@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230524145444.32820-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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



On 5/24/23 11:54, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file, it
> is clearer and simpler to use the the DEFINE_TYPES() macro.
> 
> Add a rule to checkpatch.pl to suggest using DEFINE_TYPES()
> instead of type_init() / type_register_static().
> 

Nice!

> Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---


Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   scripts/checkpatch.pl | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index eeaec436eb..db8029635c 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2877,6 +2877,12 @@ sub process {
>   		if ($line =~ /^module_init\s*\(/) {
>   			ERROR("please use block_init(), type_init() etc. instead of module_init()\n" . $herecurr);
>   		}
> +
> +# recommend DEFINE_TYPES() over type_init()/type_register_static()
> +		if ($line =~ /\b(type_init|type_register_static)\(/) {
> +			WARN("consider using DEFINE_TYPES() in preference to type_init()\n" . $herecurr);
> +		}
> +
>   # check for various ops structs, ensure they are const.
>   		my $struct_ops = qr{AIOCBInfo|
>   				BdrvActionOps|

