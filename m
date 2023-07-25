Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4607176275C
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 01:33:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qORW6-0001wt-Hb; Tue, 25 Jul 2023 19:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qORW4-0001w7-Oc
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 19:32:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qORW3-0007LR-3s
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 19:32:32 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-563dae89bc9so441647a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 16:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690327949; x=1690932749;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XuPJ5j43ZvoOb0KGdDgasUb5Fn8Kyj/lPbEODJqGnd0=;
 b=cCk1kHSv950WrZHcovDUNvFm7mZcxA9cGbj8DZOlr1wygfH36It/O2i9dzMXb6GKO4
 dXohLrJum1vrqfLJHZ7G6/4QMK8xn1YzabNGbUwgCO9PCX5T7dre5R/H3539kJg4KZb9
 2WCY3R65b3KlQz/kYo8uNUGwyNmqjsqfZJvimXOOCv90bewWclSv2/kOLDIEeCySd3sG
 gRHaOmKGi1lrP8zY5UOANwHbatry2AGSF4O0eZupiU1H33oq85AiLXCiX0bW5UvDTmp2
 +KUpKnZArfAtiamOwYVkncOmfZfvVAOTX1uU5DfrwuY4ILFTwMdUX+dHder7ZvCnByjw
 njWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690327949; x=1690932749;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XuPJ5j43ZvoOb0KGdDgasUb5Fn8Kyj/lPbEODJqGnd0=;
 b=UYczRRMuKlBSQ8+Yc34c7AjUFK457xgOEUh7GClpKQNx42rm5jByG0KvHEONI2Po6w
 XP4n3LZ4jfo7L6Bi6xTm/eZ9kG2yrdaOF5ULOdjL+6SZFR4N2xYrVtN6e6dUZ84+//rE
 8mvYkKbCuGl5xklq3s/z8tTkEIc1Fov+h7A0bZryar41ALyoDy4xUvPVtXDhr9gJbXyZ
 ncc16Gj/86ikadiVMBE0618rk3AbmugULhxT9XnwNxiugOE88o1XmrPaTi+denHUHMH2
 nvxFd4wlLrJCXPTI262B4zCQrOjlgHfHnW26xp7Myw45bJ6jevwn/m1/tg8fRdOdsluq
 QwmA==
X-Gm-Message-State: ABy/qLaUvDk5b16RZm6QQ1ga6EzZO0oyhq3bXnWEUoRzgKNNQRV4UIpm
 et9KTVa7OvZ0yGXaJ9qJlreJaA==
X-Google-Smtp-Source: APBJJlHJV1utnswfKDiHb2lQ2ZIqC9lRHQMLogGfNNFYkgmA6w4MUvXd8ThsRVsSFbqxXfnmO6wJ9g==
X-Received: by 2002:a17:90a:2ac3:b0:25c:571:44bc with SMTP id
 i3-20020a17090a2ac300b0025c057144bcmr485522pjg.28.1690327949165; 
 Tue, 25 Jul 2023 16:32:29 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:a083:fa5e:b91b:bcc6?
 ([2602:ae:1598:4c01:a083:fa5e:b91b:bcc6])
 by smtp.gmail.com with ESMTPSA id
 br7-20020a17090b0f0700b00267bb769652sm111209pjb.6.2023.07.25.16.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 16:32:28 -0700 (PDT)
Message-ID: <1bbf8dfe-6b92-6a3e-8d0d-98eed2a9844a@linaro.org>
Date: Tue, 25 Jul 2023 16:32:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.2 1/3] target/arm: Do all "ARM_FEATURE_X implies Y"
 checks in post_init
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230724174335.2150499-1-peter.maydell@linaro.org>
 <20230724174335.2150499-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230724174335.2150499-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/24/23 10:43, Peter Maydell wrote:
> Where architecturally one ARM_FEATURE_X flag implies another
> ARM_FEATURE_Y, we allow the CPU init function to only set X, and then
> set Y for it.  Currently we do this in two places -- we set a few
> flags in arm_cpu_post_init() because we need them to decide which
> properties to create on the CPU object, and then we do the rest in
> arm_cpu_realizefn().  However, this is fragile, because it's easy to
> add a new property and not notice that this means that an X-implies-Y
> check now has to move from realize to post-init.
> 
> As a specific example, the pmsav7-dregion property is conditional
> on ARM_FEATURE_PMSA && ARM_FEATURE_V7, which means it won't appear
> on the Cortex-M33 and -M55, because they set ARM_FEATURE_V8 and
> rely on V8-implies-V7, which doesn't happen until the realizefn.
> 
> Move all of these X-implies-Y checks into a new function, which
> we call at the top of arm_cpu_post_init(), so the feature bits
> are available at that point.
> 
> This does now give us the reverse issue, that if there's a feature
> bit which is enabled or disabled by the setting of a property then
> then X-implies-Y features that are dependent on that property need to
> be in realize, not in this new function.  But the only one of those
> is the "EL3 implies VBAR" which is already in the right place, so
> putting things this way round seems better to me.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.c | 176 +++++++++++++++++++++++++----------------------
>   1 file changed, 94 insertions(+), 82 deletions(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 69e2bde3c2d..58301c4b7d8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1356,17 +1356,105 @@ unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
>         NANOSECONDS_PER_SECOND / cpu->gt_cntfrq_hz : 1;
>   }
>   
> +static void arm_cpu_propagate_feature_implications(ARMCPU *cpu)
> +{
> +    CPUARMState *env = &cpu->env;
> +    bool no_aa32 = false;
> +    /*
> +     * Some features automatically imply others: set the feature

Spacing after local vars.

> +    if (arm_feature(env, ARM_FEATURE_V7VE)) {
> +        /* v7 Virtualization Extensions. In real hardware this implies

Should fix the comment formatting.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I thought I had tried this myself at some point, and ran into a problem.  But I can't 
recall the specifics now.


r~

