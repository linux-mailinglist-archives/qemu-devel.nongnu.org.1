Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138247C7C5B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 05:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr9EB-0004mb-5k; Thu, 12 Oct 2023 23:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9E5-0004mR-1Y
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:52:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qr9E3-0003T4-9L
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 23:52:36 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-690fe10b6a4so1332451b3a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 20:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697169153; x=1697773953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SDF8tOqxkclznR9UMicE9MTyhYC7WbN5fie7XWKOTp0=;
 b=QZ4HBisB7WGnXsuAGf+4PWuKRpos29dmNuUXsl6ChMu3QESW/AnGvp++2T/Cb1CxYz
 jQ/vJjuvqF3do3ylsyAFhqNJkEKsA0Na2cCibZgqlKpytB+H3fpGnMxyc54z3UlTkNKe
 gGiHPDUkP3dFT2Bu4ebP0YtBMrGy/y+Z0euVGm25jg1U8/HFdXwUhmfudAp9xroEsvdC
 GA5FBJchwVFeu8yQc38wSws396+T/TMrb+5MMQlzq4LkvIpkyZyrNo13hyqZLU6nyHmQ
 DtuiVwkOmqgZ6fIXxzZjrsiQc0lZLhfIS7vxuNCI6Za7oQ0WKX1M7Nt+QZUAWjOdHDXa
 AEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697169153; x=1697773953;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SDF8tOqxkclznR9UMicE9MTyhYC7WbN5fie7XWKOTp0=;
 b=Pghi49eqSqx0J26q0GXwSd67+FScINGFQ4CwX+bYltoiDjECCrkxAW3/CT/5Z1+ZJE
 O/64JILLB/JgFX2toVbQlBG/nHxdCifG6ZvYpySrcCtvZHy69A1lHWVEVrpFNmWp5B1u
 snfQ5nKuW4LR6Me08vf1IZtO/x8CXZbdCg5VckgreNTNNUZH4XRL6cHytDKRzu4D9Iiz
 oWTUCtdF0OEX/DodCEM3w5oaJun+Zf4uuo6opycYllfU6/mC4phnuqLMH4MCm41Lj9El
 PLuxogH2nDsJvwec1d371HZafiOFW96RuzMScPrO+yRRB9zKFoFfNHPTMCZTEiHXGtpc
 0P5A==
X-Gm-Message-State: AOJu0YyuEkXwxfMbK3jfcVa836JU7M0X4+QdpSxPen/N5Q5r+b151Fps
 FXeR8b3BbrKExQOEdtWK4PC1833uDvPmCnCZQw0=
X-Google-Smtp-Source: AGHT+IFWcrVA+DPzDJ/sygQwKtw5Y9NTLrO4JesOugsPTD3riM2JJR/NKExuybEYGxnfOA8S6w8kHA==
X-Received: by 2002:a05:6a21:a585:b0:148:f952:552b with SMTP id
 gd5-20020a056a21a58500b00148f952552bmr35644116pzc.51.1697169153154; 
 Thu, 12 Oct 2023 20:52:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 nr11-20020a17090b240b00b002791d5a3e29sm2624540pjb.6.2023.10.12.20.52.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 20:52:32 -0700 (PDT)
Message-ID: <aa9f3112-7e34-4eff-8d93-59d036e82ff9@linaro.org>
Date: Thu, 12 Oct 2023 20:52:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] linux-user: Detect and report host crashes
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, deller@gmx.de
References: <20231003192012.1674888-1-richard.henderson@linaro.org>
In-Reply-To: <20231003192012.1674888-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Ping.

On 10/3/23 12:20, Richard Henderson wrote:
> More signal cleanups.  Mostly tested by temporarily adding an
> abort, divide by zero, undefined instruction, null dereference,
> within the implementation of a guest syscall to induce an error.
> 
> Changes for v5:
>    * Remap guest abort, which means we need to try less hard on
>      the host side to handle assertion failures.
>    * Drop the backtrace.  Since backtrace_symbols only looks at the
>      dynamic symbol set, we don't much that's useful -- we still
>      need to use the debugger.
> 
> 
> r~
> 
> 
> Helge Deller (1):
>    linux-user: Detect and report host crashes
> 
> Richard Henderson (8):
>    linux-user: Split out die_with_signal
>    linux-user: Exit not abort in die_with_backtrace
>    linux-user: Only register handlers for core_dump_signal by default
>    linux-user: Map unsupported signals to an out-of-bounds value
>    linux-user: Simplify signal_init
>    linux-user: Split out host_sig{segv,bus}_handler
>    linux-user: Detect and report host SIGILL, SIGFPE, SIGTRAP
>    linux-user: Remap guest SIGABRT
> 
>   linux-user/signal.c | 452 +++++++++++++++++++++++++++++---------------
>   1 file changed, 296 insertions(+), 156 deletions(-)
> 


