Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466757A0B66
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:18:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgpyp-00022h-Hz; Thu, 14 Sep 2023 13:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgpyn-00022R-MA
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:18:13 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgpym-0001Q4-1m
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:18:13 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ada2e6e75fso168521066b.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694711890; x=1695316690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=owZbP7MsSmlYDdT3ZIi5snsWRVzy5b9I3UrCQ8r0uA8=;
 b=xWGcKcNqP2cnjNCKRocBgLttBVWXTMGDA2xRfCJmP895pQodtkEduEQFlt/hAMr47H
 xAxHvibnx4MyNLqiH/BKmoDWx/L/1j8GqEaSOhQMu76tGlu+6bZXuIRX+pWeFofy3Ev5
 x2895i2YUvxD7eo4OcRsg0Dt3lkPU1yu/FTUj9x3ukf5BjSxdmXQ0i5OOTs1GPwMjI15
 90W3Up3ZDhzVKaYOVOVnVOn4IjZudol8hni5ny7h8HCHDGrV4R9sLhjyUfbtLSmgoQGb
 ArhXxPCSShkRg2Uad6stIbJeh5DEAWp501OMN/t3QBLq3Hs1wEfAYxgx8PPY2L+rSNMt
 ZEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694711890; x=1695316690;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=owZbP7MsSmlYDdT3ZIi5snsWRVzy5b9I3UrCQ8r0uA8=;
 b=mBtqY1Fe7351BWEBLxhD5CBX0JeBIGPfdYGPRgr3nqO5VkefzyfZYj7kIGPU2y4qU2
 PW8IF67is5DSpAkqcpWzTBYkASnxwyGmIrEnk6VbPFrHI3//HStn4l7YgXIYLcCxGbWD
 GQPuipTVZ8FEFUZaiKYvTMQCuCP+l4oqkmkv4yul5P7wPxdRVvbb6HuVPbX2lS+E7tBf
 S+UUSebRe4gvzLKODv+5iVjdTwCVe9aNncEcNH1oKgFoGSikEA9b4JDtWsu/vp1fibF8
 lTTVT/vLL7bWJ+t/OOompFHA9zbUGIuCkJ/W6DOupbQaTu+hb6NGlzrf/3wJdswkJ8mS
 ERJA==
X-Gm-Message-State: AOJu0YwH5s1F6PoQuPbiwmcLFSY6agxk6ZfTAUuPLopvO5mbUqK67OG/
 JeIyPjxPjxCRj4NqGodHykBK3Q==
X-Google-Smtp-Source: AGHT+IGoARNGjBa3fQmmpZHvd1d5tofIZ8dH6qaRtHFT6SgZ3xNpspXIgS5x1MHx9Z5WAANoHxH3qw==
X-Received: by 2002:a17:907:784e:b0:9aa:1200:f74e with SMTP id
 lb14-20020a170907784e00b009aa1200f74emr4459743ejc.54.1694711890085; 
 Thu, 14 Sep 2023 10:18:10 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 u11-20020a170906068b00b00991faf3810esm1272924ejb.146.2023.09.14.10.18.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 10:18:09 -0700 (PDT)
Message-ID: <b4976774-5cde-84a4-889a-17b7028554a9@linaro.org>
Date: Thu, 14 Sep 2023 19:18:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 00/12] gdbstub and TCG plugin improvements
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
 <877cossq8y.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <877cossq8y.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 14/9/23 17:56, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> This series extracts fixes and refactorings that can be applied
>> independently from "[PATCH RESEND v5 00/26] plugins: Allow to read
>> registers" as suggested by Nicholas Piggin.
>>
>> Patch "target/ppc: Remove references to gdb_has_xml" is also updated to
>> remove some dead code I missed earlier and thus the Reviewed-by tag is
>> dropped.
> 
> Queued to gdbstub/next, thanks.

I left a comment in patch #3:
https://lore.kernel.org/qemu-devel/bf33447c-119f-c4b9-5f80-d4ad6169c708@linaro.org/

If you agree with the comment I can send a patch to replace so
you can keep this series queued.

Regards,

Phil.

