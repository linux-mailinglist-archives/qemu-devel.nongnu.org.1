Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C67B25FE
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:39:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwph-0006nK-5K; Thu, 28 Sep 2023 15:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwpf-0006nC-Dt
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:37:55 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwpd-0006j2-KJ
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:37:54 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ae2f8bf865so6481369b6e.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695929872; x=1696534672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sd3JgHHbzfXrzJFWic3Cq/C6a3eXNco/BTfaLz6PrDY=;
 b=e2kJzhB/Dfl9S3dPxMCZGFuoqgdtSkG1CwV1dXBy2ohKUoytuw9ozlZrIk1m/ZHW2L
 5R9PVOE4O7V2bH3N7qH4AnjUdfXlo24gLwHOnmka6urkx5beDx+argTqYLvljdOmX1Ib
 QeFySCl9rjtWFjSaA7qv+eJ51hSt1zSfIA8No3y7Sk1aX0qY/J7c+hoe/txhdw97X9RU
 syD6p6MuuhOehLLq3QTv9qadZetMOJeBPgWKUUOPrFHlvWp1kVmb2Mb7DS0Xwun0zJ1e
 WkUk4dm2tacQayJUB2iO4tADa+BzdLX+yAketLCCXEbPsNRm3mac/uszA3TGFIHO4bPw
 H7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695929872; x=1696534672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sd3JgHHbzfXrzJFWic3Cq/C6a3eXNco/BTfaLz6PrDY=;
 b=CiCy2FLv3icu/MJxPuH8sPUwnOLep/ulVodQzHYbjvAtEtE7sMdql6AVGNOoQX8MUP
 y7LTxxqIlRuHbblDBgwvbV7Vn3tvClR7h1kesIdzP+Ba0bJ6r09ZITTeydv0B75AzENy
 sRmqMdNKVhwgyMJVMaMs4+Cr1nzZuu8hDdJ2j78/BxVN9OD5EBUvvTBczTI5xLoh+48g
 RswIH1jJW31/91RH+8H8NVJyZG1hfLhorC5v3LuXmaB0dYIWQNDfKapvtYlZU1l3iUvp
 /35RZMM9bqm2jR1UgIRbcAVspoFxZt6eclfBjHA7/Q9bOxSq1HX2ZDp61aVqoLrx5scB
 lqtQ==
X-Gm-Message-State: AOJu0YyMUPGYnLPIzQWnINWXYPZlg2gaX+K284XhKp14+boHPH3n5exE
 zbzDh5rJCEM1Jimps6pNoaIVuA==
X-Google-Smtp-Source: AGHT+IHAYNzMMQ2KToJAzmTJncbWSi3HaoQRrazFxUDG0lpguNZAc2udTm875vEyvEBzC+Yb/lKblw==
X-Received: by 2002:a05:6808:2209:b0:3ae:5397:eaa0 with SMTP id
 bd9-20020a056808220900b003ae5397eaa0mr2522209oib.41.1695929871813; 
 Thu, 28 Sep 2023 12:37:51 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 du14-20020a056a002b4e00b00690fe1c928esm9906928pfb.91.2023.09.28.12.37.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 12:37:51 -0700 (PDT)
Message-ID: <6148083e-ba07-798c-4cc3-6cf29236c53c@linaro.org>
Date: Thu, 28 Sep 2023 12:37:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mips: fix abort on integer overflow
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org
References: <cfa02bbb-cdaf-4310-ac40-a2837d33c710@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cfa02bbb-cdaf-4310-ac40-a2837d33c710@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 9/24/23 07:16, Mikulas Patocka wrote:
> Qemu mips userspace emulation crashes with "qemu: unhandled CPU exception
> 0x15 - aborting" when one of the integer arithmetic instructions detects
> an overflow.
> 
> This patch fixes it so that it delivers SIGFPE with FPE_INTOVF instead.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> Cc: qemu-stable@nongnu.org
> 
> ---
>   linux-user/mips/cpu_loop.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: qemu/linux-user/mips/cpu_loop.c
> ===================================================================
> --- qemu.orig/linux-user/mips/cpu_loop.c
> +++ qemu/linux-user/mips/cpu_loop.c
> @@ -180,7 +180,9 @@ done_syscall:
>               }
>               force_sig_fault(TARGET_SIGFPE, si_code, env->active_tc.PC);
>               break;
> -
> +	case EXCP_OVERFLOW:
> +            do_tr_or_bp(env, BRK_OVERFLOW, false);
> +            break;


Just call force_sig_fault directly.


r~

