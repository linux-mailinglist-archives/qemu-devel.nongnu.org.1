Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314475619B
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 13:31:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLMRK-0005VK-9R; Mon, 17 Jul 2023 07:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMRJ-0005VB-7S
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:30:53 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLMRH-0006Qb-Dh
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 07:30:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-98df3dea907so577717166b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 04:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689593449; x=1692185449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q9O/dDVc/HjjUqqTDPkClS1vStBpCRbYfobKzhUiMdk=;
 b=Stu2kQqXVQLcZ5zdPwOecCUPJP5KmjYk0+GOyiHJ4oiqAqFnxygQy8w5b6opxLIIkn
 hWBybEMNIrDljXxF3Tt6oMcM+NXt6hqXhcCEm9waejOF7VRGkRbdZY2dVUWJaaaUPSsg
 6mrVAmEkL4CWFGwERGUjDKvuW0sjWnNWRNfqRK6WORtJtSgDGd8EJLIpTKRvspJqnUL7
 6jDwHhXmsJVii2JK2wHvEodUByXR1YZgsKEOz7ecjFJ+mYLJ0fHFrcZVxkGuaW2X/Rc1
 +WSUDZqhQEbWB6mds72Fh3+J1g7/XjuFxOzY/9PfmEGRFYfG+QT1N3l2giKiaCxIAkd8
 cdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689593449; x=1692185449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q9O/dDVc/HjjUqqTDPkClS1vStBpCRbYfobKzhUiMdk=;
 b=SxTs+J8n302N8J8ok6P71iyg9NaJ0TzPtEcLmGt6YYv/52f6tmrMnWxtxPhov3sbNw
 iEQzDoGStHgk/WZiAp57D65Z503Hm2pteeeoyWMNMgJ5g2YKoiwWoLF+QF/ASB33lCrr
 R3bvQtrpGx5AFP27TrRApfI+4t7n0HDlCmPFsP8jXf0gtgEef32KBChlO+XAaCGU5vjM
 W+pfl03kP3/bwZNQ2fa+gh3FwkC2M5oC+5MqxJ8xBaRrEOtLhRn6XZV2v/1fDqAy8Aib
 X3VA4/6LFrOJBgPzcqgZaHZmCrpD3rlk2R0D5br6sYqWtYLmdug/6mHuQ6RII59/ME/F
 X8yQ==
X-Gm-Message-State: ABy/qLYR7COqr7taXs6itpWl1IivVXBKRpXYDGJMROtAS5l3rJghkYVB
 4fp1iE1+uWYAjShdAtigvkhIGw==
X-Google-Smtp-Source: APBJJlHXFY3im/CfTYn1GBBp9aaFuAhAkSRQbGKlPmEV8JiFT1GPmKV7THjse9ipthji391w68kg5A==
X-Received: by 2002:a17:906:739e:b0:977:befe:d888 with SMTP id
 f30-20020a170906739e00b00977befed888mr11567590ejl.13.1689593449606; 
 Mon, 17 Jul 2023 04:30:49 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 lf16-20020a170907175000b00993928e4d1bsm9029251ejc.24.2023.07.17.04.30.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 04:30:49 -0700 (PDT)
Message-ID: <c7506bc9-0b59-bdaf-de3f-8bfe7d81c580@linaro.org>
Date: Mon, 17 Jul 2023 13:30:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/sparc: Handle FPRS correctly on big-endian hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230717103544.637453-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717103544.637453-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
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

On 17/7/23 12:35, Peter Maydell wrote:
> In CPUSparcState we define the fprs field as uint64_t.  However we
> then refer to it in translate.c via a TCGv_i32 which we set up with
> tcg_global_mem_new_ptr().  This means that on a big-endian host when
> the guest does something to writo te the FPRS register this value
> ends up in the wrong half of the uint64_t, and the QEMU C code that
> refers to env->fprs sees the wrong value.  The effect of this is that
> guest code that enables the FPU crashes with spurious FPU Disabled
> exceptions.  In particular, this is why
>   tests/avocado/machine_sparc64_sun4u.py:Sun4uMachine.test_sparc64_sun4u
> times out on an s390 host.
> 
> There are multiple ways we could fix this; since there are actually
> only three bits in the FPRS register and the code in translate.c
> would be a bit painful to convert to dealing with a TCGv_i64, change
> the type of the CPU state struct field to match what translate.c is
> expecting.
> 
> (None of the other fields referenced by the r32[] array in
> sparc_tcg_init() have the wrong type.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>   * drop unnecessary change to gdbstub.c
>   * put the vmstate fields the correct way around
> 
> NB: I believe the vmstate changes to be correct, but sparc64
> seems unable to successfully do a savevm/loadvm even before
> this change due to some other bug (the guest kernel panics
> immediately after the loadvm).
> ---
>   target/sparc/cpu.h     | 2 +-
>   target/sparc/cpu.c     | 4 ++--
>   target/sparc/machine.c | 3 ++-
>   target/sparc/monitor.c | 2 +-
>   4 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


