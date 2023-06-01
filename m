Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713D5719ABC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 13:12:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4gDf-0004W7-Eq; Thu, 01 Jun 2023 07:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gDd-0004Vu-OQ
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:11:49 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4gDc-0007do-5Y
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 07:11:49 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2af7081c9ebso9660511fa.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685617906; x=1688209906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z4sMOh4ZvMoEfCkV6dPlO7jThH7tAVNMQw6ROVQLaiA=;
 b=pgw5Y1CDDrS8g2bJO0UIsdWu5akDWY805/f2BTDYFmgJ7ReKTaJH8Jf1/5dzvpGrKJ
 wx2fEsTCL7hrs6TxfzcbxtG5dI5XoaTyX4am+UF8U6QCJ6M/XQrg88pVALV3tFGtgjtN
 k16ailcum2DefbIwVuolOMT0CYfFjk/fLVNbmFd8Lyun3qY0+LeFEMzjD2EVCMh8GUOo
 hs+pAovoSGv16CcFCErTzoksbQXG9auAcDPyO+wlHXXmBqKhweLMA2FQ/csqykJNDmYt
 iRKPB4rkkGgoXZ7olpl+ru3UXB4ysy7sl2pMXsU8/dsA2lWX01pgRd33kva4nS+VlVtw
 RNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685617906; x=1688209906;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4sMOh4ZvMoEfCkV6dPlO7jThH7tAVNMQw6ROVQLaiA=;
 b=lTSoTeztK1GEqzq8HZPZTXtU8rGDyHbKoQJyNNLWUD4Pw8KtWAcyUuWdLVKtq7Ygpl
 Wv5U/EGZsYceVQg3igvLV9ZeeGRQ82c1QXgEQHdNZGcTyBun8rgCCgajicbGalpLixuz
 WFz3lDPJveWXcgsG6kfTfWUcyqJe4W9Lg7mquTqbCXrvsSQPOfSV8RECCUXTmcPOA+b7
 aet8lqm1XLhhoX5stCuDt8TK1JTZvTclUSTjdPEiifPWBCgywNoOpVoHqd1Q7D6lOWss
 1AriFIQcT5Uk+LVDDYTBXxrLdXdZjD+BkET8e0afXNYdyeC0Mu/QmSqR9vSIkGoKtB8m
 RJRA==
X-Gm-Message-State: AC+VfDwnU9QJUOP4OJvJrfMXH2hqFRQ7XWKukI+lCKjtZO2aXZGXrOtt
 fLoP/OszlwACYmTs/3+rLiiOIg==
X-Google-Smtp-Source: ACHHUZ7eOTYBoBFy5qTxvU+XZVHy330wAA8cgNYBEkbr+uZ3B1s7DRsh7dKu59SrkyYBrcppmxXuzA==
X-Received: by 2002:ac2:5626:0:b0:4f3:843a:7296 with SMTP id
 b6-20020ac25626000000b004f3843a7296mr1017238lff.42.1685617906032; 
 Thu, 01 Jun 2023 04:11:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.141.224])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a5d440e000000b002e5ff05765esm10024115wrq.73.2023.06.01.04.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Jun 2023 04:11:45 -0700 (PDT)
Message-ID: <5120e61e-df53-415f-33f8-d3e028e50a2f@linaro.org>
Date: Thu, 1 Jun 2023 13:11:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 07/48] tcg: Add tlb_fast_offset to TCGContext
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:02, Richard Henderson wrote:
> Disconnect the layout of ArchCPU from TCG compilation.
> Pass the relative offset of 'env' and 'neg.tlb.f' as a parameter.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-defs.h          | 39 +---------------------
>   include/exec/tlb-common.h        | 56 ++++++++++++++++++++++++++++++++
>   include/tcg/tcg.h                |  1 +
>   accel/tcg/translate-all.c        |  2 ++
>   tcg/tcg.c                        | 13 ++++++++
>   tcg/aarch64/tcg-target.c.inc     |  7 ++--
>   tcg/arm/tcg-target.c.inc         |  7 ++--
>   tcg/i386/tcg-target.c.inc        |  9 ++---
>   tcg/loongarch64/tcg-target.c.inc |  7 ++--
>   tcg/mips/tcg-target.c.inc        |  7 ++--
>   tcg/ppc/tcg-target.c.inc         |  7 ++--
>   tcg/riscv/tcg-target.c.inc       |  7 ++--
>   tcg/s390x/tcg-target.c.inc       |  7 ++--
>   tcg/sparc64/tcg-target.c.inc     |  7 ++--
>   14 files changed, 110 insertions(+), 66 deletions(-)
>   create mode 100644 include/exec/tlb-common.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


