Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD8B80E8E2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:16:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzo4-0005LR-Sy; Tue, 12 Dec 2023 05:16:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCzo1-0005LC-1M
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:16:03 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCznv-0006tE-AO
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:16:00 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50bfa7f7093so7058836e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702376153; x=1702980953; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JpqawiimJ1RcqLNTZAYe2xSYTH4KKMo1c7aAiZ0pEZ8=;
 b=zwZX93Ch12Cd2C0jxqC/jzcu5/kBUY/bPMMODpcV8Z78uAWymLXe5GqGMHgx4Qevhx
 zbcPZOq0y4bfibuQBUvYXTGJaGhT9AzOjh1LqG/gc6FWs2MUDw8kGDiOisrXioMrjvez
 pRRNkYNz2WqxbuYxqZV5U1f32C/ssMMSfQJ0LiurMSqcenR+nPu6ecXtlK2UCbR4pTeB
 Q1XZ4T9VYYmbG41+Z6DxKgislTRMpFDO26cLflqJG3Qo0fRPuLpW4KDVviJ5zM13PrVw
 fNGcH+nheu3kzYaZjZ+k6uBYC9Qk/uahEpcx5K93CBzMG8Dmn6w0B8Vx1bBZPOdojLOh
 7Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702376153; x=1702980953;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JpqawiimJ1RcqLNTZAYe2xSYTH4KKMo1c7aAiZ0pEZ8=;
 b=vyRAPUz6I0VMP9or2VyZjbIXacnK9A1Y7R4mKnfvpUvB0QAZ1x5GzG7C7l4l665+ox
 N9UX4ERS7HqG3wpjXPuogaiGLCSuEDGGSSbNAFPLcNSmG5E0Wl1pCClLKcR1r5yIFuim
 YbPj3q1OavdKOOMfENdRTCQa4cjPipOQXr0ftf49+DqyM2ln6bR2aBnSarUehV61PeIS
 G/kqdmkSLXYWVTK4SNAN6qx9cr0rmAdGMdx/UoEvGEON4JRrQr2vhx/z6IsrkI7wvnAs
 IlsPJ56no5BR3vhvJt9ZRuyVFUtoKU7CuXFksk4URalS8Id04O629LovvkS38HzJCYfI
 XL6Q==
X-Gm-Message-State: AOJu0YyTZ1Lek5MYQOLFpajaIXyoni5bnv39GghWUHeHNSgfhrYDSb6B
 p8L+SjnMS9aUvdxNBaDAVfl+jGGeFreLWuSR2MWvOw==
X-Google-Smtp-Source: AGHT+IFpJ9IdSLYM2bm/zYkgjbV63P4sD0vHfSTKoK0O0s/uzWrUvq5TNaQJZy/IeMYth4kutlz6tg==
X-Received: by 2002:a05:6512:3e0a:b0:50b:f0f7:2c43 with SMTP id
 i10-20020a0565123e0a00b0050bf0f72c43mr3676899lfv.4.1702376153283; 
 Tue, 12 Dec 2023 02:15:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 e10-20020adffd0a000000b003334675634bsm10487939wrr.29.2023.12.12.02.15.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 02:15:52 -0800 (PST)
Message-ID: <8c88e598-019e-4275-9559-d86d99c655bb@linaro.org>
Date: Tue, 12 Dec 2023 11:15:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] exec/user: Do not include 'cpu.h' in 'abitypes.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-20-philmd@linaro.org>
 <89f702e5-2991-4423-be9e-1630af6c5134@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <89f702e5-2991-4423-be9e-1630af6c5134@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
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

On 12/12/23 00:29, Richard Henderson wrote:
> On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
>> First, "exec/user/abitypes.h" is missing the following
>> includes (they are included by "cpu.h"):
>>   - "exec/target_long.h"
>>   - "exec/cpu-all.h"
>>   - "exec/tswap.h"
>> Second, it only requires the definitions from "cpu-param.h",
>> not the huge "cpu.h".
>>
>> In order to avoid "cpu.h", pick the minimum required headers.
>>
>> Assert this user-specific header is only included from user
>> emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Why is cpu-all.h required?

include/exec/user/abitypes.h:85:12: error: implicit declaration of 
function ‘tswapl’; did you mean ‘tswapal’? 
[-Werror=implicit-function-declaration]
    85 |     return tswapl(v);
       |            ^~~~~~
       |            tswapal

$ git grep -w tswapl include
include/exec/cpu-all.h:40:#define tswapl(s) tswap32(s)
include/exec/cpu-all.h:44:#define tswapl(s) tswap64(s)
include/exec/user/abitypes.h:85:    return tswapl(v);

OK, I'll move tswapl() declarations to exec/user/abitypes.h.

