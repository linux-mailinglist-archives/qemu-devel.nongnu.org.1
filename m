Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FEE82C680
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:04:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOgT-00012d-Kb; Fri, 12 Jan 2024 16:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1rOOgR-00012U-40
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:03:19 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@rivosinc.com>)
 id 1rOOgO-00037w-KL
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:03:18 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-204235d0913so3976723fac.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705093391; x=1705698191;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to; bh=xrV2J4Lu+fGca7KaReWUtZJm5MebeqiOm72JnzeEw8Y=;
 b=i/OAr2n4zw5H5653y+sU6nsU5/QqG1v95QaGIKFIEgJI2Mf7Ua9/Ym6vgnQE/db1ay
 GbPWsQu3bNHYJ4zP0u+Dn1ejGSp+7F2jdhgnVeMWK8ZF66e9XCQY4NYE6tIGKuECB5WQ
 nNCWzeRaW5XHiEs1idRmSSuFXXc08udgZctz6l+lDLqpx4fln8FXjaJv5QmgtVukqs7e
 LdC8D022XISnP3cyQ3dwSGdJbNSX9mQQdmujb7w52TvBW9l8Ky5RVZbSuJbtbL+TQaoo
 XvKN5rDVNIJljCaKsPe5Jco7y5FcmnzN9PUunswtbomJcu19HSpoPRVlbi7H7XN2Q3WN
 FETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705093391; x=1705698191;
 h=content-transfer-encoding:mime-version:message-id:to:from:cc
 :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrV2J4Lu+fGca7KaReWUtZJm5MebeqiOm72JnzeEw8Y=;
 b=vurnmoBMWKqEv+rFBktCbU8phDHx5e3FpqzumA9HVjUrqYLqFuiBehMffodQ3Q0p+N
 o4qAxxcUKgfKC+X5xX5azfJ/iJmpVvuEYL2EI3wvImc5Uj2+nDNo9AlukNuB9b5KOXRO
 cyJoG2ZwkjxtCf1uk39BJB/TZnJmIXYGouWXxPDZ6GGA2gvPpRjkX3vhQqBAvHM4pNSM
 jIb+SFuB3YUzZ+hxT80ztlx0T+bQhNdjWkqNgbix8qPhQMliCUNM72KjqWYyZdfIOGvg
 S+czyBVsMiP9F8w6h/DXAhQjiGkeP8z9JDPaOHYK5v3uNVa+iIjrRR0MOxW+b7ZItmM/
 yM+g==
X-Gm-Message-State: AOJu0Yzx7bJbBzjjwiuN7WggPfE/fGbpPEbJiHI1yujnNOV9fLOktUuA
 Q5yzY3k8adZ1CjAdu2dKxGxoevypr+XiUMpl+cbBTM4cZg0=
X-Google-Smtp-Source: AGHT+IHMBRRjwwga6NIdc2bwWggGP8OBSptRqWiok3e65kdDDP/MY3YuwtENs6Qxx86RlQv6k3zBKg==
X-Received: by 2002:a05:6871:3144:b0:206:8886:ff28 with SMTP id
 lu4-20020a056871314400b002068886ff28mr2262481oac.97.1705093391229; 
 Fri, 12 Jan 2024 13:03:11 -0800 (PST)
Received: from localhost ([192.184.165.199]) by smtp.gmail.com with ESMTPSA id
 mw2-20020a056871d08200b0020652f4567csm1001526oac.33.2024.01.12.13.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:03:09 -0800 (PST)
Date: Fri, 12 Jan 2024 13:03:09 -0800 (PST)
X-Google-Original-Date: Fri, 12 Jan 2024 13:03:06 PST (-0800)
Subject: Re: [PATCH] linux-user: Fixed cpu restore with pc 0 on SIGBUS
In-Reply-To: <33f27425878fb529b9e39ef22c303f6e0d90525f.camel@rivosinc.com>
CC: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
From: Palmer Dabbelt <palmer@rivosinc.com>
To: rehn@rivosinc.com
Message-ID: <mhng-5bf9ebaf-017e-4d04-b287-ac40a32859b7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=palmer@rivosinc.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 12 Jan 2024 12:57:22 PST (-0800), rehn@rivosinc.com wrote:
> Commit f4e1168198 (linux-user: Split out host_sig{segv,bus}_handler)
> introduced a bug, when returning from host_sigbus_handler the PC is

So we should probably have a

Fixes: f4e1168198 ("linux-user: Split out host_sig{segv,bus}_handler")

> never set. Thus cpu_loop_exit_restore is called with a zero PC and
> we immediate get a SIGSEGV.
>
> Signed-off-by: Robbin Ehn <rehn@rivosinc.com>
> ---
>  linux-user/signal.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/signal.c b/linux-user/signal.c
> index b35d1e512f..c9527adfa3 100644
> --- a/linux-user/signal.c
> +++ b/linux-user/signal.c
> @@ -925,7 +925,7 @@ static void host_sigsegv_handler(CPUState *cpu, siginfo_t *info,
>      cpu_loop_exit_sigsegv(cpu, guest_addr, access_type, maperr, pc);
>  }
>  
> -static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
> +static uintptr_t host_sigbus_handler(CPUState *cpu, siginfo_t *info,
>                                  host_sigcontext *uc)
>  {
>      uintptr_t pc = host_signal_pc(uc);
> @@ -947,6 +947,7 @@ static void host_sigbus_handler(CPUState *cpu, siginfo_t *info,
>          sigprocmask(SIG_SETMASK, host_signal_mask(uc), NULL);
>          cpu_loop_exit_sigbus(cpu, guest_addr, access_type, pc);
>      }
> +    return pc;
>  }
>  
>  static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
> @@ -974,7 +975,7 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
>              host_sigsegv_handler(cpu, info, uc);

Do we have the same problem for SEGV?  They both used to set

    pc = host_signal_pc(uc);

but with this it's only SIGBUS.  Maybe the same for the others, so just 
something like

    diff --git a/linux-user/signal.c b/linux-user/signal.c
    index b35d1e512f..55840bdf31 100644
    --- a/linux-user/signal.c
    +++ b/linux-user/signal.c
    @@ -968,6 +968,8 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
          * SIGFPE, SIGTRAP are always host bugs.
          */
         if (info->si_code > 0) {
    +        pc = host_signal_pc(uc);
    +
             switch (host_sig) {
             case SIGSEGV:
                 /* Only returns on handle_sigsegv_accerr_write success. */

as it just does the PC chasing for everyone?

>              return;
>          case SIGBUS:
> -            host_sigbus_handler(cpu, info, uc);
> +            pc = host_sigbus_handler(cpu, info, uc);
>              sync_sig = true;
>              break;
>          case SIGILL:
> -- 
> 2.40.1

Either way,

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>

Thanks!

