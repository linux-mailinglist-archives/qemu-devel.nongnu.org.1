Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BF8313E0
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 09:03:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQNMx-0002mr-Fg; Thu, 18 Jan 2024 03:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQNMv-0002mR-HN
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:03:21 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQNMt-0002fW-RA
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 03:03:21 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9b050e88cso6921095b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 00:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705564998; x=1706169798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DqjLQUnQyS+cnMZZ4+3rwbT5n02gIrGoamlJbSr7Ubg=;
 b=D1HysvDbQzjmjCkVNKRPrZyZBE+VFlZMV/KHZG3D3GjlqBNw9Lig9/etz8/SzYriOd
 gnPlbWNJJGe+MF9ETH0zewf8Zu/CXdIJL81wCDRAuSaZ22eZXZeRSkbhioI17yp7YTOh
 fCS3meORV7MvPfrIGnIcFCVO6jei07BKwTRSBKTVHklFnunGi0q1rkyraDgPc5S/j2+w
 mhlipwgL02Fgf65dm1HYRYRBBV5PYLIyt7nk062V3eOubCyu1Sw/AbOgL1Jc4xArb/As
 2Qn2dcDATAXsepGbGw5SF/JyBPPLr1jSP/LeuG8buFkn1petRvncn4qFMtMmclt3zKdz
 7vRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705564998; x=1706169798;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DqjLQUnQyS+cnMZZ4+3rwbT5n02gIrGoamlJbSr7Ubg=;
 b=st2ZBTfyozCFK5oYdOKJHGSubohDVfS2uhmwm+yh7jeAyW96IHoOV3/UL9RPaDNMlz
 TNwyMLDssN7FLfmYcjVmUPNVb5HPBJbOyymzSByUjdxvLrcVsA5oOqsuY/SnozD4yV+u
 pBMxZWSjMkZmUE34w68Ucj8Zubqq6dBHls4wtvzKHsc5buhWsgAGoAumoZHSTZ2ieC9y
 8s8dGi/M23RhT7IXa6BFXIJUwi84l5hn09qONkHguP3QQpmhA98yltF2DECCXBE2Kjke
 Cpj5FgOZ+gnABmke2STwxVPzO84tcVvPuiEnS+l+WN7ycV80sxwwZqzgB2HuLd+MQXp4
 OkMQ==
X-Gm-Message-State: AOJu0YyNNrs5s9uEu5IyVYclDu+eRu15dXTYUS9glEtWwiGxUs+fn+n6
 q7ZO4Vs3i1DMdpUWMVa6A/59LMLLdy3zrbiN9YhnPp+C9HUWPLNvO2xExmMjsvTqlNYI3IqbYXV
 W
X-Google-Smtp-Source: AGHT+IEAyMRjKCtPGn6sc/5xQa047f4FsREZiehFKQnD9uM8UoaKgz67CFjhvfI9RfpKbJFft2IZSA==
X-Received: by 2002:a05:6a21:3981:b0:19a:3f15:ac01 with SMTP id
 ad1-20020a056a21398100b0019a3f15ac01mr377477pzc.18.1705564998392; 
 Thu, 18 Jan 2024 00:03:18 -0800 (PST)
Received: from [192.168.1.13] ([43.252.112.244])
 by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b006d9c7f2840bsm2691884pfe.57.2024.01.18.00.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jan 2024 00:03:18 -0800 (PST)
Message-ID: <99056ce2-57c2-4aab-bd97-8b9b67e37882@linaro.org>
Date: Thu, 18 Jan 2024 19:03:13 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] linux-user/riscv: vdso: fix call frame info in
 __vdso_rt_sigreturn
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Vineet Gupta <vineetg@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu
 <ewlu@rivosinc.com>, gnu-toolchain <gnu-toolchain@rivosinc.com>
References: <20240115231552.3217789-1-vineetg@rivosinc.com>
 <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
In-Reply-To: <f23eb285-16a8-44ee-991b-224b480dd91b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/16/24 10:18, Richard Henderson wrote:
> On 1/16/24 10:15, Vineet Gupta wrote:
>> When testing gcc testsuite against QEMU v8.2 we found some additional
>> failures vs. v8.1.2.
>>
>> | FAIL: gcc.dg/cleanup-10.c execution test
>> | FAIL: gcc.dg/cleanup-11.c execution test
>> | FAIL: gcc.dg/cleanup-8.c execution test
>> | FAIL: gcc.dg/cleanup-9.c execution test
>>
>> All of these tests involve unwinding off signal stack and v8.2 did
>> introduce a vdso with sigreturn trampoline and associated unwinding
>> info. It seems that info is not correct and making it similar to
>> to one in the linux kernel fixes the above failures.
> 
> So.. you didn't actually determine what might be off in the unwind info?

I have just run the gcc testsuite with my sizeof_reg fix installed, and these tests passed.


r~

