Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8FF80E8E0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzlO-0004cm-Bf; Tue, 12 Dec 2023 05:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzlM-0004ca-Do
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:13:16 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzlK-0005ii-Nc
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:13:16 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so18828085e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702375993; x=1702980793; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vPWh+rRJy5rCr036M+UM0nxv6bOnKuSF7Odedr6ghmA=;
 b=DSVPZEvWHKE3WuP/upZBZV1nwfVz8Zt6HakueBX9m3anuRp8GDpT5wNH2sdXshI3s5
 LFgPppNf51OhB8ro8fFT2DOJLj2lSMLHS6OqEp5DVu5oCNf3jVu/CINPfjhSBBv+j5ls
 wAi7rwD9TkPiVjNxheRJdOHwH7CZGJ42N4fp+0WSi+YGBOWrRf4Pu+jD/a59vv7FkPKT
 0+fj3jIvU059taValI/sTQm3G4ATH823VMYyOCbeAfMjuCP6x8OSGx7RvO06987UVcNt
 itZU1quzDdkAa9nbeZj3pWRWWIqAGOnQn6UUJfR1rXd9TFTXxXbIp6/Yg+nvDizV3k7I
 LeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702375993; x=1702980793;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vPWh+rRJy5rCr036M+UM0nxv6bOnKuSF7Odedr6ghmA=;
 b=AVfTHuV/HiZLz7sP3nSItY8qBwpb38yJglr0UhHnErHk0OIbagDHaF3lOjBU/A5SQA
 VvtpvD/lrFFYQlSpmUJSK6F53nu5Vd+IKKzEjtt+zbnPs0g4R1wsrW5CDt2JIiaTEXnp
 Xn5iWOiGlnvkzp2VYSA1pSkFAqMLFvRMjDegrUf5emJf1tBTSENZ1xl/dDtZEzXzqqkg
 Mq/itaSLe5CIXWz5j6FP9nD8zga9O8XrCpL8Psyp+dqILDEG1ZIcxfwAt8xH22Rx61dL
 CzJFVLsQz703VzbXnk4k06M3NVP/euZEeVA7XWvDK1rLt7FsAe/4Moaz2IT86klrnHUS
 aDqA==
X-Gm-Message-State: AOJu0YxBa7XGLrS1tjuMvKeMWmdeO4N7MeWFvO6IdEiovXurUXqrx4+a
 byPtqBKqXV4ZDoQkhHnBPJDqy4fFvQm8hDmfKm1zsQ==
X-Google-Smtp-Source: AGHT+IFJlOg98MxjWnIwLCvNPFhKIAQudLNwfZVYMsQU8Wa+qNcwUYWSEXgoc+8EHbCVT9N4OVJEmw==
X-Received: by 2002:a05:600c:138c:b0:40c:53bb:71d9 with SMTP id
 u12-20020a05600c138c00b0040c53bb71d9mr213714wmf.111.1702375992853; 
 Tue, 12 Dec 2023 02:13:12 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 p14-20020a05600c358e00b0040c37c4c229sm13437028wmq.14.2023.12.12.02.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 02:13:12 -0800 (PST)
Message-ID: <6e2aef68-9d6a-4546-8e71-f3ff010376bc@linaro.org>
Date: Tue, 12 Dec 2023 11:13:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/24] exec: Declare abi_ptr type in its own
 'tcg/abi_ptr.h' header
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-21-philmd@linaro.org>
 <98de081f-9a24-4019-8834-f7e4e6c209dc@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <98de081f-9a24-4019-8834-f7e4e6c209dc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/23 02:18, Richard Henderson wrote:
> On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
>> The abi_ptr type is declared in "exec/cpu_ldst.h" with all
>> the load/store helpers. Some source files requiring abi_ptr
>> type don't need the load/store helpers. In order to simplify,
>> create a new "tcg/abi_ptr.h" header.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu_ldst.h   | 17 +++--------------
>>   include/exec/exec-all.h   |  1 +
>>   include/exec/translator.h |  5 ++++-
>>   include/tcg/abi_ptr.h     | 32 ++++++++++++++++++++++++++++++++
>>   accel/tcg/cputlb.c        |  1 +
>>   5 files changed, 41 insertions(+), 15 deletions(-)
>>   create mode 100644 include/tcg/abi_ptr.h
> 
> I'm unconvinced about this being tcg related, per se.

Indeed:

$ git grep -w abi_ptr -- tcg
$

> Leave it in include/exec/, with exec/user/abitypes.h.
> 
> With that,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


