Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB473DC00
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 12:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDj5I-0001ov-ON; Mon, 26 Jun 2023 06:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj5F-0001ms-RG
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:04:33 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDj5D-000097-VS
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 06:04:33 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fb7b2e3dacso360017e87.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 03:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687773866; x=1690365866;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FKI0Hel25IyhAva9LDuziBz/oVZc1B06Aa04v6oRTJA=;
 b=j6D6xPKoc/BkKtJIw+PzMGHZLq4w2LDwORDTmDv711NzoyYfM/Mfe1RO6O5MqTOUEm
 dUgaXbhW3GVGUwymze6/eW8s0ax1OLegjfV6r4b3zj89anB6xfS5BMFct5fsU77PbHAK
 FQAQdZYfjAhn/nEgzaE8hapJRvBjBRBi1LGUwuvEKbbPnn+PQme7l42alffftlejoGox
 UIGYtyOi7uUBev4fI2E4n94kwYfWtNN0dT9CAy9vi258K5wYwdM8Yi4fwdsY+UTLpG2W
 PtWK2cYsoC6Y/unCnSsYWYHx+MerRCnyKzsiL77p6w4RtXPRqdP3kjha5GEZB/NjexkD
 S3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687773866; x=1690365866;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FKI0Hel25IyhAva9LDuziBz/oVZc1B06Aa04v6oRTJA=;
 b=Tpc1h5vYxOjy0ecsLj6IXGy2we/zfpOMeWds3xWFe2JwiYuiF3IU8kUuD/DACXx0h/
 Y8HKPEpcEFjg/q1QAiIRfEnzx8h4/M8z+ELarL9AvpQ9sTOFEDGAD69x317RQtEQnkbb
 nPEz4ksXJnE0fyizojz2NTe44psSncwDrqoSuqBVsUDLUDMwMxoFGz2ux+oQ/2gPlKlV
 RuhS/RhTWPk6/R/OxoFtNbRhUv7rDIcFtcnh7zpFNmHtVvGy+Nj2nniWs1tmB47xsZde
 SPqKFlpCGbMZkHaC2bsfJsyUYu5VckQvi/eqecZPEzhiRcNLTEL4PqgVpVUr+nPCUms3
 pq+w==
X-Gm-Message-State: AC+VfDxSyhzOt5KifU0UYPlumMFxNgsJ8ZYY66nxLDGKi14MHcK1D+/u
 BZ5go6OFWcK9r8DFo2rq0RcnPfsGVoAuPXRirz9ngfoj
X-Google-Smtp-Source: ACHHUZ7/wGlCJqhLjsCY2C1vmpcP+IJiO7hQx74mmTnnMgU6s9fNu3iLtJKbwJEATAXgQd3PhZ8/dg==
X-Received: by 2002:a05:6512:224d:b0:4f9:5d3b:6a38 with SMTP id
 i13-20020a056512224d00b004f95d3b6a38mr9953717lfu.45.1687773866391; 
 Mon, 26 Jun 2023 03:04:26 -0700 (PDT)
Received: from [192.168.157.227] (141.pool92-176-132.dynamic.orange.es.
 [92.176.132.141]) by smtp.gmail.com with ESMTPSA id
 n5-20020adfe345000000b0030e5bd253aasm6923035wrj.39.2023.06.26.03.04.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 03:04:26 -0700 (PDT)
Message-ID: <dc039592-ee80-1f34-0f0d-1e0695316eda@linaro.org>
Date: Mon, 26 Jun 2023 12:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] target/i386: ignore CPL0-specific features in user
 mode emulation
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230626083317.144746-1-pbonzini@redhat.com>
 <20230626083317.144746-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626083317.144746-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/26/23 10:33, Paolo Bonzini wrote:
> Features such as PCID are only accessible through privileged operations,
> and therefore have no impact on any user-mode operation.  Allow reporting
> them to programs running under user mode emulation, so that "-cpu" can be
> used with more named CPU models.
> 
> XSAVES would be similar, but it doesn't make sense to provide it until
> XSAVEC is implemented.
> 
> With this change, all CPUs up to Broadwell-v4 can be emulate.  Skylake-Client
> requires XSAVEC, while EPYC also requires SHA-NI, MISALIGNSSE and TOPOEXT.
> MISALIGNSSE is not hard to implement, but I am not sure it is worth using
> a precious hflags bit for it.
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/1534
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.c | 83 +++++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 76 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

