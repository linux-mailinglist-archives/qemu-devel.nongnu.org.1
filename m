Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E275E747C40
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 07:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuh3-0003eJ-BZ; Wed, 05 Jul 2023 01:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGugz-0003dl-5V
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:04:41 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGugw-0006KC-Pj
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 01:04:40 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so2289428f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 22:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688533477; x=1691125477;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xnnqxlEi1vy92wcECknKEznTucnJ7qT1JdK7AD3H3T4=;
 b=DIo0k+NyCHEt1CPXKR2zTRnJhK02ZqSKdflVd++wPV3aIkTT7dg6IqimxFxi+0bXoS
 X6rV/BwKR9jzcSX5CaHVh88eBL8DibTuyYTbFReuIkJXReIV6fX2hIywnCpH+s+FhBGd
 5CfTC9alMgaeY7xBgNH/bZ31MNPuVahX2SDsqQQj2S2jdb444ngrejuj1EFBlyuZ/mQC
 i2Ubf5DftHuoaNLP0Txy4OU1dj3AOD6+eUzPCG0Z4rBvCEuq4JyZd6CJGZBGh0VG15aU
 Fl96B4u5WnjmB5ZjBc24RqlUSpzNR1SVrXqDircvyqqDjor968NUedn06iD5RUfKO6UJ
 mtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688533477; x=1691125477;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xnnqxlEi1vy92wcECknKEznTucnJ7qT1JdK7AD3H3T4=;
 b=cXjHo8a5sxD8KlRZ+GoNHWN35Ews/SVqWZCEv8C1HK0nHEZZyaPdCcTBoKXM+Txs1j
 j/O5Z4udnGPlIFlLkBkHj4O6c/ALJnjC0VwbGnHwdtmgZuKPMsmFM+OiSmKjl+8dAFBx
 6MXu0lNE/WNlkaVLQgnl2/JWeUSU7b8NPqpeFbxdoj5UrJ5up5sbOsCFMZ5Ifh+1NDEx
 PDudLZ/i7+CV3Vnv3/wlue6i86iwvSI2/ubSzV6Kfq8D8R/Fpe8WWgc4ZbDPg2d9cKy6
 xci4OYf/pVIFsBf1LzHNvl9sPcF1DG/3kkd0t1smWKoipAJDQL9kcDkJNkNoNBNUBOZK
 jbDA==
X-Gm-Message-State: ABy/qLZWaPp5hr4jBCEMEYx8jtBvHiP6uVvDX1nSgarabRnDTNyiuoph
 pzXjMge875gDCZBGYqqjLD84tw==
X-Google-Smtp-Source: APBJJlG+HYjDYpCMVRjJWIH/JADDflswpwG/ZgXaHs0DzWiV3MjVT/SVTQgH3gHDkEG8mEfgpysPGg==
X-Received: by 2002:a05:6000:1cc3:b0:314:2faa:a23 with SMTP id
 bf3-20020a0560001cc300b003142faa0a23mr15770836wrb.43.1688533476913; 
 Tue, 04 Jul 2023 22:04:36 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 n17-20020a5d6611000000b003140fff4f75sm17488270wru.17.2023.07.04.22.04.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 22:04:36 -0700 (PDT)
Message-ID: <d73e2121-ee38-3245-8a3b-804931ea80a2@linaro.org>
Date: Wed, 5 Jul 2023 07:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/11] target-arm queue
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <29a83e80-32b5-cbb2-8dbd-13192e485e1e@linaro.org>
In-Reply-To: <29a83e80-32b5-cbb2-8dbd-13192e485e1e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

On 7/5/23 06:57, Richard Henderson wrote:
> On 7/4/23 18:36, Peter Maydell wrote:
>>   docs/system/arm/sbsa.rst          |   5 +-
>>   hw/arm/sbsa-ref.c                 |  23 +++--
>>   hw/misc/allwinner-sramc.c         |   1 +
>>   target/arm/cpu.c                  |  65 ++++++++-----
>>   target/arm/gdbstub.c              |   4 +
>>   target/arm/helper.c               |  70 +++++++++++---
>>   target/arm/tcg/translate-sme.c    |  24 +++--
>>   target/xtensa/exc_helper.c        |   3 +
>>   tests/qtest/xlnx-canfd-test.c     |  33 +++----
>>   tests/tcg/aarch64/icivau.c        | 189 ++++++++++++++++++++++++++++++++++++++
>>   tests/tcg/aarch64/sme-outprod1.c  |  83 +++++++++++++++++
>>   hw/arm/Kconfig                    |   2 +-
>>   tests/tcg/aarch64/Makefile.target |  13 ++-
>>   13 files changed, 436 insertions(+), 79 deletions(-)
> 
> There's one more failure:
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/4592433432#L3723
> 
>> /tmp/ccASXpLo.s: Assembler messages:
>> /tmp/ccASXpLo.s:782: Error: selected processor does not support system register name 
>> 'id_aa64zfr0_el1'
>> /tmp/ccASXpLo.s:829: Error: selected processor does not support system register name 
>> 'id_aa64smfr0_el1'
>> make[1]: *** [Makefile:119: sysregs] Error 1
> 
> I guess it's the change to Makefile.target, as I don't see any other likely candidates.

Ho hum, that's *my* patch 5, "Fix SME full tile indexing".
I'll have a closer look tomorrow.  Sorry about that.


r~


