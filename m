Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E163377ECF2
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 00:15:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWOmC-0003mW-Gz; Wed, 16 Aug 2023 18:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWOm8-0003lp-Le
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:14:01 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWOm6-0002mT-9V
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:14:00 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bcc0adab4so910793366b.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 15:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692224036; x=1692828836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zEJhz2IPLHDaEP85ICczZLGFLyYPkVCbOGyIXuOX1Mo=;
 b=CmyroviCHiKVwgOQXNIQiig+CyMxbN3y6ENyJWAa0zJj+dqB0+AksS+vWL7IYDb3U1
 7rp+9VWhFhTiNQZzVEbqR0ZQ3FC2gvV2+oBlNGSWIJMStGfUb6X+hReaTs2t34uVdUL1
 Dl9JK+qQaWpZ5Jm/9FyYU4Q1Re9UTOWV+J2pC+qsiTGwtsqe0WEaqc5zdVPvlfzqNav+
 OB2uMmYcLHqlP/POHyM6yPR82feDpAeRu2Qoia/E/T3qodpok9jFPElRfPyuwQY75jw5
 2ggW46caEnj+R8XJiEecUi4epfueCqWhdkFPn4cOTWUsVpYzkzD7RNFBZzZxOtZsq6Af
 5FDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692224036; x=1692828836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEJhz2IPLHDaEP85ICczZLGFLyYPkVCbOGyIXuOX1Mo=;
 b=Y2ZbX1dTVSZNqCC3fIFOaZxrG+UcR/Lm6clDX6O5Ixps6sor9V9jaj9zKvIG3gIKr1
 zpuPDWtGN0oM0sufBVUTODTxitKLlZVUyhguZ3SUmLurpm0BjiafLbv2svlsckqp3hMp
 CMoqwafaxstEf17lJoijy6Oj9nHziMLauAJ2heS1Ti30eYfBjX0fkCDVGs1hslbbfNgM
 q4thq6v89h7TWatvXdXrdmFVfNZv9EAZubjMck6USc7ZORDrH3y3EwwjTuXCptRNFOJ+
 LvIIa1Y4midOmtwG9ysvYK0Ds71215+vcxQ9SdNWbDX9lAgpD8aYkFKP9xgsWr5dlmnf
 wCXQ==
X-Gm-Message-State: AOJu0YyzZKkpxYXWamYkklTvbD/GjLu1b4vHITvPvHyhKUnYMtoXjKGK
 RiKdyOWOMs8RZ8Wn1jOptPSPpA==
X-Google-Smtp-Source: AGHT+IG98L0LsfZXyZgkLBn0iItvl+UUKTwV4q9ywdz0jS9wZf/nB/iq0a1yBK3tWyW8XDMC4MA0YA==
X-Received: by 2002:a17:906:cc0d:b0:99d:7336:728c with SMTP id
 ml13-20020a170906cc0d00b0099d7336728cmr2317995ejb.35.1692224036443; 
 Wed, 16 Aug 2023 15:13:56 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 jw13-20020a17090776ad00b0099275c59bc9sm9115158ejc.33.2023.08.16.15.13.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 15:13:56 -0700 (PDT)
Message-ID: <167f8783-9592-6245-7e74-58a1cd9ac437@linaro.org>
Date: Thu, 17 Aug 2023 00:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 4/4] tcg: Map code_gen_buffer with PROT_BTI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Joelle van Dyne <j@getutm.app>
References: <20230816142516.469743-1-richard.henderson@linaro.org>
 <20230816142516.469743-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816142516.469743-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

