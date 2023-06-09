Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4FA72A1FA
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:18:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ggZ-0001th-SA; Fri, 09 Jun 2023 14:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ggX-0001sx-Je
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:18:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7ggW-00021T-2w
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 14:18:05 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-651ffcc1d3dso1689850b3a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 11:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686334682; x=1688926682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G8wZ4asomBDhR0d4eGk9eBfi5gd7aSScwLvh7FyqeE8=;
 b=Y4X89W2ONUA9zTIYfie/wUIJ0NlIj9H+2kqMaQBzCqmTYf2mqlma0EQijvRW9VzwVQ
 Ml/rawvXzL+Ru0wxlqSTaVezgRvigb13rWWZnanfttLariQT1gK8ZbaZTOXgIVjWm6rB
 BtJE5XMO8BoIpkbF1LJg591pzaWcXxJEfr+S45wqKx2F4ROB4n8M8HO2CwCycfWzKqXc
 Uc48DYziG8tQGSxB6w6KH6iCJP6+PGToMx2YCGhglYYL+aIHHt6Zy57RJ1aGWLT0iBtP
 pNP47v5D7a6NjAjYh/3p6ru43bqcPeubEeVd49XAOcR0yTNPzZZyW3F1E1rsXkOfxKs+
 l7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686334682; x=1688926682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8wZ4asomBDhR0d4eGk9eBfi5gd7aSScwLvh7FyqeE8=;
 b=eefzIMZiJ+YrIuF3Z6TQPsYn74icODxyykpIK4DI4iRTv1vPtQfrEe+TWKLzHDdStM
 kMKXWNeTzXsXuqFUYvnvv3/MOd6Xk/H+mIIdT4pzPKzORtUU7nBdOs1pKEY2qwklMXD4
 gzWxTa6muJPUv8fTC3DGToSbbN4tubTCFF9K6rA7JzLorzMVIlht+61lrtf+RXjq7BFB
 qHQ8vbUUhFQk5EXkANC4tUa5wdrXRie3vX6uHPzFc0A8oNc1OCrIJRqWj14hj0JP6DwB
 Eix/Q1BUq1jLUjF7xyWbmy0onJ2idV7zRNcaWhHQ2gLYqop0EOk2krlXyeUgjEl9sSOz
 9PZw==
X-Gm-Message-State: AC+VfDwDKIxP8VNJK5J47a3wXAWS0aWYoMInITx33AqZrsPfT5w4RSWK
 54xxLtJq3VrR93Ueu+soQQQZJQ==
X-Google-Smtp-Source: ACHHUZ7USnUUjhiMaUV2DhKdMKkc0klawgZMSLn76qjYPQPCxVH/3xLaqWu3mmSb8Q7fBjpZkZrPxw==
X-Received: by 2002:a17:902:da83:b0:1ae:4562:14f1 with SMTP id
 j3-20020a170902da8300b001ae456214f1mr1905635plx.9.1686334682331; 
 Fri, 09 Jun 2023 11:18:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:20be:c4cb:f609:8cca?
 ([2602:ae:1598:4c01:20be:c4cb:f609:8cca])
 by smtp.gmail.com with ESMTPSA id
 ja17-20020a170902efd100b001b03b1bcf6bsm3548369plb.252.2023.06.09.11.18.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 11:18:01 -0700 (PDT)
Message-ID: <3c45c2a4-3697-a71e-9c77-3522f60af074@linaro.org>
Date: Fri, 9 Jun 2023 11:18:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 06/22] target/arm/tcg: Fix iwmmxt-related code style
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230609104717.95555-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
> In order to be able to move the iwmmxt-related code,
> fix its style to avoid:
> 
>    ERROR: braces {} are necessary for all arms of this statement
>    ERROR: space prohibited before that '++' (ctx:WxB)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/tcg/translate.c | 227 +++++++++++++++++++++++--------------
>   1 file changed, 141 insertions(+), 86 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

