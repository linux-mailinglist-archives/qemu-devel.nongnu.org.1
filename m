Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2726833323
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 08:39:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR5vE-00011G-Ho; Sat, 20 Jan 2024 02:37:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rR5vB-00010L-Qw
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 02:37:41 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rR5v9-0005Sc-1w
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 02:37:40 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbb4806f67so1307797b6e.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 23:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705736257; x=1706341057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yK+7e3y3bv5eqHe1DA+NBJet8+lXvBvaGRGybBVRlyw=;
 b=ZcYz0zjKXtAr3Ab4bpBYgt81OAveOQyta1D1moBLJqbzqMxYctr12k6feFPHPrmQWC
 cEv4Mv9/H4tRl0RlfHAOBKO5VhIkHTX0eR07T5pi6TOlyi2GYyxhSyisx1yhtijVf+sB
 wJmIv2vDIcATwiNDXIkl4rpSN2utxprfJkmjQUFvZEieipA80LvoR3kDOiz874TTigUk
 dHcaDKMrue3VPk6mpvuKTkldys1yv66MSdQ/LlJ/kuxmx89/BoMmUc5xKuDGB7VK3Jtc
 RZJWSAR8I/sF3nVAxaHyMwn63Fs7sNfBGOHUWRbXbZ38R2D+ExPnsCNtdvcxSXcokhrJ
 Jvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705736257; x=1706341057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yK+7e3y3bv5eqHe1DA+NBJet8+lXvBvaGRGybBVRlyw=;
 b=LlofiRRooqYaIJn4XFM1UjeAkFGBI9br5eKLeQ355F+3wTaZErKWf155ugbHXE5iVN
 iSEoZpZ8jDt/4BJt6ZH28SvJ+k5NB8pV9sRLpdPM9I1Z4OGyriYnn1+qU6cv3xcRBgXY
 ArGA6wy2VQpgXp2ebQn7XwBLzBpKIKjLXs6uh8eiujFO6heGYheAyqeuBM2HaRX9h6RT
 chuKgeCXLCktist0KC9BmOpNRDAeekgwJnLiNuarW1ujJuDqCPwCPeSBkEQJg8jsOtxE
 Rmit0nLOsQRjLKqW4CgC74+fKnbVTLBNnUYZRFhTj3/AUn1DFKO16JLx67l0pxHFZkBs
 +7zQ==
X-Gm-Message-State: AOJu0YyUnmcrBaIO/tHauR6ZlknPZVyUrAR5n04X7yhUBZnY/0OX+7iW
 pqZ+MhX0nT2rogjGr4a+q71lRp0mvE2tglacy/vwIfHhDI9Y5dpPUDoOzO+QHsA=
X-Google-Smtp-Source: AGHT+IGIpkqmzGRYw35IXJEiuoHs3H1mO/uOXiL3/Wch80Lp671rF4ONS3T32gjcjd5m54UNaU7VPA==
X-Received: by 2002:a05:6808:1812:b0:3bd:a82a:a827 with SMTP id
 bh18-20020a056808181200b003bda82aa827mr1501287oib.7.1705736257421; 
 Fri, 19 Jan 2024 23:37:37 -0800 (PST)
Received: from ?IPV6:2001:8004:5170:1e39:8ee2:6e6b:fea2:d3ab?
 ([2001:8004:5170:1e39:8ee2:6e6b:fea2:d3ab])
 by smtp.gmail.com with ESMTPSA id
 y37-20020a634965000000b005ceeeea1816sm4693980pgk.77.2024.01.19.23.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jan 2024 23:37:36 -0800 (PST)
Message-ID: <5b6571d3-f654-488d-9dc5-0d18ba542e05@linaro.org>
Date: Sat, 20 Jan 2024 18:37:27 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] target/riscv: Add helper functions to calculate
 current number of masked bits for pointer masking
To: Deepak Gupta <debug@rivosinc.com>
Cc: Alexey Baturo <baturo.alexey@gmail.com>, zhiwei_liu@linux.alibaba.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20240109102930.405323-1-me@deliversmonkey.space>
 <20240109102930.405323-4-me@deliversmonkey.space>
 <CAKC1njSLR614zQk0_DAgYN1jjdg=0eUa7N1AEwwXZVNN6BwjmA@mail.gmail.com>
 <3cb918ca-27cd-4f1e-8738-306dc5280f42@linaro.org>
 <CAKC1njRXPi1Roch=T+NwQk-TOzN=gSjmPh2KCVsemKdex9CamA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAKC1njRXPi1Roch=T+NwQk-TOzN=gSjmPh2KCVsemKdex9CamA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 1/19/24 09:40, Deepak Gupta wrote:
> On Thu, Jan 18, 2024 at 12:50 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> At some point pointer masking will be in hardware, and the kernel will gain support for
>> it, and there will likely be a prctl() added for it.  At the point the kernel finalizes
>> the API, you will be able to enable pointer masking for qemu-user.
> 
> I am sure I am missing some important detail here, BUT...
> 
> How is it different from aarch64 "top byte ignore".

It is very similar, yes.

> I think commit: 16c8497 enables top byte ignore for user pointers and
> by default for qemu-user for aarch64 target.

Not quite, no.

commit 0e0c030c681730f3ec55ba3b223b608a8f3e8282
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Fri Feb 12 10:48:51 2021 -0800

     linux-user/aarch64: Implement PR_TAGGED_ADDR_ENABLE

is more relevant.

> IIRC, user <--> kernel abi is only needed for pointers that are passed
> to the kernel.

It is also needed to *enable* pointer masking at all.

For aarch64, TBI has been enabled for user-space since the beginning, but that is not true 
for riscv.  Therefore there will be a need for a syscall to opt in and enable pointer masking.

> And in the case of qemu-user, we are talking about the host kernel.

No, we are not.  We are always emulating the guest kernel.


r~

