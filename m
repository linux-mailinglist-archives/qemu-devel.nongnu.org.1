Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC170ADA0
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 13:38:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0hNA-0002d6-PE; Sun, 21 May 2023 07:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hN9-0002bD-3B
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:37:11 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0hN7-0000Bp-5e
 for qemu-devel@nongnu.org; Sun, 21 May 2023 07:37:10 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f601c57d8dso2999695e9.0
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 04:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684669027; x=1687261027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1Qu0B0ldTle60waGFJy+QMGdYezVw7yhxtyunoe8NbQ=;
 b=ujsKxi3nroQEJx9t6Gz/YjG47nmttbLZ+uMCy59L32DwnCJ+B8TDPS/Ed9PHYyj98c
 Hb4K09YBGuYJZk4cQqpdusGty9g6SlKXAhgkegwd4zDPNXJGlzB4MhLiGlP0cd6gB0hE
 4ixGS/8uo9vCQyDMjS4K9UXUNjPmCsQTAZ3pmcpi4Kg2IxnqGnPeAmfTK5Umdhk+cfrW
 K5yzevvUCQVbDrOZSTe45+F/LpxgmyM6GkRggad7rpCv+kuL5iFy8o/H36DFTGD0XgeK
 S8pq+bwTpd9VJi7kML77N5QpwP5rZSx3YX7f9OXc6gZMDqpnDcGl8ZUHkUc8xAh0NfPm
 CqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684669027; x=1687261027;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1Qu0B0ldTle60waGFJy+QMGdYezVw7yhxtyunoe8NbQ=;
 b=RoA5BEc1VjfhsEXfX7mfvbKwsBEmGArIdlDh/4ctVfzWEaT/idzqDTpo2vZo04YzRf
 B7VZ1t89SYRnLE+/z/81/PrgUL4cw2bOrzKAf3AQsbqzkA7sHblf2nba3ozhf3Xt6Wpw
 tvmurXFTCHkkMh/SneMjJ6z1DG29PsLPFTOD0DQcWAr6mBnHOoEuEVSjurZAcoP1A3g3
 Mp7ZCpFBCPi3Ptw2BwKTvEwxzeFoKONbg0X1mLFSP9bMTvS4UkaeTfECSTR+Gr88b61j
 9PsMTNVL0izcWFampLN6aTrRX9W1Bd/wZBgBOUdy5rmO+H/It+IhnjwHiyPTbFabC7g6
 DKCw==
X-Gm-Message-State: AC+VfDxJDRlCa5rTN3oCRyoCp1yOd9QWLF7AlUdGkw7OBtzCikE7uXn3
 oKMqPm1qlfwyjcHI8GzfsSoa7w==
X-Google-Smtp-Source: ACHHUZ5UpNmBdiJBY7yswHqeOegHR6lvAhVvlT2JxBgmiWueTEzEQbglODag/UCAaR2rfutYCZrLVw==
X-Received: by 2002:a05:600c:2256:b0:3f1:7848:6740 with SMTP id
 a22-20020a05600c225600b003f178486740mr5421750wmm.8.1684669027203; 
 Sun, 21 May 2023 04:37:07 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.152.177])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a1c7503000000b003f09d7b6e20sm4995455wmc.2.2023.05.21.04.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 04:37:06 -0700 (PDT)
Message-ID: <0bb0cded-8450-536e-b90f-1a9d33311c2a@linaro.org>
Date: Sun, 21 May 2023 13:37:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] target/mips: Rework cp0_timer with clock API
Content-Language: en-US
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: chenhuacai@kernel.org
References: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521110037.90049-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 21/5/23 13:00, Jiaxun Yang wrote:
> Previous implementation of MIPS cp0_timer computes a
> cp0_count_ns based on input clock. However rounding
> error of cp0_count_ns can affect precision of cp0_timer.
> 
> Using clock API and a divider for cp0_timer, so we can
> use clock_ns_to_ticks/clock_ns_to_ticks to avoid rounding
> issue.
> 
> Also workaround the situation that in such handler flow:
> 
> count = read_c0_count()
> write_c0_compare(count)
> 
> If timer had not progressed when compare was written, the
> interrupt would trigger again.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> This seems fixed MTTCG booting issue on malta 5kEc with SMP.
> I'm going to do more test and see if we can enable MTTCG for
> mips64el.
> ---
>   target/mips/cpu.c              |  8 +++++---
>   target/mips/cpu.h              |  3 ++-
>   target/mips/sysemu/cp0_timer.c | 35 ++++++++++++++++++----------------
>   3 files changed, 26 insertions(+), 20 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


