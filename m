Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AE9728171
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 15:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Fmf-0006uf-U8; Thu, 08 Jun 2023 09:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7Fmd-0006qF-Hi
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:34:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q7FmZ-0006bo-6e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 09:34:35 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-307d20548adso451091f8f.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686231269; x=1688823269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=687bypAB/7t8xJBD4Gun81A0cQ2TsuTq5l2TZjpJ8W4=;
 b=JyL8ahp/TmFI57O6nHHpMl59k8c7vU7UVPH/Qy7y9yIA6/DF4Qw5SfGzQbee4gNCGL
 /oNZuYjutwB0Z/9RJwcsda9wLZtvAuiHmwAUuPuom4rhwL/ZMDtOpJ1GQerArwyv+Crh
 umBafa5nW4dkdqV0HDfLpMkUTtqeLn4MO8Rsy0RB9slTryXZ1Hb59sW1qR0/nQa3dwsp
 PzFZxTRBJTZthYNIW2ayW+SVrBE/RkAsg0SG5SYED7WyDHNGFkNPjHZe69zOxiP8N/0j
 2HpzvifovZZ+VswP8hS0ZbI5rh9O9drVcveS+EGTw6bWmH/FbqBLiDcqLJpKPoxQWU6H
 6veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686231269; x=1688823269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=687bypAB/7t8xJBD4Gun81A0cQ2TsuTq5l2TZjpJ8W4=;
 b=hi+a1bsG1iVQdAkRwCcebloJyQCJnUiwD6qiXKGfgyRx/Z67IiHGhucZjgBvzMY799
 kIdkqvl/EUGnLcuT4wqoTtpX2Sc3sdBIOeLvKXJIsT+4c4YicGi5Ar+d2hfUVkQRpqFg
 exq8i86pAju2sr7hSosyZiYrN86kEPBZfGItUJFsY18pSldyaRr1ThWe6pmLe2R9gAn2
 JM27gUmyFo/2apmYfquqJVpNd4W9lKTtLIMhig9UQPtFxaf3tw7ilFag4AHozkSpvFpX
 4MO09mxp4AezjxSv5VHhcpJkLzRxaj0m/Duh5Py6R5oTGf60Wsxd+8AFu/6BvbtpZ46g
 dbEA==
X-Gm-Message-State: AC+VfDwrS3r6eMAqm218B1aSEqK/43Qoyp+/ehiVyMiXwGCDNUDtagea
 qEM4F/7i/Sj6vlR4/E3VUXHemoHn6HISI74JcjY=
X-Google-Smtp-Source: ACHHUZ5V9drp1TuTJYOM7rOSgH3XynCQ5qqkI6pW8RAZcjDUFhYD0YUif/AZVhbSkHT4y3V6utEXLw==
X-Received: by 2002:a5d:534f:0:b0:30a:a478:f559 with SMTP id
 t15-20020a5d534f000000b0030aa478f559mr6643015wrv.2.1686231269190; 
 Thu, 08 Jun 2023 06:34:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.169.168])
 by smtp.gmail.com with ESMTPSA id
 t11-20020adfdc0b000000b0030ae3a6be5bsm1607171wri.78.2023.06.08.06.34.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jun 2023 06:34:28 -0700 (PDT)
Message-ID: <2c4676f2-4c35-9156-e60d-fd3f0b0ad2a2@linaro.org>
Date: Thu, 8 Jun 2023 15:34:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 5/5] target: Bulk rename 'helper.h' -> 'helper.h.inc'
 for all targets
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org
References: <20230608133108.72655-1-philmd@linaro.org>
 <20230608133108.72655-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230608133108.72655-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 8/6/23 15:31, Philippe Mathieu-Daudé wrote:
