Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF5278CFEC
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7np-0001Yt-EW; Tue, 29 Aug 2023 19:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4jH-0001OS-6B
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:50:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb4jE-0005Wq-UQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:50:22 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68c0cb00fb3so3676962b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693338601; x=1693943401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=skV5eRUPGdEcmVwHgCUFVnUCOKD8i0tN3h+49Yf9P1E=;
 b=z2pl9bk5d5KalO5zyIlThmeqWPSjIkdvmZL9GTic8lQcyQh5EVxVgZlFED8dTlzVgN
 2tKwZu5oSpf5U1BIUoPVML1i9hItoBv3hYQ2us40lLhsjSpPjKhDu9gMLRsXf96WJMs6
 MZ2fSI/6kAw7jC1jtql7HNZXoWQ4ULtNvk8f8YVZLTJlIqCAGoZn5HxUwx11elIhRDCl
 a3HSec0MBPSXVxlWEnn1OZIE1DOfn7dzsukMKHeT7Ri7mK6KbgYBFsZWfKMzsDjX3rYJ
 UT2YIJqu3Jgefoe0htAFUbSfHPdcNBO5KSNB9V+9v0DfWRgivbJK82cu/deRJw5aTR0L
 6ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693338601; x=1693943401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=skV5eRUPGdEcmVwHgCUFVnUCOKD8i0tN3h+49Yf9P1E=;
 b=Ad/ij4O764g1WEN8HwlCZjBLFBZtbCCAg6WgpxrZHZFasFxXMyVsMCeOrEDkxw5Q8z
 rbZzEErXMxhX+EwCk5HlwWjPPwPPuamwJa5IGWKiyftzn7zVxQwKZjwgrNFJ4wZ/MlaR
 KfRn/t6PqtWpRZnyQzlv8UptUTB0U+YXOmjLm8y26YDEYqrvdwdEKyOtVKUlpKl9mg7Y
 CetuZU2wqONiA1OZ2KHT87tK+GxJtNFlbBzLlNG3qLKo7FGVf6H5MVqDCTp5CKIP/w2N
 QXhBrM/udMK/sDREczl3k1OVvgB1b5GgvEkz2A831BQqASh9Y/q4U4exVRJtRYJcLkyn
 Eisw==
X-Gm-Message-State: AOJu0Yy9Xs11+nMw7zKezCfVAF8OUHWDwyGY7nZB/CIClOfy7BOZQC0U
 es1mfGXEVJj/zcR987ed4FhpCQ==
X-Google-Smtp-Source: AGHT+IG4roARXn9CYZ9x6RY5GOPNRprg/DiFczAJiJbymg63HMSQcddFoMvOq8AD40x/0VbFoWpr3Q==
X-Received: by 2002:a05:6a21:4881:b0:140:3554:3f41 with SMTP id
 av1-20020a056a21488100b0014035543f41mr286865pzc.54.1693338600979; 
 Tue, 29 Aug 2023 12:50:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ij25-20020a170902ab5900b001bc5dc0cd75sm9851065plb.180.2023.08.29.12.49.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 12:50:00 -0700 (PDT)
Message-ID: <5578994f-591c-c687-6352-026fea8d9307@linaro.org>
Date: Tue, 29 Aug 2023 12:49:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/32] bsd-user: Get number of cpus.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-12-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230827155746.84781-12-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
> From: Kyle Evans <kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-proc.c | 39 +++++++++++++++++++++++++++++++++++++++
>   bsd-user/bsd-proc.h |  2 ++
>   2 files changed, 41 insertions(+)
> 
> diff --git a/bsd-user/bsd-proc.c b/bsd-user/bsd-proc.c
> index 49c0fb67d0..dd6bad6de3 100644
> --- a/bsd-user/bsd-proc.c
> +++ b/bsd-user/bsd-proc.c
> @@ -185,3 +185,42 @@ int host_to_target_waitstatus(int status)
>       return status;
>   }
>   
> +int bsd_get_ncpu(void)
> +{
> +    static int ncpu = -1;
> +
> +    if (ncpu != -1) {
> +        return ncpu;
> +    }
> +    if (ncpu == -1) {
> +        cpuset_t mask;
> +
> +        CPU_ZERO(&mask);
> +
> +        if (cpuset_getaffinity(CPU_LEVEL_WHICH, CPU_WHICH_TID, -1, sizeof(mask),
> +                               &mask) == 0) {
> +            ncpu = CPU_COUNT(&mask);
> +        }
> +    }
> +#ifdef _SC_NPROCESSORS_ONLN
> +    if (ncpu == -1)
> +        ncpu = sysconf(_SC_NPROCESSORS_ONLN);
> +#endif
> +#if defined(CTL_HW) && defined(HW_NCPU)
> +    if (ncpu == -1) {
> +        int mib[2] = {CTL_HW, HW_NCPU};
> +        size_t sz;
> +
> +        sz = sizeof(ncpu);
> +        if (sysctl(mib, 2, &ncpu, &sz, NULL, NULL) == -1) {
> +            ncpu = -1;
> +        }
> +    }
> +#endif
> +    if (ncpu == -1) {
> +        gemu_log("XXX Missing bsd_get_ncpu() implementation\n");
> +        ncpu = 1;
> +    }
> +    return ncpu;
> +}

This has the look of odd compatibility code.  Surely all three of these alternatives are 
functional, and that sysconf() is easiest to use.

Looking at the freebsd implementation of sysconf, it uses AT_NCPUS if available, so the 
value is already cached within the process in the common case.  So I also don't see a need 
for the ncpu local static either.


r~

