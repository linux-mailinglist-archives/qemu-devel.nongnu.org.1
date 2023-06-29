Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90531742502
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 13:32:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEpsV-0000Lu-Is; Thu, 29 Jun 2023 07:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpsT-0000K5-Jk
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:31:57 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEpsO-0001qb-SG
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 07:31:57 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f8775126d3so866964e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 04:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688038308; x=1690630308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eeo1udysV6TKzkozFk/jusIghIPeMulROTzmbHX3KuI=;
 b=gE68SRRp6188v4XVLaVygYTTol6yQur2dQU9+C0POieh4tRcoUOkHQsHZyJDThV03t
 /LiEtANP/UGmmVNyMMg6EpRmdFSGPke3yImQjbXsyp7KwdBUufVRAzEBpuSeDjNwVBc9
 TmyuIpIxAEn3COeHGo4rN6Ii811L0/G7FN5goOvvPn92wgNc9lCXD8pSnjpK/CKdvCUB
 BcQfhU10J0ORXC1N1pXQI9eNfAGRnKzkkoPOKiWwmsAJHHxXEs9/v0KJFNo0muMIoBBu
 HySa1U9koPukgWx+vM8TjLW9NwTc432ATgkWJC1QdmuRQT95xmIZFZmuNdII939fnqvm
 yYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688038308; x=1690630308;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Eeo1udysV6TKzkozFk/jusIghIPeMulROTzmbHX3KuI=;
 b=OhmRFfto/YFJ1Yf5Se8vuzee/rhkuJnLPuFSEYKApRYEamv5bihpcYPw+14WPpsx2+
 MGwrDd4TW4ac8O33YlDWI/9b9bggzhkUe8oyJ96JkAojOGVdKGTm37Bx67De/SFd63bb
 QKxA4SwRgTu8dmBFMYOFCMcj7mAV8Z/2PbZsd7EA7o9WkyHJ8pnXkDcgd2iGwGbvrUB6
 aBu+Nr7b4zf1inKAexll49tjKtZ3EPz14idFW0oxOXDVZrm105+HUQMMHoVR2v4xp1Ly
 YkJ5Sib1v6JubF5vuS5TJHobwVW1i5oPi80k6nzIr1S+XyhB8rOgRu3V+/vuJr4k9OLr
 oEcQ==
X-Gm-Message-State: AC+VfDwAd0R2qLDCdFo6ADZZnC34cvxr+iCVAm3uTdGAkQvz+OQmYMWy
 z2XOHMg4KzA/OERbKaiF0TQevQ==
X-Google-Smtp-Source: ACHHUZ72kY9RFqzNS+c32tCXZqg1mbisqwZajU4G7FMIu3UwBfeJLXZrXm/fvigqKxzNzSSWze9zHg==
X-Received: by 2002:a05:6512:2512:b0:4fb:52f1:9aab with SMTP id
 be18-20020a056512251200b004fb52f19aabmr10608995lfb.66.1688038308420; 
 Thu, 29 Jun 2023 04:31:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 k26-20020a7bc41a000000b003fbb1a9586esm4105739wmi.15.2023.06.29.04.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 04:31:47 -0700 (PDT)
Message-ID: <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
Date: Thu, 29 Jun 2023 13:31:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230116223637.3512814-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

Hi Richard, Alex,

On 16/1/23 23:36, Richard Henderson wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Add ability to dump /tmp/perf-<pid>.map and jit-<pid>.dump.
> The first one allows the perf tool to map samples to each individual
> translation block. The second one adds the ability to resolve symbol
> names, line numbers and inspect JITed code.
> 
> Example of use:
> 
>      perf record qemu-x86_64 -perfmap ./a.out
>      perf report
> 
> or
> 
>      perf record -k 1 qemu-x86_64 -jitdump ./a.out
>      DEBUGINFOD_URLS= perf inject -j -i perf.data -o perf.data.jitted
>      perf report -i perf.data.jitted
> 
> Co-developed-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
> Co-developed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Message-Id: <20230112152013.125680-4-iii@linux.ibm.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/devel/tcg.rst        |  23 +++
>   accel/tcg/perf.h          |  49 +++++
>   accel/tcg/perf.c          | 375 ++++++++++++++++++++++++++++++++++++++
>   accel/tcg/translate-all.c |   7 +
>   linux-user/exit.c         |   2 +
>   linux-user/main.c         |  15 ++
>   softmmu/vl.c              |  11 ++
>   tcg/tcg.c                 |   2 +
>   accel/tcg/meson.build     |   1 +
>   qemu-options.hx           |  20 ++
>   10 files changed, 505 insertions(+)
>   create mode 100644 accel/tcg/perf.h
>   create mode 100644 accel/tcg/perf.c


> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index da91779890..9b7df71e7a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -61,6 +61,7 @@
>   #include "exec/log.h"
>   #include "tcg/tcg-ldst.h"
>   #include "tcg-internal.h"
> +#include "accel/tcg/perf.h"

Is it OK to include an header from QEMU's accel/tcg/ here?
I thought we wanted to keep tcg/ kinda independant (or maybe
this is already too late and this isn't a concern anymore).

>   /* Forward declarations for functions declared in tcg-target.c.inc and
>      used here. */
> @@ -913,6 +914,7 @@ void tcg_prologue_init(TCGContext *s)
>   #endif
>   
>       prologue_size = tcg_current_code_size(s);
> +    perf_report_prologue(s->code_gen_ptr, prologue_size);


