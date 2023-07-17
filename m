Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D2E7566B2
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLPRA-0008DF-9R; Mon, 17 Jul 2023 10:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPR8-0008Cx-VF
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:42:54 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qLPR3-00005d-N6
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 10:42:54 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1b0138963ffso3597839fac.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689604968; x=1692196968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P4COEFsGIaIoIPOHaWYE9lWTx572QD8LdV7C2tRf5NU=;
 b=IV3pX9mcQ6ULsxbcpQA46jmBpvEt4cM82U4VrKaifdSF9l5j1li6U6HT0uRGqmS74/
 lgNYzmm3rL7M45bhu4iBR/iM0SWCwS4/rvj6ZTNhRpDUvLXNq0NpyhLsuwsEcUyp5zHN
 OI7haWVbIV5hWW+4jWG5Vu6j3T/KpC6Zsn+tLiplVCjcKVmllQrKy/0kYTKNm2VJgsLy
 AKDuAw/j+5fJfgXI7k6hi1czvxzPpOxkoBuDjZH8EEfmeJZ2/qnQCHjPy82hmjArsddA
 VrUFErAdsbFGDGXICyosACvNW6wtaRZDtJogxHrCKMD/IvOI0sGCvSzy/ceOOAmvr3hT
 yIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689604968; x=1692196968;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P4COEFsGIaIoIPOHaWYE9lWTx572QD8LdV7C2tRf5NU=;
 b=ELZHkChIezA4oqcIFHOgfZRIYFVRZq3LbHDMlI2g4isqFzBoEx+hEGGK6sXRR9rmtC
 yLhbD8QtI1GO/4EwWOS6nwW8LxH8YgFfYbn9mLNHWbGrt8nsd/gJ+fmXWFlEHmdf/M4g
 mEO8QHFoAYBR5i2PJ5IK0O12G1+AjfY7yoX36DJmvwXmfQqDxTt+A9qL1eeBl0vicE3/
 ozvAEiCMs26zSyKzwAxEk7RYDoKIuJYcP6Cjjrn1s3AAZ0db6X86YG1L7qw2dRuGtyzp
 pOQcNWDa2353WN8IfJrIe/3USKQ5MqK9DSmnHoJ5hgoJsDMGWaK5qKVw8Kls7jv1VaVC
 Iszw==
X-Gm-Message-State: ABy/qLYAzUKaARRXj61AEnXkIHYdeEFYBoLO/XEwbR99xUvfxzvxRW+l
 zh7Og3f6a3ZHgABfGrOC7r1LYg==
X-Google-Smtp-Source: APBJJlG7H6WyNIcWvJ/Ts+3eoL7UaV0x3bdfIQpmb0GqNEUbL6eBwsVjSNL/0+W/8JqR5VRBt6UZpA==
X-Received: by 2002:a05:6870:37cc:b0:1b0:60ff:b73f with SMTP id
 p12-20020a05687037cc00b001b060ffb73fmr14637909oai.8.1689604967812; 
 Mon, 17 Jul 2023 07:42:47 -0700 (PDT)
Received: from [192.168.224.227] ([172.58.109.253])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a9d64c6000000b006b95392cf09sm6587349otl.33.2023.07.17.07.42.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 07:42:47 -0700 (PDT)
Message-ID: <f60938c3-0426-a8e9-cc22-1c5018601eb1@linaro.org>
Date: Mon, 17 Jul 2023 15:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 45/47] linux-user/arm: Do not allocate a commpage at all
 for M-profile CPUs
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Christophe Lyon <christophe.lyon@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
 <20230715135317.7219-46-richard.henderson@linaro.org>
 <e9c0cbcc-854f-0ebc-8dcd-37abc21d53b6@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e9c0cbcc-854f-0ebc-8dcd-37abc21d53b6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.097,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/16/23 19:13, Michael Tokarev wrote:
> 15.07.2023 16:53, Richard Henderson wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Since commit fbd3c4cff6 ("linux-user/arm: Mark the commpage
>> executable") executing bare-metal (linked with rdimon.specs)
>> cortex-M code fails as:
>>
>>    $ qemu-arm -cpu cortex-m3 ~/hello.exe.m3
>>    qemu-arm: ../../accel/tcg/user-exec.c:492: page_set_flags: Assertion `last <= 
>> GUEST_ADDR_MAX' failed.
>>    Aborted (core dumped)
>>
>> Commit 4f5c67f8df ("linux-user/arm: Take more care allocating
>> commpage") already took care of not allocating a commpage for
>> M-profile CPUs, however it had to be reverted as commit 6cda41daa2.
>>
>> Re-introduce the M-profile fix from commit 4f5c67f8df.
>>
>> Fixes: fbd3c4cff6 ("linux-user/arm: Mark the commpage executable")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1755
> 
> This smells like a 8.0-stable material.  Please let me know if it is no.
> Thanks,

Seems reasonable.


r~


