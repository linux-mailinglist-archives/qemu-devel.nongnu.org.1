Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 331D8720E06
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 08:02:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5KKz-00085C-VD; Sat, 03 Jun 2023 02:02:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KKy-00084u-6o
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:02:04 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5KKw-0001zT-MV
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 02:02:03 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-3f8008cb772so26387431cf.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685772121; x=1688364121;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=41UMxF+TJoQxJEqn7N3JrXAFDVLQsj1C/nICBtpCnTg=;
 b=ECe/47jA/aqnSDVlHmZXLz6jT/RWOQUjeMXggFd/pk8ZBe1wNVqvsY/Hntxw2nEB55
 My9i00nXCEEtfZSIdvTkl4UuC/evJtpfUYbysFFclCqsCIeDZMPM0Bxovv6WzxABxgve
 uEx3T4+FFar8jZGioC+n6EWldC+3JzHtIFQf3FYJs/RYC9uVn2YRGU/5Mlv7j2CCTZsA
 JPLKVeg7LXnoxQxXMSs4BRfkyoDaudllfe/4mMdB97iOruOfUKnppeNF4teCTKOfH48k
 gYcuWapsGklgnwY5PscOIJUGq6/BBRB6bW8LIzC8kLWPVBa4p3efFE6DKt3o/9HCV9za
 LdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685772121; x=1688364121;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=41UMxF+TJoQxJEqn7N3JrXAFDVLQsj1C/nICBtpCnTg=;
 b=SlYONrIhGOFy7Qk6IGOLZz5InXdlEBNdsfZvnbZ75OSvnaT43quL1oOgY4OddAJLGg
 w2br3y8i5rvbvqhZITwSzFlLygZaGYCp6ziY5Un8c4an7Jdh6/z5HuFkknZYFm2bfjrv
 dJ1WYEvVNp2piGHxDnGQwQYkp51BjFXvUvn6dVKEvI8e/v/YrRpH2Uy1YVcTuoxIZ74B
 cs4JWzXcBDWwmeB1iZcHEksk1veskQ3vXejJxyETBkUOP3W4yvZ1C1dTYMqVmDEt1ofv
 biZjWA99Pt7itB5iCPf0USnhq71+y96GBXyoKFHnOQKTyMVvbxTEN/ORCY4qfWVlO5Fb
 qffA==
X-Gm-Message-State: AC+VfDwjSgaYBYMy67WmixJlO+MKc9JbZ5lCJ1qhY4I+/041hK+NnB7Q
 mF2nFla5ZgCs7LqBGG8idSZKqg==
X-Google-Smtp-Source: ACHHUZ6BO4vTod+QAzNFuKr/jTvAyRZcxuJLITSAaHQX6eZAbrizYCYdYoc7n0NLJpJwS83AsxNo4A==
X-Received: by 2002:a05:622a:164f:b0:3f7:fe24:d8a4 with SMTP id
 y15-20020a05622a164f00b003f7fe24d8a4mr737072qtj.33.1685772121462; 
 Fri, 02 Jun 2023 23:02:01 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e70-20020a636949000000b0053efb8fae02sm2162518pgc.24.2023.06.02.23.02.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 23:02:00 -0700 (PDT)
Message-ID: <3ed71d98-7c55-c282-0f67-10da44582a5e@linaro.org>
Date: Fri, 2 Jun 2023 23:01:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 05/20] target/arm: Convert MSR (immediate) to decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the MSR (immediate) insn to decodetree. Our implementation
> has basically no commonality between the different destinations,
> so we decode the destination register in a64.decode.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  13 ++
>   target/arm/tcg/translate-a64.c | 251 ++++++++++++++++-----------------
>   2 files changed, 136 insertions(+), 128 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

