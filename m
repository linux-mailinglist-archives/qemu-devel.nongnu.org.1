Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD0744539
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 01:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFNVG-0005B0-E5; Fri, 30 Jun 2023 19:26:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNVA-0005Af-Hy
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:26:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qFNV8-0001AA-QF
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 19:26:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso7681005e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688167565; x=1690759565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdHFZE/CXcMkr6apj0lAlsDhQ8YE6hltzNuit+A0EtY=;
 b=ETtpuOsM3BPmkEOwzt56JJpH9n6hHoK/Fgsb46U6lEy6uMk5S9f/c8H1i9S3qgaj9A
 Azqqaw1mTF7387dVBTeAXdpgmyVHJ+DknXwMIzq76DFu52f1/nLTlS2B0RzT+4ceC+WS
 QAJPIPwuVwLKK6Mg0L85VIRqcnmmCPWYpcZPMyzw02Cb49ScZN7+8uoaMge5LvfTw+t0
 ykyFJAzqWvLP2TxcYjMRjPXUVV8gkLzBMqNEdW3+KYw4QiyepJFb+AVR0aJNC/mlAQR5
 EGlbzXL+kxsnBxlQ1o1IRW5hN7p7uKoa6LT76M85EaAS5HBvgwynwa1ypjvvK+v76i5E
 WIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688167565; x=1690759565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdHFZE/CXcMkr6apj0lAlsDhQ8YE6hltzNuit+A0EtY=;
 b=QATsDEpsB4hx9IszGvFYBs+9jcPBWDYXYpIS511eD/uFPgUADOsfDMo03W/Y9x5zXb
 6JRrBhwgwzkby6tRxxbug51C1iMZJ5Mco6fKDdnHoUfmP3p10aMiLS8U4pf5BoBxhvMH
 6l0secTKqPSyXiwrzFaRLQn2waMEAczeK/rNUYr90yVZkdzhV8xSUod7gGui7HPxRM0g
 /527rYDZpZNbftGWHygO9NrBoSykhW8IJ7KLvpFKEy8y3YkYrD+BzGJCrhXxJ1qTRyjn
 aDA0Da+5Nf/oZiJu2cSIrcy0itdoFYpuTJ4lvaBkyEPf7EobGKj65QOKQNZLF0LEYdXV
 mgNg==
X-Gm-Message-State: AC+VfDxwWaPFIvh1GKPMv6Ut3zf9KXGgTEcI3j5aXCgM1g1dy+99MFm+
 n3sDcYzzWVQcVpptFuasRA3shw==
X-Google-Smtp-Source: ACHHUZ4Cro1id0EDjQ6ceZ1Z/oPHoZwL8cl+CCGo9JrleMYWgeBK3zFCaKnNsrLhSFyyneGzv0nskA==
X-Received: by 2002:a1c:4c12:0:b0:3fb:b1af:a455 with SMTP id
 z18-20020a1c4c12000000b003fbb1afa455mr3127618wmf.5.1688167565455; 
 Fri, 30 Jun 2023 16:26:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.211.104])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a7bc410000000b003fbc9b9699dsm1868352wmi.45.2023.06.30.16.26.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jun 2023 16:26:05 -0700 (PDT)
Message-ID: <2331ce4d-c629-ab94-e5af-fab8f58194b3@linaro.org>
Date: Sat, 1 Jul 2023 01:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20230630203720.528552-1-iii@linux.ibm.com>
 <20230630203720.528552-5-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230630203720.528552-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> tcg/ should not depend on accel/tcg/, but perf and debuginfo
> support provided by the latter are being used by tcg/tcg.c.
> 
> Since that's the only user, move both to tcg/.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/meson.build          | 2 --
>   accel/tcg/translate-all.c      | 2 +-
>   hw/core/loader.c               | 2 +-
>   linux-user/elfload.c           | 2 +-
>   linux-user/exit.c              | 2 +-
>   linux-user/main.c              | 2 +-
>   softmmu/vl.c                   | 2 +-
>   {accel/tcg => tcg}/debuginfo.c | 0
>   {accel/tcg => tcg}/debuginfo.h | 4 ++--
>   tcg/meson.build                | 3 +++
>   {accel/tcg => tcg}/perf.c      | 4 ++--
>   {accel/tcg => tcg}/perf.h      | 4 ++--
>   tcg/tcg.c                      | 2 +-
>   13 files changed, 16 insertions(+), 15 deletions(-)
>   rename {accel/tcg => tcg}/debuginfo.c (100%)
>   rename {accel/tcg => tcg}/debuginfo.h (96%)
>   rename {accel/tcg => tcg}/perf.c (98%)
>   rename {accel/tcg => tcg}/perf.h (95%)


> diff --git a/accel/tcg/perf.c b/tcg/perf.c
> similarity index 98%
> rename from accel/tcg/perf.c
> rename to tcg/perf.c
> index e2813e11806..4a08fd9d259 100644
> --- a/accel/tcg/perf.c
> +++ b/tcg/perf.c
> @@ -10,7 +10,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "elf.h"
> -#include "exec/exec-all.h"
> +#include "exec/translation-block.h"
>   #include "qemu/timer.h"
>   #include "tcg/tcg.h"
>   
> @@ -335,7 +335,7 @@ void perf_report_code(uint64_t guest_pc, TranslationBlock *tb,
>           /* FIXME: This replicates the restore_state_to_opc() logic. */
>           q[insn].address = gen_insn_data[insn * start_words + 0];
>           if (tb_cflags(tb) & CF_PCREL) {
> -            q[insn].address |= (guest_pc & TARGET_PAGE_MASK);
> +            q[insn].address |= (guest_pc & qemu_target_page_mask());
>           }
>           q[insn].flags = DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE : 0);
>       }

Could this hunk belong to patch #1?

