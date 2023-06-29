Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FE57426D0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErEq-0003GK-HD; Thu, 29 Jun 2023 08:59:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErEp-0003GB-1w
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:59:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qErEn-0000L9-Dy
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:59:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fa8ce2307dso8232155e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 05:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688043543; x=1690635543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KlZbAFopa+j9KDopCXGXvNCrxxYE6RiV+LyZJ7viX68=;
 b=Fmo/RFZLUhhh251XLhM3ibxX/nY6M2ntleTqsMaMiLPOYAQzjjhLgOBxBZoLJUCLbn
 Millcn/mtMmcUmc+ynKdYAOv85xqcU8P+KuzPa/6H3QWnZ70VxNgLgDWlyY5yY5GBt30
 qWParOnD6WNDfLjEj10YNXdrMCBP8MeCYpme51QH3mZRM8KNp84c7adTBf0AgCpw3K/3
 aHTcl4qzqr8++h5+H1fUQ6oX+Qu1kd6zDBOX1GaYGFTMNTFAoBLd/LH4/2j5RLv1F7yh
 /aB+xwWwE+lxVbZiNR6g43lid5gjmEJKoHGb66LiCQmeXoaB+OtiX6hezEEv2Yn720TW
 fEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688043543; x=1690635543;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KlZbAFopa+j9KDopCXGXvNCrxxYE6RiV+LyZJ7viX68=;
 b=bG6Ipd/QXYsOvOWpdZXy1t1/mkI8vcOW6o6pCzar+hHGq/1MzKZMwaXdlZeT5E326e
 M/t3SMXzJE6PJ/GVpOuuHOJwD3lw7DG+bfxuHT95Pef7YqqsIBWna8PIB96kRvUuYf1b
 8C6uf/zzNL7ODlKh9Z2EkPepvP0XZVMtvS9JQ/FaJfWcRvYbfsygwPkk3bS7HesseY68
 RwAt9QyU2J0hNMzpLFoorrYE1fLkh/1axf858ZiOLp+cP4Jh3vM00OM46sm9KVYmH1kA
 recwzgXKVOP0QHEoi1TRdB74izYfk8zeN45iQlJYBPsZW05iovftYLKsF24mE1n9LquF
 kiJQ==
X-Gm-Message-State: AC+VfDzxxRdpNm88xUFDGxwXjP3fivygDFltcFvR0Pjtxd19OkDzG3QH
 79ipEcbl537XSSQvfgbff1wM0w==
X-Google-Smtp-Source: ACHHUZ57RhXNFpd445dgAzTyz38CfwAJ9thr0DapT6ay6TX1e1AhU5hUFDFKl3UOUgmKyAhxU5X37Q==
X-Received: by 2002:a7b:cb97:0:b0:3fb:bc6d:41f7 with SMTP id
 m23-20020a7bcb97000000b003fbbc6d41f7mr1669978wmi.27.1688043543091; 
 Thu, 29 Jun 2023 05:59:03 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a7bc4ce000000b003fbaf9abf2fsm4787561wmk.23.2023.06.29.05.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 05:59:02 -0700 (PDT)
Message-ID: <e122d115-0d0f-59d2-b593-2210ca1118df@linaro.org>
Date: Thu, 29 Jun 2023 14:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 3/5] tcg: add perfmap and jitdump
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 "Vanderson M . do Rosario" <vandersonmr2@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230116223637.3512814-1-richard.henderson@linaro.org>
 <20230116223637.3512814-4-richard.henderson@linaro.org>
 <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <e1112615-0e6c-e0ea-aa60-1d94d1da26ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/29/23 13:31, Philippe Mathieu-Daudé wrote:
>> diff --git a/tcg/tcg.c b/tcg/tcg.c
>> index da91779890..9b7df71e7a 100644
>> --- a/tcg/tcg.c
>> +++ b/tcg/tcg.c
>> @@ -61,6 +61,7 @@
>>   #include "exec/log.h"
>>   #include "tcg/tcg-ldst.h"
>>   #include "tcg-internal.h"
>> +#include "accel/tcg/perf.h"
> 
> Is it OK to include an header from QEMU's accel/tcg/ here?
> I thought we wanted to keep tcg/ kinda independant (or maybe
> this is already too late and this isn't a concern anymore).

It's not ideal, no.  Perf really should live in tcg/.


r~

