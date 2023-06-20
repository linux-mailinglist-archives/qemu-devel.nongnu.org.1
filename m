Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CF7370B7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:41:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdU0-00032H-U1; Tue, 20 Jun 2023 11:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBdTy-00031p-To
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:41:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBdTx-0000WI-Bj
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:41:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-988c30a540aso283419166b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687275684; x=1689867684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6kr/yAHzUnE7I9uVhtWoT9osyspM/+Hnlrq3EKlb/wE=;
 b=VX34LI0ckBkJydgP4sRmI9vWhfCNynaSQhIGyPFjM8/OobjRckiPbglyiyc9Fa9GEW
 9e87lSzNcZesNVkLBMWTI8ey5hCdgtbFmFuaQDKsCYsq0aGzVt3qMf8mjCIXdjRK1uTz
 6u1icaQ5WiCFF2WafaZHA5yjvsGN+QC4JNrn8K7z3HgO831R/9+jHkFg2ZwgdollI+kg
 KcNkFXvhot6rq7HrFxhszpuy5hnvFYnWRDlt6PoC53jZFTsmCchUrT/epl2Cucd4LPJx
 sqZ0rrZ3UJi+fidkuijDozJldEdeXhFvMAwlgtsNxIk0WHPOkINwWIwljE8RZ8xox1Mn
 dYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275684; x=1689867684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kr/yAHzUnE7I9uVhtWoT9osyspM/+Hnlrq3EKlb/wE=;
 b=DwKKl2SpAswsap4uhXgxXz+za8YmjKbirP7+wUM0ZlEqxePrf4JoH6kRjyH3S+vlO3
 FPmDSfRvGPDAIgawiRB2vIvLqts3TUiT/R4/8bAE8Oq/k6e89/BL+Yogo/PzgUrc8D6g
 YIde+PJFJiwJ+1q3Xsxe+HoBwWCrX4rqJlESbhrWrh0rGgq361V2hysb5EcNjDwvgeKx
 7nA0bf24FYbJhGFr4jD54LZf+Y4ChDrtqRi0j+kyVabVXF9fl3ifUIJzvKOLB5C0qb+G
 Z13MhYt2LxXop1oMWI1lmEXwLcoLd9C9or0pCfT44hTvldu063aGRsCiqdbyo5FwW9pm
 wQNA==
X-Gm-Message-State: AC+VfDwX4IKvajBKD71IvkhRCjeHvyU1mLlmTpu4bypTuUUcls2Vo5XU
 yzccAhmt2Pua5Z2bQEsl8/g4Gw==
X-Google-Smtp-Source: ACHHUZ4FvcikndAeBbnebioeD5RqwbsETiBwdd6g0Ad7eubVMAGVlRjU9XgxVpwYKmopDEg2q9B20w==
X-Received: by 2002:a17:907:162a:b0:988:918c:8116 with SMTP id
 hb42-20020a170907162a00b00988918c8116mr5457568ejc.61.1687275683737; 
 Tue, 20 Jun 2023 08:41:23 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 ju3-20020a17090798a300b0097381fe7aaasm1596187ejc.180.2023.06.20.08.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:41:23 -0700 (PDT)
Message-ID: <2974a774-b55d-371a-5596-5be1938ad4af@linaro.org>
Date: Tue, 20 Jun 2023 17:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/5] target/microblaze: Define TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
 <20230619142333.429028-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230619142333.429028-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 19/6/23 16:23, Richard Henderson wrote:
> The microblaze architecture does not reorder instructions.
> While there is an MBAR wait-for-data-access instruction,
> this concerns synchronizing with DMA.
> 
> This should have been defined when enabling MTTCG.
> 
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/cpu.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 88324d0bc1..b474abcc2a 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -24,6 +24,9 @@
>   #include "exec/cpu-defs.h"
>   #include "qemu/cpu-float.h"
>   
> +/* MicroBlaze is always in-order. */
> +#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL

Targets missing such definition:

- cris
- m68k
- nios2
- rx
- sh4
- sparc/64 (!)
- tricore

I expect targets designed for embedded systems
to be in-order for power efficiency.

What about having each target being explicit about that,
having a build failure if TCG_GUEST_DEFAULT_MO is not defined,
instead of the '#ifdef TCG_GUEST_DEFAULT_MO' in accel/tcg/?


