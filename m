Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F108B7F66FE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 20:16:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6FAH-00081t-N4; Thu, 23 Nov 2023 14:15:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6FAD-000818-Dl
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6FAA-0002kJ-NZ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 14:15:00 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40839652b97so7771625e9.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 11:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700766896; x=1701371696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yAnPvEHxfnwIrQ4YjZXX0tgE5jPkVwCpov/iR2R1Eg0=;
 b=FNlH4TkCH/g7DlATiNIjuBQDYiYkDGiwibXCJysfUANbHXtQxdj0/YeF7LOOsveSs6
 acuNXQ4/RcKxE+d6CK2Y9WuFO0RM28XXH94TG90dLJI3sHEtJnT+Uy26mgKB9mY6T0gY
 cv1+bCxzC7W0EQFZrAMmX/nA9U1wh1B7oACsrKr2cwWMLmadmIfPOk1jIpvO8wwgytJo
 8PKzb9C/Kq/beJRorlZkzBPrOYWUjVVkAND6tLSFQwPYY5oN8d9QZ8R+a02hDcTK6z+s
 xXKG0/VUAtfMJ9DhmZEz1aog9n+VT9zyxVoQbLcw5Iaew1o0zgpGd4CQc79N1rnBn3JH
 sKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700766896; x=1701371696;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yAnPvEHxfnwIrQ4YjZXX0tgE5jPkVwCpov/iR2R1Eg0=;
 b=b+8h8+p3B8qI0iFCsk3HlSwPy1dcNZQcNJIt3sqTEeqcTWTexF+hCMsxpp7vLiNn6L
 8C+QR8Nv/XBGjT1JSpFFjG8w6vV4ktLJYVZcWWzJL+0TxMV/4p/4qA7QQ8ho1YMnn4MC
 IXYY2nvCxvt3UxvKrptY4y1CV0OM8n2U11XgqKRYJnqzgBnv2cbpr1HC74oua70ujA4Q
 /GKhkmNUjkYdQWAQTrENg+bIfszAxAYYuGKTaUBryhUdozW5EAZ2nPNbq8Dvb/uPsSbU
 iuJ+59cxsromc2ZuhfxfkSMU44iTGHyX+IHLN5eJGxCz6Bja0OeiP2FdHAS3cAKkxkfg
 ZgCw==
X-Gm-Message-State: AOJu0Yyp/52IF7ZVLTWAvbB6WR0aaHVKr9/h6L9IHm7l0PGyHO44uITT
 EwRT2eUpcvzPgTLr+IASdCqkpg==
X-Google-Smtp-Source: AGHT+IHDqauS17C4rzA8GBxJDq2AveHGYEt+wojnBFB9Rx+F8gu5Vh993A74JgJOGD7jcjCbQQ4urw==
X-Received: by 2002:a05:600c:4690:b0:406:872d:7725 with SMTP id
 p16-20020a05600c469000b00406872d7725mr427029wmo.1.1700766896336; 
 Thu, 23 Nov 2023 11:14:56 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a05600c3b8800b0040b398f0585sm330965wms.9.2023.11.23.11.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 11:14:55 -0800 (PST)
Message-ID: <00133b79-fd3b-4b5c-96a5-55e94de0bf46@linaro.org>
Date: Thu, 23 Nov 2023 20:14:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 00/21] target/arm: kvm cleanups
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <cb8808dd-00bd-4569-be15-9d8f2e20b1f1@linaro.org>
In-Reply-To: <cb8808dd-00bd-4569-be15-9d8f2e20b1f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/11/23 18:40, Philippe Mathieu-Daudé wrote:
> On 23/11/23 05:41, Richard Henderson wrote:
>> This is primarily concerned with merging kvm64.c with kvm.c
>> and then unexporting everything that is not required outside.
> 
> 
>>   target/arm/kvm_arm.h   |  203 ------
> 
> Unrelated to this series goal, but I notice half of the API takes
> CPUState, the other ARMCPU...
> 
> $ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
>        16
> $ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
>        14
> 
> Since this is ARM specific, I'd expect it always take ARMCPU, and
> call the generic KVM API casting with the CPU() macro.

API clarification done here:
https://lore.kernel.org/qemu-devel/20231123183518.64569-1-philmd@linaro.org/

