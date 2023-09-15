Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB377A229E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAug-0003dh-KK; Fri, 15 Sep 2023 11:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAub-0003cz-R3
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:39:17 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhAua-0007Sg-8n
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:39:17 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31c93d2a24fso2107349f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 08:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694792354; x=1695397154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A0i/+BlLbS2hqosdhXTQlOuKWHlYC6mTdbpLkTcxu1I=;
 b=MpauQUDb/i2nDhawaGJThpdLVDsf8j08032uDyCKJW8dMI0JG5+MVZq1nxy75fEsMV
 KwZattgArKOLQ56aknHohUiO2dUMaDyJBMo+Sj8AV+p17NkcKr4KkpydZwwCAc98t6lg
 J996CwtGxoELLSi1DnZLWB4eJTLebRX95sCHjyPWR0eqHhlDvKrQ9q2RLGhiJVwu0HRr
 Ti9R7a/+pI1TDClG/B5z12PM/LKGaYCTMMvogklA7UGBUvwym5AZnEiuKJw+KLy2sHGx
 /FFPJjHgeFKF3sxDIBWyoSkIClPnj1hnooudK73l7OhF3LJTsUsYcs6/TWlPvbJS6Gsx
 44KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694792354; x=1695397154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0i/+BlLbS2hqosdhXTQlOuKWHlYC6mTdbpLkTcxu1I=;
 b=jlMm0c+8fsrpSBzNj92DJj4uJswIzX9IDLAiNKYUVHKCfCmJUYzl0Jc3MZnJhsDFzT
 /Hyt93JpNXBwtCcIFDhj0x1/N9n4b4ufyqdRimLxvHk+LmmeAqQoZE2M9m20aVRS7mqP
 HJVPmpTon/rcwrGlXlnoVrUd7zq9BWkvCexVx4uq4hykJzi1X+GdkNCGDeJbZqyx5g8g
 +gsQLXnRQhz5ShwVwceRc2EmSGPrFNnnaly20bg3/KZIZxiu2bRBMltXsg7jhWUtMP2F
 akS9msB2AnGZ+vl1JrlaU1xlEulFJbdnVBgJGYxDAoot81wlzWqfVlD/Vu1+P2Ai2M99
 ecdA==
X-Gm-Message-State: AOJu0YxAg4JpWt4FiPeheLr5jksdw2fvWGcJAUY8MIGwvDM/269QzyMH
 /jTY+b/MVyL5N0gttM8HUT/wYA==
X-Google-Smtp-Source: AGHT+IFu7V9Kos3uPn395uLl+h8oYHIjABN4/orG5m3BjrzVB4iHhJjOlLW9hpwV1aImUuBClb8nWQ==
X-Received: by 2002:a5d:5502:0:b0:313:eaf5:515 with SMTP id
 b2-20020a5d5502000000b00313eaf50515mr1607289wrv.6.1694792354224; 
 Fri, 15 Sep 2023 08:39:14 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 j21-20020adfd215000000b003179d7ed4f3sm1362573wrh.12.2023.09.15.08.39.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 08:39:13 -0700 (PDT)
Message-ID: <9ed80ad1-f472-8f05-ade4-86c963a014d7@linaro.org>
Date: Fri, 15 Sep 2023 17:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 10/11] accel/tcg: Make icount.o a target agnostic unit
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>
References: <20230914185718.76241-1-philmd@linaro.org>
 <20230914185718.76241-11-philmd@linaro.org>
 <d5zts77uzfyow6uelyq3zux736yjakwnu5rytjyczvvwc3zty3@ubcout4dobll>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <d5zts77uzfyow6uelyq3zux736yjakwnu5rytjyczvvwc3zty3@ubcout4dobll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 15/9/23 16:31, Anton Johansson wrote:
> On 14/09/23, Philippe Mathieu-Daudé wrote:
>> Remove the unused "exec/exec-all.h" header. There is
>> no more target specific code in it: make it target
>> agnostic (rename using the '-common' suffix). Since
>> it is TCG specific, move it to accel/tcg, updating
>> MAINTAINERS.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   MAINTAINERS                                   | 1 -
>>   softmmu/icount.c => accel/tcg/icount-common.c | 3 +--
>>   accel/tcg/meson.build                         | 1 +
>>   softmmu/meson.build                           | 4 ----
>>   4 files changed, 2 insertions(+), 7 deletions(-)
>>   rename softmmu/icount.c => accel/tcg/icount-common.c (99%)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index ff436dbf21..047d143b9d 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2912,7 +2912,6 @@ F: softmmu/main.c
>>   F: softmmu/cpus.c
>>   F: softmmu/cpu-throttle.c
>>   F: softmmu/cpu-timers.c
>> -F: softmmu/icount.c
> Would also be a maintainer switch

OK, now I understood your comment. I should have mentioned
it in the commit description. This move from "Main loop"
to "Overall TCG". Icount is a TCG feature.
(Less work for Paolo, but more for Richard...)

> Otherwise,
> Reviewed-by: Anton Johansson <anjo@rev.ng>


