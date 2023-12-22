Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188C181C3A4
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 04:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGWVO-0004cu-Ax; Thu, 21 Dec 2023 22:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1rGWVK-0004cN-0l
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:47:18 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aik@ozlabs.ru>) id 1rGWVH-0000RR-QV
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 22:47:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d3eb299e2eso10273725ad.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 19:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20230601.gappssmtp.com; s=20230601; t=1703216833; x=1703821633;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FKXNCaPjPdX5YP2cT4EUHkNi6hUdJgX44eDFRq/dedE=;
 b=Cv8jB1AWZrYOujBTHRodJb9VE71GvbCHahy49zcvY5CBGoW7b874S8kft+s67Q9gh7
 9/PEvcWayICm9Mjd7loPQbyTgkh+focciE1nWrsclDBLOQSHTCzi8QMzqs0B6Uy8RhTw
 5GREzhNC/bJpl74fTQzlqnrE3XqNnsvnczjGFkvuTEqvlVykkYtJVNw/l1yuemd0v7T/
 kocJVrI4IQIozCOiHjroc/LRR0k1hNmeKKSN/nrzBWbh2H5VXxzVV+0IEL40f40ImMxJ
 fn8kRRZ6yxnnl+SNGOwJWteKiP+eN32sAF8sERbsSFKuuuWPbTHOM13VR2du7k0QT+xU
 GZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703216833; x=1703821633;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKXNCaPjPdX5YP2cT4EUHkNi6hUdJgX44eDFRq/dedE=;
 b=GN47+mgncD455SJC5bTQoad6EY3vZv/m8XuzWEvZ/h44FFYxyWmR2MLYaDHk3fNK4I
 WB7ovh+2tjHgD39z8wFLxVuY1GIIriPWNC1CqFyt7AFr2EW+HpTippAfeY7/pcUWXxbx
 qcWSV+Gils8NUeR1EWQXcSoVpVe93ECVVcdnUZSUD87wN8BrQl8uatLVBNEyuOxxHIoY
 HPyQOsghnx5zq/iGgf4oaSXL+6FX8skxLqoAlX1U+yT+xp5FsL5BAJxGPn2kBe5Xw+Um
 qQMmbCPuIl5mBM6UNJTpGs8PdhOjMAWM1gradZyjnANmrnNf+gNjEDxPzzwy4D60AsOQ
 PLww==
X-Gm-Message-State: AOJu0YxnE53mI4vPK/5fkbUz9v7GU7dZrOKgUErLSK/rnjLNBditnQQP
 VE8P4ZCnCGSYwwijkf/Dy52cec8Y59Kqyw==
X-Google-Smtp-Source: AGHT+IHrnM1dP4rVtVw5+6wy6AZCeTGgQqVkwKjfB73ZQR5NIQ7vOx+fNKkr1E3HPx9yHGq0esF+HA==
X-Received: by 2002:a17:902:a3c8:b0:1d3:ef94:7dae with SMTP id
 q8-20020a170902a3c800b001d3ef947daemr510620plb.111.1703216832944; 
 Thu, 21 Dec 2023 19:47:12 -0800 (PST)
Received: from [192.168.10.153] (124-148-126-166.dyn.iinet.net.au.
 [124.148.126.166]) by smtp.gmail.com with ESMTPSA id
 b14-20020a170902d50e00b001d3dacffde3sm2373934plg.226.2023.12.21.19.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 19:47:12 -0800 (PST)
Message-ID: <5c32ffdd-b7d8-44b7-a9d4-363f47660626@ozlabs.ru>
Date: Fri, 22 Dec 2023 14:47:06 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] ppc/spapr: Fix ubsan warning with unaligned pointer access
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Hoffman <dhoff749@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 "open list:Virtual Open Firm..." <qemu-ppc@nongnu.org>
References: <20231217001441.146344-1-dhoff749@gmail.com>
 <1c5f886a-821e-46ff-bcea-045b07ebf809@linaro.org>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <1c5f886a-821e-46ff-bcea-045b07ebf809@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=aik@ozlabs.ru; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 20/12/2023 12:45, Richard Henderson wrote:
> On 12/16/23 16:14, Daniel Hoffman wrote:
>> Found while running QTest with UBsan. Unaligned pointers appear to be
>> valid, so moving the read to an explicit memcpy to an intermediate.
>> ---
>>   hw/ppc/vof.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
>> index e3b430a81f4..609a51c645d 100644
>> --- a/hw/ppc/vof.c
>> +++ b/hw/ppc/vof.c
>> @@ -646,7 +646,10 @@ static void vof_dt_memory_available(void *fdt, 
>> GArray *claimed, uint64_t base)
>>       mem0_reg = fdt_getprop(fdt, offset, "reg", &proplen);
>>       g_assert(mem0_reg && proplen == sizeof(uint32_t) * (ac + sc));
>>       if (sc == 2) {
>> -        mem0_end = be64_to_cpu(*(uint64_t *)(mem0_reg + 
>> sizeof(uint32_t) * ac));
>> +        /* Pointer may be unaligned */
>> +        uint64_t mem0_end_copy;
>> +        memcpy(&mem0_end_copy, mem0_reg + sizeof(uint32_t) * ac, 
>> sizeof(mem0_end_copy));
>> +        mem0_end = be64_to_cpu(mem0_end_copy);
> 
> mem0_end = ldq_be_p(mem0_reg + sizeof(uint32_t) * ac);


+1 for ldq_be_p(). Or read lo&hi 32bit chunks and combine. Thanks,

> 
> 
> r~

-- 
Alexey


