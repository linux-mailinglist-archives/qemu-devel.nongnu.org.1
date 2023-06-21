Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF7737E23
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:14:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBttj-0004S9-J1; Wed, 21 Jun 2023 05:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBtth-0004Rl-CT
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:13:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBttf-0004Fo-9B
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:13:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-988c30a540aso386590866b.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687338781; x=1689930781;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dgppXVXTc9T9trLOQQgbJTTblexaN9EHcgOrpHGOB3A=;
 b=HxDScBPWpGHuS6dg8Kc6WsYSjzKcgZVkF7Su26ZjGkGDDtr4GGYMbiILSADIEXaj91
 fnigJt52cowsVU/5zUITC2oWei6AtsTXxA29TMg5tBCYJMC6hmFK2zIYvJqnSTz4xCle
 nMoMspgPPEPPDgKszZEiIn6ZQ+y37GDV3xO7bqy04gMlyP6FkG+bpk6XWiScnOtWVrtK
 XS2O230V6nlrnF3nc9MLXOzfSzuf4s4BzBk7kp/hA/jZWMZo6Nua3Yo1YvX4W7FVvPgp
 51AiSNpEy54zrZTUO9j54oVy0/yLwJSzfAEFR2OyHF/xHSf7DVf/Uwx0kVZR3QhIwqqq
 5bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687338781; x=1689930781;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dgppXVXTc9T9trLOQQgbJTTblexaN9EHcgOrpHGOB3A=;
 b=APZu5e1vcWjiDiNmTnSIadzVehXNnKqYp7YB8t5wexuP1fst0wDctohxSUTjpV0cGN
 NLQ8/Bxk1Vn7FjUm/svTSS9on6eRLZvcFWi9rW7+Zjddvu8F9lnreu1dw1WGEAJ92BRf
 7hH9sf8aFOF3f/e8ETM9aadWb2AUBnt3CaJF/scW/FGkFtMAJyNYLR7EKgZ7Od7HA2wM
 W9VuoCE6LDfxQyhU8sGSCDDJXNf1we/qLubeDy/izZZ/A99E/rWgMZPx7WPx4pbD2ai8
 iveayVARgXXpNOM5azPqjPbUAmaAzbOC7YWDtRaGQhCmgyBB3Cu+akZKlSJLZbgUuv+q
 BCGg==
X-Gm-Message-State: AC+VfDxxrhgq0ITia3OghgOz5brnTXPgHSSUqAyQtYi/RRbqYr4hBqUN
 HlH9gh2ghNj0wUq86UhrrisGcBTY0zPAjpIwdtME04sj
X-Google-Smtp-Source: ACHHUZ44O0omWxgA/AAOe8uyWa9UIRsHuVr5JtYEx7RznZ4GMhEzJk0K4m8GvO0CecvRuL3mxVKPbQ==
X-Received: by 2002:a17:907:7b96:b0:969:7739:2eb7 with SMTP id
 ne22-20020a1709077b9600b0096977392eb7mr15009758ejc.4.1687338781189; 
 Wed, 21 Jun 2023 02:13:01 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a1709061c8b00b0096fbc516a93sm2728743ejh.211.2023.06.21.02.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:13:00 -0700 (PDT)
Message-ID: <0f0aed5b-1db2-59e4-0523-14d957eac24a@linaro.org>
Date: Wed, 21 Jun 2023 11:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] fpu: Add float64_to_int{32,64}_modulo
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: christoph.muellner@vrull.eu, alex.bennee@linaro.org
References: <20230527141910.1885950-1-richard.henderson@linaro.org>
In-Reply-To: <20230527141910.1885950-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/27/23 16:19, Richard Henderson wrote:
> Extract some common code from Alpha and Arm, and which will
> shortly also be required by the RISC-V Zfa extension.
> Added a new test for Alpha; I already had a RISU test for Arm.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>    fpu: Add float64_to_int{32,64}_modulo
>    tests/tcg/alpha: Add test for cvttq
>    target/alpha: Use float64_to_int64_modulo for CVTTQ
>    target/arm: Use float64_to_int32_modulo for FJCVTZS
> 
>   include/fpu/softfloat.h         |  3 ++
>   fpu/softfloat.c                 | 31 ++++++++++++
>   target/alpha/fpu_helper.c       | 85 +++++++--------------------------
>   target/arm/vfp_helper.c         | 71 +++++----------------------
>   tests/tcg/alpha/test-cvttq.c    | 78 ++++++++++++++++++++++++++++++
>   fpu/softfloat-parts.c.inc       | 78 ++++++++++++++++++++++++++++++
>   tests/tcg/alpha/Makefile.target |  2 +-
>   7 files changed, 221 insertions(+), 127 deletions(-)
>   create mode 100644 tests/tcg/alpha/test-cvttq.c
> 
ping.

r~

