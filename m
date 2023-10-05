Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4D47BA618
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 18:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoRAi-000513-JL; Thu, 05 Oct 2023 12:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRAX-0004vV-Nz
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:25:46 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qoRAU-0006a1-Be
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 12:25:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-406650da82bso10637715e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696523139; x=1697127939; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GJ4i6z35Mi4NPJSb2KYdHQ+lWjyrv5iZFTRxW48L8E8=;
 b=bgYQBcvH9hK1fdD+7XwqjP0YgRnTJZtd6Gzma+OOw1bHYJKV4r8llWGfI5Py1fQ+eX
 hzKa2u5sFgg/9ILNL978ZKa7t8d3XLW20TL5ZEufBueCH3rJd+r8Yb3/jM2OEJWlcKLR
 LNiyAc/fWGKKWMME2V5qq9nNIND93YTEN6V1X5F3RIqu+znLzQ62vffIadLjx2TqtmA7
 d0ypFhpS8Mph2of4qBhsWf6HwSdyDprXHFK8+nRWbhdEn6zD0mmCHG2grjpqpHAIC6ra
 cZnZucHzxQXd+avSg/GQeaITUw/aSbOQirnd6xWuEoB0vLAolu/cgDiwLHjhrEICacKk
 El2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696523139; x=1697127939;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GJ4i6z35Mi4NPJSb2KYdHQ+lWjyrv5iZFTRxW48L8E8=;
 b=vEiGvEjoaEzuedxVfJNgR56JI/RDXEzSGsR4gJe9CpwMQalOP+Pukn4eRavFh+9eOi
 pHJxGVHBHep+1u3MothamRh/sMLc+IwrfpqLS4XigeNvVEUYcbMrWFsnShli5emnlgH7
 WU6MATJtYohc3WsuczYvVgKsLSi0nBvUF7MtNpo0OO5J1yoRm3B5MdmW1fuqJQ3TNypY
 r+Mb4wmvcKHmx9/if4/ErYo/8BahRjv1gBC9drm4ypX+s72wGlcJNXm/7ncaYARMTi7+
 nxlBf2Th8xG3mbw+TnhDpwYcJX8Foy51QUK3APjCnvLFIDEPDvEGLPK9WnBlK8z37oVF
 QSTw==
X-Gm-Message-State: AOJu0YwLxFyBfRRkb1ynRjwa0mLkMxzs3k8xBVyLku/EGiqcx96852hs
 Jm86E2cM0O8jB1Q7KBV0hievVw==
X-Google-Smtp-Source: AGHT+IFx3lNTdvniE7zqMoV8hoysHv/1DeH5TvK1UV99o+u5mnEFp9KUjZWzwKkidIi8jX8Ki/oMbA==
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id
 x23-20020a1c7c17000000b003fe0ba7f200mr5944017wmc.20.1696523139646; 
 Thu, 05 Oct 2023 09:25:39 -0700 (PDT)
Received: from [192.168.69.115]
 (tbo33-h01-176-171-211-120.dsl.sta.abo.bbox.fr. [176.171.211.120])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b00405391f485fsm1835875wmj.41.2023.10.05.09.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 09:25:39 -0700 (PDT)
Message-ID: <5fcd653e-a5ee-950f-767c-81325a02feda@linaro.org>
Date: Thu, 5 Oct 2023 18:25:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 08/19] linux-user: Add gen-vdso tool
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230930021529.987950-1-richard.henderson@linaro.org>
 <20230930021529.987950-9-richard.henderson@linaro.org>
 <0afc2728-882a-6f4b-d343-2ce126745034@linaro.org>
 <ad44a134-75c8-2ba0-e890-b6b89f2f0b04@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ad44a134-75c8-2ba0-e890-b6b89f2f0b04@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.219,
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

On 4/10/23 01:05, Richard Henderson wrote:
> On 10/3/23 06:00, Philippe Mathieu-Daudé wrote:
>> On 30/9/23 04:15, Richard Henderson wrote:
>>> This tool will be used for post-processing the linked vdso image,
>>> turning it into something that is easy to include into elfload.c.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   linux-user/gen-vdso.c          | 223 ++++++++++++++++++++++++
>>>   linux-user/gen-vdso-elfn.c.inc | 307 +++++++++++++++++++++++++++++++++
>>>   linux-user/meson.build         |   6 +-
>>>   3 files changed, 535 insertions(+), 1 deletion(-)
>>>   create mode 100644 linux-user/gen-vdso.c
>>>   create mode 100644 linux-user/gen-vdso-elfn.c.inc
>>
>>
>>> +static void output_reloc(FILE *outf, void *buf, void *loc)
>>> +{
>>> +    fprintf(outf, "    0x%08lx,\n", (unsigned long)(loc - buf));
>>
>> uintptr_t? Otherwise nice!
> 
> uintptr_t would require more complex printf.
> 
> Actually, I should just use %tx for the ptrdiff_t one gets from pointer 
> subtraction.

Right, this is the type I was thinking of.


