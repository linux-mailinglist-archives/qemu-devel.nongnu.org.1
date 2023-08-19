Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254B2781A4E
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 17:12:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXNbQ-0007mF-8M; Sat, 19 Aug 2023 11:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXNbO-0007m5-M1
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 11:10:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXNbM-0002FS-D0
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 11:10:58 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-565dc391be3so2090118a12.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692457854; x=1693062654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i+gJWykwhffMwRLHi9Ip4Bew4/cUCSbhOcc36UoyiL4=;
 b=dgg92zZbEQ+xMLBz7LOTFlm83FPjSLFFEwO8P20yF5FP3K3bFwJKejNumbrYShdKMS
 LaCOoTR3h8OfA2CLM8Z+jDNzZ8khFpW8mjppZqzSOMhr32OSsDT2duzpP5WYjEPsKmsh
 DwtUOLj5iEEsKnU2urx0dEu/geNu+WO69djfS62Q7NVpw4nsTsrswud0xEbYiCcNAbtP
 OsP3AsbqK5QZYFwjU9wM3OzenLK1y+/8+wG3j87ofwp2TvvEDr4yCoXCax3B6b11yWQp
 nvIy+BKjb5FyOj9zcext2M1bLxeJvbHoLcCr4X1gX2UEsWmPu+QPriP9hISornkheumO
 BV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692457854; x=1693062654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i+gJWykwhffMwRLHi9Ip4Bew4/cUCSbhOcc36UoyiL4=;
 b=K1w9sVrp3kn8si07yRaipGnMNjw5oQT6PSFWldGC/Dsw9aGoIu08YH4h8TLlS5rJIH
 n6VXjDmH2kO+8v/QRAw2aJfPQzazdM/xhT+twmN6eE3tu1mtCRPJuSoW+CSu9858XYwu
 TV4FF3AbV7qTUQi0QzxWxThQdJWyVkv4Ph/RHJJV5ePxqvUF4GsLGG11PuZjLCwwz615
 zC949Ay8HfXpDcHyUgINW3JgeL3pQ3wFuyK+ERD8OR9RCisBxDZO/qiQqR3t1iFCHDOW
 PsURwezYjIsHE+/j3F4PRZmJc43rpzDH8+Vugd/dJaEqsLQJvNkmJ2yx8O27g+pu6Lem
 ZL4A==
X-Gm-Message-State: AOJu0YwZA3GGtNEkXTvOKynlP1Za4/A3kn3VPc4EHVbameFBv9hUE68W
 unW4/fa8UoeBC95DPMYlVS8tmA==
X-Google-Smtp-Source: AGHT+IEKNrvJGNZAZmJepfdPgunvKjulvohJ2PWy7TcF6ZOdKlx3NjXaNLBo2fC875+j+SDfAzWPPg==
X-Received: by 2002:a17:90a:c08d:b0:267:f8f4:73ab with SMTP id
 o13-20020a17090ac08d00b00267f8f473abmr3256895pjs.16.1692457854106; 
 Sat, 19 Aug 2023 08:10:54 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:d058:ace4:c86a:5384?
 ([2602:47:d483:7301:d058:ace4:c86a:5384])
 by smtp.gmail.com with ESMTPSA id
 i12-20020a17090a2a0c00b00260a5ecd273sm3576308pjd.1.2023.08.19.08.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 08:10:53 -0700 (PDT)
Message-ID: <e631bda3-d722-66d2-2774-1af9823ab0eb@linaro.org>
Date: Sat, 19 Aug 2023 08:10:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 05/22] Implement shm_open2(2) system call
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-6-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-6-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 8/19/23 02:47, Karim Taha wrote:
> From: Kyle Evans <kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-misc.h    | 52 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 13 +++++++++
>   2 files changed, 65 insertions(+)
> 
> diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
> index 8436ccb2f7..993e4598f9 100644
> --- a/bsd-user/freebsd/os-misc.h
> +++ b/bsd-user/freebsd/os-misc.h
> @@ -24,5 +24,57 @@
>   #include <sys/random.h>
>   #include <sched.h>
>   
> +int shm_open2(const char *path, int flags, mode_t mode, int shmflags,
> +    const char *);
> +
> +#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
> +/* shm_open2(2) */
> +static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
> +    abi_long mode, abi_ulong shmflags, abi_ulong nameptr)
> +{
> +    int ret;
> +    void *uname, *upath;
> +
> +#ifdef SHM_ANON

Why would SHM_ANON not be defined?  You've already restricted the function to freebsd13+ 
(presumably so that shm_open2() is in libc.a).


> +#define SHM_PATH(p) (p) == SHM_ANON ? (p) : path(p)
> +    if (pathptr == (uintptr_t)SHM_ANON) {
> +        upath = SHM_ANON;
> +    } else
> +#else
> +#define SHM_PATH(p) path(p)
> +#endif
> +    {
> +        upath = lock_user_string(pathptr);
> +        if (upath == NULL) {
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +
> +    uname = NULL;
> +    if (nameptr != 0) {
> +        uname = lock_user_string(nameptr);
> +        if (uname == NULL) {
> +            unlock_user(upath, pathptr, 0);
> +            return -TARGET_EFAULT;
> +        }
> +    }
> +    ret = get_errno(shm_open2(SHM_PATH(upath),

There is no need for SHM_PATH because you've already handled the condition while setting 
upath above.



r~

