Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78281F290
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:41:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcZw-0004zL-F2; Wed, 27 Dec 2023 17:40:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcZu-0004xP-3n
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:40:42 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcZo-00073a-Ic
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:40:41 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6d9aef87d44so764701b3a.0
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703716835; x=1704321635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k2niL5YaFS0EBFtoVfbLTXFZi/r3uPyi3V1hKPaD+O4=;
 b=QC6sWuBsuVeJ5oQN/yqR5I8sv6DxlzZIWWPs+J5YdMSwiZ3sQccqgscKYCHjvcZREo
 jF3eF+jjPkNTQDOUK2b9vtNSfbC5qpqT7lV+cdsbjj05d40MxC4h6sQfQtndfPHE1v6p
 tJzXVVwC2+QKNdOgTQiVeeF2rmAVESFRRW4dOUcy2nRWYmUVIKYHbmfUrFE2ZMZNug8T
 IfvQSSTme5YIsJITlOv25sxfsSbHt9M997hl24xL1ocvcxN81U8FuXkuNfEsauqXrBty
 oeNYP4P+hEf77UJ3q0wv+OEXbIZPARRYJIAmB7b1oDe2S9AEja57yQAPe5il7Drr48Sf
 ELtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703716835; x=1704321635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k2niL5YaFS0EBFtoVfbLTXFZi/r3uPyi3V1hKPaD+O4=;
 b=B8oJkaFOsbqkWmNhkSHkxtedkO8gHmwaW7iDXJbXFWyo/dqM1d8qF2v8SzgdYxM9Lx
 zAgkbBshEU+YWRNmUp2zycP7l+mdaFVStbh+xCX+3wnKCSlpOlTVu7I+NjO3YfQur4qI
 Niq2n6rtuahxWalWFn+68xBJvciwsgMe4o+pciAWTHS18ETNAj5oElqlKpsVAcCGy3xr
 97dlzXM5fqQEaqZEEJT16KCjP/dIYuEERKaZQwMc1jBPkgUC0prphQ+9Xc2CR7g+NW8g
 zTAz6NBbfEhpkGkgZRZYObYgjmO05y28KIeuM6eYt3/CDnxt8au+y0KxQFyaSJzwCktR
 TgsA==
X-Gm-Message-State: AOJu0Yw3ESIdKzNzfr5QbMf5mGn0SmUZBRtfB5jTN2UXegofcJtHgkG0
 NXfF+OXgsuRIQSKEn0NNWgpOmRBWVsRVtYuRGHTAnZB0gJiVIA==
X-Google-Smtp-Source: AGHT+IHUsUpCz6QdnWjLGDXpKDbOnCtDvHi52XyOPbfRaJgqppoXQDTo6oM7XxqSdrtr29LswsVqVA==
X-Received: by 2002:a05:6a00:1a8c:b0:6d9:c515:28ec with SMTP id
 e12-20020a056a001a8c00b006d9c51528ecmr2412237pfv.69.1703716834849; 
 Wed, 27 Dec 2023 14:40:34 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a056a001a8a00b006d99cd6ec89sm8403478pfv.185.2023.12.27.14.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:40:34 -0800 (PST)
Message-ID: <a251cdaf-8017-4d94-824e-dee87e272902@linaro.org>
Date: Thu, 28 Dec 2023 09:40:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/35] target/arm: Trap sysreg accesses for FEAT_NV
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/18/23 22:32, Peter Maydell wrote:
> For FEAT_NV, accesses to system registers and instructions from EL1
> which would normally UNDEF there but which work in EL2 need to
> instead be trapped to EL2. Detect this both for "we know this will
> UNDEF at translate time" and "we found this UNDEFs at runtime", and
> make the affected registers trap to EL2 instead.
> 
> The Arm ARM defines the set of registers that should trap in terms
> of their names; for our implementation this would be both awkward
> and inefficent as a test, so we instead trap based on the opc1
> field of the sysreg. The regularity of the architectural choice
> of encodings for sysregs means that in practice this captures
> exactly the correct set of registers.
> 
> Regardless of how we try to define the registers this trapping
> applies to, there's going to be a certain possibility of breakage
> if new architectural features introduce new registers that don't
> follow the current rules (FEAT_MEC is one example already visible
> in the released sysreg XML, though not yet in the Arm ARM). This
> approach seems to me to be straightforward and likely to require
> a minimum of manual overrides.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpregs.h            | 34 +++++++++++++++++++++++
>   target/arm/cpu.h               |  1 +
>   target/arm/tcg/translate.h     |  2 ++
>   target/arm/tcg/hflags.c        |  1 +
>   target/arm/tcg/translate-a64.c | 49 +++++++++++++++++++++++++++-------
>   5 files changed, 77 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +             * (This makes a difference only for a couple of registers likee

like



r~

