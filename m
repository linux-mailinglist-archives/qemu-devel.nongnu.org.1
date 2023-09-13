Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BAE79F2E1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWVX-0008Tq-LI; Wed, 13 Sep 2023 16:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgWVV-0008Td-70
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:30:41 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgWVP-0004YJ-RS
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:30:40 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68cbbff84f6so1012710b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694637034; x=1695241834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yO+3Gbub7iVHXs1p5bebzCW8urxZPZ2EDXZXbf7MNG8=;
 b=xfhxUkMmCTjoXwcrM95n39xUP6oS1kMupr62DTFWNkAAQtOJ3554UwzyJai3d8YNv5
 YPVeysziODjN6THNriTLW+Fz3kR1ULguTeHOYffiiFHBkWt8T39qqbom1cM2oqPItwS7
 TIOWUWvgPAE8UZ9876uglHEMcNhP+kvjdAA0UWtb9dLIKvvJ5N0z13ub+LXy8ZsjUOn+
 PDm7g4GujZvbbpEOZ2dkAWb5Ik/zM95bktPP4jtps2MTZx+AVYXh72ABiAikfkbke7a2
 S/U0xy+S7wcPMpcJXGixl8tw3flGs+SSUJHbM7Bq3Ee5stGY5TedREqj+/aB2YhTSTty
 4xMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694637034; x=1695241834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yO+3Gbub7iVHXs1p5bebzCW8urxZPZ2EDXZXbf7MNG8=;
 b=AjGHB3EkWBvsle86IJO6yelbFtIlRLhm+q0NN++1IJLFcT8NEJo/uVKhCPIpLlm1GO
 0h0S+XH+N/vqb55YZ7tQzy5b5ohXW026qX6FeV2bk+UNnDrKzLt1sGBhmeOKVCYQrW3/
 kqriGBwda4kfQXIvs+iXBp22plIvB4VRQhhR7eH/Bdo0gUtcsD7Eh1F0j+KPqR3jLrD9
 XwhnKDOyi7wHt3/F7sKP4UnzUQ4t8zAeKwhqNw5rEmPOIK7wuuFlzZqm/IcZsR+yK/o6
 3hAZLg+bpqWXGUfn0bXA8elBaAmJ8uAdG5nuginajKsbZe/lZWEYXKKecSBZgMLyqqdv
 OARw==
X-Gm-Message-State: AOJu0Yy7Y/ZTLgeotoccRsjK17/eTuvkxRMr2svbGA4WvpSsorOJeswq
 KUbk/ZFFDxigegAZtPSOY801Pw==
X-Google-Smtp-Source: AGHT+IGBdbahLx7HBESz1M62hFJjNFGP2ErS5uL6Soc3bG/h7eRgUTEsmEMTGEPg000gxr22AYXMfQ==
X-Received: by 2002:a05:6a20:734f:b0:14d:7b6:cf3b with SMTP id
 v15-20020a056a20734f00b0014d07b6cf3bmr9279985pzc.6.1694637034085; 
 Wed, 13 Sep 2023 13:30:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 i69-20020a639d48000000b00563590be25esm9235952pgd.29.2023.09.13.13.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 13:30:32 -0700 (PDT)
Message-ID: <f824fa25-0d7f-b417-11a4-e3c84efe1b7a@linaro.org>
Date: Wed, 13 Sep 2023 13:30:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] target/hppa: Optimize ldcw/ldcd instruction translation
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <ZQHLcL6E5uNvjkaN@p100>
 <ba047867-db8b-8bb6-d2e7-563516c5afb6@linaro.org>
 <acc0b3f5-959c-ac8d-89e1-5c862b39a721@gmx.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <acc0b3f5-959c-ac8d-89e1-5c862b39a721@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 9/13/23 10:19, Helge Deller wrote:
> On 9/13/23 18:55, Richard Henderson wrote:
>> On 9/13/23 07:47, Helge Deller wrote:
>>> +        haddr = (uint32_t *)((uintptr_t)vaddr);
>>> +        old = *haddr;
>>
>> This is horribly incorrect, both for user-only and system mode.
> 
> Richard, thank you for the review!
> But would you mind explaining why this is incorrect?
> I thought the "vaddr = probe_access()" calculates the host address, so
> shouldn't it be the right address?

The vaddr name is confusing (since it implies virtual address, which the return from 
probe_access is not) as are the casts, which are unnecessary.



> 
>>> +        /* if already zero, do not write 0 again to reduce memory presssure */
>>> +        if (old == 0) {
>>> +            return 0;
>>> +        }
>>> +        old = qatomic_xchg(haddr, (uint32_t) 0);
>>
>> You're also dropping the required host memory barrier.
> 
> ?

The path through the read+test+return, without the qatomic_xchg, has no host memory 
barrier to provide sequential consistency of the entire operation.


r~

