Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D24479B612
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:04:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqsD-0003sb-V9; Mon, 11 Sep 2023 20:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqsC-0003sS-Kv
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:03:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqs6-0002jJ-Kt
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:03:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-68fa5725649so1787060b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476993; x=1695081793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U6krX1hKPHgSBPX25TSIHVJG0nHU1QkYHHAFNH2+WoE=;
 b=u9mf6advP83qBzzWgOyy897uM1YDoKBP/S+FhdHhKsunXKrloftFLO+zSf8GU1uDRu
 H9/NQqWojldYGAUya9d1b87eEcndJGVxg3YFDIit+bey7zcOTHmJQy8HQt6g98MzbLSp
 Ap4D07R7bzJadDMuCZOdjH2IZIH9s/WjPB5LeFFQ8XwOOHQpO86EULIPHL0TYt4T3YMR
 nX0JFOmIrRUhkEbTETetq+CSXhYDBsj/sz4+NSPn48ZUnnCJ1KNlVBayA4uIbKTJl5UK
 DTtRVVVYN+vT1W1DssuwjLS7Ir4sAdLeMfap1eW9+E5r2nLVKNDCvg1gLDKbN6MH3DME
 RK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476993; x=1695081793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U6krX1hKPHgSBPX25TSIHVJG0nHU1QkYHHAFNH2+WoE=;
 b=u1/LHlmF9pEDx+htz5ZDi5hGql5SZ3pHbZOf+K3r04jFusHdq67DRR9mH1RyKORsFB
 aqDhoZzM9h8Ofa515u76EZJ2mGyg/TAutkXhw3SSMB8O1rcH6TzVBKnh1DuBmAh42lq3
 g+ojOvVR07pttmlVp7t//2+R8H9iVmMqMq0rGKi6lljMSHV8tR4lJCerAyF3d07ypHFb
 xa0yWbaWN/7glLEIKDNeTEUwtTwUB1FSWg538USMqbh0SgD6Nz6p3NG3Q6IWwdkjvgW0
 RFLjL9zkfW63AxImWY8fmLNFLnCNKJsYG+w3+9YzLYw3Ee4nuZ6qFSZf8EGtQZ7C/SjP
 ft5g==
X-Gm-Message-State: AOJu0YwIarMCEWgxmGM0rHBiK45dgGy3Cfv66STN3hERtkLnvbS+RFrc
 1zAm74q0NttiYeRE6UPA3DvJ7w==
X-Google-Smtp-Source: AGHT+IE9TEpWisRUv4vK5wO4OdEOazzv/LvVM599+uTWE3y4LfrDICsbH4VTUxEdBz3c8at/oBXHww==
X-Received: by 2002:a05:6a20:13d7:b0:14c:5fa6:e308 with SMTP id
 ho23-20020a056a2013d700b0014c5fa6e308mr9071968pzc.43.1694476992809; 
 Mon, 11 Sep 2023 17:03:12 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y26-20020aa7855a000000b006879493aca0sm2242320pfn.26.2023.09.11.17.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 17:03:12 -0700 (PDT)
Message-ID: <d019b498-d0ef-e006-a0c3-a2dfa29a5d35@linaro.org>
Date: Mon, 11 Sep 2023 17:03:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 17/23] bsd-user: Implement mincore(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-18-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-18-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 9/9/23 12:36, Karim Taha wrote:
> From: Stacey Son <sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 22 ++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  4 ++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
> index 0e16051418..1dabbe36e6 100644
> --- a/bsd-user/bsd-mem.h
> +++ b/bsd-user/bsd-mem.h
> @@ -189,4 +189,26 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
>       return get_errno(minherit(g2h_untagged(addr), len, inherit));
>   }
>   
> +/* mincore(2) */
> +static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
> +        abi_ulong target_vec)
> +{
> +    abi_long ret;
> +    void *p;
> +    abi_ulong vec_len = DIV_ROUND_UP(len,TARGET_PAGE_SIZE);
> +
> +    if (!guest_range_valid_untagged(target_addr,len) || !page_check_range(target_addr, len, PAGE_VALID)) {
> +        return -TARGET_EFAULT;
> +    }
> +
> +    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
> +    if (p == NULL) {
> +        return -TARGET_EFAULT;
> +    }
> +    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
> +    unlock_user(p, target_vec, 0);

You don't need the lock/unlock_user at all.  It is wrongly checking for WRITE.


r~

> +
> +    return ret;
> +}
> +
>   #endif /* BSD_USER_BSD_MEM_H */
> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
> index f5d60cf902..8d1cf3b35c 100644
> --- a/bsd-user/freebsd/os-syscall.c
> +++ b/bsd-user/freebsd/os-syscall.c
> @@ -527,6 +527,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>           ret = do_bsd_minherit(arg1, arg2, arg3);
>           break;
>   
> +    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
> +        ret = do_bsd_mincore(arg1, arg2, arg3);
> +        break;
> +
>   #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
>       case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
>           ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);


