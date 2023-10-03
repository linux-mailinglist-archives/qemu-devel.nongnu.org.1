Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B17B727F
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:32:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnm3J-0001R7-KD; Tue, 03 Oct 2023 16:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm3D-0001Qb-Uq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:31:29 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnm3C-0002HR-9d
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:31:27 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-584bfb14c59so965317a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696365085; x=1696969885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Vz7yw+q2MTYV9lvuSdIWvub+JzCN1Z60kT7oZc0WSc=;
 b=nh2KNwhNwwukky+bJ5cA3AvTmWSk966HnIGcE1DzY1+/NBm4+FmFhQ0SSN25JCTov1
 sX0rUzNZ3AfD3EWndk2yHGq278EJGcO+i0jXrfghOEbPn4g6Q+2DS9+/meXQ1ljXkHYm
 aLobT1l6SJONjTh4ESPR3dNKL8bxNWUbM6HXfi7ol+vDBDWzghn0fKQDv5wIMFC1HUDl
 XA1BWxs5IiTJS0GATt8nzuuRDl4ARS8+wc4OYM1Fd5Z2FOUNuViycIYNlwgCVHHWL7S7
 HTIkdJk5GQaeXLfcfWYX23CkGv8m5UpsgfqTwNi4nJ+rCnSBZwBxANnetOx+jzR1FqW0
 VzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696365085; x=1696969885;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vz7yw+q2MTYV9lvuSdIWvub+JzCN1Z60kT7oZc0WSc=;
 b=mfjjNQ2QPG9vuGK06F7N+CCIxNJ2TiaTs7HIMgPGMNdspGlO21oUC7Ar3M6PvS8Klx
 jlZ4VsL9NoxThIqGvGGiJncD1bpxhoGW7X2F91cR1V4u1nMcSu5AmIJK9QirjRhbxTXX
 LMbwVObHmvpmI4nOHpfu3f0k5VQ5ZY80s6wuQTsly0SGfJdsd868Z0EfLbxlqvr+suYt
 Tajr+MVx3wdaXPA1M43hZIyUjEjIXGACSUZ2byzRzrOuCAALuiXZXpehDsJSUvHhBy+N
 RlE2NnyPx4D5Ij/gJsmIOACkpNTnndb0nr00doK65DwzIELoQOCPb6JYP224hP82yY4+
 6yVQ==
X-Gm-Message-State: AOJu0YyrUQ1L93eJ1r/6hfNz5tfArdVOXnUILZRDpBWH3iMSfAZMPmSU
 jOhQopxpyluXY7vBuUNQDQPTLcjvehzkLKW+Stc=
X-Google-Smtp-Source: AGHT+IGNG7TwxHjbjmJbfB+7TziaxqarOCaCDzb4G/jtoaXfhAU726rDgva+AMCjrccfR1ilmxfE4A==
X-Received: by 2002:a05:6a20:8419:b0:161:2389:e34b with SMTP id
 c25-20020a056a20841900b001612389e34bmr697803pzd.13.1696365084411; 
 Tue, 03 Oct 2023 13:31:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jd22-20020a170903261600b001c72f51b84asm2030039plb.52.2023.10.03.13.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 13:31:24 -0700 (PDT)
Message-ID: <8b441573-6775-75ad-12d5-9a36b0f3591d@linaro.org>
Date: Tue, 3 Oct 2023 13:31:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] target/sh4: fix crashes on signal delivery
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>, Richard Henderson
 <rth@twiddle.net>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: qemu-devel@nongnu.org
References: <b16389f7-6c62-70b7-59b3-87533c0bcc@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b16389f7-6c62-70b7-59b3-87533c0bcc@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 9/28/23 09:42, Mikulas Patocka wrote:
> sh4 uses gUSA (general UserSpace Atomicity) to provide atomicity on CPUs
> that don't have atomic instructions. A gUSA region that adds 1 to an
> atomic variable stored in @R2 looks like this:
> 
>    4004b6:       03 c7           mova    4004c4 <gusa+0x10>,r0
>    4004b8:       f3 61           mov     r15,r1
>    4004ba:       09 00           nop
>    4004bc:       fa ef           mov     #-6,r15
>    4004be:       22 63           mov.l   @r2,r3
>    4004c0:       01 73           add     #1,r3
>    4004c2:       32 22           mov.l   r3,@r2
>    4004c4:       13 6f           mov     r1,r15
> 
> R0 contains a pointer to the end of the gUSA region
> R1 contains the saved stack pointer
> R15 contains negative length of the gUSA region
> 
> When this region is interrupted by a signal, the kernel detects if
> R15 >= -128U. If yes, the kernel rolls back PC to the beginning of the
> region and restores SP by copying R1 to R15.
> 
> The problem happens if we are interrupted by a signal at address 4004c4.
> R15 still holds the value -6, but the atomic value was already written by
> an instruction at address 4004c2. In this situation we can't undo the
> gUSA. The function unwind_gusa does nothing, the signal handler attempts
> to push a signal frame to the address -6 and crashes.
> 
> This patch fixes it, so that if we are interrupted at the last instruction
> in a gUSA region, we copy R1 to R15 to restore the correct stack pointer
> and avoid crashing.
> 
> There's another bug: if we are interrupted in a delay slot, we save the
> address of the instruction in the delay slot. We must save the address of
> the previous instruction.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: qemu-stable@nongnu.org
> 
> ---
>   linux-user/sh4/signal.c |    8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Queued to linux-user-next.


r~

