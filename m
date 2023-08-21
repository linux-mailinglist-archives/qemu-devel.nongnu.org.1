Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5253E78242B
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:12:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz4v-0004Md-Pq; Mon, 21 Aug 2023 03:11:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz4s-0004Ls-0O
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:11:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz4p-0008Br-So
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:11:53 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso28507735e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601910; x=1693206710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tvU7DzHy3ryY1mtn+3X5dyrJfqEC6bfLCNdeWMlNWHc=;
 b=M+wyDotqnFaWplHeE5FRJuUEeh5TNjjZm4TlrbOPmwSESiqEj9kVEJs0GFLQ2p4KDf
 uGN2+3Ojpw0l6S8NtFnDVfzUeo5dxeJXdjG3/cYuD/JXUk3PIRsHG3Gu8St14xjZu/v/
 ouKzhalR5+3BBPIu5MiebXSSF/R6WgwEv/4B1fw0gMyOt5NBJ/MXxWsRswU9Y6vSOTr6
 XrzpBjhYuXr9kHeZdutiugUuE3xIhNs/B/P7oCYHBazqcl/oIXHHwQLyEOkW3djC1uJX
 1vZbZF6Hb/oioshfBbPIryqiuNMDuOMrQelCL5gb1CKPwnbVKQWypTEH9GZ/Goq/oHDa
 7THA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601910; x=1693206710;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tvU7DzHy3ryY1mtn+3X5dyrJfqEC6bfLCNdeWMlNWHc=;
 b=lX5VWlR1/TxKL88WpnS1GT7yHGbZBwu7GYI5JfjXealsumjgeKyAkhPDJV5bE/5cs9
 YFEEt8wHCnIYEzsM26p49XRGgWqIufn0fX0NfcocURNrpv5x8pBE5jPHOaE+lY3HQsKf
 EnASAuTwAgCZkVaarPGmhl9V63XePl9i6ZDgNPnqM9WlOTlXJXqk730uLhU79EFwGou9
 9/Vsu2GleigkOU0SKtpcSv0oURzOjBL16Bl5NBpK26UbFhrC8kXjd0wdxtTaOH6jZgZh
 KLD1dGGcq2RJG7e4U9RRJMMbN9OrNUMz8W5qIt7QvOwaYjeyHKUUP6dbXDKkLLepqMKV
 aEHA==
X-Gm-Message-State: AOJu0YyRHnUOmCTmfEhK4C0vQEF3HjYc34PXi3u5X6W21zLsUdljb34z
 f4mf4i3jsLCUv0obEWPBiwf12bDG66laQQtc5SE=
X-Google-Smtp-Source: AGHT+IF5eeSoNRdMwM62fnTTXtsQKgT88MKGLZ8efLQqoFdm1OhO4mbJ5L7F2yx/2bIBSXe+Gd3n3w==
X-Received: by 2002:a05:600c:210c:b0:3fe:238e:b23b with SMTP id
 u12-20020a05600c210c00b003fe238eb23bmr4719942wml.36.1692601910400; 
 Mon, 21 Aug 2023 00:11:50 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 x5-20020a05600c21c500b003fef30b28b2sm1211736wmj.18.2023.08.21.00.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:11:50 -0700 (PDT)
Message-ID: <a053569e-e793-4845-4eb4-aa1e9208c46e@linaro.org>
Date: Mon, 21 Aug 2023 09:11:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 05/23] target/m68k: Use tcg_gen_negsetcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/8/23 00:13, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 24 ++++++++++--------------
>   1 file changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


