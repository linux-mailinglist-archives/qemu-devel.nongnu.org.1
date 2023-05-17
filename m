Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E970728E
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 21:52:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzNBe-0008SV-La; Wed, 17 May 2023 15:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNBb-0008S7-60
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:51:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzNBZ-00088x-F3
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:51:46 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64359d9c531so879709b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 12:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684353103; x=1686945103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yzUH8Amofmfhyh3Wcz52s6RgYf1r66fh6ErhQdgGoOs=;
 b=YQge4Xwoe0wnVVGpxN3VuhBPwFu6RhEBSMs4+wGdIf/dkaaHSTqe1Zmc8kiKE7TH6P
 6RIz7VkYg/kc7hMquXiJWkunr96PIiG1XIfKVNJgBCEOmiBsVuYBRhVhIB0J7jhN2Tki
 hKt7zLLQcwfocZo67+k2kLfPaS+gX0n9JBjnDOx+q3CKLoYrpbkGZc3Exccww/L251Re
 eKIwIU57od5MPkdLW4qVV7l1nit4juA8PBTpoI3vQqU4xrmNCeVq+P+1uwWg/TUXcLIW
 LW5zGYUsx9xQ8keFgdwwkgzuY2TJsSe+7iN4/1kjeiuR2KAyNp8z1npuOL9VJMIaDgAh
 WWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684353103; x=1686945103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yzUH8Amofmfhyh3Wcz52s6RgYf1r66fh6ErhQdgGoOs=;
 b=BWHVsWLVut5g0KjxrXgIcX6R+8cQJiLIUJF1NzYUksZlLpw1hQAXkmURc9UB3sOGgZ
 7yNAYTmFmolfW7tbiN3B34ULY1V8iBE5hee7RNpCMX/mArBq3g4QTG3PnHZkgVHqLAIm
 JI6DjWSsCnl4/oir6RFnQwlpT1GrUT2VcbpzZAAVs0sZhRbRjXwXQuYRt/nTJp5c94nU
 XpGCULanN2kvJyKqaPgrXWA7e12xZXKlnCzIPk2LvX01flEOWy5AMCnuq4gNdGOCq1YY
 Q3izBQpQgWRtM3WU+arsIZkGXJJGplkgSbuUk5tG1gYj99TND6XwpejPo2l8ckQqdpxC
 vE3Q==
X-Gm-Message-State: AC+VfDzt788nzk65kpfOwQhljfAM7UUGYPsFNhmzc08UOujeg7pu63le
 bwSXRDBIXYdinSwFPr9LSJ/W/w==
X-Google-Smtp-Source: ACHHUZ77glBH1Mn3QdHCFR6KJGLyfbcLwtC1ub9E2IzBGcFyOdZ03yy3JFcQHWGRlCG4IfqnGxLcLA==
X-Received: by 2002:a05:6a20:7f8b:b0:f0:c858:2d68 with SMTP id
 d11-20020a056a207f8b00b000f0c8582d68mr54223424pzj.35.1684353103289; 
 Wed, 17 May 2023 12:51:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 f23-20020aa782d7000000b0063d63d48215sm15654529pfn.3.2023.05.17.12.51.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 12:51:42 -0700 (PDT)
Message-ID: <6051fefc-a5b0-0c45-b1a9-ebdf2717caa7@linaro.org>
Date: Wed, 17 May 2023 12:51:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] target/arm: allow DC CVA[D]P in user mode emulation
Content-Language: en-US
To: Zhuojia Shen <chaosdefinition@hotmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Beata Michalska <beata.michalska@linaro.org>, qemu-arm@nongnu.org
References: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <DS7PR12MB6309A0F097FA4FB9D7CACB5BAC7E9@DS7PR12MB6309.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/17/23 10:31, Zhuojia Shen wrote:
> DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> user_cache_maint_handler() in arch/arm64/kernel/traps.c).
> 
> This patch enables execution of the two instructions in user mode
> emulation.
> 
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>
> ---
>   target/arm/helper.c               |  6 ++--
>   tests/tcg/aarch64/Makefile.target | 11 ++++++++
>   tests/tcg/aarch64/dcpodp-1.c      | 47 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/dcpodp-2.c      | 47 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/dcpop-1.c       | 47 +++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/dcpop-2.c       | 47 +++++++++++++++++++++++++++++++
>   6 files changed, 201 insertions(+), 4 deletions(-)
>   create mode 100644 tests/tcg/aarch64/dcpodp-1.c
>   create mode 100644 tests/tcg/aarch64/dcpodp-2.c
>   create mode 100644 tests/tcg/aarch64/dcpop-1.c
>   create mode 100644 tests/tcg/aarch64/dcpop-2.c

I recommend splitting the tests to a second patch.

  +++ b/tests/tcg/aarch64/dcpodp-1.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVADP instruction */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP2_DCPODP
> +#define HWCAP2_DCPODP (1 << 0)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_FAILURE);
> +}
> +
> +static int do_dc_cvadp(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +    if (sigaction(SIGSEGV, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }
> +
> +    asm volatile("dc cvadp, %0\n\t" :: "r"(&sa));
> +
> +    return EXIT_SUCCESS;
> +}

...

> diff --git a/tests/tcg/aarch64/dcpodp-2.c b/tests/tcg/aarch64/dcpodp-2.c
> new file mode 100644
> index 0000000000..3245d7883d
> --- /dev/null
> +++ b/tests/tcg/aarch64/dcpodp-2.c
> @@ -0,0 +1,47 @@
> +/* Test execution of DC CVADP instruction on unmapped address */
> +
> +#include <asm/hwcap.h>
> +#include <sys/auxv.h>
> +
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +#ifndef HWCAP2_DCPODP
> +#define HWCAP2_DCPODP (1 << 0)
> +#endif
> +
> +static void signal_handler(int sig)
> +{
> +    exit(EXIT_SUCCESS);
> +}
> +
> +static int do_dc_cvadp(void)
> +{
> +    struct sigaction sa = {
> +        .sa_handler = signal_handler,
> +    };
> +
> +    if (sigaction(SIGILL, &sa, NULL) < 0) {
> +        perror("sigaction");
> +        return EXIT_FAILURE;
> +    }

This isn't: if SIGILL, exit with success.

You don't actually need to register anything for SIGILL, in either test, because SIGILL is 
a fine exit for failure.  So is SIGSEGV for test 1.

Also, you could merge all 4 tests and save some CI time.


r~


