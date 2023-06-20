Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6B97366D4
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXD8-0007Wv-BV; Tue, 20 Jun 2023 04:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXD5-0007W4-TE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:59:35 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBXD4-00063w-A7
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:59:35 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so542424066b.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687251572; x=1689843572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bk1WWc2OsWTvabacK/WESYj8WKq3rwbdQ5NWHegaIDY=;
 b=iscCA7albEx8EOQwttEgwKbjjM97wAUS8Z5fX5Fq1HJwB6VNGlyVjPcwmxUJrFS600
 WiGwoACiKr9Qv+H3ubnroQWLJtvNsnzmJsPRWLASJbyUeZUC/a84XW1qVKUqoQcHnPhe
 CCAmW5KRY0ahVRoaKRBGg9oQlHZ0y8kgHnf7ZhIvhGdB7rrFrYdgtYXw5S5oDa0D6UFZ
 z2CpYlY6eYfVvCEpHwGSZAW7kIN/NIr5sg60MRmWdueXVbYz0W2rL+F634AUCvL+wneT
 HQjhfX2GnAoXmgbNbu5UouzKrkOAZebNFNIDQ3zKVxQTkB8rYQewfoRt6lsnWKFEjUw1
 yV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687251572; x=1689843572;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bk1WWc2OsWTvabacK/WESYj8WKq3rwbdQ5NWHegaIDY=;
 b=LyQv11X1QjeJ1o+qpcwWwELJt2xKNRYd/srmL65ld3evNhyXphT2ugZ3+YfaM4qe2O
 wUHTQ+qzlesvIdfBcMll/MdanIRkewQA9jghI+Gy7UZnj63490SPj7ArjF3PuMQYxXqL
 T0B8/akpaTyqWsqYkmCXm2z2rrtx58berUEudcXKFUqTczts+OBIFe/chY8aI1U5ZlLM
 TtmanHfBRyre1+RVL0EulDYCTaO9OSLX96m0j5uwi+U+lNbfOj43HHOTFK/xjzyyoNRJ
 FicUjIq6NXYuQ0lHCmmY9jmRE4yK8wIUsSBvHUDYStwDtxHvP8ALpazzJvrdm5jQFw8P
 hK+A==
X-Gm-Message-State: AC+VfDxf/0tCsZMS+QUJjyCgSkaWXW6/Q/cLgPwnZOi/CZB9vq8ZCv9a
 nFZxK3QI243J3dIyBXVRuNmXPQ==
X-Google-Smtp-Source: ACHHUZ62z62OcJXgkOgoSdST5Eho5Shq66LOHBtKXj3VfzVfKhiFRAea/qYRbuIh1LOErigkEkUD6g==
X-Received: by 2002:a17:906:5d0c:b0:988:71c8:9f42 with SMTP id
 g12-20020a1709065d0c00b0098871c89f42mr5852440ejt.8.1687251572334; 
 Tue, 20 Jun 2023 01:59:32 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a1709067cc700b00988b86d6c7csm1006106ejp.132.2023.06.20.01.59.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 01:59:32 -0700 (PDT)
Message-ID: <28b351a9-49d2-bf5b-ab02-2f1425f0855b@linaro.org>
Date: Tue, 20 Jun 2023 10:59:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] x86_64/atomic128-ldst.h: fix arch include guard
Content-Language: en-US
To: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230620083918.9134-1-frederic.petrot@univ-grenoble-alpes.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/20/23 10:39, Frédéric Pétrot wrote:
> Fix arch name in the define that prevents multiple inclusions.
> 
> Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
> ---
>   host/include/x86_64/host/atomic128-ldst.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Whoopsie.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/host/include/x86_64/host/atomic128-ldst.h b/host/include/x86_64/host/atomic128-ldst.h
> index adc9332f91..d0240d4212 100644
> --- a/host/include/x86_64/host/atomic128-ldst.h
> +++ b/host/include/x86_64/host/atomic128-ldst.h
> @@ -8,8 +8,8 @@
>    * atomic primitive is meant to provide.
>    */
>   
> -#ifndef AARCH64_ATOMIC128_LDST_H
> -#define AARCH64_ATOMIC128_LDST_H
> +#ifndef X86_64_ATOMIC128_LDST_H
> +#define X86_64_ATOMIC128_LDST_H
>   
>   #ifdef CONFIG_INT128_TYPE
>   #include "host/cpuinfo.h"
> @@ -65,4 +65,4 @@ static inline void atomic16_set(Int128 *ptr, Int128 val)
>   #include "host/include/generic/host/atomic128-ldst.h"
>   #endif
>   
> -#endif /* AARCH64_ATOMIC128_LDST_H */
> +#endif /* X86_64_ATOMIC128_LDST_H */


