Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4E799B42
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 22:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf4uL-0008As-CW; Sat, 09 Sep 2023 16:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf4uJ-0008AZ-PC
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 16:50:19 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf4uH-0007Ch-7P
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 16:50:19 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c39bc0439bso3032265ad.0
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 13:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694292615; x=1694897415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CmshPNdUVElJqrEmTM9WrvVoAh0siLxtF48XC/Y0VP8=;
 b=oMxRu5nX2v/iKseAzA63EGN6TVgrkbcxcXmtcN1TApK9qxz2SdV6uciGuuzcO3TOlw
 5h6nUxFqgajw1qVFNL1HKYVN3aWp30xZM8TRl6cNlKDmNvMEcfc9LIHkgE1ujwckWepp
 lnZ9d9pwRJsHIBeCIUz9ccq6xFesnYg66wd9tX7/NAlZLQvOybMUwXZ0TwzmWLS7yIl7
 w5/K5cKjkOjxUyWp9OpcwK4FulA6vlJd4IwTEY0oXsrUSNlKaKsBTDfsukgRlLnQ0BRF
 A/XT3HSVxm+/rcfnTc3DT/ca99bB/SOK8tYLePLJk+05fWfpo8syECgqlm5VxSvynrpe
 w7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694292615; x=1694897415;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CmshPNdUVElJqrEmTM9WrvVoAh0siLxtF48XC/Y0VP8=;
 b=mAfEy8WIiZb3XBM8bX/U4LGISoSmNPfwScVrwQeKBjkvIoPxF+QspsTgSeV6paEQ4V
 1D4wUGuc6jPz7CyxtWV2EH92JItKBB2YVFBRcydkO1ac2C4GZoBEnQPAZgGvXbqaRP8n
 rmL6+e1jbPOOazpPOoDc6cDqu9TE1BNsussppCZCXmPnRqo3QWqoudOTMPRfjkbP6Jgg
 WrAn6BjjojSFop53Fetd/f9+N939/ntpkr3ib2rHulEIXRyjsAidLymrUXZTIAIOawI3
 5ZO+VfVojq+H72DxO47GSALT35j3b1SzWWRchWevhtQW7ujdRg8pRctt+1zRgJwhFVxu
 OBBA==
X-Gm-Message-State: AOJu0YwvmvIb+Vhv3HmvBCVduNsytjjenXdecQG5V4uuYFW8Ouq2eD2S
 cjghmz6XgGjutvSQSecERCbgX18a+1EFHieiWGA=
X-Google-Smtp-Source: AGHT+IG9kE9qD0VW0P7aQRbUcLUjvbgB8nuWyaQNRiTw7Da1njB9l/CUbGKRRy78R710eoqPbu1Npw==
X-Received: by 2002:a17:903:32d0:b0:1bd:e258:a256 with SMTP id
 i16-20020a17090332d000b001bde258a256mr7807635plr.32.1694292615141; 
 Sat, 09 Sep 2023 13:50:15 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902e9c500b001c1f0b3e900sm3619234plk.229.2023.09.09.13.50.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 13:50:14 -0700 (PDT)
Message-ID: <88a0cad9-a742-01c9-af7f-b7b0c09a20cc@linaro.org>
Date: Sat, 9 Sep 2023 13:50:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] tcg/aarch64: Enable BTI within the JIT
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230816142516.469743-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230816142516.469743-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Ping.  Patch 3 still missing review.

On 8/16/23 07:25, Richard Henderson wrote:
> Patch 1 is cherry-picked from
> 
> [PATCH v3 02/14] tcg: Add tcg_out_tb_start backend hook
> https://lore.kernel.org/qemu-devel/20230815195741.8325-3-richard.henderson@linaro.org/T/#u
> 
> here used for a different application.
> 
> There are not as many landing pads as I had imagined, so the
> overhead here is really quite minimal.
> 
> The architecture enables the check only when the PTE for the
> jump target is marked "guarded".  Linux implements this by
> adding a PROT_BTI bit for mmap and mprotect.  I have isolated
> this within a host_prot_read_exec() local function, which
> seems clean enough.  So far, as far as I can tell, Linux it
> the only OS to support BTI.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>    tcg: Add tcg_out_tb_start backend hook
>    util/cpuinfo-aarch64: Add CPUINFO_BTI
>    tcg/aarch64: Emit BTI insns at jump landing pads
>    tcg: Map code_gen_buffer with PROT_BTI
> 
>   host/include/aarch64/host/cpuinfo.h |  1 +
>   tcg/region.c                        | 39 ++++++++++++++++------
>   tcg/tcg.c                           |  3 ++
>   util/cpuinfo-aarch64.c              |  4 +++
>   tcg/aarch64/tcg-target.c.inc        | 52 +++++++++++++++++++++--------
>   tcg/arm/tcg-target.c.inc            |  5 +++
>   tcg/i386/tcg-target.c.inc           |  5 +++
>   tcg/loongarch64/tcg-target.c.inc    |  5 +++
>   tcg/mips/tcg-target.c.inc           |  5 +++
>   tcg/ppc/tcg-target.c.inc            |  5 +++
>   tcg/riscv/tcg-target.c.inc          |  5 +++
>   tcg/s390x/tcg-target.c.inc          |  5 +++
>   tcg/sparc64/tcg-target.c.inc        |  5 +++
>   tcg/tci/tcg-target.c.inc            |  5 +++
>   14 files changed, 119 insertions(+), 25 deletions(-)
> 


