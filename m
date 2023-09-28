Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869097B2798
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlygB-0000iA-L7; Thu, 28 Sep 2023 17:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyg2-0000gg-Lk
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:36:06 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyg1-0005tE-55
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:36:06 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2774f6943b1so7224080a91.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936963; x=1696541763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EebwEyf28F4dRjrNAg18DAlEhBDtV9LFksVtSWpk/kI=;
 b=cY0ee/0oNU51s9ES6j6/yXu0DDtIzfXxR/t8QBTEQG3uFuxJdpDFR715MStlVIOLgD
 fmEtA3EFR92XOh2hvXtyBvjWBSx+s79YGsmYoTVrdXe8A2irAOJzij96JPtSSUD0ZBn6
 LEJZGAqe263HJQmSGE5fo46mVsLYAxOcaxMi8pt+GIBBGG5uLg5oSQF2UTZMpluJPbP0
 ex9n7IZmut9PuOQfpI+t/KPs+iaS2flckRO2k/pdrHyfS/hBH0dy5O/KntggfOAfveaV
 4VQsLb1eqPNhtr2NmwQMlBSxBtoh9XoSMv9Q7Y8vH0C40JufdVaU9ngnN9EZvtm4nA3S
 JOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936963; x=1696541763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EebwEyf28F4dRjrNAg18DAlEhBDtV9LFksVtSWpk/kI=;
 b=rHAJF/QHIsnORm3ZxBd4CCbRq84gejYtpFYoQ5//k3fVRmyvmsG2YiBx5nOuyHLQYf
 4wraoulfOcV6QVm1+teWa6+UF4DIEx4fWgdAB1ihx3JdLjQjW+jc9i+2IjNLUFiADtiH
 fFZ1mQ8Ix9Tz+XIfCZCo2v9s+KG1jYNa+1tHuX+R1mPXHM87xljcMZLoyOVFEMEOTRrA
 DjLL7Dq8FfDV08tq8mZ84oSyeR1+AvEAy2DqVQTtTNZjMG9PDV2wW/NswVnnlpp4YysC
 O8PbywicJ6olf6GWbHeXYgbRkn1BdoA6Jw756d9n972ZlvG0r7gA6dB82icuZZMYduzQ
 18qg==
X-Gm-Message-State: AOJu0Yzlu6JOjiVyCAiLOOKwHxJapizFq/CG+bHofEeHQx5menuMkc9o
 874mW602Wluo9301ve2ZV1URNQ==
X-Google-Smtp-Source: AGHT+IE9dxk44SngE703TYhUIB2uFEx5WajS7hpj6SOdkfO14mHGAAVY321AuwOrue53V+3h9CrxsQ==
X-Received: by 2002:a17:90a:df82:b0:277:6a7b:b904 with SMTP id
 p2-20020a17090adf8200b002776a7bb904mr2287703pjv.15.1695936963629; 
 Thu, 28 Sep 2023 14:36:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 x5-20020a17090abc8500b00276e8e4f1fbsm12997pjr.1.2023.09.28.14.36.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:36:03 -0700 (PDT)
Message-ID: <7eeb96f5-b9a5-dbb1-2df3-d900eec8f27a@linaro.org>
Date: Thu, 28 Sep 2023 14:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 7/8] target/sparc: Fix VIS fexpand input register.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-8-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-8-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/24/23 01:03, Nick Bowler wrote:
> This instruction is documented to get its input from the second
> single-precision input operand; the first operand is ignored.
> This is exactly what a real UltraSparc II does.  Meanwhile, the
> the emulator uses only the irrelevant first operand, treating
> it as a double-precision register, and ignores the second.
> 
> This will not normally contain the correct data so the emulated
> instruction usually just produces garbage.
> 
> Signed-off-by: Nick Bowler<nbowler@draconx.ca>
> ---
>   target/sparc/helper.h     | 2 +-
>   target/sparc/translate.c  | 5 ++++-
>   target/sparc/vis_helper.c | 5 ++---
>   3 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

