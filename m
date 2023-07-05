Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B6F748848
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:47:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4i7-00042y-Gb; Wed, 05 Jul 2023 11:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4i3-00042W-Re
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:46:28 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4i1-0002LA-UJ
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:46:27 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b702319893so8423451fa.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688571984; x=1691163984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/w9Ru4RcunP1ne5DT6w8zcU9K7QuAAFX/ncVwM8/AHU=;
 b=EPvPb3SHUsnFAFBFLQQXLMV03oiIIsTtPMUFWf4B0VHzLwsNSFFLkKAVZZFRttzJlh
 qWXDQZcTDvbwwxd0gVNUwSEpiYLoZQdqvqZJ/RkCkgFihyT3JHvqX9XHkYYc+X5ym168
 lMDQRtK2gfTSUJO/njW0yxMvQBVCVtRB7KBLjtSiWh+zfyzAKrT6eYIAs/G+LNIdhCJO
 22QW8nRvgVvy3xFOykerGbY/F1DvjBGNcDbtd3GuFlfT97Jjs//z6MzboW3ToTYHPKdr
 NTM1adRWxKuCD8ZQ4DWQWGmRUTgzAZscWnoHWLbP9Jw7G6pFmZltKKaJLGhYIEQ4Lqpr
 F/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688571984; x=1691163984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/w9Ru4RcunP1ne5DT6w8zcU9K7QuAAFX/ncVwM8/AHU=;
 b=Q0+xVwWoONevlLbo/J1QaIFwW2QO6TNfDzwjqPxFpHiQARfy1BXEnRwzL2+BCKrJp2
 O78J9sSU2kaKOEqEkBTGBIFvF32znAaYiqRWqXQoyyhlSZifsdEIDuiw84vQ3XZEhSJG
 yLTcGTRmmcZklBFYN98zUOJTa36cXvG+XliTq6j4CX7Vo030+48wNIpvj/rpo/RnIWbc
 bI5kfesyJt3VopXnCSp94s1BJpxDBluUpo8awjpESBvN7qwLM+XD4+6GUZ6Vt+cLOlkA
 Z/0BH/wBNzaVb2iFLgJHQplgUAfzIQTly3bbtR6NJl2Ch4G1jEkeOgrIX1MbqvJBUaGy
 /v+w==
X-Gm-Message-State: ABy/qLaQhTqzTsycYyQRALqct/5JnlbbsMo38lv4+CGaCZ/bh0+lIebr
 MxaQYouODJ6KWH6LrgrD8N1VgQ==
X-Google-Smtp-Source: APBJJlEwlGt+PifHxC09OmHw4QnzmyIrXc/j+aupvbp/9AL5l5cDdGkPItR0D05b0xlr93qCXQZ/Bg==
X-Received: by 2002:a2e:9590:0:b0:2b6:e296:bd68 with SMTP id
 w16-20020a2e9590000000b002b6e296bd68mr7637062ljh.35.1688571983890; 
 Wed, 05 Jul 2023 08:46:23 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a2eb712000000b002b6d68b520esm3245425ljo.65.2023.07.05.08.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:46:23 -0700 (PDT)
Message-ID: <4e5a77e3-17bc-f4bf-b0d3-476469b768c2@linaro.org>
Date: Wed, 5 Jul 2023 17:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, sir@cmpwn.com, philmd@linaro.org
References: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/5/23 14:10, Pierrick Bouvier wrote:
> Support for execveat syscall was implemented in 55bbe4 and is available
> since QEMU 8.0.0. It relies on host execveat, which is widely available
> on most of Linux kernels today.
> 
> However, this change breaks qemu-user self emulation, if "host" qemu
> version is less than 8.0.0. Indeed, it does not implement yet execveat.
> This strange use case happens with most of distribution today having
> binfmt support.
> 
> With a concrete failing example:
> $ qemu-x86_64-7.2 qemu-x86_64-8.0 /bin/bash -c /bin/ls
> /bin/bash: line 1: /bin/ls: Function not implemented
> -> not implemented means execve returned ENOSYS
> 
> qemu-user-static 7.2 and 8.0 can be conveniently grabbed from debian
> packages qemu-user-static* [1].
> 
> One usage of this is running wine-arm64 from linux-x64 (details [2]).
> This is by updating qemu embedded in docker image that we ran into this
> issue.
> 
> The solution to update host qemu is not always possible. Either it's
> complicated or ask you to recompile it, or simply is not accessible
> (GitLab CI, GitHub Actions). Thus, it could be worth to implement execve
> without relying on execveat, which is the goal of this patch.
> 
> This patch was tested with example presented in this commit message.
> 
> [1]http://ftp.us.debian.org/debian/pool/main/q/qemu/
> [1]https://www.linaro.org/blog/emulate-windows-on-arm/
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   linux-user/syscall.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 08162cc966..90777c5833 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -659,6 +659,7 @@ safe_syscall4(pid_t, wait4, pid_t, pid, int *, status, int, options, \
>   #endif
>   safe_syscall5(int, waitid, idtype_t, idtype, id_t, id, siginfo_t *, infop, \
>                 int, options, struct rusage *, rusage)
> +safe_syscall3(int, execve, const char *, filename, char **, argv, char **, envp)

I guess we'll quickly get a build-time error if there's no host execve syscall
(which looks to be, eventually, compat-only).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

