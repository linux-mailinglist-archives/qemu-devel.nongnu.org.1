Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFFF7370D9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:47:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdZ1-0005Z1-Hx; Tue, 20 Jun 2023 11:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdYv-0005YX-K2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:46:33 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBdYt-0002MY-Ll
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:46:32 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-988a076a7d3so371325166b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687275990; x=1689867990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nS5VmzPsL24vhra4r9Gd1EaZdRsn/gxMbJdFkIUo9V4=;
 b=BSn7cBWaK1mH7Ca1SaOJLYo2e6dKLesg5KVbKMXaI/A10HmuaFacrxzXxo1TqAhSgl
 nFC9/WikpKkuYMWSG5pHjFQvwzdo42kc7605diA6u9doyu0g/WxcNBzEkpDuCzeO23rQ
 4h3icxwmdid3VjxkKmeAY+YvCsFHCjgviN9EAK+fA3pfRngG63c8Dj+pwpuQN1sEbuUX
 a3ai+TJv5coqKWAVx1nboM8gw73ujADQOUmJQPKarOBLIjiHEoY2NlpW82mh6RfRZbOu
 RC1XBy4bKqS8PboYuQVXCMOKc4PozJ+TxvwCE2hGtkq6EBHI/p5LD5REvbzns+Hmq9XV
 bKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687275990; x=1689867990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nS5VmzPsL24vhra4r9Gd1EaZdRsn/gxMbJdFkIUo9V4=;
 b=Vcy2nA2CK6FdW5XJdiu1l8U5UTCpR8NTo2WeymgmFqMOBBoxveOEbUCN8TSk9uaqI8
 /13Qf2yntypj1NHrxo5YJY8zwZcGUaVM3w+Ecq0P6XghYLGWeSCAiyyDuUWLXwq9DuWs
 XaWyewLLjZdM/M92J/GnHx370WqFyI7st4UvkPV17vCgNErE/ZSET0IulRqXUIBZzj8z
 f+sWK9awm+kugpIf5C5n+Jqe1E5Of6wXkI+JowRXxu7Y2RHDgE4i7O88dXka9uDe9xd7
 iPALXn5hYoGGXKGVEwgzNDBU4UsRdscEFvX5475N4OlXTAFRJayo9vxVt+nOF+d0yKrv
 l11w==
X-Gm-Message-State: AC+VfDylg0veGWQyNh8C53z6mz1P4pQFvIK3F1rk7Bvkm/CakmHWidBO
 YWvpKbdBOLuZR/KV/B+E72R/qA==
X-Google-Smtp-Source: ACHHUZ7PJKecfbfoYpFU4rKQa6fKuW/cT3F2iTkrf5705uBa5gCb+S67g+wDddH4MC8WCqaEiPp2jQ==
X-Received: by 2002:a17:907:2687:b0:987:4e89:577f with SMTP id
 bn7-20020a170907268700b009874e89577fmr9674650ejc.24.1687275990112; 
 Tue, 20 Jun 2023 08:46:30 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a170906705000b009892cca8ae3sm1288325ejj.165.2023.06.20.08.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 08:46:29 -0700 (PDT)
Message-ID: <6670763e-c427-09be-41d8-c797a394900e@linaro.org>
Date: Tue, 20 Jun 2023 17:46:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/5] target/microblaze: Define TCG_GUEST_DEFAULT_MO
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
 <20230619142333.429028-2-richard.henderson@linaro.org>
 <2974a774-b55d-371a-5596-5be1938ad4af@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <2974a774-b55d-371a-5596-5be1938ad4af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62a.google.com
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

On 6/20/23 17:41, Philippe Mathieu-Daudé wrote:
> On 19/6/23 16:23, Richard Henderson wrote:
>> The microblaze architecture does not reorder instructions.
>> While there is an MBAR wait-for-data-access instruction,
>> this concerns synchronizing with DMA.
>>
>> This should have been defined when enabling MTTCG.
>>
>> Cc: Alistair Francis <alistair.francis@wdc.com>
>> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
>> Fixes: d449561b130 ("configure: microblaze: Enable mttcg")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/microblaze/cpu.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
>> index 88324d0bc1..b474abcc2a 100644
>> --- a/target/microblaze/cpu.h
>> +++ b/target/microblaze/cpu.h
>> @@ -24,6 +24,9 @@
>>   #include "exec/cpu-defs.h"
>>   #include "qemu/cpu-float.h"
>> +/* MicroBlaze is always in-order. */
>> +#define TCG_GUEST_DEFAULT_MO  TCG_MO_ALL
> 
> Targets missing such definition:
> 
> - cris
> - m68k
> - nios2
> - rx
> - sh4
> - sparc/64 (!)
> - tricore
> 
> I expect targets designed for embedded systems
> to be in-order for power efficiency.
> 
> What about having each target being explicit about that,
> having a build failure if TCG_GUEST_DEFAULT_MO is not defined,
> instead of the '#ifdef TCG_GUEST_DEFAULT_MO' in accel/tcg/?

I'd be ok with that.


r~


