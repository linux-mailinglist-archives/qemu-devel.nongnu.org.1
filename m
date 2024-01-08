Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D686E826D30
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 12:51:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMo96-00062O-IQ; Mon, 08 Jan 2024 06:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMo92-00061j-Ku
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:50:16 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMo90-0007jM-NO
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 06:50:16 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3373a30af67so1714241f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704714612; x=1705319412; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XOf8gGqS4dYN+pjWP3M18zUtXBMcAqxom+v6AMiL62Y=;
 b=XP86o1A9fooXcxEzgcX/2Da3gr1Ngn83D+n8xJ9DL0c+/HBv0JQUaRerZfLEwNVicf
 U2duFHS16D7pIGB0X19DUee+lvg8svBgv6Ttalt+gcU442LpWy76TQBbuP0KL17NaYWp
 3qrwqOYRxUQBuFdTnDG3DPyonHns8G5EOUIQLS1wvfUjd//R0izfDjZolOfZcnJyZZdS
 z7Xa6zcUSH7vV0uaFUZBek8XSMJjPAZk0vkLx+U5eJVDyVW53MC7XZlcdujxP6yjrGC/
 y3uxJjspMdhTeUaMYL+vcAsMhCbAODVpQ1QiY4INxAVTEPiJW21aFJ2XrvZBwalIDRO/
 2OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704714612; x=1705319412;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XOf8gGqS4dYN+pjWP3M18zUtXBMcAqxom+v6AMiL62Y=;
 b=OziytTSH2nuG1fNNkMeo2l0PkvuGI6pbvLzcSWKorFL8pUmx6UKN203+cRbMRVaAUD
 H8fyIxaFV1GW0+FJDmR3ePmk16cln39NVC0iTT/omMuyoyl1INYCzO0TQzGmRjL3Qfo+
 mBzOPfDzeR3TdkK1DpqPisPUE7sCOj3NCvxxB0s2z8Hj3NNF4ZGfh2GrorKsXa4wTrAJ
 ctGDnl5VyyRl+MVZyLEWN/VxHbBTIfw7kcF4CHulRL0RXAj3CusbcQqYwjqhnh3L+oFY
 2hQ8c6YKg8h5Ki2WxLioLcakfPkEkqKgQljMm9poanl/2NooF9z47YSHOaOW+2Tum1Lo
 MINg==
X-Gm-Message-State: AOJu0YzEeQTZu+koLSTChVwH9e/36pD+NT0k3dANDrYTboTyafFdp3p9
 ki8uCwF90X9Gy0mBGScJliekt/AlZgSx4w==
X-Google-Smtp-Source: AGHT+IELJSXMW9keoTF6MyBg9FUgJwZiOvkCs2H6LHiUEbXVb2U3tK+uMTHTbG7d9PfQ+mWr4xrwqA==
X-Received: by 2002:a5d:488b:0:b0:336:5f9a:cea4 with SMTP id
 g11-20020a5d488b000000b003365f9acea4mr1384243wrq.62.1704714611775; 
 Mon, 08 Jan 2024 03:50:11 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 d7-20020adfe2c7000000b00336d24b4847sm7589164wrj.114.2024.01.08.03.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 03:50:11 -0800 (PST)
Message-ID: <eea1905e-f2dc-4dfe-b40c-ed6c1f55cc7b@linaro.org>
Date: Mon, 8 Jan 2024 12:50:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/tci: Fix TCI on hppa host and update TCI test matrix
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Helge Deller <deller@kernel.org>, John David Anglin <dave.anglin@bell.net>,
 Laurent Vivier <laurent@vivier.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <ZZpQZ77s2t81mXIT@p100>
 <CAFEAcA9K4GVcYNe2YvtDxiXC-HBvAXEZzNMA-z9xkpNY4Qf2EQ@mail.gmail.com>
 <7df97a8e-6bb2-482c-86cf-a9dbf2bd2e53@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <7df97a8e-6bb2-482c-86cf-a9dbf2bd2e53@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 7/1/24 22:40, Helge Deller wrote:
> On 1/7/24 16:22, Peter Maydell wrote:
>> On Sun, 7 Jan 2024 at 07:20, Helge Deller <deller@kernel.org> wrote:
>>>
>>> Update the TCI interpreter test matrix for big-endian hosts with
>>> big- (hppa, hppa64) and little-endian (x86,x96-64) targets.
>>> I used native ppc64 and hppa hosts for those tests.
>>>
>>> Starting TCI on a hppa host crashed immediately, because hppa is
>>> the only archive left where the stack grows upwards.
>>> Write-protecting the stack guard page at the top of the stack
>>> fixes the crash.
>>
>> We deliberately dropped support for HPPA hosts, under
>> commit a1eaa6281f8b and commit b1cef6d02f84bd8.
>> Do we really care enough about trying to run on these
>> ancient host CPUs to want to bring it back?
>>
>> My personal rule of thumb is that if a host CPU is supported
>> only by TCI then we are better off saying it is entirely
>> unsupported -- in practice the performance will be so
>> terrible as to not be something anybody will want to use,
>> especially for older architectures which are slow to
>> start with.
> 
> I can see your point (and the performance is really horrible).
> It's not my intention to make hppa a supported TCI platform,
> but for me it's a good candidate to at least test TCI on
> a big-endian machine, mostly because I have access to some of
> such machines.
> And, this patch is all what's needed and it's pretty trivial, so
> it would be great if it could be accepted.

I was also running linux-user tests under HPPA/TCI and Cc'ed
Helge for HPPA host removal:
https://lore.kernel.org/qemu-devel/f61ff7ff-44a2-14c3-da08-755c290c75b7@linaro.org/
where he seemed to agree with the change so I didn't insist:
https://lore.kernel.org/qemu-devel/9a5f4a80-0700-4261-f26d-ad86ad4209cd@gmx.de/

Peter, in 2021 I had a go at implementing it (back then there
were few more HW still alive). I hit 2 issues:

- in compat32-bit user mode, signals are broken, see in
   arch/parisc/kernel/signal32.h:

   /* ELF32 signal handling */

   /* In a deft move of uber-hackery, we decide to carry the top half of all
    * 64-bit registers in a non-portable, non-ABI, hidden structure.
    * Userspace can read the hidden structure if it *wants* but is never
    * guaranteed to be in the same place. In fact the uc_sigmask from the
    * ucontext_t structure may push the hidden register file downwards
    */
   struct compat_regfile {
           /* Upper half of all the 64-bit registers that were truncated
              on a copy to a 32-bit userspace */
           compat_int_t rf_gr[32];
           compat_int_t rf_iasq[2];
           compat_int_t rf_iaoq[2];
           compat_int_t rf_sar;
   };

- 64-bit userland is missing glibc (missing L3 TLB support for user
   applications). John was working on it.

Regards,

Phil.

