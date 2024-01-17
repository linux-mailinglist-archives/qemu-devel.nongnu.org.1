Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD2383012C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ19b-0005aU-EU; Wed, 17 Jan 2024 03:20:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ19X-0005a1-PK
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:20:03 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ19V-0005aG-ND
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:20:03 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e8cf57d66so275485e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479599; x=1706084399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZfKOZlLr4j7i+El6ebMYR5a8uJt4NTqeeZxFoXkdOog=;
 b=FraKDpKpGStwaBpKw2NHORkN25Gi92PUq0l63cyz2eXRNqVGZDVbXztUItV+WKiSSW
 4LtvKNuUBEqHQ0ihHKpcSsAmyhAHPxD+rNZ7GAFDG9aNUpYYEPiCc5t8s0l+PNMD6VLR
 NoKfhoAkbRTrcGcoYXulhgwzhIG3U8dhIElxU602ZX2w+vXmcqmiJlmgKoII+0Wfb8CL
 8jvFNZ8Vm+W0JJPIs/xshDsEJAFj4I2IFcj8nszrTqRRtcV65JHOfsniJx/loKgVhkxi
 pP8E3CcomrihVNefnJ6FWg0nTtgrc3sA9osnySUSgbxLRLwaD3nBI7xMnFRUjW6MlkgJ
 3Nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479599; x=1706084399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfKOZlLr4j7i+El6ebMYR5a8uJt4NTqeeZxFoXkdOog=;
 b=GiWy8xvt9o/pt80XVl/PzgJtKkHrAbUZcQXD26omScfwbfwzwWHksBqYHq6xen+J4Y
 /37MJ8Q6tQbUIi331UyHkwAq9d1k3BNiUeipn6VeonvCCJANE8FzvG4RR9JI9WIvrYFK
 C7AER1CVrGnDykXN5Qs57FUa2EWBBMRR7ACz1nstBrWlXMwQhPuVQEP/8E3/NPJWcvV7
 dTt2PY5Z7zF1OBqZf5XpExREHDVFAmzmDZ8eGf2LVVoZdHGJJ7A6zlj0WTZvRfq1A0B6
 oB9OHDctCRpqsvuqKoBGNHBdzdnJEqd2ojoWREejGiBJmohaR1bDp6COGLD2plzRfzbq
 CIhA==
X-Gm-Message-State: AOJu0YxDXQYsV7Oe7kRK35kg2xlcbP/5jproM083kP7EaHmIMmIJHdGR
 wAi4AvDH79YX9zT1jnju6GHhNcffLdcXAA==
X-Google-Smtp-Source: AGHT+IEuCkBPQZUok+QLcJ9jLhTkNpzj54UBYj8oWtnrGZhU07U/idqilViK6BumQB1x6t0cIZ+qQw==
X-Received: by 2002:a05:600c:220e:b0:40e:4864:1e7 with SMTP id
 z14-20020a05600c220e00b0040e486401e7mr2155770wml.340.1705479598906; 
 Wed, 17 Jan 2024 00:19:58 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:19:58 -0800 (PST)
Message-ID: <730f9c37-bfbd-4936-a2d7-bdc0174a4810@linaro.org>
Date: Wed, 17 Jan 2024 09:19:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/watchpoint: Move TCG specific code to accel/tcg/
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240111162032.43378-1-philmd@linaro.org>
 <15efba7d-c308-43ac-a036-2dd00ba26422@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <15efba7d-c308-43ac-a036-2dd00ba26422@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/1/24 22:49, Richard Henderson wrote:
> On 1/12/24 03:20, Philippe Mathieu-Daudé wrote:
>> Keep system/watchpoint.c accelerator-agnostic by moving
>> TCG specific code to accel/tcg/watchpoint.c. Update meson.
>>
>> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
>> ---
>>   accel/tcg/watchpoint.c | 143 +++++++++++++++++++++++++++++++++++++++++
>>   system/watchpoint.c    | 124 -----------------------------------
>>   accel/tcg/meson.build  |   1 +
>>   3 files changed, 144 insertions(+), 124 deletions(-)
>>   create mode 100644 accel/tcg/watchpoint.c
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks, patch queued.



