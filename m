Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C840B7E2D2A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:47:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r05Yf-00031k-G3; Mon, 06 Nov 2023 14:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r05Yc-00031Y-TG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:46:46 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r05Ya-0004SR-KH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 14:46:46 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53dd752685fso8190665a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 11:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699300002; x=1699904802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdOScHiulgNO/7mJVhA3UY17NCtJWhVmUCV+xu6ao4Y=;
 b=h+QtsrPY9Sway5ivzW8rBPZwoS2WGHtM12jTRjH9DX7HAUmqd1+QBK/XRwqP78VLIt
 06sR9iw8bG5TsT72LGUJMv3u2XX5+RkANACDsefJ71uFaMRAlKdZpeUF18VKe9DDnT/i
 RsUU9uMXtxvcMAWJQ0scCjzM3ZFP5sOXXlIyfKvZnhYH6wgPw3+Hw0vhpY8Xq4RMePSO
 2XURQKzYiGHm+jH4P74miCP8YZqwC/iz3wn6SeeXh/ADa5RzKsA/12cyHnKwBH+GkYCd
 x7GHmvhiumVTGByFcjrljIiSAfFWrZvqFOsZKS/YeWVAwnMi8KJTv0hMtCUbt39Or2q2
 xN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699300002; x=1699904802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdOScHiulgNO/7mJVhA3UY17NCtJWhVmUCV+xu6ao4Y=;
 b=IDFmW0dv4BZ+G/w2QzaFdeoF0LqaY6OEH+1Ce0cUKvgCuA3WKXqNLJ7c2hAyQUsCUp
 tlPN2O5OB0KM7nGtrLGimzcizGfPC8pr8+X6MWXmKCmlLc/Pg6sANbVaSWcyfUcvmAaQ
 IP/cmluQbA4iJjpmcdX1XH1AIm96e3ntsxkjWxkeJJGG8avfxnlKdaUV3w1yJ6NRO12K
 zSABFmVKwKD/RfzX3klhkqlvdNfVrryABjSfJG5+cM0TU3AftvDjX/BMo4MFieo4kK/J
 syc92+yUzoatkUR6IUixjd0kKUlMXHW8xzGiNJdHs24wXQh2n63au91KFy6GXLYbk25C
 K7Wg==
X-Gm-Message-State: AOJu0YwUfKcVK5YtNfhP/ApC5b/z1yKdzvVQDi425UGxNeSMdVKWQvRw
 AF/8QhJoGIutaCJ6nkclUYcFLA==
X-Google-Smtp-Source: AGHT+IGWwxGYEGfCUNPcc+cgm+Aa/YMkbQ8o7sBBE36BxpxC9OQI/NKVd9nfxX2PRbzp2CdFyp5aow==
X-Received: by 2002:a50:871e:0:b0:543:ba69:c257 with SMTP id
 i30-20020a50871e000000b00543ba69c257mr12520186edb.19.1699300001733; 
 Mon, 06 Nov 2023 11:46:41 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 eo12-20020a056402530c00b00530a9488623sm4621524edb.46.2023.11.06.11.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 11:46:41 -0800 (PST)
Message-ID: <d2975549-fb73-ea2f-6a49-aa99d550d5ed@linaro.org>
Date: Mon, 6 Nov 2023 20:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 13/35] tcg/i386: Move tcg_cond_to_jcc[] into tcg_out_cmp
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Return the x86 condition codes to use after the compare.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 24 +++++++++++++-----------
>   1 file changed, 13 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


