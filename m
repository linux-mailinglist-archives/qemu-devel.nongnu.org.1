Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59F80E971
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:46:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0GK-0004Wq-HT; Tue, 12 Dec 2023 05:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0GH-0004WP-ER
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:45:13 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0GF-0000vw-Il
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:45:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ceb2501f1bso4493591b3a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702377908; x=1702982708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PjxJGKNeOp0Q5xjjphl09KEAsx4dIXLdp3eGnCbkbk8=;
 b=w4/Z7ZJ7T9iWKwaCeOAc9hrGiiM/LrvppltRsBRyJD4J34OKjkuMYi3nLHlmX0sTqf
 esbA/UQxotttIBDjYZsxdwjEJoKIB/2/r6uXe+ZMsYGiwPjFFa2HWFZqei9awngJ2i6U
 nH3jjdJfTG/WyXxgRErxGHOKgwSOg2S7GYPU7KPNjt41RAxutFFvIe4oOuCVLm1pryaZ
 dAD3zirnEplHsI6z99K74kAl4VkqG3hB/H7BisEKvuI64gZfN0kbDI2CwMhR2xHU5qTT
 PMIu/z7UnkN8aLxTA8hVFi4WesDt1EuIJiumkU9w/iZo4Mxdp4XDfR7kdfyohRSU6tqW
 rNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702377908; x=1702982708;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PjxJGKNeOp0Q5xjjphl09KEAsx4dIXLdp3eGnCbkbk8=;
 b=mKtQod/5iz0l7Zg090IJbKbS/jID9y5TJjuL23e/QlYBp5dwT81lotmm17U3fClNge
 hwC75hNty7OQs5/Db1Rexw4E1ZrmHkmSccX25CcM5aJ72XNVy5pX/QejnWEby+cMQt0u
 cAmVA8Nl2KNMgT8MULzTUB03M1Ycu9WwQ8oge+0rc7FeD6XMEQL70SKg7/IYTpWeczKi
 D/aBwukg3XpAa+gdX8bgdXq2e1UAyEeNJm7YWKnu0UAwpKh1vrIwekjPKD3uEgCRqQmh
 1Fur89WjhwQNDm4kN0yVvHO6MBdfl6Cq/RVthyJ/K+6DAWPNV68bw2ZNazzoumEs0y0F
 FT7g==
X-Gm-Message-State: AOJu0YyIa4fXbgEvd81CrDviq5IRblL9SiLyRgQifdxjC6UWbx1Mu+/4
 nRnqBLubcIKHPl6fumnzAAX7Gw==
X-Google-Smtp-Source: AGHT+IGmuZz0XXV2XUZoKxEkCW3ufwwfAHwFIgH18RmXc3N8QzdzS2IzhNd0NS1Nx4pthEMwXyWB2Q==
X-Received: by 2002:a05:6a00:4653:b0:6ce:6f99:4ec4 with SMTP id
 kp19-20020a056a00465300b006ce6f994ec4mr7519186pfb.1.1702377908470; 
 Tue, 12 Dec 2023 02:45:08 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 it16-20020a056a00459000b006ce321a9523sm7780771pfb.49.2023.12.12.02.45.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 02:45:08 -0800 (PST)
Message-ID: <046e51f6-6f6b-4e09-8a0a-5cbfe339f309@linaro.org>
Date: Tue, 12 Dec 2023 11:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-20-philmd@linaro.org>
 <89f702e5-2991-4423-be9e-1630af6c5134@linaro.org>
 <8c88e598-019e-4275-9559-d86d99c655bb@linaro.org>
In-Reply-To: <8c88e598-019e-4275-9559-d86d99c655bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x433.google.com
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

On 12/12/23 11:15, Philippe Mathieu-Daudé wrote:
> On 12/12/23 00:29, Richard Henderson wrote:
>> On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
>>> First, "exec/user/abitypes.h" is missing the following
>>> includes (they are included by "cpu.h"):
>>>   - "exec/target_long.h"
>>>   - "exec/cpu-all.h"
>>>   - "exec/tswap.h"
>>> Second, it only requires the definitions from "cpu-param.h",
>>> not the huge "cpu.h".
>>>
>>> In order to avoid "cpu.h", pick the minimum required headers.
>>>
>>> Assert this user-specific header is only included from user
>>> emulation.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Why is cpu-all.h required?
> 
> include/exec/user/abitypes.h:85:12: error: implicit declaration of 
> function ‘tswapl’; did you mean ‘tswapal’? 
> [-Werror=implicit-function-declaration]
>     85 |     return tswapl(v);
>        |            ^~~~~~
>        |            tswapal
> 
> $ git grep -w tswapl include
> include/exec/cpu-all.h:40:#define tswapl(s) tswap32(s)
> include/exec/cpu-all.h:44:#define tswapl(s) tswap64(s)
> include/exec/user/abitypes.h:85:    return tswapl(v);
> 
> OK, I'll move tswapl() declarations to exec/user/abitypes.h.

Better, to a new header.


