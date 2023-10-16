Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8E7CA378
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:06:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJY8-0006dJ-Iq; Mon, 16 Oct 2023 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJY1-0006ba-O2
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:06:01 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsJXz-0004Ee-Cg
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:06:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-406402933edso43784415e9.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447157; x=1698051957; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bzO4vuOb1dUOqV1eJozUCpUsDI/mOPHGsaTuKyht7rA=;
 b=wogmLUn809TRinv1U+7czyvGEwf1PIlGhX7NKAIHPwX9c3E95zh5YJ/wSpHwjpcrm1
 i525ZYfsflaLg5mFmZks3/NXc2Oamzk4ERTxCixrT2KzO80VQVzAzF+DYhuGXeVuMYzm
 p1jVSCQKTMj9yJH3VMmiBhDwx44k52FlN6qGP8DAlt2vNRk2Y7MjalseaajZXYSO4538
 WNeYCNujC2y41SSQHNAxDoyfxj27BMrmXZcTQDYfTDYzpHhJChMtYxluN5UZRugocs9t
 dHPiF2CsAZDkFA9gXlYIVjzO0G33boxNDoPdXRi6Z0XCvXWXii75YDHzwU6RNC02mGtb
 D9Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447157; x=1698051957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bzO4vuOb1dUOqV1eJozUCpUsDI/mOPHGsaTuKyht7rA=;
 b=H1HJo6NydA/509q7hD684DG0uOTIY95UEwk1C3tEEoL34NKBcEnNlsGauadToLa7qv
 OkYpP9FSfKKDzCsWTnx4Rm8PiKlNb9bVRLDR2yhSnO5tj86aRhiAzWyBLmDkJZvSJ/g3
 QFfwlxpxWKmskJMOoy44aQaL0ouJo2TQwDQB9Qu4ItO8If0Dlu7C46dgOvpcCaEmI+Pm
 Lx8zo87+st7oo9gOVld67yVJHP7t1ZWl1h0GQtcgQ6ZtHkHZhUBEdA7JjvH6YZ2T970+
 iZyI6MuRXGp2Qyn41kILxdUPqn7EM+LxH2anzt8KeISkxbAkpJI53JJunMKxGmzRa9LN
 vD9A==
X-Gm-Message-State: AOJu0YzR4Y0FUl+WfLYaVsV/TWbuvjPxV7RMFPYeoL/S8zyGXZiLnK7K
 kBiuPL2SYWcglmlYlk8SHwYNoukR81L6Toq5xr4=
X-Google-Smtp-Source: AGHT+IHLE9ApYn/BsAxXdqdXIWiyx+FQkNs6mZEs2yYhlvYZj/zU21CzBlYTY7H7z2p/BhK/LCen1w==
X-Received: by 2002:a05:600c:1c8d:b0:407:8129:46ec with SMTP id
 k13-20020a05600c1c8d00b00407812946ecmr2919911wms.24.1697447157584; 
 Mon, 16 Oct 2023 02:05:57 -0700 (PDT)
Received: from [192.168.69.115]
 (9r679-h01-176-171-216-136.dsl.sta.abo.bbox.fr. [176.171.216.136])
 by smtp.gmail.com with ESMTPSA id
 bi13-20020a05600c3d8d00b00402ff8d6086sm6508202wmb.18.2023.10.16.02.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:05:56 -0700 (PDT)
Message-ID: <42ef00ea-6523-c497-b24e-08241c3ec4f4@linaro.org>
Date: Mon, 16 Oct 2023 11:05:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] hw/mips: Cleanup in preparation of heterogenous
 prototype
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20231009171443.12145-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009171443.12145-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 9/10/23 19:14, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/mips: Merge 'hw/mips/cpudevs.h' with 'target/mips/cpu.h'
>    hw/misc/mips_itu: Declare itc_reconfigure() in 'hw/misc/mips_itu.h'
>    hw/misc/mips_itu: Make MIPSITUState target agnostic

Queued to mips-next.


