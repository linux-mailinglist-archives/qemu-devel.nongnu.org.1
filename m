Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5630379FBB4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 08:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfaU-0007Zx-QO; Thu, 14 Sep 2023 02:12:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfaT-0007ZM-3v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:12:25 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfaQ-0007I5-M5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 02:12:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9a648f9d8e3so78395866b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 23:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671940; x=1695276740; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jzSFymGM6+PkesHb7QY+86ogj8PJHCTzZUReJc861Uc=;
 b=q1lHH098ToJmEM2layxWfaj3hKzc3tQ0lLb9+yIIitqvrhqute8IMAzgLzgLyOGz1b
 fKoe337vDLntdPTZO5QSK6s68WU4YBySWYdsWbIhCUvhCkE5MmfcB9n1lmSu7o+Phjhz
 j9NnTEOYlS0ULhhbhI6oXb/q9626s5f72f9VgDQ0J7HcryBixkg0F2MMtK1RC39eZLQU
 h5jC/bSuo0Z79UhYuPUs0AvdhlNt3Gg5jjZw2JP14cNEqdXSFco41xbcUw7aTkWaKhOU
 1t28C+tmHBZ38FViXN8KCyyHGBB7Krlsr5UVoSnkOW+fR2nXDno1Zf3npVWPMj+h4ZkT
 L+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671940; x=1695276740;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jzSFymGM6+PkesHb7QY+86ogj8PJHCTzZUReJc861Uc=;
 b=uImpoixLZIMYAio2paf00DeNba7p2tj6g9bo7GwIRXaM/bUfyClMu+UMeLbGBc7DQ+
 34LQhpCZ3EyynBSySTbJ2uuMND8OshKngnN77qiL494o6WpZajR6cL2bXLeTwbulk+79
 IcQZv5yvUBeDa2GUZ+2BxosWqYyJC6g/2ySZ9iQRonVCCnmhOIilSgcjHdfJrYtjkEva
 hi8djTmMRvkRGCXnhMnLPMH8Y3n9elEDIniqXHRXq6sbJjQ1wHEAne0PwCtScgkjm4O8
 2XwnkEgJvD9T0FTwXC783YrWQ+kyVKIC4NcD4mXUVA3P18oo/MFyMv4yWzJXpk+zWLkO
 Z9ZA==
X-Gm-Message-State: AOJu0YxyYtgkNwmtEgT6abepYIR8YGtrZo/wwpttXiagwFv4O7Z3tds1
 wcBDy/Zf6N4nut9d2BPy9Zb8/g==
X-Google-Smtp-Source: AGHT+IE3r85HhCN+dFzYSTz7++HxQDLyzdTti6xSQtjX1s4SLDDpbV2UuQbm/ynFYkf8ZNeaGpGFrw==
X-Received: by 2002:a17:907:778f:b0:9a5:852f:10ac with SMTP id
 ky15-20020a170907778f00b009a5852f10acmr3546892ejc.53.1694671940429; 
 Wed, 13 Sep 2023 23:12:20 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 br13-20020a170906d14d00b0099cf9bf4c98sm517473ejb.8.2023.09.13.23.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 23:12:19 -0700 (PDT)
Message-ID: <d82ee90b-fe29-3a60-ba95-33529c913af2@linaro.org>
Date: Thu, 14 Sep 2023 08:12:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 14/24] accel/tcg: Remove cpu_set_cpustate_pointers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, ale@rev.ng
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-15-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914024435.1381329-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 14/9/23 04:44, Richard Henderson wrote:
> This function is now empty, so remove it.  In the case of
> m68k and tricore, this empties the class instance initfn,
> so remove those as well.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h  | 10 ----------
>   target/alpha/cpu.c      |  2 --
>   target/arm/cpu.c        |  1 -
>   target/avr/cpu.c        |  2 --
>   target/cris/cpu.c       |  2 --
>   target/hexagon/cpu.c    |  3 ---
>   target/hppa/cpu.c       |  1 -
>   target/i386/cpu.c       |  1 -
>   target/loongarch/cpu.c  |  8 +++-----
>   target/m68k/cpu.c       |  8 --------
>   target/microblaze/cpu.c |  1 -
>   target/mips/cpu.c       |  1 -
>   target/nios2/cpu.c      |  4 +---
>   target/openrisc/cpu.c   |  6 +-----
>   target/ppc/cpu_init.c   |  1 -
>   target/riscv/cpu.c      |  6 +-----
>   target/rx/cpu.c         |  1 -
>   target/s390x/cpu.c      |  2 --
>   target/sh4/cpu.c        |  2 --
>   target/sparc/cpu.c      |  2 --
>   target/tricore/cpu.c    |  9 ---------
>   target/xtensa/cpu.c     |  1 -
>   22 files changed, 6 insertions(+), 68 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


