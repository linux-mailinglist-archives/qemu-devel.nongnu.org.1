Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A94AA79D150
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:45:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2l7-0002w9-2x; Tue, 12 Sep 2023 08:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg2kq-0002qE-4O
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:44:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg2km-0000EV-QJ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:44:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99357737980so695155266b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694522667; x=1695127467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bacZ1tfzNsWsQvHZfCR/sOc1FErmJbppB6WFLqVEIBA=;
 b=OLGDOOX6fqXarjnTcUom73fbPLxb50Lf6ZGfd4xlXDXH3I79rMaaMBi0MjqtmUThg7
 kx8szxZ+pXl31661PVvkX9rlF+2jgsUnPbwH5zWlaLbUwZUHOO6XRPwxmEHC8vxShFay
 M3VRgcvpnxGXHcH4ajj+asNj+/4ZyoSngS91FFC1ZoVRy1+cQD0g4Aj0VnuGPFx2a9eZ
 zZflT5E5XWLIghTpE1K2zkB0hyA65QC5Y65S8w6NwkPrALrVRBc6/Z1ak2vE9dWsL+eM
 oqgP6/vYq9swJXxHWdO9joJL00uVztY/Ck8y/LfamnK4H7V8A4yYK+FrqZuy05uxGMOD
 PgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694522667; x=1695127467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bacZ1tfzNsWsQvHZfCR/sOc1FErmJbppB6WFLqVEIBA=;
 b=Cb2YHS2YdHTGUHVL0DZFYYSl3OMtAi9K+teICVgTEeVdy3HI1byldxMbNBRHpBVcj1
 qIvD9id6LDrcHmqwcW0iwVKRnkp5lqCbXuRge3HlFeP26+4IBJC6GYEURMv9b7zDmd7Q
 gjCjVCPID3cLPn2rXnLKvGh87Q5vipfllMPDuxZufpYegIidPCX8LffPUXURbAwaFBVE
 clukUB1qTXMFcFan+iX8ZPYD2Va/+b6QGivnDNQH4119mGdVgO2rbb/H7Jv8b1C/U8pP
 1WfMoVjLxWDLLAu1tz+ycEHVapKu45uEm+LPc0nvazwf/0SximOOxmEVtvikYV2WXDD6
 cSkw==
X-Gm-Message-State: AOJu0Yx3K5Zr6KdkXO1mrwi9WwZdWyHsGz8rNgn1q8s3QizhdvdtvTgv
 gPQFGZDyI05TKQRflUYwJY3FcA==
X-Google-Smtp-Source: AGHT+IGzhDiawzKLYqVl6CtibhX95DR55HpftyVT2AEpC+6ebW85/pSFdf7oAPt7n4PrKJOb+cLSvg==
X-Received: by 2002:a17:906:1041:b0:9ad:8d45:6883 with SMTP id
 j1-20020a170906104100b009ad8d456883mr1001460ejj.76.1694522667033; 
 Tue, 12 Sep 2023 05:44:27 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 q26-20020a17090676da00b009ad8338aafasm1058723ejn.13.2023.09.12.05.44.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 05:44:26 -0700 (PDT)
Message-ID: <df59a661-b05e-f947-7ac9-1f738c6cdf97@linaro.org>
Date: Tue, 12 Sep 2023 14:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] sysemu/kvm: Restrict kvmppc_get_radix_page_info() to
 ppc targets
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Greg Kurz <groug@kaod.org>
References: <20230912113027.63941-1-philmd@linaro.org>
 <20230912113027.63941-2-philmd@linaro.org>
 <b49e350d-089d-62f7-3e5b-dcc885547912@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b49e350d-089d-62f7-3e5b-dcc885547912@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 12/9/23 14:32, Michael Tokarev wrote:
> 12.09.2023 14:30, Philippe Mathieu-Daudé:
>> kvm_get_radix_page_info() is only defined for ppc targets (in
>> target/ppc/kvm.c). The declaration is not useful in other targets.
>> Rename using the 'kvmppc_' prefix following other declarations
>> from target/ppc/kvm_ppc.h.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/sysemu/kvm.h | 1 -
>>   target/ppc/kvm_ppc.h | 2 ++
>>   target/ppc/kvm.c     | 4 ++--
>>   3 files changed, 4 insertions(+), 3 deletions(-)


> I wonder, if it's defined and used in target/ppc/kvm.c only,
> why it needs to be in an .h file to begin with, instead of being static?

Good point, I didn't noticed.
It is this way since it's introduction in commit c64abd1f9c
("spapr: Add ibm,processor-radix-AP-encodings to the device tree").

I'll respin after waiting for more review, thanks!

Phil.

