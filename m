Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9807787F25
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 07:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZP3A-0008SA-6h; Fri, 25 Aug 2023 01:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZP38-0008S0-Q5
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 01:07:58 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZP36-0004RF-4x
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 01:07:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so811545a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 22:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692940074; x=1693544874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1pyyVHYYkiednLyqpEAXGnH5Lyuv62QgSvEwJ0x584=;
 b=bHzvqtjuZoNTGBak/L2tSl6SiDnHI3tD2AU8V88nmvrKruJ6ev+tBUdU0x0+tcM+Dn
 i/ujwFzAq3AXlxNJchGLpUXsBLmvjOmaCxOFprkMfnaL7n+XZkKaSs2WenDf5DuLWloc
 Jhf0T54MX7jGlTIh0kpZR1Kxj1sesPYvpREOh871CQHu6gO4JHpgFGrHtXDa7Zen2PuV
 G1dvKiFajfxgVmumw4Ljq4/uEQj4+IsHjx+K4yT7QVhddoXIsAHg/0ibRWIbHZp/7uHB
 A3iSA1fHkd+MOxGbwWibss4Vi57WwgWoB1oIZdKk3ViXGFpAOZbk0bAGBqsHXI4snzys
 qA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692940074; x=1693544874;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1pyyVHYYkiednLyqpEAXGnH5Lyuv62QgSvEwJ0x584=;
 b=IgSLgRAFuEKwEybDdKZfrnaQoVhxW0uH3T69maRJsQQRJCAyJB51UY+kzcT6G3GG+1
 zLYk5yNvU3s+tF3lI1iKkalGSyqh0HDu8B9MpBkvX2TEyeXiO9+vAFaVlLEnGKlWe3QK
 YnX69gDGJNv6wGN01c7ljdY2Py3+EIKyKrZlD9ueuUdpjE75WPPCdCtHGhwBPUewZe1d
 bYgyB0EYyTf79uy2e/BaXXJioGjT+0YFTLnLk187K1CiqdgfBL+em7PCKd81AtKhi+OO
 uX4LQWscWMj7BhblCY/ciW7Uydwt8hy4qaZllM8IaGSetfukSvCtrgQHsI0R1g4j6vyW
 o2rA==
X-Gm-Message-State: AOJu0YxFaHYzphXwP54a3WSNjJb5UzcAjdCHtgleiFeeHE/Olyaok1Eu
 uUnHD/8vcU8La+MK4vApIKMHMb/7tj9ZlEZwqjw=
X-Google-Smtp-Source: AGHT+IGO3Tho4MieFSg2RlbwTBpYyyDpcFu7zF5MaLYjTh++rzKNve6YFE+M6cdQFdEPMH2dvbciww==
X-Received: by 2002:aa7:d9d8:0:b0:525:734a:bf30 with SMTP id
 v24-20020aa7d9d8000000b00525734abf30mr15870520eds.36.1692940074117; 
 Thu, 24 Aug 2023 22:07:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 a15-20020aa7cf0f000000b0052a023e9b5dsm567952edy.47.2023.08.24.22.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 22:07:53 -0700 (PDT)
