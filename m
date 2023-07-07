Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB78F74B7AF
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 22:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrp3-0002H9-SV; Fri, 07 Jul 2023 16:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrp1-0002FT-Q1
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:12:55 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrou-0005ze-Vj
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 16:12:55 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-313e09a5b19so3083541f8f.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 13:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688760765; x=1691352765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNKCZf49pb//jdl6pnd+4L6O+4LLaJjDsI33iJbiLZk=;
 b=Ld00U7J8Clc6X38cBf+Pga5Yw1wCDAJhIbMwGMdeczCts5q0mTsOGAYdubBQWT0rFL
 ksvULCqlC6s9ME2Bw8qLfyNH9zN/Sav5JdJj5wRdaRw7Ns16QVyhU9SzdOt2H8cdu4JM
 4q/e9Bx3ik1XclAzmXZaN7ojjOqPmKK4h02/xMThwvh6CEchhfZH4R4qnt4ntp+mOFmc
 DefykUyUrfLkm3d5buKZMH3/3ytyN06Yk0iogpnBMjQOJ1MdEEqHAUYqpWcSWJpCKGCk
 QIT06j3vSLBIflDsWk7d/GLsTtWxHMiM6Whd/d3w+n46DLM9xMosqNEqwukDc25QzFai
 +COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688760765; x=1691352765;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNKCZf49pb//jdl6pnd+4L6O+4LLaJjDsI33iJbiLZk=;
 b=LQAAJ6ed3A3Z2x4oHbUfj2Nv0FNhTB8gRBBIhF2yhDdKo4TvhlOgulQkqiTfrsGrFO
 h8k+WWx9jQb7MfsFyrydKqIh6tVOPVgwY73TewB9v22zGX8yK6JKw5EkoJnGQ1oy1bAp
 2AqokZwUhvCYAAvIkFiAhBXTQNgs4qC6U8OPRu3u/E6PcKf0ha65SB/uuCNqUQgI7KdK
 vJLhQF6zgMBkJxVhGv18ji7VuqSc7mpXet43h1mI595JEIgx7+X+wZPsYpFWUEn4LmKv
 64obZEvAYQq1SOMiJKkL3YsT3lrLyY/kPDSmFBShW+ciaakb+/PVFK5E8SAbcPEuZT/P
 f3Pw==
X-Gm-Message-State: ABy/qLZ6q6RM0YbIbAOGBCy9KnakfNU1blBF+o8F+VhulNkUHg5adoh4
 URqUJ40Qc030MbggJG1VfjHPaw==
X-Google-Smtp-Source: APBJJlE37WE8GI1xNs4RlkNC/kxnOYwP/TZ1NwkJUpWlT7N1TxryU16nLhAtMVjxXCfdM86dvTet4g==
X-Received: by 2002:adf:dfd1:0:b0:307:7959:6461 with SMTP id
 q17-20020adfdfd1000000b0030779596461mr6100571wrn.31.1688760764648; 
 Fri, 07 Jul 2023 13:12:44 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 d4-20020adffd84000000b00311d8c2561bsm5239357wrr.60.2023.07.07.13.12.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 13:12:44 -0700 (PDT)
Message-ID: <17272422-74ca-7c31-403c-dc13f2f2b1e0@linaro.org>
Date: Fri, 7 Jul 2023 21:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] linux-user: Fix fcntl64() to return O_LARGEFILE for
 32-bit targets
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-2-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707131928.89500-2-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
> On a 64-bit host, O_LARGEFILE has the value 0.
> When running a 32-bit guest on a 64-bit host, fcntl64(F_GETFL) should
> return with the O_LARGEFILE flag set, because the 64-bit host supports
> large files unconditionally.
> 
> The flag translation should have happened in do_fcntl(), but since O_LARGEFILE
> is zero for 64-bit hosts, the translation can't be done with the
> translation table.

But surely add the code to do_fcntl, right after the host_to_target_bitmask, so that it's 
present for fcntl64 as well?


r~

> 
> Fix it by setting the TARGET_O_LARGEFILE flag unconditionally for
> 32-bit guests on 64-bit hosts when fcntl64() is called.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>   linux-user/syscall.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 08162cc966..3f1e8e7ad9 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12328,6 +12328,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>           }
> 
>           switch(arg2) {
> +#if HOST_LONG_BITS == 64 && TARGET_LONG_BITS == 32 && \
> +    O_LARGEFILE == 0     && TARGET_O_LARGEFILE != 0
> +        case TARGET_F_GETFL:
> +            ret = do_fcntl(arg1, arg2, arg3);
> +            if (ret > 0) {
> +                ret |= TARGET_O_LARGEFILE;
> +            }
> +	    break;
> +#endif
>           case TARGET_F_GETLK64:
>               ret = copyfrom(&fl, arg3);
>               if (ret) {
> --
> 2.41.0
> 


