Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9B280EBB0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:25:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1oX-00011K-VK; Tue, 12 Dec 2023 07:24:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1oR-0000wP-Nu
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:24:35 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD1oO-0003XR-UD
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:24:35 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a1f47f91fc0so660815866b.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702383871; x=1702988671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lc0kMqhhyTL0/ED+GsijVzAfaP8VzTIUwqo3zggCI8k=;
 b=KTRzUdwBH2151SVzUUJF559pQtJGhM9l6DFhEsxVxzgUaRCHZV61qId+rLjygN+Vnm
 ftHFfVuTxAFOX545/JCcmNAr+jiQndphUmWhZ2AYmFPsL3k84dIkmqPP7u+ZBCJMbvZm
 YqoAuBfIPiqJbTGO5mjQAYcyFmXbT22hX9HC0L/esf5n9wfw/2ueJvOJnWBSnx7lqdog
 drr9dkNqIe0Am9rcHCjwlpdRR9c0G5yq3dcmcv1u9/e6kEyGXcGmnV4DSb1Byzodh1l/
 P5gpwHTU+XeqtBJHbLE6TM1SnBe5++u2BTqAw+cDT08blyAyNtAOjJJ4j3q0jt1GaKsS
 wt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702383871; x=1702988671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lc0kMqhhyTL0/ED+GsijVzAfaP8VzTIUwqo3zggCI8k=;
 b=YXQbiyffsniPFaBJBoceJ3O69M6qBTpn+NZEEbJ3DBI2YmA0eWj9JIqONm0eKaeHXZ
 5Kxl7ms5YDox1f4SWcj8RqwkLjN4yXqVEBHkfAGNenBYi8hU6C2Wf7bMDWXaWV+NgdGV
 m/TthLiv9INnr63YBf1TmfN5n13wsAsl/6v9c8EJY/IfliP3p1gJwbFUfaSu3XzYZ0wq
 Iwt5qf46eDh7fPOg0IhdPStFJ1kbcP8yPndz+keL6Ki/t/5XjdswzynmUISeY46eHYX2
 U198SjFKQNbBp84S828avLNGphIwyvf/sGcfa+PAmOqp0N+d+hB+nbzQrJ3sqh9XQdLG
 GleQ==
X-Gm-Message-State: AOJu0YyE/qR0WE/RcZ2ZH7WZdCxFDZsaFNvjPiHAwGUNtTndeTARpltn
 Z4zyLZ85nBdMRiLezHyT0Tejyg==
X-Google-Smtp-Source: AGHT+IGOoeb7O8ekBg4UDFmGttrgQBh/uwJUUJ8aZVHDuCegDl1qawbyQj0ZFGDfX6+1yvx0B1N+dA==
X-Received: by 2002:a17:906:c14e:b0:a19:a19b:5603 with SMTP id
 dp14-20020a170906c14e00b00a19a19b5603mr3779457ejc.147.1702383871197; 
 Tue, 12 Dec 2023 04:24:31 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 sa16-20020a1709076d1000b00a1da72b8752sm6171897ejc.212.2023.12.12.04.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 04:24:30 -0800 (PST)
Message-ID: <3e62416d-c014-403f-ad51-8fd109821dac@linaro.org>
Date: Tue, 12 Dec 2023 13:24:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] exec/cpu-all: Remove unused headers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-16-philmd@linaro.org>
 <488571cb-7770-4183-a760-ae4bd6549531@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <488571cb-7770-4183-a760-ae4bd6549531@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/12/23 00:16, Richard Henderson wrote:
> On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
>> Nothing is required from the "qemu/thread.h" and
>> "hw/core/cpu.h" headers.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/exec/cpu-all.h | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
>> index 9a7b5737d3..b1e293a08f 100644
>> --- a/include/exec/cpu-all.h
>> +++ b/include/exec/cpu-all.h
>> @@ -22,8 +22,6 @@
>>   #include "exec/cpu-common.h"
>>   #include "exec/memory.h"
>>   #include "exec/tswap.h"
>> -#include "qemu/thread.h"
>> -#include "hw/core/cpu.h"
> 
> While thread.h is fine, I'm not sure removing hw/core/cpu.h from 
> cpu-all.h is a good idea, and would explain the rather surprising 
> changes to add core/cpu.h to other files.

"hw/core/cpu.h" defines the CPUState structure. Any code that
deref CPUState needs to include its definition from "hw/core/cpu.h".

Similarly, files that don't deref CPUState/CPUClass/cpu_foo methods
shouldn't be polluted by its declarations.

This series focuses on useremu, next comes sysemu and "exec/cpu-all.h"
is split. I'll see if I can postpone this change.

