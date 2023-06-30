Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BED35744538
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:26:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNUr-00055r-MA; Fri, 30 Jun 2023 19:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNUo-00055j-Uh
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:25:46 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNUk-00014g-0U
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:25:43 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3141316b253so2805124f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688167540; x=1690759540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gm1EimRJOm9tGjEEwLh/4E+ujRhNov0AK6AZfqKF/a0=;
 b=nSFHWfVFIkeFVwXTHTV2kPmdtM47fWxWCeh9wpeXoGTPM0OdyjmvtSqIwAd/jqcuNX
 DV4mhzv5DsaQNCPTi1xxsuHPtVcBGhkhBPvtrXcN48zBLpQRXSyVvbQMDJ4wMerMxOb/
 uLtXyjsZXH0nAbrL6KnuweIjhhQ5cXE1/sbq7ut15hjSIHu/gjJLtpTfFagcqBuRZgs/
 Bzaqj4kg/0Gynv8NUTeqQ14iVy9mDuKzHaRwiRs/q+5unw3QmHFtZvUXTNwm7loozfQ0
 Ep92xEUQ6e2azhdlTj8zf+39rQtgFcKMn1obx4/8d0nuaacNtRMScyvV0P9fSN6QNlIm
 Ma1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688167540; x=1690759540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gm1EimRJOm9tGjEEwLh/4E+ujRhNov0AK6AZfqKF/a0=;
 b=J0v2pb9JvE+InDmj5zlplisKKPwGk8o7f50ZFzvovQGtuYUA0krtR3YLQahvbq1B51
 ogY1QasSBxtbIa3i6ZtmMzZEIeTvdgEzv6TjbtaUXy+uhGr9onjwQmtocBdy1bhmuecH
 B0/zKKGPNQsWbXtelL0GoOZN9yZCUSkO9HYI3e9uGA622k1DTi23rcsW0eY1huFoW8CP
 gNY+/e4jd0q4owkQIwD/LM2Z0rlh/D94seTK1yLmrxlHcANkJmoEzfxWVexA5BKxqR8G
 k5jtieSNACoYMFcqhz33AkjpdQYbJHvYYp02kGbmtaJgtPLKdX1HK79pGGXIJhW2geHe
 yWcw==
X-Gm-Message-State: ABy/qLbQNFfJ7Y6ybx264UBaGWRY+m3GNmyaUPpDxZ1WSRR9+uXnGAQa
 uyLzO2If/te607+iwo+k/MqxkQ==
X-Google-Smtp-Source: APBJJlF5CHdH0DPbCZPVQ9pPAQlxVG9QxCTDQEfj+qhUXk6waXN/amg3LAkgQRVqJgPuyxtocO3MjA==
X-Received: by 2002:a5d:51cb:0:b0:314:1494:fe28 with SMTP id
 n11-20020a5d51cb000000b003141494fe28mr2966494wrv.53.1688167540256; 
 Fri, 30 Jun 2023 16:25:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 r15-20020adfe68f000000b003111025ec67sm19328767wrm.25.2023.06.30.16.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 16:25:39 -0700 (PDT)
Message-ID: <53905ad3-471e-abff-7383-5f3182f7f040@linaro.org>
Date: Sat, 1 Jul 2023 01:25:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] target: Make qemu_softmmu_page_mask() available for
 *-user
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20230630203720.528552-1-iii@linux.ibm.com>
 <20230630203720.528552-2-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630203720.528552-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 30/6/23 22:36, Ilya Leoshkevich wrote:
> Currently qemu_softmmu_page_mask() is usable only from the softmmu

s/qemu_softmmu_page_mask/qemu_target_page_mask/?

> code. Make it possible to use it from the *-user code as wel.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   softmmu/physmem.c      | 5 -----
>   target/meson.build     | 2 ++
>   target/target-common.c | 9 +++++++++
>   3 files changed, 11 insertions(+), 5 deletions(-)
>   create mode 100644 target/target-common.c
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index bda475a719d..6bdd944fe88 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -3359,11 +3359,6 @@ size_t qemu_target_page_size(void)
>       return TARGET_PAGE_SIZE;
>   }
>   
> -int qemu_target_page_mask(void)
> -{
> -    return TARGET_PAGE_MASK;
> -}
> -
>   int qemu_target_page_bits(void)
>   {
>       return TARGET_PAGE_BITS;
> diff --git a/target/meson.build b/target/meson.build
> index a53a60486fc..dee2ac47e02 100644
> --- a/target/meson.build
> +++ b/target/meson.build
> @@ -19,3 +19,5 @@ subdir('sh4')
>   subdir('sparc')
>   subdir('tricore')
>   subdir('xtensa')
> +
> +specific_ss.add(files('target-common.c'))
> diff --git a/target/target-common.c b/target/target-common.c
> new file mode 100644
> index 00000000000..6868a1f490f
> --- /dev/null
> +++ b/target/target-common.c
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +
> +#include "exec/exec-all.h"
> +
> +int qemu_target_page_mask(void)
> +{
> +    return TARGET_PAGE_MASK;
> +}