> Since commit 139c1837db ("meson: rename included C source files
> to .c.inc"), QEMU standard procedure for included C files is to
> use *.c.inc.
> 
> Besides, since commit 6a0057aa22 ("docs/devel: make a statement
> about includes") this is documented as the Coding Style:
> 
>    If you do use template header files they should be named with
>    the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>    being included for expansion.
> 
> Therefore rename the included 'helper.h' as 'helper.h.inc' for
> all targets (

Missing:

"moving the headers which are not in the 'tcg/' subdirectory there and"

> updating the documentation).
> 
> Unfortunately since the HELPER_H path definition is used by all
> targets, we have to do all changes in a single bulk commit.
> 
> Mechanical change doing:
> 
>    $ for t_a in target/*; do \
>        if test -f ${t_a}/helper.h; then \
>          mkdir -p ${t_a}/tcg; \
>          git mv ${t_a}/helper.h ${t_a}/tcg/helper.h.inc; \
>        fi; \
>      done
>    $ sed -i \
>      -e 's#define HELPER_H "helper.h"#define HELPER_H "tcg/helper.h.inc"#' \
>         $(git grep -l 'define HELPER_H')
> 
> then manually updating files in include/exec/ and docs/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/helper-gen.h                        | 2 +-
>   include/exec/helper-proto.h                      | 2 +-
>   target/alpha/{helper.h => tcg/helper.h.inc}      | 0
>   target/arm/{helper.h => tcg/helper.h.inc}        | 0
>   target/avr/{helper.h => tcg/helper.h.inc}        | 0
>   target/cris/{helper.h => tcg/helper.h.inc}       | 0
>   target/hexagon/{helper.h => tcg/helper.h.inc}    | 0
>   target/hppa/{helper.h => tcg/helper.h.inc}       | 0
>   target/i386/{helper.h => tcg/helper.h.inc}       | 0
>   target/loongarch/{helper.h => tcg/helper.h.inc}  | 0
>   target/m68k/{helper.h => tcg/helper.h.inc}       | 0
>   target/microblaze/{helper.h => tcg/helper.h.inc} | 0
>   target/mips/{helper.h => tcg/helper.h.inc}       | 0
>   target/nios2/{helper.h => tcg/helper.h.inc}      | 0
>   target/openrisc/{helper.h => tcg/helper.h.inc}   | 0
>   target/ppc/{helper.h => tcg/helper.h.inc}        | 0
>   target/riscv/{helper.h => tcg/helper.h.inc}      | 0
>   target/rx/{helper.h => tcg/helper.h.inc}         | 0
>   target/s390x/{helper.h => tcg/helper.h.inc}      | 0
>   target/sh4/{helper.h => tcg/helper.h.inc}        | 0
>   target/sparc/{helper.h => tcg/helper.h.inc}      | 0
>   target/tricore/{helper.h => tcg/helper.h.inc}    | 0
>   target/xtensa/{helper.h => tcg/helper.h.inc}     | 0
>   target/alpha/translate.c                         | 2 +-
>   target/arm/tcg/translate.c                       | 2 +-
>   target/avr/translate.c                           | 2 +-
>   target/cris/translate.c                          | 2 +-
>   target/hexagon/translate.c                       | 2 +-
>   target/hppa/translate.c                          | 2 +-
>   target/i386/tcg/translate.c                      | 2 +-
>   target/loongarch/translate.c                     | 2 +-
>   target/m68k/translate.c                          | 2 +-
>   target/microblaze/translate.c                    | 2 +-
>   target/mips/tcg/translate.c                      | 2 +-
>   target/nios2/translate.c                         | 2 +-
>   target/openrisc/translate.c                      | 2 +-
>   target/ppc/translate.c                           | 2 +-
>   target/riscv/translate.c                         | 2 +-
>   target/rx/translate.c                            | 2 +-
>   target/s390x/tcg/translate.c                     | 2 +-
>   target/sh4/translate.c                           | 2 +-
>   target/sparc/translate.c                         | 2 +-
>   target/tricore/translate.c                       | 2 +-
>   target/xtensa/translate.c                        | 2 +-
>   44 files changed, 23 insertions(+), 23 deletions(-)
>   rename target/alpha/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/arm/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/avr/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/cris/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/hexagon/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/hppa/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/i386/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/loongarch/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/m68k/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/microblaze/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/mips/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/nios2/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/openrisc/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/ppc/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/riscv/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/rx/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/s390x/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/sh4/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/sparc/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/tricore/{helper.h => tcg/helper.h.inc} (100%)
>   rename target/xtensa/{helper.h => tcg/helper.h.inc} (100%)



