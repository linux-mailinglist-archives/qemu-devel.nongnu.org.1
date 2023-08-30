Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFF78D666
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:08:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLqm-0006HJ-FE; Wed, 30 Aug 2023 10:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLqk-0006Gb-7J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:07:14 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbLqh-0006Oi-Ou
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:07:13 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a41031768so4108523b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693404430; x=1694009230; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7gPPfT9aHJWbM0s6HThJ+CP0TQcSjrQxaxu/jX5NSA=;
 b=EsGbvjcapiUYm0O7Kb7JqfY/6tdf791HP9Eq++qmYKIQAecw32mSaZwZ6AFMqBBIDw
 2pxPya3g8Iyvzv1q6JJdFrS1PG5/nRj3kj/ZCkCWP8mGz8E9DlD4y8Os01AZxvsHta83
 TO+zRe0/R2A2DtGJHG8oAasQ4GRSEXxsSbr18Fp3/r+y+Wb2sOP0LrNaozeaYVIY4wrE
 9SQm6aDrHAlbEREUs12o8fjY3JBo7BSGNDKjUudYpwRZMaYq/ieIv1qeR1CRU/q4g33V
 c1ty+aozP0DARt8Q5k7O1SG9MoejJlyo/87OlplwiWIvo5eGLFNtzqu+2ERMI/NpkrVO
 NKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693404430; x=1694009230;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o7gPPfT9aHJWbM0s6HThJ+CP0TQcSjrQxaxu/jX5NSA=;
 b=cehanujeJTLF7GeR72I7SR01raLM7sExf1Gn5U73FhB7d4opTjUFndjZ7sdEN0mYAl
 8fdOk+Z8gMq16ECJgrTz0dKsoB1/pX3aM+lWbBhlSpR6Qy3NS0UXSm6cqqAIED5RSStc
 4MzWexW7+5rni70fEU3LLlaytdwV99eR+zHa+gml6+glpbdoC545ryeRKZgzrjAK7DdT
 Yw9XYJyyifhImVGz3p54yGh32f0grWClF2+8YcmLNuF4toXm/+GiCHyf5WM0vqF31+lY
 83uGFz4NCEEaghQPARVOjvTXFfr+yuMrkVZQoVb5UaL9Ur+1n6Sk+u1immFkk2Eoaq/I
 4Zeg==
X-Gm-Message-State: AOJu0YyrCdKoshG43nkezf/lx9AVXUCkI3KK22eTlOP6pHi/z3XUJihX
 w1UD1KmnwxHwGSYm+vkM+uG/GBYs9CBAUtDLqxM=
X-Google-Smtp-Source: AGHT+IFpR/qbV0C9wpxJ0ENFRkM5H6W8TYdoPVUV1WQ5ySb6JEwMu892rQLlogrNGQ5qBSvoSS0iNQ==
X-Received: by 2002:a05:6a20:258d:b0:134:a478:6061 with SMTP id
 k13-20020a056a20258d00b00134a4786061mr2650967pzd.26.1693404430149; 
 Wed, 30 Aug 2023 07:07:10 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 h24-20020aa786d8000000b00679a4b56e41sm10090948pfo.43.2023.08.30.07.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 07:07:09 -0700 (PDT)
Message-ID: <7d7a65b3-3882-9d87-cddd-8de12ca55bed@linaro.org>
Date: Wed, 30 Aug 2023 07:07:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] target/i386: raise FERR interrupt with iothread locked
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, qemu-stable@nongnu.org
References: <20230830103141.138775-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830103141.138775-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 03:31, Paolo Bonzini wrote:
> Otherwise tcg_handle_interrupt() triggers an assertion failure:
> 
>    #5  0x0000555555c97369 in tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:83
>    #6  tcg_handle_interrupt (cpu=0x555557434cb0, mask=2) at ../accel/tcg/tcg-accel-ops.c:81
>    #7  0x0000555555b4d58b in pic_irq_request (opaque=<optimized out>, irq=<optimized out>, level=1) at ../hw/i386/x86.c:555
>    #8  0x0000555555b4f218 in gsi_handler (opaque=0x5555579423d0, n=13, level=1) at ../hw/i386/x86.c:611
>    #9  0x00007fffa42bde14 in code_gen_buffer ()
>    #10 0x0000555555c724bb in cpu_tb_exec (cpu=cpu@entry=0x555557434cb0, itb=<optimized out>, tb_exit=tb_exit@entry=0x7fffe9bfd658) at ../accel/tcg/cpu-exec.c:457
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1808
> Reported-by: NyanCatTW1<https://gitlab.com/a0939712328>
> Co-developed-by: Richard Henderson<richard.henderson@linaro.org>'
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/sysemu/fpu_helper.c | 6 ++++++
>   target/i386/tcg/translate.c         | 8 +++++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

