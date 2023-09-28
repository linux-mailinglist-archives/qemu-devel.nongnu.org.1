Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 629887B278D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 23:31:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlyZa-0002fg-Cm; Thu, 28 Sep 2023 17:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyZU-0002fM-5g
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:29:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlyZS-0003dH-HA
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 17:29:19 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6910ea9cddbso11711483b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695936556; x=1696541356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxXu1o4f7qpaQKM+74ULezQnFvd/j8GuqcyEq4nBVYg=;
 b=wbQngt/6b0r1dgHh023kgXXKNSsXwANYB+dvhQzy3tPraesmEWxPWeLpQfHw1qKMZ/
 s7UJUoZG050gh5/Iv79fZdmbB/rSswZ5zW5RfDhpNgbjXcyrLA8+vP7lW0hRk8GEt/t/
 o3qYG4PXiUpBi2ACzEBp0cCMH91mlFaK3jVC7Y2RLIGoc0vCvMmr2+ZQxhwG2MZ8LOzH
 YRQAzbFRq/BFDDMzdzFURIQ+ud5Qyyo79GNfT8otjTfrgFluoPICRTlasFFoFn2kBs51
 93jODvlivcQO6J8+F6FI6JhM34LVsVaieRkq42A74rEQwzC6o30yQpIreESM3CnP+VEK
 Lmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695936556; x=1696541356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxXu1o4f7qpaQKM+74ULezQnFvd/j8GuqcyEq4nBVYg=;
 b=CwjRx6Bfe60cg1xZ5NQAnh0+k8XkLPhYxsX4Sjf3U8nZXSZhjXBqPEptENqaP6p9Ef
 glL178zALNX+vQCCQZ59uHt1C/PIpZ3kCvALYZYFhFBBWdy6oJQJ/90gWKMjYTP4AKKs
 WadpATqI1Fgfk9JPz+OHJF6dypni/doWBTX3j2+mWxhV44pxGIcFMC6Rt02Wh7vHvCZT
 0KiKEacovVbIVnp0wnvo6MLqOOkrD5Z+dhJYVg22W1BfJgQQ8MTwV5FGAALaziO6uMzB
 JL95Nc0YItnbSUi/WKYlL80HhD2fSlE4vD7gfh2tuRapQX5sY9wIH9h2usETogLeyJXQ
 qqSg==
X-Gm-Message-State: AOJu0YyoW19K4xwdvWCT+oGLO1d69Dd+cWJY8o4Eq9766Npb/ajB3Sl6
 C+DhLp8yPxmP/EEaAQ10NhHnlQ==
X-Google-Smtp-Source: AGHT+IESBrobmXLNqLBbwExAkBkcrhH2mK8poW4FZCzJP6V8CgJ6uxGftG643sk51W6qWSd80/BjUg==
X-Received: by 2002:a05:6a20:f3a4:b0:15e:9d1b:84bf with SMTP id
 qr36-20020a056a20f3a400b0015e9d1b84bfmr1974758pzb.23.1695936556520; 
 Thu, 28 Sep 2023 14:29:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 y10-20020a056a001c8a00b006926e3dc2besm13182158pfw.108.2023.09.28.14.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 14:29:15 -0700 (PDT)
Message-ID: <a6efe37d-4aae-ad6e-87b5-76fc680ec2a7@linaro.org>
Date: Thu, 28 Sep 2023 14:29:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/8] target/sparc: Fix VIS fmul8x16 input register.
Content-Language: en-US
To: Nick Bowler <nbowler@draconx.ca>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20230925050545.30912-1-nbowler@draconx.ca>
 <20230925050545.30912-2-nbowler@draconx.ca>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230925050545.30912-2-nbowler@draconx.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
> On a real UltraSparc II CPU, the fmul8x16 instruction reads its first
> input from any of the single-precision floating point registers.
> 
> But the emulator is reading the input as if the first operand encodes
> a double-precision register, which in most cases will not contain the
> right data and therefore the output of the emulated instruction is
> just garbage.
> 
> Signed-off-by: Nick Bowler<nbowler@draconx.ca>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1901
> ---
>   target/sparc/helper.h     | 2 +-
>   target/sparc/translate.c  | 6 +++++-
>   target/sparc/vis_helper.c | 9 +++++----
>   3 files changed, 11 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