Message-ID: <848aaf42-6caa-71ee-3753-0d1bb3518b95@linaro.org>
Date: Fri, 25 Aug 2023 07:07:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2] linux-user: ppoll: eliminate large alloca
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230824175102.2999098-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824175102.2999098-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 19:51, Michael Tokarev wrote:
> do_ppoll() in linux-user/syscall.c uses alloca() to
> allocate an array of struct pullfds on the stack.
> The only upper boundary for number of entries for this
> array is so that whole thing fits in INT_MAX. But this
> is definitely too much for a stack allocation.  Use
> heap allocation instead.
> 
> This, together with previous patch for getgroups(),
> eliminates all large on-stack allocations from
> qemu-user/syscall.c. What's left are actually small
> ones.
> 
> While at it, also fix missing unlock_user() in two
> places, and consolidate target_to_host_timespec*()
> calls into time64?_timespec():_timespec64() construct.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
> v1: https://patchwork.ozlabs.org/project/qemu-devel/patch/20221216192220.2881898-1-mjt@msgid.tls.msk.ru/
> v2: remove alloca() optimization for smaller number of fds
> 
>   linux-user/syscall.c | 45 ++++++++++++++++++++------------------------
>   1 file changed, 20 insertions(+), 25 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9353268cc1..e79594bcd5 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1487,14 +1487,12 @@ static abi_long do_pselect6(abi_long arg1, abi_long arg2, abi_long arg3,
>   static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>                            abi_long arg4, abi_long arg5, bool ppoll, bool time64)
>   {
> -    struct target_pollfd *target_pfd;
> +    struct target_pollfd *target_pfd = NULL;
>       unsigned int nfds = arg2;
> -    struct pollfd *pfd;
> +    struct pollfd *pfd = NULL;
>       unsigned int i;
>       abi_long ret;
>   
> -    pfd = NULL;
> -    target_pfd = NULL;
>       if (nfds) {
>           if (nfds > (INT_MAX / sizeof(struct target_pollfd))) {
>               return -TARGET_EINVAL;
> @@ -1505,7 +1503,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>               return -TARGET_EFAULT;
>           }
>   
> -        pfd = alloca(sizeof(struct pollfd) * nfds);
> +        pfd = g_try_new(struct pollfd, nfds);
> +        if (!pfd) {
> +            ret = -TARGET_ENOMEM;
> +            goto out;
> +        }
>           for (i = 0; i < nfds; i++) {
>               pfd[i].fd = tswap32(target_pfd[i].fd);
>               pfd[i].events = tswap16(target_pfd[i].events);
> @@ -1516,16 +1518,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>           sigset_t *set = NULL;
>   
>           if (arg3) {
> -            if (time64) {
> -                if (target_to_host_timespec64(timeout_ts, arg3)) {
> -                    unlock_user(target_pfd, arg1, 0);

So this changes unlock(sz=0) ...

> -                    return -TARGET_EFAULT;
> -                }
> -            } else {
> -                if (target_to_host_timespec(timeout_ts, arg3)) {
> -                    unlock_user(target_pfd, arg1, 0);
> -                    return -TARGET_EFAULT;
> -                }
> +            if (time64
> +                ? target_to_host_timespec64(timeout_ts, arg3)
> +                : target_to_host_timespec(timeout_ts, arg3)) {
> +                ret = -TARGET_EFAULT;
> +                goto out;

... to unlock(sz=pollfd*nfds). Is that also part of your
"While at it" comment?

Having one patch for each logical change eases review /
cherry-pick / backport.

>               }
>           } else {
>               timeout_ts = NULL;
> @@ -1534,8 +1531,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>           if (arg4) {
>               ret = process_sigsuspend_mask(&set, arg4, arg5);
>               if (ret != 0) {
> -                unlock_user(target_pfd, arg1, 0);

(Ditto)

> -                return ret;
> +                goto out;
>               }
>           }
>   
> @@ -1546,14 +1542,11 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>               finish_sigsuspend_mask(ret);
>           }
>           if (!is_error(ret) && arg3) {
> -            if (time64) {
> -                if (host_to_target_timespec64(arg3, timeout_ts)) {
> -                    return -TARGET_EFAULT;
> -                }
> -            } else {
> -                if (host_to_target_timespec(arg3, timeout_ts)) {
> -                    return -TARGET_EFAULT;
> -                }
> +            if (time64
> +                ? host_to_target_timespec64(arg3, timeout_ts)
> +                : host_to_target_timespec(arg3, timeout_ts)) {
> +                ret = -TARGET_EFAULT;
> +                goto out;
>               }
>           }
>       } else {
> @@ -1576,6 +1569,8 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>               target_pfd[i].revents = tswap16(pfd[i].revents);
>           }
>       }
> +out:
> +    g_free(pfd);
>       unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
>       return ret;
>   }


