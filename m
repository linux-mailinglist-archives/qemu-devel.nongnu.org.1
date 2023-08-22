Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 583A2784D30
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 01:11:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYaVN-0002aj-05; Tue, 22 Aug 2023 19:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYaVK-0002aV-M4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 19:09:43 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYaVI-0002qH-Hp
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 19:09:42 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a85cc7304fso1685883b6e.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692745779; x=1693350579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PG/xZsfsDZHy4TgLsTZpfi8MtAC0ojYolTnS8HQgQ0=;
 b=hnLjkk/VQJ+bTPp/EPj8qrfJURhowhGXTIaU1ypKpU/DlZtVc7q2Hm1fTl1k3J2DzB
 2QbbpqOuC8nezTvXkeuuLQx/BR0oCALGB/7a+ERcgLPn/ZQug6RmRJx7SmmvkZEMVnA/
 s8P5/ULsbjLGWfxcTYg4UV2Yy9NpT2RtrrnNUcqNw2oslgyEcUKnOezrsFJ23mkc53tW
 kUAobvJaSYCpufm3vOhGpETDsO9rjnh0FWK98M90uGXHKZ6lETK73i/ilO97hMY+JBbc
 Q6NKfUmSg7foeqoQibbvLYlDoIO24Kv1/5ABy8e0MUlHsr6sy3fXKQnNGpAfujPHXm+2
 2skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692745779; x=1693350579;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PG/xZsfsDZHy4TgLsTZpfi8MtAC0ojYolTnS8HQgQ0=;
 b=BBgHM5RX/h+MD5Q99Y1j856Hx+2tR8mfO85y1LkTfMdYQr819f5QiT3sxK8nZR+GgO
 xGuhjN+05tbe56sO8g7A2zgQyBjZHObeXgWtqwgIXX8xzkSNOdLITcP5ug9CBredT/hK
 kxBgJHEMHG2Kh05ZDTnoPMW86TL9eQ5HCege/CsPHurfjbOUeMKQ6FzylgQTbbHkD2xq
 gCpt2aLP8pZN52gtVSRCy93PywMDax+wC+mBE0xCUnqBa707p1wbJhXSfP1+3EZEMaWZ
 jrPD0DCxmVtE4b0Yf8niK/e37WyeblKOhpYQoBHy47QN/AiXTeGuNoc5ISTq1fMY+q8U
 RA0w==
X-Gm-Message-State: AOJu0YwbFVpvZU1t21AdJTeF/bQWipyBlZlQg4+CGy0OEade+moLaaLw
 Bg+fHpL8W+QD+xWWo/90AlnF3g==
X-Google-Smtp-Source: AGHT+IGMoQ6kIUo6WN0rEOZ/oaCD7LrdjPIT0LsDSE6ZISZz54ggYDYINgKCCxgbiILNDNEh47EgUA==
X-Received: by 2002:a05:6808:2a47:b0:3a4:894a:9f57 with SMTP id
 fa7-20020a0568082a4700b003a4894a9f57mr11101943oib.6.1692745779063; 
 Tue, 22 Aug 2023 16:09:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:4e3c:f4a4:b92a:b5ab?
 ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a637e4f000000b00565e96d9874sm8328596pgn.89.2023.08.22.16.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Aug 2023 16:09:38 -0700 (PDT)
Message-ID: <892fd054-605d-ff32-290e-836071b07bc6@linaro.org>
Date: Tue, 22 Aug 2023 16:09:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] tcg: Unify TCG_TARGET_HAS_extr[lh]_i64_i32
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230822175127.1173698-1-richard.henderson@linaro.org>
 <19bce54d-5e47-e0f9-e804-434ef99839fc@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <19bce54d-5e47-e0f9-e804-434ef99839fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x234.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

On 8/22/23 15:05, Philippe Mathieu-Daudé wrote:
> On 22/8/23 19:51, Richard Henderson wrote:
>> Replace the separate defines with TCG_TARGET_HAS_extr_i64_i32,
>> so that the two parts of backend-specific type changing cannot
>> be out of sync.
>>
>> Reported-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/tcg/tcg-opc.h        | 4 ++--
>>   include/tcg/tcg.h            | 3 +--
>>   tcg/aarch64/tcg-target.h     | 3 +--
>>   tcg/i386/tcg-target.h        | 3 +--
>>   tcg/loongarch64/tcg-target.h | 3 +--
>>   tcg/mips/tcg-target.h        | 3 +--
>>   tcg/ppc/tcg-target.h         | 3 +--
>>   tcg/riscv/tcg-target.h       | 3 +--
>>   tcg/s390x/tcg-target.h       | 3 +--
>>   tcg/sparc64/tcg-target.h     | 3 +--
>>   tcg/tci/tcg-target.h         | 3 +--
>>   tcg/tcg-op.c                 | 4 ++--
>>   tcg/tcg.c                    | 3 +--
>>   13 files changed, 15 insertions(+), 26 deletions(-)
> 
> Clever than what I was thinking of, thanks!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Queued to tcg-next.


r~

