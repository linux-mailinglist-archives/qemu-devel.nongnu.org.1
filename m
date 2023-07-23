Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A967C75E3E2
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:41:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNc86-0007aJ-TF; Sun, 23 Jul 2023 12:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc7z-0007Xh-Fa
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:40:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc7w-0004rk-Ts
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:40:15 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbfa811667so27371115e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690130411; x=1690735211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=huBZQawe0XyowvUqqdU0giPuev4c9ToFYQnlJ+E/f8I=;
 b=u2FZbq6WtGOfBq92IpbHe9FgGAKZNy0jtXFLrlQyVwLxHk5mkVcMBWOr6hptjzdLJ9
 YKx/ixgS4Lw8G6pI5dYjZVom/Xa19neUmZ4eqaDL9P2klO0/f2gWbAUw06f0pxav6be9
 7jqlTqOSjZnxVjS9R35yqIvENAvJrZRmdNv+o9oYIQ2BuVfdiyNqaP3PsVNWdRaoGFJs
 5smKmskGvb/55G9Gw0hNsVltKPwiWLpTlodk5p+neuiPdeC9ISbnebY2/JVtH7G2cH9m
 MX0uV0docjGCZu6EyuVSazj9uGcdwmgQBqpAaMNwogq1mcvCEZwQ30j5gtV9LtugtCuV
 3eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690130411; x=1690735211;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=huBZQawe0XyowvUqqdU0giPuev4c9ToFYQnlJ+E/f8I=;
 b=d61jFGPdN/9DvLWyXaRItHvjP4kB2mYT1ciFFpe68xGWehcqB8FWWYv/a0pMWQz/bD
 Yk9VoYDnF6tOPftI7/Ctoo25BU7gizUrJ143XS5x2F/rQF6psuWntTlIb/LmxbIYvLYM
 3Tdw4w7DQ1b+ln7BZ8VOJLG97okaM8P9PxD81hqXO4uUS6cwmEXniiXK0teyie/xpOlD
 Q/WfIOi+Pa266ukwQEOaduMFi6Afv3BRNvf5KGcjqd/vqwreAS+00PTaKWmk/BgMZwot
 huYXyNw+kZge4Gho8hXFPYVTW/F5/Y+GEFCeMhw2ks8OEampNwgVdytcC7hJImridgKx
 9mzg==
X-Gm-Message-State: ABy/qLYPl5CPAMIihLSVAiRa/uc+Drm71JA+/KcTCib8M1jxtz4QhFTh
 iiIWTsvMxkUB6p76CBTz7iWFNA==
X-Google-Smtp-Source: APBJJlGRP2YJw6xeAK6kEKe/ISS6m83uVA5SGR15yC4KF2iJ7M1AdUiXGMnYGWj6ShQe6qwHj/s6tg==
X-Received: by 2002:a5d:4489:0:b0:313:f38d:555f with SMTP id
 j9-20020a5d4489000000b00313f38d555fmr5941459wrq.24.1690130410764; 
 Sun, 23 Jul 2023 09:40:10 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 h3-20020a5d4fc3000000b00314329f7d8asm10125609wrw.29.2023.07.23.09.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:40:10 -0700 (PDT)
Message-ID: <835f947a-8c33-d1dd-943d-9aeef7898615@linaro.org>
Date: Sun, 23 Jul 2023 17:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/14] target/s390x: Fix assertion failure in
 VFMIN/VFMAX with type 13
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-8-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> Type 13 is reserved, so using it should result in specification
> exception. Due to an off-by-1 error the code triggers an assertion at a
> later point in time instead.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: da4807527f3b ("s390x/tcg: Implement VECTOR FP (MAXIMUM|MINIMUM)")
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

