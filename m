Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C8F7C86C2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:25:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrI9T-0007l4-Rz; Fri, 13 Oct 2023 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrI9R-0007kC-Cg
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:24:25 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrI9P-0000fe-RS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:24:25 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b709048f32so91052b3a.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697203462; x=1697808262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GHJybb6DACavOvETjWa+Di361Pgfer/3yhWD73zyrq4=;
 b=CN8rbSurdg8EIQyhpFxa9qmA5FuJW8FbvCnVrBcLWYz34TCjLvXysjPBRmtIPBXT6w
 daXt3mTyDBKJtEJTaOL8wDotn61OXDmahz26Ua+d6t6Tz5cljaHPriO2w1NqSXscvTor
 p2jMy+TgsKqoxLWwoc3UE88EMkLrthVf0GtQDP6G8Y7+444KajZKCHFm2XRiLCLdCvDz
 dBczkvT9O2NdyXV870KvIAk2ufASmP+Ts5M62mQ4N3Akoyo7IYCC7vD2bMFdLJgZ+7ya
 7Al1IwqcxxEqjLvmXKFmN2RuYrG+Eg6zWc1PLJbAcVjD0kT7xCv+0jfqiWfC2g1LkGb6
 TYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697203462; x=1697808262;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHJybb6DACavOvETjWa+Di361Pgfer/3yhWD73zyrq4=;
 b=OlJj0yakw/hN9acGpixNOcs4qAwLvVwtTIHKFtwFnRRJ3OAhWZUqe9Hz6MsWZ5+Uyy
 d4MqC4SUbayOki1yugVYgB1y1OGXrKmXzCrU1Mu1ZGbgk3TPhnL7IU8AX9e+PqsuoJgJ
 JMPL8K/WDvBSR207rHB4QRzKWOR7nK1R3GABGJt8Z+g6WdBFV9rNfz60M0rQFQ/PLCGu
 JOqX0Q1pk4UlAIMLirhh/QPhHKopFHU8EvCzsvbw+sFXeQ0InJWhZWqQD3zhChpz8pcx
 NZDdpHZ7L5yrGPFkCMfswM+gaBI/Af0TGF0ayjbtJU/e0n6WWQmc/G52To57HGAHV7iO
 eNIQ==
X-Gm-Message-State: AOJu0Yw57lRLuQwS+3Usv8uROEzLFZiWkkXfI8d/hj7RdJFYxORjYt1d
 NXGhNSnQbYE1tY4fYbDOtRxo+c9Wyc3ZqgxEp6Q=
X-Google-Smtp-Source: AGHT+IG+kfJbQGGRZKF2NA379WVXqMe6S9LEfZejwSrlJN5d7rww7u087Lr5rdTPGlXIKpRRiWciBw==
X-Received: by 2002:a05:6a00:190e:b0:68b:fdfe:76c2 with SMTP id
 y14-20020a056a00190e00b0068bfdfe76c2mr26927471pfi.20.1697203462161; 
 Fri, 13 Oct 2023 06:24:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 h26-20020aa796da000000b00688965c5227sm280527pfq.120.2023.10.13.06.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:24:21 -0700 (PDT)
Message-ID: <5271d2b8-2f52-4cc6-93c1-30d56dc7c1f3@linaro.org>
Date: Fri, 13 Oct 2023 06:24:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/ppc/spapr: Restrict PPCTimebase structure
 declaration to sPAPR
Content-Language: en-US
To: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/13/23 05:56, Philippe Mathieu-Daudé wrote:
> The PPCTimebase structure is only used by the sPAPR machine.
> Move its declaration to "hw/ppc/spapr.h".
> Move vmstate_ppc_timebase and the VMSTATE_PPC_TIMEBASE_V()
> macro to hw/ppc/spapr.c, along with the timebase_foo()
> migration helpers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/spapr.h |   6 +++
>   target/ppc/cpu-qom.h   |  22 --------
>   hw/ppc/ppc.c           | 107 -------------------------------------
>   hw/ppc/spapr.c         | 116 +++++++++++++++++++++++++++++++++++++++++
>   4 files changed, 122 insertions(+), 129 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

