Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2B8330B3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 23:12:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQx67-0008Bt-FP; Fri, 19 Jan 2024 17:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx65-0008BS-0E
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:12:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQx63-0006SG-8i
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 17:12:20 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-337d5480a6aso1001354f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 14:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705702337; x=1706307137; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P/Ch0DZilak71MvWIlwUwDWzPV255jzSG5zoN11o2z4=;
 b=jYNf+u1lYBfsRc0q4ejoGCTp098hD+8j8+27wXzvRCkS0JTUoi1ag4h2bZiQO4yn0o
 0n/YHaB84xrfCUwI2zSYGo788H+iMTyi1OUuhi4AdytypHm5U02jfNmXq71bc+VktyFf
 YQLpTyKJ14l0XmUvQfP5W44LLr1ktdTULqcyxVL1Bivt0fmZ/C7FMmjxmxtz+y0XWsbN
 EQ7kmn4qhhTy5BK8rbBsIhMLYxjYd/6Q6HEb43TwzZWJfZ4kI5c2EFNvz/u9k9L2167l
 aUxdEozbJVu7no2NQSSyd97jnrFLL6upiUofiZ4AY2UISiWt9Modc6+jRcOc4ZRchu+A
 6G0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705702337; x=1706307137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P/Ch0DZilak71MvWIlwUwDWzPV255jzSG5zoN11o2z4=;
 b=d8LrrL/JVKxp5wscGkWdNKIuw6JsJ8TmF1FeQvj1oeizEb+LnCeT75H1HfamuMccmK
 I8nprdRESnM890LMD8SDQ+6F08BoutxFTGHxm8OUQ6hTQD3FJ9/I46RSXog9TfYvMfay
 VLZIL1XAgCT6tLQHZR2FPcGB5MdSPBySqr7LfWTBGZoAdYzKFjj6CCTuxRqanNhjXio7
 ZE/yAw9WNk2XHq+XeNQlAey05zF/r4wCslQF50xjvYDyad6/70IqndQaENHRaDfI0ove
 uWi5LipyNkuUmcjmi/MgZOHHMxnqcJJSyx3dfuy6LMVPEAoQpf/okvjgPF7RyajsoOfE
 jWhA==
X-Gm-Message-State: AOJu0YzK2bRvGmI+PzA5keIn2XGw5ufX4t/dAT6sLjYPgNbhtGJxDm0f
 MoPS1QEQUaOq2nOnUZRLq05CWcOU4KD0r7TqDJxfirLZjo7JYrxYhSavR4NRiBFIhWv09W7XZKQ
 m
X-Google-Smtp-Source: AGHT+IFcf5Zuf/qbYV+kjENtrqgsg8qLw64Ut8UlgAbjAPjF//tYVN+NlRLsj9CX99jVMlLTN6IhWA==
X-Received: by 2002:a5d:58d6:0:b0:337:9afa:6d2f with SMTP id
 o22-20020a5d58d6000000b003379afa6d2fmr231382wrf.27.1705702337315; 
 Fri, 19 Jan 2024 14:12:17 -0800 (PST)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 a12-20020a5d508c000000b0033763a9ea2dsm7424084wrt.63.2024.01.19.14.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 14:12:17 -0800 (PST)
Message-ID: <81041168-2036-4908-ba0f-5203297ed799@linaro.org>
Date: Fri, 19 Jan 2024 23:12:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/38] tcg/ppc: Add TCG_CT_CONST_CMP
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20240110224408.10444-1-richard.henderson@linaro.org>
 <20240110224408.10444-34-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240110224408.10444-34-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/1/24 23:44, Richard Henderson wrote:
> Better constraint for tcg_out_cmp, based on the comparison.
> We can't yet remove the fallback to load constants into a
> scratch because of tcg_out_cmp2, but that path should not
> be as frequent.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target-con-set.h |  5 ++--
>   tcg/ppc/tcg-target-con-str.h |  1 +
>   tcg/ppc/tcg-target.c.inc     | 48 ++++++++++++++++++++++++++++++------
>   3 files changed, 44 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


