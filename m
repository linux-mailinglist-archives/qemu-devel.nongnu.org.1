Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FF1747C33
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 06:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGuWO-0008W8-MZ; Wed, 05 Jul 2023 00:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGuWM-0008Ut-Hi
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 00:53:42 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGuWK-0003Zq-LC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 00:53:42 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc0981755so70999515e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 21:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688532819; x=1691124819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=InwOupzyTvJNM77R71DO6mmVTF7jpkE1TYUD1GUfKdY=;
 b=gelIpRx35bf3F6/TScUHDITZc5EljP+tWTiZrRVPmiIvPmBbCVLo7d9XEUcgY1sC9x
 pn8bN06iOIC5+7G4WeQaqlk5twLSPnUvuncuwVB1rQ7zKLj3lYKr0T+5047+xnw5InIC
 V+rtsgPRflXLTse++bkBoZ21EG03HvTxLwi5pg+16oTQEfeai8nRolVQm0oaPHh1lEqW
 3/xO9by6GlBeM0o5Wqbmn7gd1B3w3PQGFOZwPq6pNrXN02YFBEUe8wpN6hkqUGVpxD8S
 gHbXGvLpSGlrBCAQZ/PHdJ+17ukS7/XsNxCJ+GadQCs3yJn93gAUP0ye7L2ujLQl9DSe
 zNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688532819; x=1691124819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=InwOupzyTvJNM77R71DO6mmVTF7jpkE1TYUD1GUfKdY=;
 b=c/yLvXaU3q/h6M1WjjraAMpDgdnPsXPAU3qGbkWetaF6ENlAxWai6d5tTTIc6P7xwx
 rJcEfcBGP8kdvwayZYvzxtKYCqDb7E3tx7zQuKVkgaRJfWfaLVbweqqorUEZkva/qBkL
 5HcaZqVRXz9vg8BhOhQQVwDClMjkzdjf2fRLfvJKr89uWDrz1pLJPQqjauaQQSdPeWO5
 I6UEFgp6R/GGkKtm0A9gqaVn7cBxQuIgmv33GoJyC1/jkniG9Jv4S8nXS1W6NOhKND7P
 zEHvvskWSCBtHSg7u4XmcPrnPQ/k3zAXxHUUW5nxjrUqKaG+xalvxL+GICz/2UqvqQvk
 T5rw==
X-Gm-Message-State: AC+VfDzWzZZ/QEr8vXbTVPfbL2054qn7uZmE6fi+fSf7U4cMOSIw0ros
 qPQbjYXj8YxhBT8vSx+h+Mo1uxTVWufOmNDTB3lNVQ==
X-Google-Smtp-Source: ACHHUZ5zhjNVTPslR8JcDzWOG9/UAWrRAx/Q1zhXQh6MHDwekE0xUldCPUj2yzp3aaUpsJ/FdCdPXA==
X-Received: by 2002:a05:600c:219a:b0:3fb:a1d9:ede8 with SMTP id
 e26-20020a05600c219a00b003fba1d9ede8mr12383680wme.10.1688532818081; 
 Tue, 04 Jul 2023 21:53:38 -0700 (PDT)
Received: from [192.168.1.25] (91.232.79.188.dynamic.jazztel.es.
 [188.79.232.91]) by smtp.gmail.com with ESMTPSA id
 c16-20020a7bc010000000b003fbe43238c6sm959238wmb.9.2023.07.04.21.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 21:53:37 -0700 (PDT)
Message-ID: <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
Date: Wed, 5 Jul 2023 06:53:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704163634.3188465-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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
> +int main(int argc, char **argv)
> +{
> +    const char *shm_name = "qemu-test-tcg-aarch64-icivau";
> +    int fd;
> +
> +    fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);

Build failures:

https://gitlab.com/qemu-project/qemu/-/jobs/4592433393#L3958
https://gitlab.com/qemu-project/qemu/-/jobs/4592433395#L4149
https://gitlab.com/qemu-project/qemu/-/jobs/4592433400#L3694


/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_open.o): 
in function `shm_open':
(.text+0x3c): undefined reference to `__shm_directory'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
(.text+0xcc): undefined reference to `pthread_setcancelstate'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
(.text+0xfc): undefined reference to `pthread_setcancelstate'
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/bin/ld: 
/usr/lib/gcc-cross/aarch64-linux-gnu/10/../../../../aarch64-linux-gnu/lib/../lib/librt.a(shm_unlink.o): 
in function `shm_unlink':
(.text+0x30): undefined reference to `__shm_directory'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:119: icivau] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [/builds/qemu-project/qemu/tests/Makefile.include:50: 
build-tcg-tests-aarch64-linux-user] Error 2

It looks like this test needs something else.



r~

