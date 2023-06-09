Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B258A72A2BB
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 21:01:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hMF-0001JF-Bk; Fri, 09 Jun 2023 15:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hMD-0001Ib-1E
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:01:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hMA-0005rc-Cy
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 15:01:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-652699e72f7so1818012b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 12:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686337265; x=1688929265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6PAqdzWBbgN32/0eDNtcEb0V9Dht+3LEVcjQvZalBQ=;
 b=DkAFuqG9fDjhYCEOHca+TMtDf/2MSGOVpuip93lYPYXwLotMEu6vkN0Qz05obgpeR+
 LaDq5pb3kCFiyesMLZiN4my5X4f79XK2UJ5ZAfuZBVKE11qDkwyyaC1Sr6rTWwhsOvQb
 KcisLAYnYmyAJQY3YxHCnLq8Mp3Uz3Oj2NKLBWyU7bDoWvFblxzbnwBTN178OhXh6no0
 bOhm5LrYhXDHMT9jB9ieBmaj0jBVONS+X/yhAdrVFxObq9rhiS6ZYbfASns/0dfpap3m
 jzDpnVxs3Yq96hY7eDiBWJNYPtgcgoQ8gpi3m0Rl604t7SWvKJqUCR1NViCZ4f+j4F0U
 DO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686337265; x=1688929265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6PAqdzWBbgN32/0eDNtcEb0V9Dht+3LEVcjQvZalBQ=;
 b=M++OcdY45AAiDfaf6ChsyjuncLrFU6unQHCR6K9yL+r6vjEzutxRY/mim76qJWqS2G
 liZxlX75Dxpk1UU4vWfOiWmZmba/nJpisWgzM/d19uX8te9wupDZ3Zmz1qPXiqKrn2uX
 1vT/lr4ErKxIvsrabb1Qja90+1malxOU1Scax8YzhqYY6tdqmBb9avJ1MH3Tn/7wc8wx
 OJxZCXATeXUf6v95qbr1Bs5CN1h9N9kg8RHX90SIJ0b65X0QiQg7Fd1WWtkVosiwtJIO
 G2vtM1Ecee568KUH/Lv0Zxsi4/IDUDME5vSiUiyi8gk3cHLuOiBSCpzppSEPgYkYaB6L
 YBCg==
X-Gm-Message-State: AC+VfDxXsw3PmJDRKsPaz4TPfWUAFIZqGzwjQ3+m/+qfDeU4LSolE5og
 55Rj4w8+0pPcuD+n5jWlWJKHNg==
X-Google-Smtp-Source: ACHHUZ6Vf8S14po6AhcmnOOmMJB8mlP9hW51DodzrLgFDDT4ZBZxciC5aV7xdV0Bo6/pUQ0o+s4pmw==
X-Received: by 2002:a05:6a00:1898:b0:64d:277c:4ab2 with SMTP id
 x24-20020a056a00189800b0064d277c4ab2mr2332891pfh.24.1686337264684; 
 Fri, 09 Jun 2023 12:01:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa78d95000000b0064d34ace753sm2999045pfr.114.2023.06.09.12.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 12:01:04 -0700 (PDT)
Message-ID: <f2605dac-e48a-cd18-2d4d-b1cb1da5be36@linaro.org>
Date: Fri, 9 Jun 2023 12:01:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/22] target/arm/tcg: Extract VFP definitions to
 'helper-vfp.h.inc'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> helper.h is used by all units, but not all require the VFP
> definitions. Move them to a new header; the next commit will
> remove it from the common helper.h.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h             | 137 +-------------------------------
>   target/arm/tcg/helper-vfp.h.inc | 136 +++++++++++++++++++++++++++++++
>   2 files changed, 137 insertions(+), 136 deletions(-)
>   create mode 100644 target/arm/tcg/helper-vfp.h.inc

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

