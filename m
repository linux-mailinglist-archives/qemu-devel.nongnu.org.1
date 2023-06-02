Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A475720C27
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 01:00:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DkT-00057R-K8; Fri, 02 Jun 2023 18:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DkP-0004zk-7I
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:59:53 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DkN-0000T9-HA
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 18:59:52 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-30aea656e36so2461384f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 15:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685746789; x=1688338789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6DNYzNscKJ3gK+lVAMrc8nn8Qnsr8+Okm1SxxsUzTLA=;
 b=ezwoRk97yssRfN/zXyh5iKX5rmqJmMELwaqt7lXzk2GavxzQnUnmi3UsILPTPmvXjd
 OFTDsvJT2l13HvSJ+oujmKOj6wvw4VD4TAffAAN8SorAXcPgl+Ibk2mYj5Q3pSB3Hyqh
 6hMtR45EVbIlwgO/A4uUdmgSsAyJ39J0r+GnUgvMnR0lG79KwJiECBb7pd/S0IvxUIyn
 yxz0HpfXRxG6gvM3yeIs6r51u3in9z3blKh2aPJeSWeRqfg9UHsWzzc36i1m2ro30UUe
 IrxpfB0gxBRxS+FIGyT4raFNLx2YD62tTyqP/1GBBDpvdFaqlOwVKVX6g58pFdeUniH6
 LkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685746789; x=1688338789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6DNYzNscKJ3gK+lVAMrc8nn8Qnsr8+Okm1SxxsUzTLA=;
 b=grKKiq1IV7xbQJibdhNTY0bddklfkWZffCE6b4Pz5hc6kf0S+H+rsBonY67/dymTsf
 cX5LUTBxRP/PdADgblehluUx8s6TCot3fSTYeV4VXUKCjaNhLRhBm6dJkVX2X0fiVcPL
 6lYq3fyC1VkgFJtF/vsqIT6KFxc9e7kVs0aIcj+Ud765qIdepvX3Ae8s/iC2OGX3PrMm
 +j6ZQVZUKy6/VRpt2Hb6cVpaLf6/fFs3yDGhdnXOkVS9E2bT5NJl393HHE20CWQ61z6f
 tcMlslhDLyk5AC8RkvH3HKg+HFnXO1Fw3uBlRvkeWsTRWRJ78pQumyGwfRZjGprrFhFi
 b7/A==
X-Gm-Message-State: AC+VfDzJseQ1yEohoUUzi3e0lpvyjxiDzf15ykfPSGPaHgsmWlhAf1L0
 t6enbx/Urh1myMm8AgfT71iBqdYdTnolr8Y1c00=
X-Google-Smtp-Source: ACHHUZ6ntTyR+jvrGU/lvbK8WGMSuCPwfMcEcOTO41gsAbm0vG+SNdLje95aiNm9O4jf0ni68m3ovg==
X-Received: by 2002:adf:e652:0:b0:309:43a2:8e9f with SMTP id
 b18-20020adfe652000000b0030943a28e9fmr951413wrn.27.1685746789364; 
 Fri, 02 Jun 2023 15:59:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a5d4652000000b0030ae54e575csm2796493wrs.59.2023.06.02.15.59.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 15:59:49 -0700 (PDT)
Message-ID: <9d6e1144-b846-c880-a876-d710bd9d8ad9@linaro.org>
Date: Sat, 3 Jun 2023 00:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 2/2] bulk: Replace !CONFIG_USER_ONLY -> CONFIG_SOFTMMU
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230602225811.60152-1-philmd@linaro.org>
 <20230602225811.60152-3-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602225811.60152-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 3/6/23 00:58, Philippe Mathieu-Daudé wrote:
> CONFIG_SOFTMMU is the opposite of CONFIG_USER_ONLY.
> Now that CONFIG_SOFTMMU isn't poisoined anymore,
> replace !CONFIG_USER_ONLY negation by the positive
> form which is clearer when reviewing code.
> 
> Change mostly done mechanically using:
> 
>    $ sed -i -e 's/ifndef CONFIG_USER_ONLY/ifdef CONFIG_SOFTMMU/' \
>             -e 's/!defined(CONFIG_USER_ONLY)/defined(CONFIG_SOFTMMU)/' \
>                 $(git grep -l CONFIG_USER_ONLY)
> 
> and adapting comments manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   scripts/coccinelle/round.cocci                |   6 +


> diff --git a/scripts/coccinelle/round.cocci b/scripts/coccinelle/round.cocci
> index ed06773289..0a27b6da4d 100644
> --- a/scripts/coccinelle/round.cocci
> +++ b/scripts/coccinelle/round.cocci
> @@ -17,3 +17,9 @@ expression e2;
>   @@
>   -(DIV_ROUND_UP(e1,e2))
>   +DIV_ROUND_UP(e1,e2)
> +
> +@@
> +expression n, d;
> +@@
> +-   n & ~(d - 1)
> ++   ROUND_DOWN(n, d)

Oops, unrelated =)

