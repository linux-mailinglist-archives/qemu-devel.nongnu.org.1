Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC0373723B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 19:02:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBej7-0005CV-E8; Tue, 20 Jun 2023 13:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBeit-00055S-4Z
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:00:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBeip-0008IW-JJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:00:52 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-988a076a7d3so381325566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687280450; x=1689872450;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G0gJSJZXw/Ys+S/m+xcfE7vmYvlXSMN4jkg1jVcWze4=;
 b=syAs6Cyk0x3SfFFszWczsYPkq2t4oyWcN7qSXhXkeQ+vUW+qW2Mzm09JPYSsanjLcU
 fq3tf3RHyJzEwCwvbxjp7pGhYrzDuIccNAzadX9CoYJ+IgVgLWDrsm8lFudo3SFumm3M
 T8iwXSUWsm+yeWESaSajGv4sio37Lq4LU9AQwsNiF4GMkb6KihtLhxUSHvUBpSYpdNBY
 MAddMXITqcx8exiWtr3JhnvVQdv7bnXl0IixlitkTgOT/CQt/r9fikwP/dCb/hQvJCmV
 /ETRgQxccTz3cjMPNmK9IB46Ua1dy4gw2ZP1eGmdObB+qCMB7ToeWqq+Mf7LSlaGIBBv
 W9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687280450; x=1689872450;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G0gJSJZXw/Ys+S/m+xcfE7vmYvlXSMN4jkg1jVcWze4=;
 b=aQocrpW66njc+OTgtnRR75vmpTqFBTo3gBz8I+Js+bC71QP8JIuGaCGJWNKo0jsg1W
 4x0QQbMppWAUCJj7mmpyzqMOTjUVO0cRx454D7WBjER0vcIdIgvMUqxuxp+o8MmME7i/
 NsFM11We9JntoNYVt81KeGXF29EKmf6xH+CHRUqyol5uzqNCrrPcmJsmULcw0F2vbhwp
 je9Vkz8cKopThXihAQji5bf5MN8L2ON4gz2m/6XKQbfuxTF81Aifcfjeg2uK1JeE9sHO
 eFLWeI+9jZOaGxSULoeI4dqiv2pAbnWcLvxNyUKRax9rYT3UegX71T3COHPAf1NLo9w5
 EBQw==
X-Gm-Message-State: AC+VfDwPMR8r0iyzPSt7XbcSMFaSn56oNjw3tpTtOjT98HzEOONHR6Iy
 sYrBfJKgKoJoFGPrb0Jr8nj0PQ==
X-Google-Smtp-Source: ACHHUZ7qoYzsa7Rcv1oeR22/Dn2wO8p79iZSqwYwuh/0iCtbDZ+ZJcVzS5mGqIu9OvpDXOzu2m+tUQ==
X-Received: by 2002:a17:907:3ea3:b0:987:3f34:88ea with SMTP id
 hs35-20020a1709073ea300b009873f3488eamr9579018ejc.58.1687280449848; 
 Tue, 20 Jun 2023 10:00:49 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a170906185900b009890f2c4cf9sm1733972eje.79.2023.06.20.10.00.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 10:00:49 -0700 (PDT)
Message-ID: <3d868e44-2b06-14e0-dcd2-39b0008a559d@linaro.org>
Date: Tue, 20 Jun 2023 19:00:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 6/20/23 18:56, Peter Maydell wrote:
> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
> failed: (cpu == current_cpu)
...
> The assertion in cpu-exec.c is interesting too and may or
> may not be relevant.

FWIW, the last time I saw this the stack had been clobbered and the saved value of "cpu" 
was garbage.  There is very very little in cpu_exec_setjmp() by design.


r~

