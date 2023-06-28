Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D87409D6
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPxU-00020W-6U; Wed, 28 Jun 2023 03:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEPxJ-0001xc-BG
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:51:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEPxH-0006ah-2K
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:51:12 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa96fd7a01so37416715e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687938669; x=1690530669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EFo6qxm7Fb5/qm0fUPMVjU2GbYBqnb0O2osPRSmTXqw=;
 b=yurSZZkvpsZ2A9OezBqaFgD0RQFgZNFpcKEs+0os8VbeLeNsZSflfh0zXQ6T4BJ7qM
 jjrJdudeBeQVgXIRU8ppBSvyUk3Rko2aUEhB3yAYcDDuQsDPmj5n4j1kamXQQiIa7zjZ
 xUtRUFwvMjIrGz47AAc01K4xr8kD4W0X2YEcMH3O+etYxrAQ6iLv+I9piYDMa+dVOMIP
 agAPXiAkpC4knfjGgTq/q27AQD+vrMfW2jjVQtU3uO0ZJ+g+5/e0f/bPn57XdgrPoKso
 nrWbqpEi4+23CsOG8iYxXMRKaj+cYfVI/ClPk6pND9GsmzPA1lfpHDdeJMApxi1cin1p
 2ecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938669; x=1690530669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EFo6qxm7Fb5/qm0fUPMVjU2GbYBqnb0O2osPRSmTXqw=;
 b=D/TsvrMEto1ttWZWdmSOsX4Wf5HT7wWC+bTbe69DrtTJg9MGy1G/4OAGXQtc4jmK+O
 ui1Vo8b6ubsG/IKt5sjsKexruUsKUH2VdUaMSTdGDaOkt8FEjbbrigpkrGy4S+No8eQs
 BrtZ3Iuk8OsTXzhVbl1KSBkVB7IEigsLqhPI5Nubl3JBX2jZDdX5BSKtC508wlwCfdu9
 p9gRv+umgzdFKNtrTtAHlf2mdIvmXFm1FvqELoSANZTxA3CzstjL5FN61KteOKAk2rqP
 bDCW9MjZweeP/0N98e2zzs2a0pESnRnsyEfZUuYqIp0Doz1c5HqmerQZD95NBBBC/eyz
 ZHWw==
X-Gm-Message-State: AC+VfDzP9lzdhGi8olA3tuo/m5a2hBcxs3LSwZdqQgxzWqxC38pJz0Dk
 EQOhZx7esSzbcwePAIXIRT49qn77jNzlB/TEuDQ=
X-Google-Smtp-Source: ACHHUZ5yfNTs6OK/kUhmW3YTZ54zKTqNBJvniaIcYAe3tSHClUskAHZVBS1d8lGE8J3yynVR21l6Bg==
X-Received: by 2002:a7b:c041:0:b0:3f9:b748:ff3f with SMTP id
 u1-20020a7bc041000000b003f9b748ff3fmr21175099wmc.1.1687938669415; 
 Wed, 28 Jun 2023 00:51:09 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f90a604885sm13038326wma.34.2023.06.28.00.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:51:08 -0700 (PDT)
Message-ID: <41722f05-87d5-5d0e-f977-a46ca55667dc@linaro.org>
Date: Wed, 28 Jun 2023 09:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 4/8] target/sparc: Introduce DYNAMIC_PC_LOOKUP
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230628071202.230991-1-richard.henderson@linaro.org>
 <20230628071202.230991-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628071202.230991-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 28/6/23 09:11, Richard Henderson wrote:
> Create a new artificial "next pc" which also indicates
> that nothing has changed within the cpu state which
> requires returning to the main loop.
> 
> Pipe this new value though all pc/npc checks.
> Do not produce this new value yet.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 147 +++++++++++++++++++++++++++------------
>   1 file changed, 103 insertions(+), 44 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


