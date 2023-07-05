Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B7747C38
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 06:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuaN-0002Ss-3L; Wed, 05 Jul 2023 00:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGua7-0002Qn-PF
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 00:57:35 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGua6-0004vU-0u
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 00:57:35 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fb77f21c63so9728377e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 21:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688533052; x=1691125052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIJpHYDojjaQypK18Z3zdJXmbcDbn8jVyw6STALXfqA=;
 b=hMvB7/ApwI3uUVT7TNKP7xvWkAHnhMk8f8nljg+txqpSctYwjXEzNrxB5Bu+Q1uZ2C
 bB6RsTzMxjWUQjngWP1NOJRNsbMwd7NpmtVSCiYk5Pd1lcVhxRo18xOOeTxqdgel3oI1
 DLABXHysIBwdMYzITPYsU4GkjHEo7Yb8naGFspMrqyWFo2uFfQiNAbS9Szr603vgrq2i
 EW4e2JBN41HilYdV1XrcEQcieU4OLFpszsd18mRsM+S0vcO2NyvJ8mbCSrdJn3KxlxWT
 ZDuIXT62ulbvRE01uRUn7FnagHbsPKk6x2wf53FCnvXAuZvEjH90O8A7XQ2hPa3VLSic
 YWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688533052; x=1691125052;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIJpHYDojjaQypK18Z3zdJXmbcDbn8jVyw6STALXfqA=;
 b=S26dEE4z7hqfsaU8EOp/NE/R2GXuAJZnupTqQub3IxZcgvt+GSg3JTPzKVG2/wRh2F
 8CC2ZysGYUb+jBYBBV1If0Bhyygr3UHCfRV1GdlRjP/Yn0DwB7Q7Q0GTeYeoXpnNJaCC
 zcEFwEmeJtxxyPMKPI/IkSS/WLgiHEhMWAjUAP8HkRmWclyU6SnJE4kFvRk1lBmeDbM8
 XtRtUVzoR+FF66KsYTU8GEYCMLu3gIi+xM3PvCQNP9mHV0Kq1oSk4aa11qScNeYIgi7R
 7iOPkikzU99jWT3oKUAGbAJUDf2zc+fhg4eauOgk4I8GLUfH9Pje0VIT7FdmuCS/wGap
 PBGA==
X-Gm-Message-State: ABy/qLabQybZzubTMqjig5CVQYKVF690+UN8S0XAENHTVbMEfJWyDuU5
 YAMQHPtIVxQkpM20PP4yfbZO7A==
X-Google-Smtp-Source: APBJJlFHKMRrQg6c365IBm7uVyvLyrec6u/rOP0dgJRNTkwRtHbC/7YhzlQNRh9LvZLaSVR0Ovo7Og==
X-Received: by 2002:a05:6512:328b:b0:4f8:7697:5207 with SMTP id
 p11-20020a056512328b00b004f876975207mr9963522lfe.23.1688533051762; 
 Tue, 04 Jul 2023 21:57:31 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 y4-20020a1c4b04000000b003fbe4cecc5fsm930160wma.34.2023.07.04.21.57.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 21:57:31 -0700 (PDT)
Message-ID: <29a83e80-32b5-cbb2-8dbd-13192e485e1e@linaro.org>
Date: Wed, 5 Jul 2023 06:57:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/11] target-arm queue
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704163634.3188465-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/4/23 18:36, Peter Maydell wrote:
>   docs/system/arm/sbsa.rst          |   5 +-
>   hw/arm/sbsa-ref.c                 |  23 +++--
>   hw/misc/allwinner-sramc.c         |   1 +
>   target/arm/cpu.c                  |  65 ++++++++-----
>   target/arm/gdbstub.c              |   4 +
>   target/arm/helper.c               |  70 +++++++++++---
>   target/arm/tcg/translate-sme.c    |  24 +++--
>   target/xtensa/exc_helper.c        |   3 +
>   tests/qtest/xlnx-canfd-test.c     |  33 +++----
>   tests/tcg/aarch64/icivau.c        | 189 ++++++++++++++++++++++++++++++++++++++
>   tests/tcg/aarch64/sme-outprod1.c  |  83 +++++++++++++++++
>   hw/arm/Kconfig                    |   2 +-
>   tests/tcg/aarch64/Makefile.target |  13 ++-
>   13 files changed, 436 insertions(+), 79 deletions(-)

There's one more failure:

https://gitlab.com/qemu-project/qemu/-/jobs/4592433432#L3723

> /tmp/ccASXpLo.s: Assembler messages:
> /tmp/ccASXpLo.s:782: Error: selected processor does not support system register name 'id_aa64zfr0_el1'
> /tmp/ccASXpLo.s:829: Error: selected processor does not support system register name 'id_aa64smfr0_el1'
> make[1]: *** [Makefile:119: sysregs] Error 1

I guess it's the change to Makefile.target, as I don't see any other likely candidates.


r~

