Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF67779B7
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 15:37:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU5q2-0001uw-E2; Thu, 10 Aug 2023 09:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qU5q0-0001rB-A7
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 09:36:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1qU5py-0003ga-Cx
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 09:36:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31781e15a0cso873837f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 06:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691674584; x=1692279384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ic48J12nNu44lj9Tz3lBcwTgbHsJI730JOJ/unsLydE=;
 b=t4uAKePzxy5tmj6pulAkS9DvdT/GXdQTjErr+/G3QWToNRkrRmrafhGrkWd6egJk9V
 FegkXfnsfjxH1MDTiSRn5ucCi+f64MevNwstt2v5Jrv1yUK3NaHI82OJY6QCcbcJPQfQ
 mJaRRGgAEeU2N6ti5uKByWTiv/qn1eL4ORfIH+WnWzXYTKg6rHzGqTW1Q7IcV5AxtFrW
 9BF6j/aiziNqm52h9MKfcsp0k5Nlq2fFsIm+HxjxF/P754RVeIb2xKwBHtB4aLyn8H0P
 0wEXS+zZ7IpefBRRus76Ee6bCRvbtPtnhfOOIEmsZYQ5FuRF4ibUkX9s9G9OZS0ad86H
 gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691674584; x=1692279384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ic48J12nNu44lj9Tz3lBcwTgbHsJI730JOJ/unsLydE=;
 b=foppODTf3v0QSXcbTE5tHNBFJBtoMYNEsJO1rr0pEfdH3iI7NwqFoiiJWY3rIf2uFF
 8Dntl9jnslWJ0yz0B/lhZpBO/3Cp6HPSAJxIwsEZJINPck2GS48PlzmS7TaD8qiySGQQ
 jznlRVYScHuXuH6dPoPl7t7n+/ihAwxd0KKuL44qSjziWMBzwWmGPN7bxq02tAnWGTfx
 4y4u/2m0SpQmJQmKWwnF+egPIcZCfEukl0Gi0FaMi3y+z3f1k7/WPua2NNOskHrQxaCC
 1Kx4evzEySVA1QUj6IIMa1WsQj1s7KN2c9U4RLBa5g2dGyUFrnNEAbM6fpYYXKVT4wGr
 vkDA==
X-Gm-Message-State: AOJu0YyIcXcaQ3kFHEJJAFpQ8V6iouBBKsCHOu7fGfJCXAmQiKjNrw99
 g2id7Huq7QYw8WHuYBNjJ92A4g==
X-Google-Smtp-Source: AGHT+IGzD50e8c0k0BZV6DsnnVw1oRnQ6Bioqhvp+obYHhGIAxbXJzcnfqlN2TFoX3aME4W0M8j3zw==
X-Received: by 2002:adf:edc4:0:b0:313:e48a:d173 with SMTP id
 v4-20020adfedc4000000b00313e48ad173mr1965589wro.68.1691674584256; 
 Thu, 10 Aug 2023 06:36:24 -0700 (PDT)
Received: from myrica ([2.219.138.198]) by smtp.gmail.com with ESMTPSA id
 t15-20020a7bc3cf000000b003fe601a7d46sm5093191wmj.45.2023.08.10.06.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 06:36:23 -0700 (PDT)
Date: Thu, 10 Aug 2023 14:36:23 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/6] target/arm: Fixes for RME
Message-ID: <20230810133623.GA2050932@myrica>
References: <20230809123706.1842548-1-jean-philippe@linaro.org>
 <CAFEAcA8wh35V4ivo2cMP6zUGgCDi6t9-AHS0FVfeLThvjHtV9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8wh35V4ivo2cMP6zUGgCDi6t9-AHS0FVfeLThvjHtV9A@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 10, 2023 at 02:16:56PM +0100, Peter Maydell wrote:
> This didn't build for the linux-user targets. I squashed
> this into patch 6:
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 7df1f7600b1..d906d2b1caa 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -2169,9 +2169,11 @@ static void arm_cpu_realizefn(DeviceState *dev,
> Error **errp)
>          set_feature(env, ARM_FEATURE_VBAR);
>      }
> 
> -    if (cpu_isar_feature(aa64_rme, cpu)) {
> +#ifndef CONFIG_USER_ONLY
> +    if (tcg_enabled() && cpu_isar_feature(aa64_rme, cpu)) {
>          arm_register_el_change_hook(cpu, &gt_rme_post_el_change, 0);
>      }
> +#endif
> 
>      register_cp_regs_for_features(cpu);
>      arm_cpu_register_gdb_regs_for_features(cpu);
> 
> With that, I've applied the series to target-arm-for-8.2.

Thank you, sorry about the build error, I'll add linux-user to my tests

Thanks,
Jean


