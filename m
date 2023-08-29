Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F318F78D07A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7ns-0001aa-Ud; Tue, 29 Aug 2023 19:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5nA-0005BP-3M
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:58:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb5n7-0001Cf-Mf
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 16:58:27 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68bee12e842so3374620b3a.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 13:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693342704; x=1693947504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qf6ucjtJWAHMe/xIqW1IVPzwZ4LlL/t79pnH0003mO0=;
 b=oc6jGc+JFDGPuFSZQVciyh4nlTkmYC+g5dZ4BNZjK353xFfbG0EZMAo8bRc8GwxYyL
 EUt3nhJuSNEK+cc+Z2NKoVxyUtqEUONS+ZtGrfPoPvfFLILciLA/e3/9eEGm9OHWmT1A
 5qP5rQ2HiEl0L39Sio3AEqbUkphumrLzPEMJ/pQZdsKgoxY9EaYdBnz0MRdgU6lefIjd
 GZre2nswWgZy5k4z/YnzMai0duHZMqdOXglSasR0idfYv07Rs049RJYIsRib40MG/he4
 KHKJ+pbSqlY7uyouJgjxcwnjOCBLP9fyK39SdwQaMXfe7DUDX2P9aS0JrioQIB63uQt6
 LhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693342704; x=1693947504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qf6ucjtJWAHMe/xIqW1IVPzwZ4LlL/t79pnH0003mO0=;
 b=F3QBdyJQPgVv5qzhO6gejgZ2FVm4IEo50RddUNGuWYdzTvShE9/Zfc6QhNtO58Qfav
 42f6LUz8MIkx70lE68KPnPy1qLADnKtkhNVKYFS2RMMAi40QopLQVNlfx3BVEU/uM2AA
 4Y1/yJwuH3u/05xZ5t1X0oy3q0t4qYblFlerPTBY3rAKZl1h4d2cictWIP2pXxpsg298
 JEFAenD83/FfB9bYa7+nKa8EXo8hfmYlarS5YwKSv0r7GVExLcaXv8OGhMjn5Loj93Ek
 1grOJS2gFYLeBDZDUMB8BDrliLqFEESQBSSJBY5/5Tk9hHV+jkbE9O3MlHMw7JGXahJU
 p+5g==
X-Gm-Message-State: AOJu0Yxq1O2nbrH6Y13L5jWSvGXrb6KOMh46ZXPzGhLb8UvxOyVV8Uwa
 pOf1bYfxcFA85pGR9fsyzvii0jMOozfM9Zk/M4k=
X-Google-Smtp-Source: AGHT+IGKAqy35oJR57IA0ZVPoBzj2JHcwjgb6Yl4CrJEuchhJcRFyvEcevVBge8VKvd19mcBsqsH/g==
X-Received: by 2002:a05:6a20:395:b0:137:3eba:b7fb with SMTP id
 21-20020a056a20039500b001373ebab7fbmr392687pzt.2.1693342704000; 
 Tue, 29 Aug 2023 13:58:24 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a14-20020a62bd0e000000b006875df4773fsm8810558pff.163.2023.08.29.13.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 13:58:23 -0700 (PDT)
Message-ID: <02510730-72e8-9b0e-483c-048c7301328f@linaro.org>
Date: Tue, 29 Aug 2023 13:58:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 32/32] bsd-user: Implement pdfork(2) system call.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-33-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-33-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/27/23 08:57, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-proc.h    | 32 ++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-proc.h b/bsd-user/freebsd/os-proc.h
> index 94824d737a..1eaba908a5 100644
> --- a/bsd-user/freebsd/os-proc.h
> +++ b/bsd-user/freebsd/os-proc.h
> @@ -248,4 +248,36 @@ static inline abi_long do_freebsd_rfork(void *cpu_env, abi_long flags)
>   
>   }
>   
> +/* pdfork(2) */
> +static inline abi_long do_freebsd_pdfork(void *cpu_env, abi_ulong target_fdp,
> +        abi_long flags)
> +{
> +    abi_long ret;
> +    abi_ulong child_flag;
> +    int fd;
> +
> +    fork_start();
> +    ret = pdfork(&fd, flags);
> +    if (ret == 0) {
> +        /* child */
> +        child_flag = 1;
> +        target_cpu_clone_regs(cpu_env, 0);
> +    } else {
> +        /* parent */
> +        child_flag = 0;
> +    }
> +    if (put_user_s32(fd, target_fdp)) {
> +        return -TARGET_EFAULT;
> +    }

I *think* this copy belongs in the parent?  It's really hard to follow the path of new 
process creation within the freebsd kernel.

Anyway, the rest looks fine so I'll give an

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

