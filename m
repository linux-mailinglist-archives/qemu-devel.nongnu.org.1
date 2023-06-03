Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E21772116A
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 19:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5VMP-0003tY-SV; Sat, 03 Jun 2023 13:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5VML-0003t6-I3
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:48:14 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5VMI-0007vU-US
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:48:13 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-256e1d87998so2741597a91.3
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 10:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685814489; x=1688406489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uPIU40JyBiMLhs/F+377fsQhyAV/joiOfzqUwyaS1i4=;
 b=i4xEurmfu5EQBRc7/uJb7+npaSpauf1y+QilBEOKUJWbVtrVUKCnb3paA3k9lMN2fK
 3ImBExnXpBq5FLpnKbEDxF02T1s2gY9fwsLwQjoJiVAazu2haD2G1KNZp6EVZ+thwB6r
 Yb+O+yPxY1qjKESU0X7x6A+1LPc6jBhZ099RDeGZUnYopdhwiHuJtg7uW0hbAZMMQa5C
 IcwWO+KQ+nnchdezxt+6HGkkzsT+9vB4OlixtnM2VpdLWryd6wBhqoXk1Afx7mnuX8g4
 Vafx95cZfHNBdnmT44uQokTpaufakdyBag1udjrU5dk+h/R469RF54JNZ0lhJP2XCyxE
 Bc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685814489; x=1688406489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uPIU40JyBiMLhs/F+377fsQhyAV/joiOfzqUwyaS1i4=;
 b=Zk57kuNp3lqkMS2pi7lqnlFTO4Arvh5zXSlH3cenzoMFKaNU7znDUtASlb/GZITRK2
 6iSDx78mXmiQroXUjBxEnVr1wmWar9I7eMkt5UtqhQrOUKKdAAwgZPkyJfr6Mux8bdCM
 Z/zG2ekD0JdE1rW6Nkv04xNjiYIbuvkvjnlLkVj/qZQH78QvadEstypHrweg1z30QA5b
 aQXtAT7A0Zje/V/EDsR8ffrhm9oKvjqeFBjOAHrhQx/BmWgtjF4RsLWmGvL6++u285co
 6iJep2HVfK8+3qnZTCOUIzc0544bFnK4yDvqHLTyq1/dGpzm/cyOS8W5D3aH+djQmsKH
 nj9Q==
X-Gm-Message-State: AC+VfDy8/nZg+XL3aUdNJzlQ47JQPt7qssYyDk0brHkb9ZjlUArH3nou
 qbAZGWDXKuKEA1HtG7uLAc08kA==
X-Google-Smtp-Source: ACHHUZ435/jocAoBIf26tqpr7ndqYk9gsj6+AzeZOFDhbS3J4Oy83SQU5VJejMmzHdO2J8zQ2Ytofw==
X-Received: by 2002:a17:902:f68a:b0:1a6:71b1:a0b9 with SMTP id
 l10-20020a170902f68a00b001a671b1a0b9mr4599788plg.47.1685814489022; 
 Sat, 03 Jun 2023 10:48:09 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 jh1-20020a170903328100b001a6cd1e4205sm3445280plb.279.2023.06.03.10.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 10:48:08 -0700 (PDT)
Message-ID: <9e7e7b8e-38c7-3dee-d881-05bcd306c309@linaro.org>
Date: Sat, 3 Jun 2023 10:48:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC v2] linux-user/riscv: Add syscall riscv_hwprobe
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Robbin Ehn <rehn@rivosinc.com>, qemu-devel@nongnu.org, laurent@vivier.eu, 
 qemu-riscv@nongnu.org
References: <f59f948fc42fdf0b250afd6dcd6f232013480d9c.camel@rivosinc.com>
 <20230602-86a3d8d9fad1fb3464d28702@orel>
 <995af08d-239a-f563-5da1-c2c245639d86@linaro.org>
 <20230603-c4d94ebf5c1a129e5cf3ebb4@orel>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230603-c4d94ebf5c1a129e5cf3ebb4@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/3/23 08:50, Andrew Jones wrote:
> On Fri, Jun 02, 2023 at 07:58:30PM -0700, Richard Henderson wrote:
>> On 6/2/23 07:02, Andrew Jones wrote:
>>>> +struct riscv_hwprobe {
>>>> +    int64_t  key;
>>>> +    uint64_t value;
>>>> +};
>>>
>>> The above is all uapi so Linux's arch/riscv/include/uapi/asm/hwprobe.h
>>> should be picked up on Linux header update. You'll need to modify the
>>> script, scripts/update-linux-headers.sh, to do that by adding a new
>>> riscv-specific block. Hacking this by importing the header file manually
>>> is fine for an RFC, but that should be a separate patch or part of the
>>> syscall define hack patch. And hack patches should be clearly tagged as
>>> "NOT FOR MERGE".
>>
>>
>> Not true.  linux-user/ never looks at linux-headers/.
> 
> Ah, thanks. I should have known better than to try and review a linux-user
> patch, since I know almost nothing about it! Is uapi like this usually
> duplicated, as was done in this patch?

Yes, because linux-headers is only for the "native" compiler, whereas linux-user requires 
the ABI of the guest.

If we were doing this all from scratch, we would mechanically parse and rewrite linux-headers.


r~

