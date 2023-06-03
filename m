Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B617213C5
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 01:28:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5aeW-00036w-FY; Sat, 03 Jun 2023 19:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aeR-00036Q-Fb
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:27:16 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5aeO-0001Hw-O9
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 19:27:15 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3980f2df1e7so2868686b6e.1
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 16:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685834831; x=1688426831;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qVHpuCpa+NdcZHDpk/AWQCalP7Go1RDFc7d2rShjI4g=;
 b=MFdACri3a76uIKAY26PAPfHv0FInAECuIvcOBaXprI/FUGfOiMm+chCBHelRbXr4ua
 TxUljrc/rKkrrIWoS1uWZQMg+ivDB8mirlXNRLfVcl92D9p6lVfmBRTQUDCEMxLk0rZd
 IJPNLVat+b2wbf24zH8nAth/rM6a+43Kxhu/BDTxGLIuGi3rFd71MUKLSIw+Ontub9dv
 o23uKlsKsB39v5Ca1BUaJRHfkp4q2yJxLdVdrDwaZyD2oU/7OEeTnGOvRCT5yOW1xdcJ
 fSYcrb6cXGxCvYftXWj7rKuSR7tvK4HJxBHLmzMAadRcQNHJaBZ7KhwylFZt1eJJdeEM
 jsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685834831; x=1688426831;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVHpuCpa+NdcZHDpk/AWQCalP7Go1RDFc7d2rShjI4g=;
 b=g0vh0+Lxn2e1Oz1rpHNb1ZkIBinVxJHDH6M3lx3Qj1KThl/oA6GuDW9VqAriMoJodC
 ROLEPtpx+0assrjk5UqsnVG48PQHryKuVpM7PAV5qFKpyX49cqApD/h+ciqOUWPos7bC
 LHle1daR5fVsfIO2bCWiDoOa5xJ4N5qqLhXbYUZwk109kUmyEFEcHfQLUoGJYh6JGTWE
 eFK+UROgY0mjL4nzr4PCJzmPnUZ4lwO0fwErH356bSflIJAs/7B9bGJKLXDAv62btdDk
 fso0B1rU7ldsEV94Grkq4Qw8lb/9s7SnjPFkGzIj7yottG/n+Uwik/c1EXEKopjq2+Wz
 eLLQ==
X-Gm-Message-State: AC+VfDz27WI96i8VoS1leiPvoUnr8P6H0JPZnHvFuz4OLMnHUUx2Eevt
 vqivdecn4aU7piQIuCIDDuPE3g==
X-Google-Smtp-Source: ACHHUZ4PsyMBCwA+fYLuNLFDsV7KJ7dkxZyju57OYiJ0eoHNjN3GrS1/87h9UXbE4KeZoMtln+Y4fg==
X-Received: by 2002:a54:480c:0:b0:398:465e:ec68 with SMTP id
 j12-20020a54480c000000b00398465eec68mr4322528oij.4.1685834830788; 
 Sat, 03 Jun 2023 16:27:10 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m13-20020a170902db0d00b001b042e8ed77sm3668633plx.281.2023.06.03.16.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 16:27:10 -0700 (PDT)
Message-ID: <70ef9d29-424b-cf65-b238-18fa81114ce0@linaro.org>
Date: Sat, 3 Jun 2023 16:27:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 14/20] target/arm: Convert LDR/STR reg+reg to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the LDR and STR instructions which take a register
> plus register offset to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  22 +++++
>   target/arm/tcg/translate-a64.c | 163 +++++++++++++++------------------
>   2 files changed, 96 insertions(+), 89 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

