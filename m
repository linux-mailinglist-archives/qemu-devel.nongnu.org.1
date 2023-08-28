Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC4B78B70A
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagg7-0006HK-H6; Mon, 28 Aug 2023 14:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagg6-0006H6-1N
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:09:30 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagg3-0001FK-OA
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:09:29 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdc19b782aso21249935ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246166; x=1693850966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TeYO3sjn9qzI34OPnmuGl1l7tSg3o4XVHS1muErXnfY=;
 b=nh7XA/afF9qPMjtvm+yHWXpTSAS8PEAH3JQPKiQKiRC2Pi+a4Au+KNdIyJ/nqo3SFn
 5QKcY7vflpjXLjBYsPE3gL2swgcmwR50vsSEHi7ZYkB97n8m2nF3cLiDli49gpODdQK9
 JYESyNYKn5/pD18lmt65tybtcbt1J2FS+PMatvx6bog/2SKiLN27QnEq1c/kyCZFNLeU
 n0ba/LCxgU9toE2AfOfqtKBa2eMVGFGYEe8gqxpo2Pow3OHytr9ofL+mThiTfbEHC5TW
 RJGgYAwNJKP2dpum8REN5Q9kCm6NCcTtQmZ13jj2kzS27hIhr2+Tt4aqQ6CPVkXUulUW
 rI/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246166; x=1693850966;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TeYO3sjn9qzI34OPnmuGl1l7tSg3o4XVHS1muErXnfY=;
 b=IfzI5/r1aqat1iFrv5hoc1C/SoMUdThI+WhWJhWTIWjIoAbdZizmuC7Hl4OsPKwNn7
 +/q4fxA+gHnRDM6AUx2w4tPAxP685ZsfW6M25Yswf9zawRBwBQ//LlTRbRhbyxBSbwhT
 K2MGDepYu2TsAhE42L+5ADOEH2CyCBKbaITCj5AOF49AZ7Tl66kuTiXhmB8acwqOkufR
 FeLac59s7fQ0m/7CcxmnKXKRPitFE5PuJdjrnKZfK1K1zlH7Ut9fJeIrd/g1/aV/m8Ys
 zrTWV2iuhYyEpMq2ipplXOyHMu/04aGhR2AQj9hogN3irl/OvnIYgv0laaQ7qfTpkB6S
 PmEw==
X-Gm-Message-State: AOJu0Yz+wy/5qMNsJkVrmnr/trgD9a+1AXKI8lS22ycrY5klIGHzAC9C
 o+fCXmHr0JKMCt/1+LSIEZ/Hcg==
X-Google-Smtp-Source: AGHT+IFHRPUshP0Zh4Xf2qICiqnqM2xNcUzJf+6pO15ZFfvdRH7sUdPdirOVd4eGiurHHKv3YRXp6g==
X-Received: by 2002:a17:902:c945:b0:1b8:78e:7c1 with SMTP id
 i5-20020a170902c94500b001b8078e07c1mr27881848pla.51.1693246165856; 
 Mon, 28 Aug 2023 11:09:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001bc35b14c99sm7663536pli.212.2023.08.28.11.09.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:09:25 -0700 (PDT)
Message-ID: <6726b8e1-bfa5-1e63-f3b2-48bbb821d88e@linaro.org>
Date: Mon, 28 Aug 2023 11:09:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/11] target/tricore: Implement CRCN insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-3-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-3-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/28/23 04:26, Bastian Koppelmann wrote:
> reported inhttps://gitlab.com/qemu-project/qemu/-/issues/1667
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>      - Removed useless deposits in crc_div()
>      - Replaced final deposit() with extract() in helper_crcn()
>      - Add trap for CRCN insn if not feature_162
> 
>   target/tricore/helper.h                   |  1 +
>   target/tricore/op_helper.c                | 63 +++++++++++++++++++++++
>   target/tricore/translate.c                |  8 +++
>   target/tricore/tricore-opcodes.h          |  1 +
>   tests/tcg/tricore/Makefile.softmmu-target |  1 +
>   tests/tcg/tricore/asm/test_crcn.S         |  9 ++++
>   6 files changed, 83 insertions(+)
>   create mode 100644 tests/tcg/tricore/asm/test_crcn.S

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

