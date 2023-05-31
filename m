Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AEA717629
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4EO2-0001N7-5l; Wed, 31 May 2023 01:28:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ENF-0001AE-Sj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:27:54 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4ENE-00068x-Db
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:27:53 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so39584265e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685510871; x=1688102871;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NmpSaoDAIVb1aQbcn8Pal6xewS69G2DvhWNpGG4hnh0=;
 b=LV3PoTgZN+808izuMQsGxebP4omcWhWGYIOm5KcVbobndu684YtEx6yF3vzfP48w+N
 GxqT3n1XlaYEwLR3C+wMN8eIPUv7lEe/fHFY1IcD+qzjOvzvqqZJ9dyG9Nwz8FRWudUs
 YXGvL7Kqn4Zr0vSw7Nh7nUiLetDikG5OJDOfMH6d3t0u8FoIhqUHqJDCOwiVtwSvn0cm
 eZghvKuI7BjerV5sD3ylOcyoSHcesz6uc2K0/T9hlDgBFQ5kAxrc78uIYpTFip2uwH2E
 KXcQQZ1SdudIfmk0aYn+t9ADAutiRcOXSEpex+WhFUqC5LsaJJ9JD19m7AH4xfNbN1Dl
 IcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510871; x=1688102871;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NmpSaoDAIVb1aQbcn8Pal6xewS69G2DvhWNpGG4hnh0=;
 b=dooknRdyFSgnF+NaivHBsK1HlRifk97rOgUlUNzk4D6IUb355D8u+ZdK5pKNRlnmVh
 bsaBmA95UXQGnmI+BEMDXhmrWgpWFjA3WH805OiAJEJUoq7N5TGTq5ng9O9ggx4joGlU
 KOl1dnw8GC8yUuJH9fGTMc4NAHsBTp+sbAb7fpMEAv23p5aqEe0TP3CnXVkqLl2as2jl
 3SD0N5seUMZ2LzhQ7TI8DgbsZwWqxIzBYVaewVeY7zi6uOu0m2HxigjCPrw1XT4VFwAJ
 3TfjiDLbnMqTBpGDW4zDNqM7ot+64g96lXGpkuPgE2UXwZgtvcAL6mzTYWcpWv0MhahC
 XPUw==
X-Gm-Message-State: AC+VfDxaJc+pk1GFuFBgVxg6PfAde5fzk1y/rtTjxmYuK5aBNpm1vGTd
 EPsZ+mT94JSfpp2jNCPtRDk4pA==
X-Google-Smtp-Source: ACHHUZ73qMXBKyOxln0n10X5v080L/Hx9HZqaPtSelAK7b7qUOe/hmVmUK9jWWWhQw3zdiLWtabOIA==
X-Received: by 2002:adf:f54c:0:b0:2ff:f37:9d0f with SMTP id
 j12-20020adff54c000000b002ff0f379d0fmr3028076wrp.57.1685510870909; 
 Tue, 30 May 2023 22:27:50 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 b2-20020a5d4b82000000b0030aec5e020fsm5301251wrt.86.2023.05.30.22.27.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:27:50 -0700 (PDT)
Message-ID: <c10ff8ca-6bda-4d43-f545-4468d5d089c7@linaro.org>
Date: Wed, 31 May 2023 07:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 44/48] tcg: Remove target-specific headers from tcg.[ch]
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-45-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-45-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> This finally paves the way for tcg/ to be built once per mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg.h      | 1 -
>   accel/tcg/plugin-gen.c | 1 +
>   tcg/region.c           | 2 +-
>   tcg/tcg-op.c           | 2 +-
>   tcg/tcg.c              | 2 +-
>   5 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


