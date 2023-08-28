Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B2B78B71C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagmU-0001Nt-FY; Mon, 28 Aug 2023 14:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagmS-0001N2-E4
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:16:04 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagmP-0002Wk-U6
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:16:04 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1bf48546ccfso16500375ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246560; x=1693851360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7U/cIhbBXS/EsecqvdDk+RvgUD1c0nFhYu9i2go59kU=;
 b=nWv/oRLtjAczi1XbvmhW5aHlb7O18AQie60kpsQt/wi9MdvN00ktJCJZbH/7KQH33G
 mqjlFZSrY/DmvKkdQ3wQ18AUElFQb0Z87FUzb0+4ZkEwVntF/g49oqAjCQX1BN/kMgzx
 0+uh1mTCwn9Ed7XXTNxn+gO80UVmXArwZx3J4gTQhAO3/Sh2ukhACX5h0Wne6/MwJV8f
 msaMcNCXcQ2iczPIq6ODoqt/nZpeGsb2ptWNWRvYBjftXddgJXpKVdyHaIDGVGuZcFx7
 pr7Ubh+Jzuv82M55xi/fJt3+gftRVSfZsaHD7jpow0+GsK3Ud+R+Z1UK5qO1fe7/2FHK
 n7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246560; x=1693851360;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7U/cIhbBXS/EsecqvdDk+RvgUD1c0nFhYu9i2go59kU=;
 b=MC7nr4WsmXn+LaH7FcU4kEZhoBU+VrsAgvki9UQkmonqiNJFXecz1gTEexjUwvMP5K
 z1ifb1DQvFpC78wTbP1OW99g1QnPAsQd/QmS/jA9abJv5mXY1PEbJXNV20dmltO3kS7G
 xZ8kgx72dkX6Dl/w6/ZPO03goM21nNLdPJbhZe1pF0hsKGBrq2+pNzray4ksYqo8olpm
 clmf3+OIdqpkZmWB0VIV5b2+z0pKodEesofzB9yb5En7pwfykzQ4vVR1QxApzhiYj1v1
 dGLarDfo1UxZDqsBTZcuwqfqgfT/Uid6T2lvHG3XruS5ctzutbVOKfStJzef20OkP8/C
 0Abw==
X-Gm-Message-State: AOJu0YyMBLNXuBcpIh85BLDC0+wiZAe4d22xA39zpbtpfPIQRG1ADlRu
 FnwyGQhHbLwKf+BjWwaL+TfdAg==
X-Google-Smtp-Source: AGHT+IGixoxNk0N2ZtWChr7lWUd8IXkokh4oVZ9DFqUiLkuR6Ey5dwfk+33C8MzqeU+KCUcvrV4now==
X-Received: by 2002:a17:902:c40a:b0:1b0:3637:384e with SMTP id
 k10-20020a170902c40a00b001b03637384emr28030271plk.25.1693246560371; 
 Mon, 28 Aug 2023 11:16:00 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g20-20020a170902869400b001bbbbda70ccsm7684817plo.158.2023.08.28.11.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:15:59 -0700 (PDT)
Message-ID: <8fd2be59-9cd3-4ec5-e6e6-bea0e3c36c93@linaro.org>
Date: Mon, 28 Aug 2023 11:15:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 06/11] target/tricore: Implement ftohp insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 8/28/23 04:26, Bastian Koppelmann wrote:
> reported inhttps://gitlab.com/qemu-project/qemu/-/issues/1667
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>      - Removed special case for f_arg being infinity
>      - Clarified, why we need a special case for arg being NAN
> 
>   target/tricore/fpu_helper.c               | 38 +++++++++++++++++++++++
>   target/tricore/helper.c                   |  1 +
>   target/tricore/helper.h                   |  1 +
>   target/tricore/translate.c                |  7 +++++
>   target/tricore/tricore-opcodes.h          |  1 +
>   tests/tcg/tricore/Makefile.softmmu-target |  1 +
>   tests/tcg/tricore/asm/test_ftohp.S        | 14 +++++++++
>   7 files changed, 63 insertions(+)
>   create mode 100644 tests/tcg/tricore/asm/test_ftohp.S

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

