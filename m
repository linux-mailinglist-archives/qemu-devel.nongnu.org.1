Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0C8782430
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:12:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz5P-0004sD-PC; Mon, 21 Aug 2023 03:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz5N-0004nB-TI
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:12:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz5L-0008GO-K1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:12:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so2739677f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692601942; x=1693206742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8j/9Xl7/CVA7+FDuM4eBPrFg58HikPhkxWcHnl6JDMo=;
 b=ryz3HmZLMmGDtQ+hYzZGinJwJ3z0RjoI4hGlDOsjPN7J9NKmqTT/OJ6fW2aULEwv5b
 97Qg3ZiNawIc3+uzV1kHiJ+0fhqDZWqfEnY9SwafUgPVFJCgCCfq7B5F0XzZ7NyHOXrD
 bzsdTT+2HMTvOjNX/DuHoK80Y5XKch+Bf3bEWCto+BU7rxpB1vGTbd1Hr5/qfuQTYNIw
 MN4r6qxmBZZd4NOBAbcVJDbmyj3zHsJm42CTXao7H84z5y1G2AFcEPSRKh14JfzH3pjg
 PWU2urWyZA+VFcNGNoJkR6Pyddkbf6cN2pu0yXHVydhOc/ubw39jsQDl3PDC1wPS76B5
 907g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692601942; x=1693206742;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8j/9Xl7/CVA7+FDuM4eBPrFg58HikPhkxWcHnl6JDMo=;
 b=Yp+ZjNi09FOhI7ssfKasry/5KsU0zjUK6vdQbmYqpLQmhZy6y3Mr386sn0asgD63MF
 e6LfkUpWyZ5xtjy+D0bVZMy7FmqTa2qPoIsiei20YiSUFcQswyrpKtrnT5YTnAjeBxn4
 Jxp+LKeo2LGvA8E08MsMeOWfLw+sM3Kz6n/O9oZx6Ozb1AzpK3AqeXWVkUf5UK8dtYcT
 cdI5Rkw+2rhy/aiKN+9sG/T0uh5UQ9sFON45UH9JVwtRgJylRIuuCUcr6Si83nfwABOO
 2VZbr3jOcvk07h/vzA/KvptU4R/vpQw4CAfrYyLSbcfrFSmkcSsJwFIetDkX6cofQpvz
 z2cg==
X-Gm-Message-State: AOJu0Yz50GsMAuIrU9j/tN4CXp4gndC0zT4BCyrA9F4njndyaiuZdqEu
 JNJLZko/gMXalkGdIwbQsauYyErRhy5Ga+A+dR0=
X-Google-Smtp-Source: AGHT+IEdG7X15RIXFeBozHje11Mk93IiUIviKro7tqQdBB01LdGRHltMTTFN5gneXw8TuPphGqEkLQ==
X-Received: by 2002:a5d:5222:0:b0:319:8ce0:4e52 with SMTP id
 i2-20020a5d5222000000b003198ce04e52mr4211384wra.67.1692601942317; 
 Mon, 21 Aug 2023 00:12:22 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 m4-20020a056000008400b0030ada01ca78sm11376795wrx.10.2023.08.21.00.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:12:21 -0700 (PDT)
Message-ID: <a4604608-0943-b0cb-2097-095915c2977b@linaro.org>
Date: Mon, 21 Aug 2023 09:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 06/23] target/openrisc: Use tcg_gen_negsetcond_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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
>   target/openrisc/translate.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



