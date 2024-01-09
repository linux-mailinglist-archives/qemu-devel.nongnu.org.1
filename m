Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F988828371
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 10:46:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN8fs-00031k-96; Tue, 09 Jan 2024 04:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8fq-00031O-Ja
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:45:30 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN8fo-0006fU-KD
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 04:45:30 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-20451bc39b1so2031495fac.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 01:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704793527; x=1705398327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ec9WhR4/B6HMealWmBC5ASoJhwmV/C2NA+IdoLTolU=;
 b=yd6Qyt2iQb8Zm3YXNP2jL66oEVC9L2pLB04ZoaIlh59Ocwwfrhl1wl97T/YCHChgur
 BXTcmwqQG0h4h93T2e+Xa0iIAwhJVbzLSrJ/m8c1p5Wy59zZhZzwOPK4AogWwmnakPjI
 +09/q359OaDkEnE+hJpvSuBQ0hiYsx8DVRw8XiYBQJ9+EPRtzfub3cFLNeutmDjSmvUs
 l8XkYy8MCfIRCTZa4LoyOcmcqb2L6m9Jcjc5ykMXpvBPfaZRM1DObx/uCU3NyoNnQvIQ
 xYRCF+2f7POkBVjdrpCm9Et0RnJEEd+VSCpSfC3LStZGvnEsKs3YDnkO5EyWWGf2/7R+
 lHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704793527; x=1705398327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ec9WhR4/B6HMealWmBC5ASoJhwmV/C2NA+IdoLTolU=;
 b=Ij+CKNWup3yEPTEr4oQbyZHdB+S5FQH8VpGrh0RqdK7Yva1/Lurw+7+mN1ppvgcxtC
 XKlhmA6O224/wHWrkNQsEQKb7VGHck46O17Su6S5ra+jIvOxSeuSYC5YL6arVn0eRBrg
 W3PSitGCyB37Y1iyGZSTkjYIVTKo1rxa12it1hGST8v3ELDwlIMOII0QeYlE0grhHAmF
 takPWvcyJOsPhuOyCoyIBXewlasjQTlyHE1+xvSATtE+hjExBXAi14ixe4wYq8Xl+XqH
 DPzR68mRgDHBgoJbO2yByIbXk47ZmRf/FQwkJAjixn2jlowsqV3U6YUHW68yxLjGGuMr
 geRg==
X-Gm-Message-State: AOJu0YxduI/NCkxT9EsxVoHwy6qEpoYTRxYBYQEcUAP1mxb28W7jbM51
 IowVP6bWVJpQHJ4I0DoXeX8BwjKc8AIW7Q==
X-Google-Smtp-Source: AGHT+IHoBDP8IzPLIaQeK6GRijitrC0k5IcV3CIGv6+VJ9SkbZ7+oe80TUsa/qVovqQuqt4v38Vb0Q==
X-Received: by 2002:a05:6871:468b:b0:205:cb67:c081 with SMTP id
 ni11-20020a056871468b00b00205cb67c081mr6226448oab.68.1704793526855; 
 Tue, 09 Jan 2024 01:45:26 -0800 (PST)
Received: from [192.168.51.162] ([172.58.109.255])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a9d76c4000000b006dbc5410868sm309275otl.21.2024.01.09.01.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 01:45:26 -0800 (PST)
Message-ID: <a07485d8-d9b4-4d98-8eb2-8d43e8718485@linaro.org>
Date: Tue, 9 Jan 2024 20:17:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/9] Hppa fixes 8.2 patches
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240108143802.50256-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240108143802.50256-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 1/9/24 01:37, deller@kernel.org wrote:
> From: Helge Deller <deller@gmx.de>
> 
> The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:
> 
>    Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/hdeller/qemu-hppa.git tags/hppa-fixes-8.2-pull-request
> 
> for you to fetch changes up to 282abfd5ea2c489aec7276a50c39029de55bcd85:
> 
>    target/hppa: Update SeaBIOS-hppa to version 15 (2024-01-07 09:13:07 +0100)
> 
> ----------------------------------------------------------------
> target/hppa qemu v8.2 regression fixes
> 
> There were some regressions introduced with Qemu v8.2 on the hppa/hppa64
> target, e.g.:
> 
> - 32-bit HP-UX crashes on B160L (32-bit) machine
> - NetBSD boot failure due to power button in page zero
> - NetBSD FPU detection failure
> - OpenBSD 7.4 boot failure
> 
> This small patch series fixes those known regressions and
> additionally:
> 
> - allows usage of the max. 3840MB of memory (instead of 3GB),
> - adds support for the qemu --nodefaults option (to debug other devices)
> 
> This patch set will not fix those known (non-regression) bugs:
> - HP-UX and NetBSD still fail to boot on the new 64-bit C3700 machine
> - Linux kernel will still fail to boot on C3700 as long as kernel modules are used.

I believe at least one of these patches to be wrong.
Please do not pull right now.


r~


> 
> ----------------------------------------------------------------
> 
> Helge Deller (9):
>    hw/hppa/machine: Allow up to 3840 MB total memory
>    hw/hppa/machine: Disable default devices with --nodefaults option
>    hw/pci-host/astro: Add missing astro & elroy registers for NetBSD
>    target/hppa: Fix PDC address translation on PA2.0 with PSW.W=0
>    target/hppa: Strip upper 32-bits of IOR on error in probe
>    target/hppa: Strip upper 32-bits of IOR on unaligned access error
>    hw/hppa: Move software power button address back into PDC
>    target/hppa: Avoid accessing %gr0 when raising exception
>    target/hppa: Update SeaBIOS-hppa to version 15
> 
>   hw/hppa/machine.c         |  33 ++++++++++++++++++++-------------
>   hw/pci-host/astro.c       |  26 +++++++++++++++++++++++---
>   pc-bios/hppa-firmware.img | Bin 681388 -> 163324 bytes
>   roms/seabios-hppa         |   2 +-
>   target/hppa/cpu.c         |   2 +-
>   target/hppa/mem_helper.c  |   4 ++--
>   target/hppa/op_helper.c   |   2 +-
>   7 files changed, 48 insertions(+), 21 deletions(-)
> 


