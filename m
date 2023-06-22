Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 453AA739C3F
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGLQ-0003zR-D4; Thu, 22 Jun 2023 05:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGLO-0003z1-AS
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:11:10 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGLM-0002U4-QQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:11:09 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31114b46d62so7210570f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687425067; x=1690017067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuOwQCA+pAwL2HhzTpc8yUZpBbtGEN0SCfBahFZhQdc=;
 b=LeKUgphqpQYhjYa8KX7EvJVm9WcFDkhAltsqVTlA+kcIS0Re9FHfcgy+lx3IQm3ieE
 e/QvQppLaHye+3HtiSz4Tf4yX/Mcs+EmLB4QAJ3vu6egvgVpagj5W+pA3g5gc/EuPUYP
 4fGnd3DniI8rBkSos8BUOSqv872HMVqON0kJzQ/cTjvXMco2Yv8bWcOkaMGOp98auDyo
 Km02TWr9v+n9ho9iT7oGLo2csPOa4KLhMpr37gapZCPUUZ6hDC8qaele7D4wVYaJ1YEq
 3pqvJPqyu+au6RTDCMFJ+m+QmXAkBNzKifwxuET7rhJgxp2hHfPJ0nUtZi+1WBAuFmuO
 uQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687425067; x=1690017067;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuOwQCA+pAwL2HhzTpc8yUZpBbtGEN0SCfBahFZhQdc=;
 b=kyXGrqWHkTM4iSbIsqRv6CmaOIs6a1nkC7ruRQvs/cZJSx9zPEUfOyh/oMgQg9S1ks
 Z1U4rC8bxU4DYVXJzfQrsVVSubTHKUOeC57E/vzvlG+UuUzkXj+XvgEhywbE0fxnKu60
 5vn7HhZqwFQ/qKo3uqqEPWP+r02l8Ysw/kAvGb0lNe8aPECbJId7m9qJufmqTX7hQ7G6
 ynphhjkGHI0gqzZS0C/gmpW0ZR8hsG03QfvqlRg/+Z/cON91ox14+anD3SibtBnoFOGV
 52B9oaOfQXfzun9kIW90dFZ3BSot88z4oTbUvw4Cfxj8L+zUfRedaKiBovn6/+pAU1E1
 fLlg==
X-Gm-Message-State: AC+VfDwmFgKZrkvocwzMT7S0T0N9Du0ekydcOukqIrC/23XBM3i+u6P5
 pdOgxcQ/Ngytq03/Vl8xNwOOrw==
X-Google-Smtp-Source: ACHHUZ4muJhOYibBK/M8kp2gR0zEz0lY7s2Ru8ewN7aIm2KIx9maTWKsf3zF2CjwoATSkKJ7XVW14w==
X-Received: by 2002:a5d:464e:0:b0:30f:c801:aa7c with SMTP id
 j14-20020a5d464e000000b0030fc801aa7cmr18211386wrs.43.1687425067252; 
 Thu, 22 Jun 2023 02:11:07 -0700 (PDT)
Received: from [192.168.69.115] (che77-h02-176-184-42-18.dsl.sta.abo.bbox.fr.
 [176.184.42.18]) by smtp.gmail.com with ESMTPSA id
 w7-20020a5d6807000000b003127741d7desm6525608wru.58.2023.06.22.02.11.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:11:06 -0700 (PDT)
Message-ID: <5210c8ea-910b-e002-20c0-0603e6445bb2@linaro.org>
Date: Thu, 22 Jun 2023 11:11:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/9] accel/tcg: Move TLB_WATCHPOINT to
 TLB_SLOW_FLAGS_MASK
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621121902.1392277-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 21/6/23 14:18, Richard Henderson wrote:
> This frees up one bit of the primary tlb flags without
> impacting the TLB_NOTDIRTY logic.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h |  8 ++++----
>   accel/tcg/cputlb.c     | 18 ++++++++++++++----
>   2 files changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


