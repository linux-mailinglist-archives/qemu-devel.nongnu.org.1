Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74D7676BF0E
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:13:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQwfz-0001Yi-IH; Tue, 01 Aug 2023 17:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwfx-0001YK-75
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:13:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQwfv-0006Oa-HX
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:13:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso56577555e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690924380; x=1691529180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Up9ny0NeBwyvDkJBV4rWgEf+8Gso+u5gq5kAv/Vn6nA=;
 b=h83m0ty0z9LNckc6dDfKHx1JDxHsZxFeo2Y+KSFLQxtB8tKWG+Jv8o4+3NVI0z7iwD
 Lpregm6d+5vPqh12Db/A2kcww3ptcGSktMhjGdcZ+LaSdU/l7uBn0WpNjSg/NOZHez0q
 9/E1pL8Mg3s+Mcim/6e0vTBeiKZRv9y3vVUmYj1JqCSj/WoOyuf99OFXj+31GhGjQiVr
 iggXh64QIbUouiVJexLSBdXi4eSVRiNu5Ie0uPya76uWmf1/G3OseLfPBCYLLQxxpi4N
 h2s6wq2q3yU7c85MFHry4ywkjxXyA6/36kUtftmXRRUmRk+JIVUiMeh2FVMIx3Ijqe6N
 GlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690924380; x=1691529180;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Up9ny0NeBwyvDkJBV4rWgEf+8Gso+u5gq5kAv/Vn6nA=;
 b=NFJN7E7cVREgMEuLJlcAbMwiAJ+o4A7655zeZTtqaweViDpMmMGTCqTJrXTsZCsG6X
 X+3zrKxWdlClsCN9a6ybmrKHVDDk17/+HQ8SUNKj3NJKYo52DaD6OTvxrkWVBvs90U7B
 jEuBW10gwau3fG9NiL+7VPkbO80K1jM1jLGN+yzn8lYYshT4qT4ijUt/Kr2Cxwx3KlP1
 6wr+0tqvZVXwt2efQyv4RHxIDQ/vMBNQ4mhSFZN+mlqfHnHpc/JJodXfc7LyRqsPiCXS
 mwQrvKMbXmKAPx2jLY+Hc8qaO0jbsYHZZ5s7oP35rz2clz81nFa6wH3kl0GMge/nSr6a
 22NQ==
X-Gm-Message-State: ABy/qLYETTByKwTzPx01UrI/f8u/v25v48UB2IINZ40X25/KJLf2ZIRR
 E26DxzR65ZOcL0Vk4bW9RLRHXg==
X-Google-Smtp-Source: APBJJlHQLOhTeIs+bQYSngxugGMKr1lOxtHAoRz1abe0tPgYL7wKdp2BGUgvAirhCOiIfBEJbgFvmw==
X-Received: by 2002:a05:6000:1371:b0:317:5e22:3ed4 with SMTP id
 q17-20020a056000137100b003175e223ed4mr3203235wrz.49.1690924380686; 
 Tue, 01 Aug 2023 14:13:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b003142439c7bcsm16967164wrw.80.2023.08.01.14.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:13:00 -0700 (PDT)
Message-ID: <1672bc32-8b3a-d543-1e51-56139430de70@linaro.org>
Date: Tue, 1 Aug 2023 23:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] accel/tcg: Issue wider aligned i/o in
 do_{ld,st}_mmio_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230801184220.75224-1-richard.henderson@linaro.org>
 <20230801184220.75224-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230801184220.75224-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 1/8/23 20:42, Richard Henderson wrote:
> If the address and size are aligned, send larger chunks
> to the memory subsystem.  This will be required to make
> more use of these helpers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 76 +++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 69 insertions(+), 7 deletions(-)

Super nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


