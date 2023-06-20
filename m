Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65B736B20
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:38:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZgH-0001fw-G9; Tue, 20 Jun 2023 07:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZgE-0001fN-Fy
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:37:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBZgB-00031l-Oe
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:37:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-985b04c47c3so629951966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687261063; x=1689853063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlcyhHNvDrJNX9TUNb2y+2zQmpobE3soADxRX3PU0G8=;
 b=x7CfuvJ4XnBWvC3U0UYnbGtSgl13uWMZnrMwdhWRz0o38iXJ4kjOr7EEXfkBp01CPR
 VUYZzxpGMJI+2m/rhwlIPMaxeZLa7rXTs6fRaFFoqG8LGtmmJ/SnUjb1pEGdPbiybRwG
 22g4BnJN+qBay9wwINRoKAOtASXhumnxCND4CtZm9KlGihov8Tm+ZBOqr82aNEoA4+YX
 B2/hPr68LNCtNOADjzCEehGOHa7BZ5uZRPY7HEIZ4NpZUs367j1SLbopMnB09fgiIBVt
 TNHBGz5+8GSIEy87Mze5drZ5g2kWxMlOyFruK/5sB0UkwzfPtYjq6O+OKYMZX8by4q+2
 4aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687261063; x=1689853063;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlcyhHNvDrJNX9TUNb2y+2zQmpobE3soADxRX3PU0G8=;
 b=FduNBs0dYkYkcg/f9KrmmsU+0EJTQroy0RQiDcbmcnBGLI1ZTd5G1rnzdmBRAScXlG
 ZA98fciLWTXhc5ziyC1DXggkaUUZIGVlArr5+4C2xX2NAs6VKYrE4Fkjbzj5qWpBDXu7
 A1TzPQt5YJHV7QwSUtLeByDWpdIA/msmu6X2gc6xuWDiQrkcVc2hC1v13Mv56UmRT3Hi
 p095Ybl46SUlI8zMlrtVIce7AoaGS1RDNwvRhvyZeDVWjwcAbPi2w6CcXFP+6PBp8ucA
 dy2ecF+Xx7NHurjHs8Reg9kDoYyRsLhy7P0XHaYluPOoJggRkeRL/oHAZHgeoM4i3M0X
 /XGA==
X-Gm-Message-State: AC+VfDzpW6gbt5mg8nR1Jw/beSSgyZcUp08Lhu1RVUidrDrx+qU8meRs
 Y4PX5iXGyUhMBn9P3KCM8COqDg==
X-Google-Smtp-Source: ACHHUZ7lYYmtHCnwUIzQqPVZ6TCmFzsh+WuM+1oo48IKzw2xKDJs/s9MwZlSX9IZX6o33efMRz2h+g==
X-Received: by 2002:a17:907:26cb:b0:96f:e5af:ac5f with SMTP id
 bp11-20020a17090726cb00b0096fe5afac5fmr10606869ejc.47.1687261063328; 
 Tue, 20 Jun 2023 04:37:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a1709064a8900b00985767bb5f9sm1221958eju.70.2023.06.20.04.37.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 04:37:42 -0700 (PDT)
Message-ID: <5baebd7f-d023-1b8d-4638-3ddc2c5ef5e7@linaro.org>
Date: Tue, 20 Jun 2023 13:37:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 22/34] target/arm/tcg: Reduce 'helper-crypto.h.inc'
 inclusion
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230619154302.80350-1-philmd@linaro.org>
 <20230619155510.80991-1-philmd@linaro.org>
 <20230619155510.80991-10-philmd@linaro.org>
 <02f54fc1-0ceb-d905-85b6-81892345778f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <02f54fc1-0ceb-d905-85b6-81892345778f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 20/6/23 12:38, Richard Henderson wrote:
> On 6/19/23 17:54, Philippe Mathieu-Daudé wrote:
>> +++ b/target/arm/tcg/crypto_helper.c
>> @@ -12,12 +12,17 @@
>>   #include "qemu/osdep.h"
>>   #include "cpu.h"
>> -#include "exec/helper-proto.h"
>>   #include "tcg/tcg-gvec-desc.h"
>>   #include "crypto/aes.h"
>>   #include "crypto/sm4.h"
>>   #include "vec_internal.h"
>> +#define HELPER_H "tcg/helper-crypto.h.inc"
>> +#include "exec/helper-proto.h.inc"
>> +#include "exec/helper-gen.h.inc"
>> +#include "exec/helper-info.c.inc"
>> +#undef  HELPER_H
>> +
> 
> foo_helper.c does not require helper-gen.h.inc.

Right.

> Usually we put helper-info.c.inc into one of the translate*.c files; 
> probably translate-neon.c in this case.

Yes.


