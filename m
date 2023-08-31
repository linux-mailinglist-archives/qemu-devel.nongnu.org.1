Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F478EEF4
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:49:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbi1X-0004Xy-H1; Thu, 31 Aug 2023 09:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbi1R-0004PQ-0V
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:47:46 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbi1L-0004SS-JK
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:47:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4013454fa93so8358165e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693489631; x=1694094431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ylGHSm+VMkIhxBp03m5mU5AD9oDrynueHV9319MFZyY=;
 b=sLIm/KH1cYrfjX+prPCBnRdCY42XuBLC+YYuNojx+ZDRaMgm6YNcJe28BOcPpvi4bp
 YHbLjnvgwV0h7Wdj8+NZa4UPxK7K1OaP/VZq22JppB9WL7gUjt+mePNpMRi6MQ/GSpOQ
 +qaxpJ3lw5EP1yZ9ltB5xH07QVY2lvdE9iFx9J8LtlnZvI/bOh/LINCejij2LlaFyfWi
 iAed7RRg84igqqtQXiktnpayEy04rwFQ9WLjDGNP3OaI5Hu81scm/r1nYDqpjnrYTrox
 Zy/1i2KQp+1U3gnccR3WWeSZt6DxxE5UI0muy9vRyFqoszNLF0FU91+viy7KvRmOxjut
 YG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693489631; x=1694094431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylGHSm+VMkIhxBp03m5mU5AD9oDrynueHV9319MFZyY=;
 b=gB+YY9u7L1fMS0mo9AB6+4zcEg+20dte9r3JwD3hNoZnN7AmSuv0DBCdKepMZtxwHQ
 27CZvg7uExv/hqBsrtHC+MulUe26Ozm4MJ0C3EKKrHmaa+kRaO/0XnCETSUFxvRcFo/v
 5aVCCoiSLOIUUv41NM/Pmn7P4/k1K+UdHkSxG1R0BvEMbtA8L53FA3KwKDNxNWfzcRpa
 6I4q6I5ZePpKqCv1dSkspclK+H8/tmUD5H4znlZn5KdUKYmL6Suhdl7n55dhX7XAwkkO
 ax9TYkMSEWmJ1YbpgLjBFJh7/nYjwxovUSMEA4ANTda1EeGRaEAJGip/jdXya12FunhD
 hw9g==
X-Gm-Message-State: AOJu0Yza2x6O0LMMbCndWO/HSqpK8oYGSityGZwTVkitMeyhfQOPi5gk
 OdRcUE8taPT+J3XvprgbIEJNpw==
X-Google-Smtp-Source: AGHT+IGdoder4ZlJC+IifXogfFvPfpzmxjzlbTpzg83AS+KgkLBRDy7zD54tLVo7gSCElJCSs6aAYw==
X-Received: by 2002:a7b:cb98:0:b0:3f8:fc2a:c7eb with SMTP id
 m24-20020a7bcb98000000b003f8fc2ac7ebmr3921584wmi.5.1693489630688; 
 Thu, 31 Aug 2023 06:47:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a1c6a17000000b003fc01189b0dsm1978739wmc.42.2023.08.31.06.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 06:47:10 -0700 (PDT)
Message-ID: <cc5480f2-f37b-c011-e291-597b8cb2e2f9@linaro.org>
Date: Thu, 31 Aug 2023 15:47:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PULL 39/41] meson: Fix MESONINTROSPECT parsing
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20230831125646.67855-1-philmd@linaro.org>
 <20230831125646.67855-40-philmd@linaro.org>
 <cc0e09e8-8ffc-741f-1ac9-5cebe312b684@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cc0e09e8-8ffc-741f-1ac9-5cebe312b684@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/8/23 15:06, Michael Tokarev wrote:
> 31.08.2023 15:56, Philippe Mathieu-Daudé wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> The arguments in MESONINTROSPECT are quoted with shlex.quote() so it
>> must be parsed with shlex.split().
>>
>> Fixes: cf60ccc330 ("cutils: Introduce bundle mechanism")
>> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
>> Tested-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-ID: <20230812061540.5398-1-akihiko.odaki@daynix.com>
>> ---
>>   scripts/symlink-install-tree.py | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/symlink-install-tree.py 
>> b/scripts/symlink-install-tree.py
>> index 8ed97e3c94..b72563895c 100644
>> --- a/scripts/symlink-install-tree.py
>> +++ b/scripts/symlink-install-tree.py
>> @@ -4,6 +4,7 @@
>>   import errno
>>   import json
>>   import os
>> +import shlex
>>   import subprocess
>>   import sys
>> @@ -14,7 +15,7 @@ def destdir_join(d1: str, d2: str) -> str:
>>       return str(PurePath(d1, *PurePath(d2).parts[1:]))
>>   introspect = os.environ.get('MESONINTROSPECT')
>> -out = subprocess.run([*introspect.split(' '), '--installed'],
>> +out = subprocess.run([*shlex.split(introspect), '--installed'],
>>                        stdout=subprocess.PIPE, check=True).stdout
> 
> This turned out to be wrong on windows.

Doh, thanks for reporting, I haven't noticed on the list.

I'll repost without this patch.

Regards,

Phil.



