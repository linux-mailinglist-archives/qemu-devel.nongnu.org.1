Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B3A74B7B3
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrre-0003Cn-Hj; Fri, 07 Jul 2023 16:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrrc-0003CW-1q
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:15:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrra-0000IY-4R
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:15:35 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8deso29295145e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688760932; x=1691352932;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2VtQnDPkWTjgtbeFhXTmrbjCfLpQtZRW6ogQQ14a2Yw=;
 b=I1duePoxxnob2ZrW6+BR9lmyPKDQndUe5YbCAYcwEzvxx2wJT4eJ1FveNpRozMy0dF
 qt3r7yh7cez/6igW3DSzkbPFxCB14DgzdYqAXb81TKQJq9BEXBd8o+pGEU2r6nvyMzX0
 f5A6sUJDNL54DGdKTj/Qaa14BaY06KRU5rjT28xiLZw3NUVL9A6sFnksc4V+BnZpXb4F
 Rr7/IjE47xw90/5ZioTRw6DJ0vQi95+czvfJuvKgMqLitPdV35NK0ddhHG1M9DRW+g6W
 C1Entj6jz5JoQgdn+EBtO5uE71YL1ZitYH5AKqzaeDSfKChWL942u1Ct+eLumeVXyccu
 tGUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688760932; x=1691352932;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2VtQnDPkWTjgtbeFhXTmrbjCfLpQtZRW6ogQQ14a2Yw=;
 b=cIwhsdqx4s4P07Yx+y6sVaF0XTDZKjCfpuklFyZajuZF/+RbF0fG6tfcVTBsLmqjab
 WdU/1UWxMuaOcjzUcYzuJvDigGb7JMneT9jbLnziQPU4qiLOpPxbghvF7eLb3dCUTIkD
 DkkPoMN5yuNbtXh/zOQoEKFk3Xruhzp0BSFx5KjJyYdFKFUlNsdQMk3JW0XvBUiC8ATc
 msc9E4wd+Qi2eRDvX+wUbXx1gGMIGZSod5JSYIlPMhfqHBwE9nrcEaUizEAEItEw/KI1
 iCaqRTJSJmpm9lP1vwU7hATyDyogrZ2jjwIQWIwr1GONrr0Ve7yeKxoErbW3XygZo8Fr
 aXWQ==
X-Gm-Message-State: ABy/qLbUNgXQGXapvVxeriMerdcF2AcTnH1a/Rv0I+oBPgFX/mrArqIx
 nrTuMPZQcMi4K/zI43NDdYCDOQ==
X-Google-Smtp-Source: APBJJlFARz2Gt24zStJ9BxSXojYefXwu56W4nqZEh6ROtzz3i6JXp0GbonwbEf3ijFbgtY1Ew+u8WA==
X-Received: by 2002:adf:dc11:0:b0:311:1b8a:b70e with SMTP id
 t17-20020adfdc11000000b003111b8ab70emr6920183wri.66.1688760932137; 
 Fri, 07 Jul 2023 13:15:32 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a7bcb0a000000b003fbb346279dsm3318244wmj.38.2023.07.07.13.15.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:15:31 -0700 (PDT)
Message-ID: <d092563a-772c-773c-3909-48820b189bbc@linaro.org>
Date: Fri, 7 Jul 2023 21:15:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-3-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707131928.89500-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/7/23 14:19, Helge Deller wrote:
> The accept4() syscall takes two flags only: SOCK_NONBLOCK and
> SOCK_CLOEXEC.
> Even the real Linux kernel returns -EINVAL if any other bits
> have been set.
> 
> Change the implementation of accept4() to recognize those two values
> only, instead of using the fcntl_flags_tbl[] bitmask translation.
> 
> Beside this correction in behaviour, it actually fixes the accept4()
> emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
> different than TARGET_SOCK_NONBLOCK.
> 
> I noticed this wrong behaviour with the testcase of the debian lwt package
> which failed (by timeout while hanging in the read() syscall) in qemu but
> succeeded on real hardware.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3f1e8e7ad9..9e9317237d 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -3440,7 +3440,18 @@ static abi_long do_accept4(int fd, abi_ulong target_addr,
>       abi_long ret;
>       int host_flags;
> 
> -    host_flags = target_to_host_bitmask(flags, fcntl_flags_tbl);
> +    host_flags = 0;
> +#if defined(SOCK_NONBLOCK)
> +    if (flags & ~(TARGET_SOCK_CLOEXEC | TARGET_SOCK_NONBLOCK)) {
> +        return -TARGET_EINVAL;
> +    }
> +    if (flags & TARGET_SOCK_NONBLOCK) {
> +        host_flags |= SOCK_NONBLOCK;
> +    }
> +#endif

Can we avoid the ifdef?  Anyway, surely the TARGET bit check should not be protected by 
the #ifdef.


r~

