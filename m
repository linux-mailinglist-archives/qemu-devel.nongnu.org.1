Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C137A1B08
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:45:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh5NC-0005Nc-Rr; Fri, 15 Sep 2023 05:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5NA-0005N8-Ca
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:44:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh5N8-0001lJ-V7
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:44:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so251511566b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694771061; x=1695375861; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=02Uhtf7b3d3/mmbqyB2A8vh0dRw1EXWfJOL/1ijaT5Q=;
 b=Mq3hvluo2ZPJMlpj693tz9rsKRFtQPVghSIXEgslq3QZkcQQ+Un6wrhuT4Xt9kRhKJ
 un+WUNs7eWhOfHLFm8xE5LuE1n53kZHljSzXLQRFa6Pk9UB8YqTBzxyXfDYZ+N90tWyz
 4/qhqZz5jHctqZfD5HKcgKAiq8DfD/LcdMA6cFYzQwr4wf/BeVZ6bbOj6U64zNpsqf8v
 LTERGPA3E6PqjPSJUYi2lM2hMQyhd/GBINGKsDceYoI7p//aSE1MLaKLF3zNsgaJHyV4
 bGH1FqDlX0cWGzFjQy9nGRfjDNjQYwwQaHP6fvV9k65vgA4p4Yn6Z5ht6w8m5qyLuySK
 eXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694771061; x=1695375861;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=02Uhtf7b3d3/mmbqyB2A8vh0dRw1EXWfJOL/1ijaT5Q=;
 b=rxANHBVCm/VU4x0bShEWqAYK6ACxUdUXTM07+OXem9SpNxeiK/BfeZ5LiRjL1JNr3+
 W9+sa9rbg31qrsQuiHA1h9ifcHtmRHRobVco/9xlxQAr4ffAQEVitzkRDzZj473iRmJN
 CaU04PjBY4dU/c0DjBJbeg9Hij2mCYtNkYLbywGiX2s1JuhBXQkMUH76JguOQkjXixSA
 R9s+/Bl0BDqY8YqTOApPaewVqcD/xz82liyjcI2Hyj/HrJIM09uGmu4mbWKdnmOoBrBJ
 7vEuehDKl7UsOeHvxJuscQ+MUN7o5jbhj6TnBQzK9yQeTwMOiRdyMaZ2VKRr2ilO/cS8
 kI9g==
X-Gm-Message-State: AOJu0Yy199EMTiY471Hxvov1F7JKtRD6L4I1dIp8T5KUQdEYR7e2G1Ac
 uttd/ApJBfqg7vQujdRyMfd+neGyRXRA64zQz5A=
X-Google-Smtp-Source: AGHT+IHMNETJjSa4PYshVkDEeLr4L7AioNDwOeTkciz8iji4QTvRWXIQVdm5i85beuXjaREGIhmdew==
X-Received: by 2002:a17:907:7718:b0:9a9:e735:f621 with SMTP id
 kw24-20020a170907771800b009a9e735f621mr1012638ejc.15.1694771061307; 
 Fri, 15 Sep 2023 02:44:21 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 v4-20020a17090690c400b00992b1c93279sm2129548ejw.110.2023.09.15.02.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:44:20 -0700 (PDT)
Message-ID: <ef56d933-bd77-d5bf-5085-e13504fe51fa@linaro.org>
Date: Fri, 15 Sep 2023 11:44:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/6: 2/2] accel/tcg: Track current value of can_do_io in
 the TB
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230914174436.1597356-4-richard.henderson@linaro.org>
 <20230915094109.82757-1-philmd@linaro.org>
 <20230915094109.82757-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915094109.82757-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 11:41, Philippe Mathieu-Daudé wrote:
> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Simplify translator_io_start by recording the current
> known value of can_do_io within DisasContextBase.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20230914174436.1597356-4-richard.henderson@linaro.org>
> [PMD: Split patch in 2, extracting set_can_do_io() first]
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/translator.h |  2 ++
>   accel/tcg/translator.c    | 14 +++++++-------
>   2 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


