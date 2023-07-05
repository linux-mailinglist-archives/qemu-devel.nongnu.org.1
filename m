Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC964748669
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3Yf-0002Dm-1M; Wed, 05 Jul 2023 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3YQ-0002D8-J0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:32:28 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH3YO-0000Q5-8I
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 10:32:26 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b6f52e1c5cso29633181fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 07:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688567540; x=1691159540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TGMxSVxdyfaEo0E1iTSZEeZAouIT0GsXaETPIxDto8o=;
 b=qRZwdLAlG7BMWgptrI7EI5lJK6ijA0adJMYEOx7VrtSKzhxKPfIAvhjac0Mwrwvytf
 r1twTdpyvfusx77tc5NijvdiHVSHEmbauTtzU6PapQ2xU+6WBufFo8Z4DvuenlpxaNiH
 IbgVqYTaqco64dyceNAmeOtruqYxEOJn2b0k9rYGwTI6x6ncdL4E+/PFMdGFuIstMPdp
 q+qj0NRJPC6tQmPtVS4dOp68hvLgo4HeNdjvuFx4zuTfeoaSB49H3W14qQ2wLssPaX2c
 ztGo7dN7Ho33Jh45udPD81Zlv7kZTVeGmj30Pqlzx0qSwkdCqoIgfoTBbO8AqvkdoHA1
 mjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688567540; x=1691159540;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TGMxSVxdyfaEo0E1iTSZEeZAouIT0GsXaETPIxDto8o=;
 b=C61DzLRSvSGUeiKC+aKmWav4eIWHS2AmKJXZLIItcfKNN7Ls37Uofg7LVxrHj0Jzh/
 XjJ/MhJbWD2SIASPVCOPaurJo9Y72N3KPwKDAK8z6SR2fpgFWkiIF/zYM9CDXcg3M6eT
 88p1E7hATayHKHj8KkarjlHoymOGZsdNibx3JnOuwByn8/B0KDIdJfnce6GwTNQwgoqm
 krxY3fUp3kFw4p9rBZRTNGbb5NmnNVB35XO6u62MKlV9vvarRdAdYXz01F0qvS0cDua2
 4twfw0WG+U2mEewWfWPhgg6xVxV3132Ics6wkNqj0HFkCvq8VjoCePR6F00yI8CaLfkm
 k4rw==
X-Gm-Message-State: ABy/qLZ5xU7VAnm44WGDqGmwaBZ7qHKF1sZScl1UzoD7EdLH+kp1i+HV
 yBlY79AfzeyXcTRgrH2Kq8Wuow==
X-Google-Smtp-Source: APBJJlGPBhESFu3dln3nX4ZcSJThsm6UNbOoKH7AkAK0hUoFx29rU7Snbfy4H/5bKyhpR3+9WCbXUQ==
X-Received: by 2002:a2e:8605:0:b0:2b6:df71:cff1 with SMTP id
 a5-20020a2e8605000000b002b6df71cff1mr9619981lji.52.1688567540585; 
 Wed, 05 Jul 2023 07:32:20 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 f21-20020a2e9195000000b002b6cb40e9aasm3629995ljg.103.2023.07.05.07.32.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 07:32:20 -0700 (PDT)
Message-ID: <837e45df-08c9-44c9-b4c7-489251901860@linaro.org>
Date: Wed, 5 Jul 2023 16:32:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/arm: gdbstub: Guard M-profile code with CONFIG_TCG
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230628164821.16771-1-farosas@suse.de>
 <d8f954dc-8a69-7593-716c-e360d2c8e47b@linaro.org>
 <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9QSS7qs2kcCuyrDrRc6tb_0euMD3vFJ=_Q8s8dJYBRfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 7/4/23 17:44, Peter Maydell wrote:
>> IIUC tcg_enabled(), this guard shouldn't be necessary; if CONFIG_TCG
>> is not defined, tcg_enabled() evaluates to 0, and the compiler should
>> elide the whole block.
> 
> IME it's a bit optimistic to assume that the compiler will always
> do that, especially with no optimisation enabled.

There's plenty of other places that we do.
The compiler is usually pretty good with "if (0)".

My question is if

>       if (arm_feature(env, ARM_FEATURE_M) && tcg_enabled()) { 

needs to be written

     if (tcg_enabled()) {
         if (arm_feature(..., M) {
            ...
         }
     }


r~

