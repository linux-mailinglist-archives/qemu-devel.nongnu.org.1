Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CE090B6B2
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jun 2024 18:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJFP5-00045n-Rv; Mon, 17 Jun 2024 12:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJFP1-00045J-Gs
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:40:20 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJFOz-0006WP-VY
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 12:40:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6f6a045d476so3492057b3a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718642416; x=1719247216; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GjHRlE+Qa2GToNwsD9KbIzb7D7jKjKlTUfF3oksf4B8=;
 b=zvOlNThenc6QDSEFODWV4npzjli8d8qoUSF2Y5Ka5V549j4GMq1F8viufj4clgOAzC
 bM/lFD6s81kHUBVZenvunIa8fDqrmQHm5sA8Dllk/hQfW8Mu9m2pv4MZUyzuUNN/cWGT
 Lt7RujL//ZK9iKVNbDgT/BXeCXNrlt7eYD+NNt5AWXPmMpdRVjnjsTznkyVB03Af6CqC
 PaBdvHnH5wbAtsNsjsc1BzDOxQDWmDn3fHJ6JpRdUoTGkYKONJyhux6uKeRrJsD9eUIj
 QQYHTEzVREyKpQtO6F8pWoNHwIcsbxWmJ0T8to09MD5V3fr1KyEOTr1F2QjGQoXuoidc
 4vRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718642416; x=1719247216;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GjHRlE+Qa2GToNwsD9KbIzb7D7jKjKlTUfF3oksf4B8=;
 b=keRt/Upcq5q2+gNp/TtHxDA3Z4NsFGqlQCU6JayKyRF5mKG9M1SK6XzSqWwzPzYgpA
 xoqh+9sfftTnqmnu0g19f0Pe4WRFFYcOPpu9IOpP/WQQy6lTXhko16UMEAUvJQXyp6aM
 oEuAaOH5L9kW97yXANHuiH6jSt6LpTvMpEMscY56dC9tcSFsd5SdjezFYsbjHqvtcZ49
 +q7NpUTmk5ZciI23ke8iSIoSSBaEmfJLTqUr4hrMBaUfFY/9npUIMiASomYEf75ucUMg
 +j1Zi+cHlzRKfrYeXy1R32zO8SAxoBEgyKeynJ2pOwJNP8ucCwoX9s8FSMaydxrSSuZb
 Gl/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6+AZ+5dB2WaptqvV1hEq7zoPDIatW0cYTonUx43r7Fx6DrYtsiMhC+xu9+QTAZoRQHeBzEVLRHe9Phz2YJAbYf+/14r4=
X-Gm-Message-State: AOJu0YzlmIB3EPMNOJfJ/M9JuCSPAYMA0/RIeNyC5PHz5gMyBuiY0PBW
 KPE9U9MWOq7MS7fhXBdYhcuJM+mTMBC1On2Y51wU+lMoQgc8iRcEaibzx1Yfz94c/v/o55AuJ75
 f
X-Google-Smtp-Source: AGHT+IEgI4H1V249nNCYQQfEodX08Xyv7Q4GomA9wZxoP+IflHCEohGcHYgGJ1aXF5Nt0SXFO/CANg==
X-Received: by 2002:a05:6a21:4603:b0:1b0:257b:a5da with SMTP id
 adf61e73a8af0-1bae822114fmr9169921637.45.1718642416411; 
 Mon, 17 Jun 2024 09:40:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705ccb93e11sm7562341b3a.198.2024.06.17.09.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 09:40:16 -0700 (PDT)
Message-ID: <826b9258-d641-49aa-a5b4-bcf4c7af431d@linaro.org>
Date: Mon, 17 Jun 2024 09:40:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] tcg/loongarch64: Import LASX, FP insns
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-2-richard.henderson@linaro.org>
 <d410c503-04c3-f840-4f61-2d515e655baf@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d410c503-04c3-f840-4f61-2d515e655baf@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/17/24 00:57, gaosong wrote:
> 在 2024/5/28 上午5:18, Richard Henderson 写道:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/loongarch64/tcg-insn-defs.c.inc | 6181 +++++++++------------------
>>   1 file changed, 2123 insertions(+), 4058 deletions(-)
>>
>> diff --git a/tcg/loongarch64/tcg-insn-defs.c.inc b/tcg/loongarch64/tcg-insn-defs.c.inc
>> index ee3b483b02..d2d60bda51 100644
>> --- a/tcg/loongarch64/tcg-insn-defs.c.inc
>> +++ b/tcg/loongarch64/tcg-insn-defs.c.inc
>> @@ -4,11 +4,13 @@
>>    *
>>    * This file is auto-generated by genqemutcgdefs from
>>    * https://github.com/loongson-community/loongarch-opcodes,
>> - * from commit 8027da9a8157a8b47fc48ff1def292e09c5668bd.
>> + * from commit 71b640c0fabc670fd8a3e762b42b4745bfe94848.
>>    * DO NOT EDIT.
>>    */
> Hi,   I can't get this commit on [1].  is this commit id wrong?
> 
> [1] https://github.com/loongson-community/loongarch-opcodes

Hmm, the commit id changed: 7f353fb69bd99ce6edfad7ad63948c4bb526f0bf.
Perhaps I tweeked something before the merge...

I'll regenerate, just for completeness.


r~

