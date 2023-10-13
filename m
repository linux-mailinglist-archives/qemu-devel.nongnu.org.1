Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DAC7C8721
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 15:45:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrITf-0004FK-Tx; Fri, 13 Oct 2023 09:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrITY-00045c-W2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:45:15 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrITX-0006DP-ET
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 09:45:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c8a6aa0cd1so17260105ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 06:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697204710; x=1697809510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+1xel1i75QhNewR32I7YorOIZNVqIQBedrKE82mS/EQ=;
 b=HnXGoVq1eo4NXaXS+n9LtNUV69vPieCIALn61o97US3DxlojmvS2m+LLZZ0iRefF8a
 sFXhxk1Fcli2fSUClqa5872/P/AEfwQj/D1So4MAjxX+50THJKE6Z2v/j6O79MaIyUGh
 4SHQkCaas878mYU+lIzc/7thj1Xz1tUC2zBAKP7jcetbYBIyohIyFls10LbJEJuC+7dU
 Vjf3v+KADGyopYVSU4w+H+iNOGjvMqEb8vv4/tKqQYWDujDbkOaziwUNGPlqCHMA0o1f
 K274+CmyYEgAPrRtHARsyvck/rA+bXwFHDKzUtrS5kRwMWd18+EPw/1RebNGZ/i27jdk
 rsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697204710; x=1697809510;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+1xel1i75QhNewR32I7YorOIZNVqIQBedrKE82mS/EQ=;
 b=t4n2PxrwHXnet9bdFIdr3KUKlAc2QJE71bIzm4YoiEuVEIcKKifRctukxqEk6tVbpi
 DRgHxS1hkn7DCyKsuOp+hxsqY7+Xt4BMjdB74GJNuN2swuRUR2EI7ZNoYL99do1+np6z
 p9PL0466BfU3Dfmc3P05r1nRMe99Fqxg06+7eGfocZfHN5wMoxM1NdS9HyQXBuGXoeas
 dzZ4T1lVJysSRTziN10+4bwAU2gPt6Z59UvhIhAnLWcS/Taec3qUZCFuspPuHyF6s52G
 RF0hoqggYcA8B0IOi9NzAzODkPaIy9bjB0389NIeSxCpWaUxGrR6uf9vrV4/FF/z+TbP
 3koQ==
X-Gm-Message-State: AOJu0Yz2U5/e53PUKp+wbkjhlDl3e+QgbX7NwLqAsDgBeRZCMkgVx9bR
 P9OGQDxSMWYa/wR/of4HZWyznuENTjnWAENz5h8=
X-Google-Smtp-Source: AGHT+IGuKPBMNjzvHlh10ZWuUkqc73agxE+cZcaT2XviGCtRw+Jv6e4KgQj330Itxr5narLeHzkrpg==
X-Received: by 2002:a17:902:bf49:b0:1c6:112f:5d02 with SMTP id
 u9-20020a170902bf4900b001c6112f5d02mr21969821pls.55.1697204710017; 
 Fri, 13 Oct 2023 06:45:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jh10-20020a170903328a00b001bdb85291casm3905528plb.208.2023.10.13.06.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 06:45:09 -0700 (PDT)
Message-ID: <597ac58b-d601-47b8-abd2-733f254a6eb9@linaro.org>
Date: Fri, 13 Oct 2023 06:45:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/ppc: Move powerpc_input_t definition to 'cpu.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231013125630.95116-1-philmd@linaro.org>
 <20231013125630.95116-8-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231013125630.95116-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
> The powerpc_input_t definition is only used by target/ppc/, no need
> to expose it. Restrict it by moving it to "target/ppc/cpu.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/cpu-qom.h | 21 ---------------------
>   target/ppc/cpu.h     | 20 ++++++++++++++++++++
>   2 files changed, 20 insertions(+), 21 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

