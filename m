Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B98C47C81C7
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 11:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrEJG-00035D-Tv; Fri, 13 Oct 2023 05:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrEJC-00032m-0m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:18:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrEJ6-0006Bf-UE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 05:18:13 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so382188766b.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 02:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697188686; x=1697793486; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Pqby8K43OHvqpl430Fc1LwtNk25i4STB+Jq7cuumHbw=;
 b=prWnLC6O/CAOn0/Hosd6E6jHXXOmAWBAd9vsRslaknpvusTAfqDy0Q3Ldh2fCdl4b+
 ZdLJ6DGWgn4uMOr3zWaimAWwTYY4BJoBazt13yU/EMzqCwupln/a4sZ/f+BpTKjJ/iI2
 VFZYaB5WzDJStodYIJrIqUCyq5sGMyjAX9lGAxFanqPnbQZXtOVj19Oixr+3VgxrzOgi
 xbpUUKBhqiq0GotZaAcbGFpl/WNd2iQLInp7Gb47pAgZ3D0iSDmmJf2r8jyS7fMvS5VW
 ZBprZ+0MCtloxmwSl5YCqlKqlS9042n7njZ3R3INj2Nl6C0YuIH3kBHMbBtprFUdcygH
 HAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697188686; x=1697793486;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Pqby8K43OHvqpl430Fc1LwtNk25i4STB+Jq7cuumHbw=;
 b=Fg2kqGnx6kWv91NysKoQzDbAUYyFUlB11/56D0CFP5pFXdG7QMNrGtRdQotrboFZZz
 h1m+3XvmlIi23dH55AFxhBhoNgNBn7V5ItU3WAMs20NWYq636LwAVwwPW9PAP35c1Mty
 Kc/CNuVds6uc/Lf0s/VZkZoeEXti0+yCubquoyXbCruOLJatqRlm2uq8mG9qAx1qRIWI
 yPraiyNzTP7DPWgKfBvUtc6SmiOaa5DkTrYa5++yc8iKpYZl8FjHckz+BPCuQhmFfd6X
 n3TEQmW2NPRxHBYu/X3gs+0meJtZyzy8sBJfIOrtdZxDt7sMFweDPgPuPbEnAcOGt0S1
 K+Cw==
X-Gm-Message-State: AOJu0YyVM/2sVtDhRkRouGTU4lHbUKJ2gEGnVICdduPtUqRcavRXfJje
 4V6HNZk5wBlwWqkzr+nGYmoqhncsIeSce7Kguyw=
X-Google-Smtp-Source: AGHT+IGjAljAZ8Jsl9uDh+lT0pBfLMz2RJ91JcMt7zDTu1ivLbUBTTkAtl8ALAZRtuQOtzLJErejmQ==
X-Received: by 2002:a17:906:3097:b0:9b2:b30f:deb with SMTP id
 23-20020a170906309700b009b2b30f0debmr21222534ejv.4.1697188685970; 
 Fri, 13 Oct 2023 02:18:05 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 si5-20020a170906cec500b009875a6d28b0sm12137437ejb.51.2023.10.13.02.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 02:18:05 -0700 (PDT)
Message-ID: <8ba0812c-2691-4bf0-27cc-e4431ab22b29@linaro.org>
Date: Fri, 13 Oct 2023 11:18:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 05/18] target/hexagon: Declare QOM definitions in
 'cpu-qom.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231010092901.99189-1-philmd@linaro.org>
 <20231010092901.99189-6-philmd@linaro.org>
 <b3ecf0b1-95e6-47d6-b26f-017dbfd120f3@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b3ecf0b1-95e6-47d6-b26f-017dbfd120f3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 06:06, Richard Henderson wrote:
> On 10/10/23 02:28, Philippe Mathieu-Daudé wrote:
>> "target/foo/cpu.h" contains the target specific declarations.
>>
>> A heterogeneous setup need to access target agnostic declarations
>> (at least the QOM ones, to instantiate the objects).
>>
>> Our convention is to add such target agnostic QOM declarations in
>> the "target/foo/cpu-qom.h" header.
>>
>> Extract QOM definitions from "cpu.h" to "cpu-qom.h".
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/hexagon/cpu-qom.h | 35 +++++++++++++++++++++++++++++++++++
>>   target/hexagon/cpu.h     | 23 +----------------------
>>   2 files changed, 36 insertions(+), 22 deletions(-)
>>   create mode 100644 target/hexagon/cpu-qom.h


>> +OBJECT_DECLARE_CPU_TYPE(HexagonCPU, HexagonCPUClass, HEXAGON_CPU)
>> +
>> +typedef struct HexagonCPUClass {
>> +    CPUClass parent_class;
>> +
>> +    DeviceRealize parent_realize;
>> +    ResettablePhases parent_phases;
>> +} HexagonCPUClass;
> 
> I can't imagine the class structure being any more useful generically 
> than the object structure.  All we need at this point is the typedef, 
> provided by OBJECT_DECLARE_TYPE.

Right.

> I know this makes hexagon match others, but I think its the wrong 
> direction of cleanup.

I agree.


