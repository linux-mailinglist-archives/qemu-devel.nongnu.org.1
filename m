Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C82789B6C
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 06:59:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qa7s4-0004fV-HA; Sun, 27 Aug 2023 00:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7rx-0004fE-32
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:59:25 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qa7ru-0006gY-KL
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 00:59:24 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3a76d882080so1731371b6e.2
 for <qemu-devel@nongnu.org>; Sat, 26 Aug 2023 21:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693112361; x=1693717161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ulJ2EmQwmbMK422AUsDQGHa063cU0/5kqPs9euxbEdU=;
 b=G6Q/x/cuZMzhhmPyOhFNWph0qaaOZpOdmiZhx9LpXnhYQEdPP3qxOKVepOxR1d94g8
 GpqBNd2NUjTLI0zaBxuE588Vt4lGr1hBIXkv8kf5t5HNsNHHl6UlVpVDdcLbIkPETKyo
 W4F63bk9FHKesM4Dv2ju4Dlu0+i7vlVHT6juQXnIIczQf3eIegRHfwtVp/v+F7viO+O2
 TPmSlFEOmbAKsb8Cl79b0VJ1ZMs5Pq7EKn51UebX9Ie4RpKc9uEbEwzO59BCb+fQJN/G
 EKQ6CmmgCSfmgWZIbvnNx1/D0+i39mRvjwypiOdPkyO5wc9EyeWgm8Uq+2Xsha9QobQ8
 TLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693112361; x=1693717161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulJ2EmQwmbMK422AUsDQGHa063cU0/5kqPs9euxbEdU=;
 b=SH9o3zjaooRgAO3ALPCOK6izE9c3ZZ9BiqkJ37sJePUQdq8Vi3Kz+A1WuifwqMBpUV
 SYgwqRBSz7jIUoTcjeQUf9pNYjp8QI0ai8Zb4vQ47VkNpZzaJdJqQ+gRGWNyTHeON3r8
 rbqF/PfgeLAepne4Pg5yOa/6aNH98vDpg3Xls01wbOs4dPhptEfY4NoP6GMuW3nDGdF5
 62yxvh2LqqpKH2fhQrT+SzVG++vlUZdKgm/DBdY///En6Gyc4xUbBSzZorlSTXvc0/KI
 BsSi5K0ifj7JErBonh+FO8eqKh7qGRooRtKZ3IGEvSvt4Yz/MpaItuc8EqLau89C8jGY
 40lQ==
X-Gm-Message-State: AOJu0Yy0UWrqJtFVqqyVfGrWYRoinDyMbXRkUZURPLT9gaS7xlomGxRT
 6T+4uO24GwBywAJzZmh6nJ2mhMkaVi3Fc6j/fQo=
X-Google-Smtp-Source: AGHT+IE3+pQoEeWJobwU8iPeGgqf+iRsFZVXPuFfmVKD0zDuYF+5nP8EXAU8jQnnsTcx4sziQubHyw==
X-Received: by 2002:a54:4d87:0:b0:3a3:baf8:5b8a with SMTP id
 y7-20020a544d87000000b003a3baf85b8amr7007534oix.13.1693112361353; 
 Sat, 26 Aug 2023 21:59:21 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 b1-20020aa78101000000b00687fcb2ba7csm4074201pfi.103.2023.08.26.21.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Aug 2023 21:59:20 -0700 (PDT)
Message-ID: <6c7a2565-dae8-1f75-0fd7-c77eca48ab99@linaro.org>
Date: Sat, 26 Aug 2023 21:59:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/10] target/tricore: Fix RCPW/RRPW_INSERT insns for
 width = 0
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230826160242.312052-1-kbastian@mail.uni-paderborn.de>
 <20230826160242.312052-8-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230826160242.312052-8-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.57,
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

On 8/26/23 09:02, Bastian Koppelmann wrote:
> we would crash if width was 0 for these insns, as tcg_gen_deposit() is
> undefined for that case. For TriCore, width = 0 is a mov from the src reg
> to the dst reg, so we special case this here.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c          | 10 ++++++++--
>   tests/tcg/tricore/asm/macros.h      | 15 +++++++++++++++
>   tests/tcg/tricore/asm/test_insert.S |  9 +++++++++
>   3 files changed, 32 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

