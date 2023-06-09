Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9072A2AF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hIn-0007HL-Pw; Fri, 09 Jun 2023 14:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hIl-0007Gv-Op
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:57:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7hIk-0004mn-5z
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:57:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-652328c18d5so1695670b3a.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686337052; x=1688929052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSHGR0C/BjNgWpI2dI3oFmqunAl+B2f/vHVMhbxgnRY=;
 b=QqFScrKtSi8fUY+6VJAx0zwd3T0NqHWaCqwxRTg3bGI/Bz6EYcqj+9oEWG6aym0Apc
 jWNuRKuN9xm99IQSiLpwe4LWlgUtQOTuKlLyo7UeaPXAKjHvrOprMyhcvTPy56c4y+w6
 1Tns/ncPW7janPpOgGgr1oXtgPiAnU4cD3oyIw7fazusTx/Xv4WgyDObxrPGTB9Wtm+j
 py/dSD4YNaYJKA7J8unlRr4yz7k+whBieMIWyRw/wBymjcCT6YBwKOAYXQfwzTrOdvAH
 H9spbHpKSVmDN2KfEAV160nJWKUMTQY6Q6aSU6uHWqnoN2K3FTm6bCoBaxLkOpSq5IHg
 fBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686337052; x=1688929052;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSHGR0C/BjNgWpI2dI3oFmqunAl+B2f/vHVMhbxgnRY=;
 b=c/3h8QqN9nvbQHqb3cua8HblqtCabHLLt5obfNdwX2UHCcZpyRfT7wpZWrydtV/ldi
 58lEc626BakElSc2jDYrhq2CINsDCuVSZWtrlIdKsLbp9mUAI2t2DJxL+hHJv4p3NqPb
 oazpPY8SSZGTCMdCD7rmrT5XmpsZ7OYGpt4yANWgu4w7TetBMvCV/jz6RBbhVChYBvka
 maJACCCGdrT+rOPijKc/dv3vyeGyZUn9tYAtH91LQNZCg1M/XVEMFcJlxuznfVw7pst0
 i88rjXjywUA5HyuQjbfWUOgxaJpYJ3ghy2qDs0CZ6VD0i61N0A3pozFxKs/gu34X3Equ
 ihog==
X-Gm-Message-State: AC+VfDwTLX0j2pE1ZROV+DUyaIY8M2RIn9QqGBe8cxhjI/daRdO6T+kc
 gECR4QiWgu7sFNvPj0UowLAksQ==
X-Google-Smtp-Source: ACHHUZ5RoY5uZeG+YpGMGVJ/Tlm285NHDorfYgPBrqejStytYsn2C2n2M5rT1p3sIYIc83jWgWfe1w==
X-Received: by 2002:a05:6a20:549f:b0:119:38a8:63d2 with SMTP id
 i31-20020a056a20549f00b0011938a863d2mr2281780pzk.1.1686337052674; 
 Fri, 09 Jun 2023 11:57:32 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 g6-20020aa78746000000b0064d413caea6sm3057766pfo.179.2023.06.09.11.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:57:32 -0700 (PDT)
Message-ID: <3e710699-0e56-e613-22e4-7a7a579af7b0@linaro.org>
Date: Fri, 9 Jun 2023 11:57:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/22] target/arm/tcg: Extract iwmmxt code to
 translate-iwmmxt.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> Extract 1300 lines from the big enough translate.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate-iwmmxt.c | 1334 +++++++++++++++++++++++++++++
>   target/arm/tcg/translate.c        | 1312 ----------------------------
>   target/arm/tcg/meson.build        |    1 +
>   3 files changed, 1335 insertions(+), 1312 deletions(-)
>   create mode 100644 target/arm/tcg/translate-iwmmxt.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