(Cc'ing Joelle)

On 16/8/23 16:25, Richard Henderson wrote:
> For linux aarch64 host supporting BTI, map the buffer
> to require BTI instructions at branch landing pads.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 39 ++++++++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/tcg/region.c b/tcg/region.c
> index 2b28ed3556..58cb68c6c8 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -33,8 +33,19 @@
>   #include "tcg/tcg.h"
>   #include "exec/translation-block.h"
>   #include "tcg-internal.h"
> +#include "host/cpuinfo.h"
>   
>   
> +/*
> + * Local source-level compatibility with Unix.
> + * Used by tcg_region_init below.
> + */
> +#if defined(_WIN32)
> +#define PROT_READ   1
> +#define PROT_WRITE  2
> +#define PROT_EXEC   4
> +#endif
> +
>   struct tcg_region_tree {
>       QemuMutex lock;
>       QTree *tree;
> @@ -83,6 +94,16 @@ bool in_code_gen_buffer(const void *p)
>       return (size_t)(p - region.start_aligned) <= region.total_size;
>   }
>   
> +static int host_prot_read_exec(void)
> +{
> +#if defined(CONFIG_LINUX) && defined(HOST_AARCH64) && defined(PROT_BTI)
> +    if (cpuinfo & CPUINFO_BTI) {
> +        return PROT_READ | PROT_EXEC | PROT_BTI;
> +    }
> +#endif
> +    return PROT_READ | PROT_EXEC;
> +}
> +
>   #ifdef CONFIG_DEBUG_TCG
>   const void *tcg_splitwx_to_rx(void *rw)
>   {
> @@ -505,14 +526,6 @@ static int alloc_code_gen_buffer(size_t tb_size, int splitwx, Error **errp)
>       return PROT_READ | PROT_WRITE;
>   }
>   #elif defined(_WIN32)
> -/*
> - * Local source-level compatibility with Unix.
> - * Used by tcg_region_init below.
> - */
> -#define PROT_READ   1
> -#define PROT_WRITE  2
> -#define PROT_EXEC   4
> -
>   static int alloc_code_gen_buffer(size_t size, int splitwx, Error **errp)
>   {
>       void *buf;
> @@ -567,7 +580,7 @@ static int alloc_code_gen_buffer_splitwx_memfd(size_t size, Error **errp)
>           goto fail;
>       }
>   
> -    buf_rx = mmap(NULL, size, PROT_READ | PROT_EXEC, MAP_SHARED, fd, 0);
> +    buf_rx = mmap(NULL, size, host_prot_read_exec(), MAP_SHARED, fd, 0);
>       if (buf_rx == MAP_FAILED) {
>           goto fail_rx;
>       }
> @@ -642,7 +655,7 @@ static int alloc_code_gen_buffer_splitwx_vmremap(size_t size, Error **errp)
>           return -1;
>       }
>   
> -    if (mprotect((void *)buf_rx, size, PROT_READ | PROT_EXEC) != 0) {
> +    if (mprotect((void *)buf_rx, size, host_prot_read_exec()) != 0) {
>           error_setg_errno(errp, errno, "mprotect for jit splitwx");
>           munmap((void *)buf_rx, size);
>           munmap((void *)buf_rw, size);
> @@ -805,7 +818,7 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
>       need_prot = PROT_READ | PROT_WRITE;
>   #ifndef CONFIG_TCG_INTERPRETER
>       if (tcg_splitwx_diff == 0) {
> -        need_prot |= PROT_EXEC;
> +        need_prot |= host_prot_read_exec();
>       }
>   #endif
>       for (size_t i = 0, n = region.n; i < n; i++) {
> @@ -820,7 +833,11 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_cpus)
>               } else if (need_prot == (PROT_READ | PROT_WRITE)) {
>                   rc = qemu_mprotect_rw(start, end - start);
>               } else {
> +#ifdef CONFIG_POSIX
> +                rc = mprotect(start, end - start, need_prot);

Hmm this bypass the qemu_real_host_page_mask() checks in
qemu_mprotect__osdep(), but I guess this is acceptable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +#else
>                   g_assert_not_reached();
> +#endif
>               }
>               if (rc) {
>                   error_setg_errno(&error_fatal, errno,


