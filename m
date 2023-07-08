Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9C074BE94
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 19:20:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIBb0-0000JT-CK; Sat, 08 Jul 2023 13:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBay-0000I1-By
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:19:44 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIBaw-0003q2-TM
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 13:19:44 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so4485559e87.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 10:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688836781; x=1691428781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uBq6xE0H67dxAxxLrM+uItKGrmh4nAnJSVcXuurF28Y=;
 b=sHgNXnHRDhWSK8PPLDS/A81M4E2QhZ4MbpfotK8OE6kbNEsKNCKWgEuisq0ykp6h5V
 I9bB0LPjy++zY153jpjY1FKukyFMDubsqtD3cVKFtq5/+LQhlxvcV3bcQa2gHBHof/zv
 xSSOGhmTE1xv1UqyxDrfQgU54qOToK+K6epZxPygFJXtddjRTlOWxrdIlD7nmfwJahBP
 kHInyOGPaDCad0zs+xuOZwnrgph7RUwpfmwmmphwxXxATtPWjUBcOy5TwslBUi+b+Amc
 w99C1aUus1k8GljAP71qJf/7UTEZYxPUD8d5HLEet+erJZ/Vsg9VSQSlanxzEl4/ji54
 rp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688836781; x=1691428781;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uBq6xE0H67dxAxxLrM+uItKGrmh4nAnJSVcXuurF28Y=;
 b=M/6KjHTpV55ao+b7UNcDC2aRMJZ+oxCNAYBipUT99X31k93aDw2Aej1w1nofSdb3P3
 acDliEThRe1hXRzbD0XMgTixtj2EOYMaG4QStbBkwdBWzXYI9VUt0x8JBlqdeKTfd8BU
 88Qq1CRc2amgBPCoCiFSYto3QLKVSoMwO6DyYEJksRIxsSQESv/0DrJ5Bco18WG1qab9
 1Nle32+GB8hX3Xxz7T50vca3ApVt40IsJ0N0bMydXPS+j6fNoQYOVINABtkGzMPbCqkw
 sIEUS03tnibe9Ls21hi1c9LZXVBcogSGzXt+z9kNAQJQlR0/C4N2uQnozP2qVpfjz8/o
 +y9A==
X-Gm-Message-State: ABy/qLYv0SzCO0KrC0DehiwGvGYI/yl5NWuM7RQN34P1BN5hvOjaVwYO
 l3OuEYqoK0FQQ4VegxS4A6DblA==
X-Google-Smtp-Source: APBJJlFRFkI9ZkHKXn2lF143R3z/oaRTPLLPkF285qpVqp12ECDK1HMJUtffrCv/FFh4Ss10suEXyw==
X-Received: by 2002:a05:6512:3253:b0:4fa:5e76:7ad4 with SMTP id
 c19-20020a056512325300b004fa5e767ad4mr5483697lfr.10.1688836780953; 
 Sat, 08 Jul 2023 10:19:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.184.32])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a056402071900b0051a5cf5fcaasm3504349edx.23.2023.07.08.10.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jul 2023 10:19:40 -0700 (PDT)
Message-ID: <54371e18-33aa-5871-3eaa-7931f22339b5@linaro.org>
Date: Sat, 8 Jul 2023 19:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 26/37] target/arm: Use aesdec_ISB_ISR_AK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com
References: <20230703100520.68224-1-richard.henderson@linaro.org>
 <20230703100520.68224-27-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703100520.68224-27-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 3/7/23 12:05, Richard Henderson wrote:
> This implements the AESD instruction.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/crypto_helper.c | 37 +++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


