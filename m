Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D19672B0E7
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 10:56:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8GqL-0007hZ-9c; Sun, 11 Jun 2023 04:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GqH-0007gU-VE
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:54:33 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GqG-0002EN-2x
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:54:33 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6da07ff00so33854145e9.3
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473670; x=1689065670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HrCPFIlv9L7Z0OO56JsRw0LaQxQ2vbRBrtIUtJNMoKs=;
 b=ZnX5KwR3nOHTx4vlugYOvVf62RkDiteu0uZQN4CIJf6OmiHWFXo8PDjeZfN6FFA7jo
 egecCqHanmsVdeQESWyJoFnjl12i7O02Rim4XYZrB7XPq6zTTUX6mL32wLOwMGg9shJX
 TwwF7UNxXVip5ZBEIwIj0P1SlQ8+A0BsNmRaF6mphKBsQcUiSJNGrkzzHHgXklmVFqfB
 jApqQCMcieOGkI/Cqq0Z+dGgDnFYs6KmJ9QrzmgPL4Ieg7D7/rrGEqmbhHx9A8GARFt7
 jRNgqHWWl1xv6s+z7NE5GmBB70TlrZG65t1nszzRrNkoNdkBHnDSUh4zhgaQTRNzG/YP
 f6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473670; x=1689065670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HrCPFIlv9L7Z0OO56JsRw0LaQxQ2vbRBrtIUtJNMoKs=;
 b=DYYBe3bKXOoXsV5lW/E4Jdi5avSGVP5acR5brfoOXnTtPpJzGettvtiuMoeWYPEeqK
 7gwHfe84WG0D0Y8JYorOE6DYwECocyl4W9VawvBlD6GExMvAh32tAEm/ysgWHwvmoQvI
 oQBahR+BB92c3aeD2F2x12vFCy/MZ4GwzDgu2bvkCrN4aGDdqdURvJX1DwobYyWR4YA3
 TWQVsYbXu5FWSZNWZGxbbWIrzZ4BeVc8SI9cgQBDPYZP6ntZVsxvNy3nHrommlS35VFv
 o82Z6wea8GwFPwXZbmT+K9ZLJWo9V0JtC4aMR7LNCWX98ZUtFherrG080Jc5reB/eLPI
 6UDw==
X-Gm-Message-State: AC+VfDyBE3iLsdehpVuX9N9zmC6TZwgDb1/VjRCmIx0WwS6AuxP/1D+K
 2LTmrcTT3+Y7cVpEVV+eWCM1sA==
X-Google-Smtp-Source: ACHHUZ64bB2kG+Y2uP4cZQ6hFWmMpcJWHXjq3WKK7cN5zzFdaEA2dS9reGwVwvfO9Ha4zr9PgdnsQg==
X-Received: by 2002:a1c:f70a:0:b0:3f5:d0b8:4a53 with SMTP id
 v10-20020a1cf70a000000b003f5d0b84a53mr5342446wmh.34.1686473670030; 
 Sun, 11 Jun 2023 01:54:30 -0700 (PDT)
Received: from [192.168.1.67] (91-163-26-170.subs.proxad.net. [91.163.26.170])
 by smtp.gmail.com with ESMTPSA id
 w25-20020a1cf619000000b003f7f52c9988sm7866091wmc.21.2023.06.11.01.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jun 2023 01:54:29 -0700 (PDT)
Message-ID: <b319419e-2500-bfe5-541d-576cfff32987@linaro.org>
Date: Sun, 11 Jun 2023 10:54:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 09/22] target/arm/tcg: Reduce 'helper-iwmmxt.h.inc'
 inclusion
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230609104717.95555-1-philmd@linaro.org>
 <20230609104717.95555-10-philmd@linaro.org>
 <5624531a-48ca-9d78-1046-108b8e4df603@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <5624531a-48ca-9d78-1046-108b8e4df603@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 9/6/23 20:59, Richard Henderson wrote:
> On 6/9/23 03:47, Philippe Mathieu-Daudé wrote:
>> Instead of including helper-iwmmxt.h.inc via helper.h which
>> is included by all TCG files, restrict it to the few files
>> that require it.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/helper.h               | 1 -
>>   target/arm/tcg/iwmmxt_helper.c    | 6 +++++-
>>   target/arm/tcg/translate-iwmmxt.c | 6 ++++++
>>   3 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/helper.h b/target/arm/helper.h
>> index c4a321c0ea..dd12fee107 100644
>> --- a/target/arm/helper.h
>> +++ b/target/arm/helper.h
>> @@ -949,5 +949,4 @@ DEF_HELPER_FLAGS_5(gvec_uclamp_d, TCG_CALL_NO_RWG,
>>   #include "tcg/helper-sme.h.inc"
>>   #endif
>> -#include "tcg/helper-iwmmxt.h.inc"
>>   #include "tcg/helper-mve.h.inc"
>> diff --git a/target/arm/tcg/iwmmxt_helper.c 
>> b/target/arm/tcg/iwmmxt_helper.c
>> index 610b1b2103..fa84b5f672 100644
>> --- a/target/arm/tcg/iwmmxt_helper.c
>> +++ b/target/arm/tcg/iwmmxt_helper.c
>> @@ -22,7 +22,11 @@
>>   #include "qemu/osdep.h"
>>   #include "cpu.h"
>> -#include "exec/helper-proto.h"
>> +
>> +#define HELPER_H "tcg/helper-iwmmxt.h.inc"
>> +#include "exec/helper-proto.h.inc"
>> +#include "exec/helper-gen.h.inc"
>> +#undef  HELPER_H
> 
> You should only require helper-proto.h.inc here.

Oh, good point.

> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This was exactly the sort of thing that I had in mind.

Good :)

