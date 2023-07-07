Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C958074B724
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 21:33:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrBB-0003Mx-PA; Fri, 07 Jul 2023 15:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHrB9-0003MS-Ic
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:31:43 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qHrB7-0002Y1-Vq
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:31:43 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6b7484cbc5dso2042635a34.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1688758300; x=1691350300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ccTiCkLVA/LRJPZjVHRAReNmK/s85i/9qg8fzqvgX8E=;
 b=VZvsl3JZf+mNArvtcn3ht10sC6xpEFZgLEaYluUV0uhOXFhi+cZykwyyCHMqa2Iphm
 ImYSRISE8Gn/8ATbWokLCzLf9kuyXm6dmXvNP71hSRfRsBNcXEd8p/y1Z2NFFoz7NaJa
 63cBY8G55/c8kiZN9cp27i4WpB5xPwyF617tRljh/3lmZPu8eub17j/3qzdYrmeBXleS
 hmkzUQoFH6FZp2NoxgywXTpwOYdPT8pnap56cFq8VojUmq9Wycczy17oyPdo62JPcrR4
 X7wCsk0lf/LYG7f8wu//TvDLWhXK4473+ikN/rDOp6CGrgsDBeHzC9/JX/K4mppAThMN
 PGCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688758300; x=1691350300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ccTiCkLVA/LRJPZjVHRAReNmK/s85i/9qg8fzqvgX8E=;
 b=G+wJa8fU1tmLl1T6qOTrjdaNOHyjNpLtARSs/6IjxuMqjgYtF7a2J/vfYmerLCzmnh
 0uVxu80LifAYB1W5CiskHnSJ2BGUiRM4L2QY9vHS//MD6GzgbxuuwnT1qZ+RFlURZoyg
 gstorUotRP+Ahqq0Qt/3rfnXPt3qXrs/6HxYUD1XbQO+46ttV27658bwbgVY4iGqKlJy
 jJhr+gVScNm+h2rP/kwx+sH7xntC05dWR0ilttnPKWrUmk++IRZ1VCSy1QkV6YCl5+mz
 /SYjq6UmWttRQg34Ipyfbdw0eR/Tr1eye2GDE0FZ1f7FG7GmK7ZDshrvFwo9sNwvhQOn
 F56A==
X-Gm-Message-State: ABy/qLaf6iWsRHw+BxQ1SSfIjfySktw+dHKWFOXTDtXLo7/oEsvaBMkn
 9ZIbdq38Z3CiXIOQBW62KclgRg==
X-Google-Smtp-Source: APBJJlEv6mOuKOP4l6srcdwZwhqGFzf3bqoHNG/VX0l7NULTAbWbwvFCjLwiAtkJvyLHIq8CXuItBw==
X-Received: by 2002:a05:6808:1444:b0:3a1:f18d:2fe8 with SMTP id
 x4-20020a056808144400b003a1f18d2fe8mr5256267oiv.10.1688758300384; 
 Fri, 07 Jul 2023 12:31:40 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 4-20020a544184000000b003a361fbec60sm1939734oiy.47.2023.07.07.12.31.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 12:31:40 -0700 (PDT)
Message-ID: <00b01e30-2675-01f7-dc39-19214d6f5197@ventanamicro.com>
Date: Fri, 7 Jul 2023 16:31:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] target/riscv: Remove redundant check in
 pmp_is_locked
Content-Language: en-US
To: Ruibo Lu <reaperlu@hust.edu.cn>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, luruibo2000@163.com, alistair.francis@wdc.com,
 liweiwei@iscas.ac.cn
References: <20230704023811.4355-1-reaperlu@hust.edu.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20230704023811.4355-1-reaperlu@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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



On 7/3/23 23:33, Ruibo Lu wrote:
> the check of top PMP is redundant and will not influence the return
> value, so consider remove it
> 
> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Ruibo Lu <reaperlu@hust.edu.cn>
> ---

I believe we might want to add:

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1733



>   target/riscv/pmp.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 9d8db493e6..1a9279ba88 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -49,11 +49,6 @@ static inline int pmp_is_locked(CPURISCVState *env, uint32_t pmp_index)
>           return 1;
>       }
>   
> -    /* Top PMP has no 'next' to check */
> -    if ((pmp_index + 1u) >= MAX_RISCV_PMPS) {
> -        return 0;
> -    }
> -
>       return 0;
>   }
>   

