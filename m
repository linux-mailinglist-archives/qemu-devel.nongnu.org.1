Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCB720A91
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5Bk9-0000AP-5O; Fri, 02 Jun 2023 16:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Bjv-0000A5-PA
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:51:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5Bju-0002Cm-48
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:51:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f6e1394060so23839575e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739072; x=1688331072;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ILq7X2J+pi2vixuHRXBUFJqfwVeG4b710Mj2RhfZZdE=;
 b=p2j+zd57N0s4IghknKrdePv+zoO9HhaxMUUwNTiKkB+juV3L1of11ItZoigeL8MG4P
 yD03PipQbFAahksmmjPzjcXuLwAwWmGrJc9UJrczsUXEOnLiSTrCfbJ01BSxJ6Ou3sD+
 jMQySSeQWrbkuCay52kzWfgordRz3V2zauhEusYUX4AntMtzwc3J3Og7ulrdPIbYPIpf
 X3hM3auTWGmdDUQGj4VRnt7k3eaZ3yJUS3Bys2PhwcNRxjejQ5EVC3TllvdJwuIQbyjY
 sWs5UF1fFj1p5lTtVs1YeUUH/bEne+thFQuxwUAxScrgy4XYt7ctSEZGWL6pdi8ikLhY
 6xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739072; x=1688331072;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ILq7X2J+pi2vixuHRXBUFJqfwVeG4b710Mj2RhfZZdE=;
 b=bOR7k6+J66jauzF3fmh7mlbWALzdwI+mZk4nIAEA9MGtbmY2fUAZBUfMf1kvHqjavz
 39UIBQZvbajxJDZe6KngzenafrWtA3Ly4w8bbubcv+BZ3JBFiuxGg+mlSfYZMNhjKS0n
 +gTBp+PJWyz24von8ltEpnSOQYmFV27NayKnOhzulExSsMty8N3iVTqvE2qMwaeTepFZ
 jxvXI6taoXY8IQ3WgF+DEhP3T+DSxd0c2W2WuoXBVTTNIdKFWY+A2tkCazTJKekALejN
 4NON3p4Aqoog1jWjoK0dJdg80XvWb2PWxq5/48PykSqyRIQN4rKc6BPy+e4GPIivLiJt
 qz1Q==
X-Gm-Message-State: AC+VfDxXu8oXcevAc6uZtJ+tswamkFsv6ishlVuc/Hv/1I87fAqeL0Zp
 eFdKV/rYizTQWK3k//xKKshwdQ==
X-Google-Smtp-Source: ACHHUZ6GIJNqhjGby1gtkRniR6Go0ylrhTfTVItoUcOYce4dyJcvkUCPYxbMMhWEMH1I1i2heUjttg==
X-Received: by 2002:a7b:cd8f:0:b0:3f4:f0c2:125 with SMTP id
 y15-20020a7bcd8f000000b003f4f0c20125mr2354066wmj.23.1685739072196; 
 Fri, 02 Jun 2023 13:51:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 x17-20020a05600c21d100b003f4272c2d0csm2963338wmj.36.2023.06.02.13.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:51:11 -0700 (PDT)
Message-ID: <13e60074-adc0-f3f2-e5fe-f48e6778cf04@linaro.org>
Date: Fri, 2 Jun 2023 22:51:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 13/20] target/arm: Convert LDR/STR with 12-bit immediate
 to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-14-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602155223.2040685-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

Hi Peter,

On 2/6/23 17:52, Peter Maydell wrote:
> Convert the LDR and STR instructions which use a 12-bit immediate
> offset to decodetree. We can reuse the existing LDR and STR
> trans functions for these.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  25 ++++++++
>   target/arm/tcg/translate-a64.c | 103 +++++----------------------------
>   2 files changed, 41 insertions(+), 87 deletions(-)
> 
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 4dfb7bbdc2e..c3a6d0b740a 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode


> +# Load/store with an unsigned 12 bit immediate, which is scaled by the
> +# element size. The function gets the sz:imm and returns the scaled immediate.
> +%uimm_scaled   10:12 sz:3 !function=uimm_scaled
> +
> +@ldst_uimm      .. ... . .. .. ............ rn:5 rt:5 &ldst_imm unpriv=0 p=0 w=0 imm=%uimm_scaled
> +
> +STR_i           sz:2 111 0 01 00 ............ ..... ..... @ldst_uimm sign=0 ext=0
> +LDR_i           00 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=0
> +LDR_i           01 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=1
> +LDR_i           10 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=2
> +LDR_i           11 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=3
> +LDR_i           00 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=0
> +LDR_i           01 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=1
> +LDR_i           10 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=2
> +LDR_i           00 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=0
> +LDR_i           01 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=1

Why not use "sz:2 111 0 01 sign:1 ext:1", returning false for the
cases not covered?

