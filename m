Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692567B2792
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyeH-000707-Ui; Thu, 28 Sep 2023 17:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyeE-0006zy-JO
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:34:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlydx-00054b-08
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:34:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-690bfd4f3ebso10628642b3a.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936835; x=1696541635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MAylnPkOvZzEmiTdvecCTnQyomrIl+kxijb/UMFVEQ0=;
 b=OgngPHOLNm0xZ050Ka2pwu3gz5HGnltbYTb0MWoHZxVcaNuOSdnTvKM2ZD5PjpWlcv
 VGIpmHmXel/2uCRFpMzwhFhl0Af772NaFIG2eRy9U7vqa14YPUZgPEqHL0fBs9rJ2JVk
 3milvml8KIb02NkD6BFJ5QIsZybSnpgrcuCd3gvYBHCI0JHLgf/Y006EL1BuKVhekWI+
 j1YdmaM6Al63GbXaDrHZlx9F9l8Is6SrWBFmUgtDS/fhjJHLsMFfq2gdunRzIlg8M4fD
 P+GOjCdUqk1CcjtZFQKkepFHTA4tSSx5z6pfBnfHUtPaxW61PM5Kv3gkvhObi7l5KeUm
 /BMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936835; x=1696541635;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MAylnPkOvZzEmiTdvecCTnQyomrIl+kxijb/UMFVEQ0=;
 b=qvR3/RvZtMRFaEbXItKVuBNhr4UN2R8fI8t7Glu1QFndJFDq85O7Sp1QV0Z0XXPt2m
 RCUeOiWdqvLhMzUwurre5oYEpWJJVLpiQ6Buj9EWOdsq9UYhqQ0AiLlmUzbtkfAe+q5Q
 qCchh2pU9b92gyTMo7rfAikr2YenHaAhWl4qraFUrTCcYMNbd0srf2bONzcphBqygWzj
 dngbI8j3aSIIlf1B99r5go1UjawvjR7IT2Q+aM4/WTZwuTJbJ7TjM89Ji9RNUHADA+xF
 Z7tl9U2MiYSaIUHXqzmXvgViMLoDRrdlO4/lgu6hfLetspp6z3sUPxfai42Onivg2xla
 SJhg==
X-Gm-Message-State: AOJu0YxawK3LukXLEZWbyUlWf+KlTKjxEEQDsvrplUkJDXaPLIiLBhdo
 DCvaxtJZufxu44eZiXEBRFaAMQ==
X-Google-Smtp-Source: AGHT+IFQw2Uk/KD8iQtT+Z9xc6taliwd8oQdFbEwHHVjSbBaI4r09JSAcVI2WbOJ7vwsiZjaAlQdQA==
X-Received: by 2002:a05:6a00:16c7:b0:68f:ecb9:5fde with SMTP id
 l7-20020a056a0016c700b0068fecb95fdemr2368479pfc.34.1695936835637; 
 Thu, 28 Sep 2023 14:33:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 w18-20020aa78592000000b0068890c19c49sm2397233pfn.180.2023.09.28.14.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:33:55 -0700 (PDT)
Message-ID: <c8a269a7-9d5f-8893-f434-e98242a15e0e@linaro.org>
Date: Thu, 28 Sep 2023 14:33:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/8] target/sparc: Fix VIS fmuld8sux16 instruction.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-5-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-5-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/24/23 01:03, Nick Bowler wrote:
> On a real UltraSparc II, the fmuld8sux16 instruction takes two single-
> precision input operands and returns a double-precision result.
> 
> However, the emulation is taking two double-precision input operands,
> which are unlikely to contain the correct values.  Even if they did,
> the emulator is rounding the output, which the real processor does
> not do.  And the real processor shifts both outputs left by 8, which
> the emulator does not do.
> 
> So the results are wrong except in trivial cases.
> 
> Signed-off-by: Nick Bowler<nbowler@draconx.ca>
> ---
>   target/sparc/helper.h     |  2 +-
>   target/sparc/translate.c  |  2 +-
>   target/sparc/vis_helper.c | 19 ++++++++-----------
>   3 files changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

