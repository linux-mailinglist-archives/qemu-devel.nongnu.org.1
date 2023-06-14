Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7D972F3E3
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 07:01:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9IdG-0007ve-Pr; Wed, 14 Jun 2023 01:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IdE-0007v3-GT
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:01:20 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9IdC-0006ZQ-KR
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 01:01:20 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f642a24555so8033696e87.3
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718876; x=1689310876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rIUbRwPXyD0bCNaHCt68EH1wEvTMGh1zBWnuUUIDOLI=;
 b=JsU3aymITPnHNLv5vXK9gwl65mjHTJlQO+W4cYisuVnF4OqVmbrF6Msk6V2bfkzrqM
 +xeuVTOva7d1yvlsSp0VVhqvZwOhtmMSkslBD9npNPx4tjgksCOCcWCvKpgqQCqpgPuA
 oNstthbqpkovMV2HHBe8n+fPH9T9kkNXki4STE8kIPAOb1c5i6RdcA31c2aa2sUVgGTG
 6MLs9w7pE8Ph6ATCyngJVZMvVFAJ49ZwMAVpNve8Y2CzCj8X81ZY5C0FlepzYt19sv35
 2os0ATuvtiLJWUoQSjKcq/pnlgBu43XGfiaGNQupCHC6JTT8qpr2jThcnKllqVML280a
 jmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718876; x=1689310876;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rIUbRwPXyD0bCNaHCt68EH1wEvTMGh1zBWnuUUIDOLI=;
 b=ZtHE/qykN776x/sKygv1oIIPtW8mfUvfSWWe69IcPCHdQZksqebhfQdBK/VqTyDfr2
 jZU0WFaujxmyNX5kl27kJI80wFRxhnb+408Gr3aTIEe/Jl0+tZqM7xOXUXBe8yGAFwnu
 NmlEvHg6DBdFHYJtKyPTSn43KmohpzPfp36jKhEj6P9/FMW1uJKijWeYOahgQ5hBBIu1
 JeYgHOFu0KM/Emc6WM5VSwh+JsYqV0U2us7JvmD0G956CAoqzD2Vylss7uDgMsv4Psyh
 j5CpKv+DcWZaDrr8vJXfzc1afI1ufID6FQW+LPeWrrjAdHFSZKZfw9C0XXPvgvWE7CSN
 NPJw==
X-Gm-Message-State: AC+VfDxOj/QVOftoBI6Ryo7pXKqvghaEAl1xpA5xXMTUgU92CyEaJLi+
 FL4ui56lXTwBRGlYrBBeDHF18Q==
X-Google-Smtp-Source: ACHHUZ59ieyKSq2Ub61+5k+VsSKTfiWcuioeBMdOCSOnICFFq+gUvwj+owbyZLSw68NUEA8IYNGYsQ==
X-Received: by 2002:a19:6749:0:b0:4f5:c86b:97b3 with SMTP id
 e9-20020a196749000000b004f5c86b97b3mr7151073lfj.1.1686718876399; 
 Tue, 13 Jun 2023 22:01:16 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 b14-20020adfe30e000000b00307a86a4bcesm17071019wrj.35.2023.06.13.22.01.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 22:01:16 -0700 (PDT)
Message-ID: <82a922ac-2c1f-97c1-2949-565add323688@linaro.org>
Date: Wed, 14 Jun 2023 07:01:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 23/26] target/arm/tcg: Inline 'exec/helper-gen.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-24-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> +++ b/target/arm/helper.c
> @@ -26,6 +26,11 @@
>   #include "qapi/error.h"
>   #include "qemu/guest-random.h"
>   #ifdef CONFIG_TCG
> +
> +#define HELPER_H "helper.h"
> +#include "exec/helper-gen.h.inc"
> +#undef  HELPER_H


Why is this here?  helper-gen is for tcg code generation, which should not be required at 
all in this file.  I can't see how the modification to translate.h affects this.


r~

