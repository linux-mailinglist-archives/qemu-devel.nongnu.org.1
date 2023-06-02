Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C9F71FE33
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51MM-0005BS-NI; Fri, 02 Jun 2023 05:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51MC-0005As-N2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:46:05 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q51M9-0002ma-DB
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:46:04 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2af2c35fb85so25421281fa.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685699157; x=1688291157;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eB+YoVqD6xgyohhfQOVelNqHefRmhxEg8yamGNpNP2E=;
 b=qiHVuCM1wLiGEkuRqPXK4udcSvH29jcRNXuUjAdoqY5qRyHedHL2eYhfddY7hSIrTc
 DeJnFUR1ljGXSctn021gsTQ6KAo5N75dlJpQCxBjPE92ewB/uVU41Rlac8KA6Tg9lmko
 7G385fUlH1fHEPOx43B08VUa+EsmEE33DEUQYK3KX+Y7qgVwZ+1cgu/2uspX6libfpvN
 VXMuQBfUtFQ144Oy3sUyV8of4L6p7pBLd4OI8yVsFGUv8sNaO/DxDbKYEe6laY+GMhC7
 irPyrDd+bDt5krx6T1DLIQLZ8yFz+BXdodjH6CEiX3mWf52VYA87s1jS4irzZ+EMVK5G
 vCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685699157; x=1688291157;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eB+YoVqD6xgyohhfQOVelNqHefRmhxEg8yamGNpNP2E=;
 b=Vvv1+OwekeKQoPdKzv74y2nI1RJvMZ3owU9vnSXoiUt/ny/jeQk+Kc9Xj4kBSh5KdJ
 fNBXrxiZhmB7GHV7CvhQpqXozzbxBm1z+INkJo+kEO5nUQDrQM4Ydhs2mD6BRRd8u5FX
 pJzvIGBs7rJOHsZImgRFMYT0Tp+Hdbgkyc0LIoQBmWPIFHaWC5oG0IYh0EbSobh1QcH9
 kT5iIoqYj0Zus9dxyJLHE6dqtgoib6u70Nk/SQmvcup8NiONn2S78FQQxQBqghfd+i0N
 75VbWPWd/mSeAoZeOpDLOOInn5gPdAypVD80slPUSQkPuUfKV9zGTQNYPnQD4DxGZYub
 6uBw==
X-Gm-Message-State: AC+VfDxnUzMc2Kq/DO93V8acn47+EUZ5rBKo5ar6AbOqI9JQFhIDnnmC
 0le/r3UqA0ztDMH5XAyiJVZZgeeCAc57GiBsNk8=
X-Google-Smtp-Source: ACHHUZ7ulDVBGFXG7Bp+A7fUTOnNQtAKFyKsGaWewJ/g5AaC4x4TivPTnEVXSOyir2sJl3gXD9xAaw==
X-Received: by 2002:a2e:87c7:0:b0:2ac:7ab1:a441 with SMTP id
 v7-20020a2e87c7000000b002ac7ab1a441mr1272962ljj.30.1685699157039; 
 Fri, 02 Jun 2023 02:45:57 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a1c7405000000b003f6f6a6e769sm1400196wmc.17.2023.06.02.02.45.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 02:45:56 -0700 (PDT)
Message-ID: <62bb0342-66f8-f01a-18c0-75dfe67aa240@linaro.org>
Date: Fri, 2 Jun 2023 11:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 35/48] accel/tcg: Introduce translator_io_start
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-36-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.1,
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

On 31/5/23 06:03, Richard Henderson wrote:
> New wrapper around gen_io_start which takes care of the USE_ICOUNT
> check, as well as marking the DisasContext to end the TB.
> Remove exec/gen-icount.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   MAINTAINERS                                   |  1 -
>   include/exec/gen-icount.h                     |  6 --
>   include/exec/translator.h                     | 10 +++
>   target/arm/cpregs.h                           |  4 +-
>   accel/tcg/translator.c                        | 27 ++++++-
>   target/alpha/translate.c                      | 15 +---
>   target/arm/tcg/translate-a64.c                | 23 +++---
>   target/arm/tcg/translate-mve.c                |  1 -
>   target/arm/tcg/translate-neon.c               |  1 -
>   target/arm/tcg/translate-vfp.c                |  4 +-
>   target/arm/tcg/translate.c                    | 20 ++---
>   target/avr/translate.c                        |  1 -
>   target/cris/translate.c                       |  2 -
>   target/hppa/translate.c                       |  5 +-
>   target/i386/tcg/translate.c                   | 52 +++----------
>   target/loongarch/translate.c                  |  2 -
>   target/m68k/translate.c                       |  2 -
>   target/microblaze/translate.c                 |  2 -
>   target/mips/tcg/translate.c                   | 29 +++----
>   target/nios2/translate.c                      |  1 -
>   target/openrisc/translate.c                   |  9 +--
>   target/ppc/translate.c                        | 13 +---
>   target/riscv/translate.c                      |  2 -
>   target/rx/translate.c                         |  2 -
>   target/s390x/tcg/translate.c                  |  6 +-
>   target/sh4/translate.c                        |  2 -
>   target/sparc/translate.c                      | 75 +++++--------------
>   target/tricore/translate.c                    |  2 -
>   target/xtensa/translate.c                     | 27 ++-----
>   target/loongarch/insn_trans/trans_extra.c.inc |  4 +-
>   .../insn_trans/trans_privileged.c.inc         |  4 +-
>   .../riscv/insn_trans/trans_privileged.c.inc   |  8 +-
>   target/riscv/insn_trans/trans_rvi.c.inc       | 24 ++----
>   33 files changed, 117 insertions(+), 269 deletions(-)
>   delete mode 100644 include/exec/gen-icount.h

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


