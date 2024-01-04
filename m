Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D93A78242C9
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 14:41:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLNxM-0008LC-4M; Thu, 04 Jan 2024 08:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNxE-0008IX-5a
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:40:13 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLNxC-0007CG-4i
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 08:40:11 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40d5d898162so3614445e9.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704375607; x=1704980407; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TyGOTt5YQ5dKu9eEJjLJcTwPgoh0JifEfkWu+PyEtDI=;
 b=gdbhDYSZymnT4Nc+19kw7Zk976DvAeteKQJQyFtR6XHZS9MmFMGFUMmwRNdmuPitNz
 97h0wTASt5EcvsVQjB8/tfbYM5/qZqsnhO/y4FI4I2ah0nkWQM9BgyPlDl1Sp6epQCiO
 hMxn9q0sNGGt+u4zTb4Q8KS1yOeLJchr1rW55Kkdumyg1Fkl1M5BbZEEaL7inWW5Ov0v
 iD0z/Utv+oOLVJ8EpX5J/O2ZAtweK0UG3kp9p+y5N0e1v1px6pwt5YPvxiEUkCgflBPX
 X1Fhblr4KJsHBCjvnNDkCqRaARN/vdpabHcZXC7lQP+0hbMWLN4tesBYxDA0I/+OKKv7
 QcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704375607; x=1704980407;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TyGOTt5YQ5dKu9eEJjLJcTwPgoh0JifEfkWu+PyEtDI=;
 b=sQiSCxTWBGWIWT6WvUwf7HoAc8WCCIYMRcSNHEywEq7kSIp/w1GcmmdrwH/jC/eAX+
 4UQ5fdqfwcT0xOXnvgKTP0o4zo2vuzVf6uFZBa3Wr1TP6H1PYEj2RHyzw5SDtYA6Ypfx
 lfU8jUgKmosaxFe5Rn9kYq1iuJYKAqSMbhmTibkuHSdreyBCjmQQ3rr4yb/YcJlVvNhN
 fv9VieslswCGWKUxCpl1iP9pL2kb0lNjji1yBIHoVCyFxH0t2Mq9PuDrJPrZ2+LS51pH
 PQVv4YFPSYBEE8TKtwkF5DhYmqxrIhgMklIX8RzPl2PJoKH5y31eZo8Jx87jy5qcmpGj
 aDRA==
X-Gm-Message-State: AOJu0YwjXtQwk+VFhtPOGjyoHspxygJGrAjp2jPPUEkU7RDdMRQXtlv7
 nZ7FSEFzTCxHgpy4FiTLMtlIZ3Z7wrrHnA==
X-Google-Smtp-Source: AGHT+IEh8zh5TO9xChhuF1GP5QhK44PI6nhJLjguKVympHK9kS/451TmlJTbEDGw8VhtqpXIdSZgwA==
X-Received: by 2002:a1c:6a15:0:b0:40d:77d9:8d80 with SMTP id
 f21-20020a1c6a15000000b0040d77d98d80mr403977wmc.44.1704375607155; 
 Thu, 04 Jan 2024 05:40:07 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.232])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a05600c450e00b0040d6d755c90sm5763131wmo.42.2024.01.04.05.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jan 2024 05:40:06 -0800 (PST)
Message-ID: <b0f06e83-aa11-4990-a3ed-e6738e7ebbbf@linaro.org>
Date: Thu, 4 Jan 2024 14:40:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] hw/misc: Implement STM32L4x5 EXTI
Content-Language: en-US
To: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
Cc: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20231228161944.303768-1-ines.varhol@telecom-paris.fr>
 <20231228161944.303768-2-ines.varhol@telecom-paris.fr>
 <908650b4-3bb2-4cf2-8909-5bffc622950f@linaro.org>
 <877ckpgrie.fsf@telecom-paris.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <877ckpgrie.fsf@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 4/1/24 14:23, Samuel Tardieu wrote:
> 
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> This doesn't build:
>>
>> ../../hw/misc/stm32l4x5_exti.c:172:9: error: expected expression
>>         const uint32_t set1 = value & ~DIRECT_LINE_MASK1;
>> […]
>> I could build using:
>> -    case EXTI_SWIER1:
>> +    case EXTI_SWIER1: {
> 
> Out or curiosity, which C compiler or option do you use for checking? I 
> have no problem building this using "./configure 
> --target-list=arm-softmmu" with GCC 12.3.0.

C compiler for the host machine: clang (clang 15.0.0 "Apple clang 
version 15.0.0 (clang-1500.0.40.1)")
C linker for the host machine: clang ld64 1015.7

If you don't have access to similar compiler, you can fork on GitLab
and push a branch to trigger the CI; I expect it to fail.

Regards,

Phil.

