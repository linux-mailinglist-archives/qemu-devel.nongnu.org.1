Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E89AE772980
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 17:41:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT2Lp-0000DZ-Pl; Mon, 07 Aug 2023 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2Lk-0000Cq-Sw
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:40:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT2Li-0007DL-NK
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 11:40:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686ba97e4feso4452067b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691422849; x=1692027649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P29RLOjDMDH0bTd5TEL4L1BGMytoouin0Zf+LgNCZYA=;
 b=WXOc71CSwo8tb3v7ZeQFE+IgKPGyKoa8M3SG/w0U6xevi8ldU2I3GcD0CEoweyuYHR
 Sc8F7JpqRR7QTcXAAYylFE/zHkPJpoDiyPiah0nBpRXGn69KNgaLWFCJ5+mQ+HeOBnpz
 c5I+Z1x8fkxEYuMa3xH1YN33xYKKk4AqgXnb/2stq3eeAVVDPl0ac44jE/SgWreEdoHk
 SL4ntgRmZfJxZ1Q4dLNcZh3yq3UvsgrZYYry9Dx6e53tsXyE7lHyMACcjXmeOJhXm4+A
 jZ/HvcHJPy6KaMy/VOhAPAKmsOTnwYQDPZd3QUF8oqINgFR4Z58Y9YNcF30Qao6laEcF
 2Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691422849; x=1692027649;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P29RLOjDMDH0bTd5TEL4L1BGMytoouin0Zf+LgNCZYA=;
 b=B1adkaN4kIRafSUsNsteZuftzPLROXV+T2GlWfAm2hPWWOMba/sMLGAWuTf1R48Tms
 rzAQWuT19sNdeX37sWiu1hk1mbfggCbGvnxJ+uNQNS3rfam82e7wuIeSJnVa6485lR1G
 OvNoVb443ZMPhz8XiZPH4QcvIPam4RNnZRhNnRy6P9Vx4iD+3IUUaeGaLBm48qHvw0BT
 Ox4ZqH0W4Vhhh1fJ2A4rh/YfM9rDo11EdaUIWH+d4deLNsipkmbXIiSfEc6Rvz+oduMq
 Kfxfb2v32R4UQqhQ69e4HVfghRK7iLw64XDbvnsypgahLR6cd3Ah+K01BBpRLjOAS9JM
 7gkw==
X-Gm-Message-State: AOJu0YwXboyuqZ4h/CCbOCuYOGttC3fm+CY7OjIi2yCUs6TLov3+47SR
 138TkmYn7vtd6osPO6jZgNvO9yLj92TW07tVOJ4=
X-Google-Smtp-Source: AGHT+IHG6xvmgMxk/wA+w7wTvVzI/njmetmONpUt4dj7xYaWU3XmF+M9v2mcDr3ikDhyI+ZYu5itNw==
X-Received: by 2002:a05:6a21:3b49:b0:140:2805:6cc9 with SMTP id
 zy9-20020a056a213b4900b0014028056cc9mr8482902pzb.57.1691422849092; 
 Mon, 07 Aug 2023 08:40:49 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 y7-20020aa78547000000b006661562429fsm6526702pfn.97.2023.08.07.08.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 08:40:48 -0700 (PDT)
Message-ID: <29e320c8-b95b-2188-a250-0eb5a19708da@linaro.org>
Date: Mon, 7 Aug 2023 08:40:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 0/6] Add loongarch32 mode for loongarch64-softmmu
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230807094505.2030603-1-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807094505.2030603-1-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 02:44, Jiajie Chen wrote:
> This patch series allow qemu-system-loongarch64 to emulate a LoongArch32
> machine. A mode enum is added to CPUArchState to select LA32 or LA64 at
> runtime. A new CPU model is added for loongarch32. Initial GDB support
> is added.
> 
> Changes since v2:
> 
> - Fix typo in previous commit
> - Fix VPPN width in TLBEHI/TLBREHI
> 
> Changes since v1:
> 
> - No longer create a separate qemu-system-loongarch32 executable, but
>    allow user to run loongarch32 emulation using qemu-system-loongarch64
> - Add loongarch32 cpu support for virt machine
> 
> Full changes:
> 
> Jiajie Chen (6):
>    target/loongarch: Add loongarch32 mode for loongarch64-softmmu
>    target/loongarch: Add loongarch32 cpu la132
>    target/loongarch: Add GDB support for loongarch32 mode
>    target/loongarch: Support LoongArch32 TLB entry
>    target/loongarch: Support LoongArch32 DMW
>    target/loongarch: Support LoongArch32 VPPN

There are changes missing for the translator.

All of the doubleword (D) instructions must be rejected in LA32 mode.

Virtual addresses must be zero-extended from 32 bits in 32-bit addressing mode.

I see a note about VA32L1/VA32L2/VA32L3 in CSR.MISC enabling 32-bit address mode for LA64. 
  You would want to implement this with a HW_FLAGS bit which indicates to the translator 
whether 32-bit addressing is enabled in the current mode.  This would always be true for 
LA32, and from MISC for the current priv level for LA64.

There are changes to BL, JIRL and PCADD* to sign-extend in 32-bit address mode.

What happened to the PWCH adjustment from v1?


r~

