Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A8799B6C
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 23:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf5Ve-00076d-DL; Sat, 09 Sep 2023 17:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5Vc-000769-3V
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:28:52 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qf5VZ-0004j0-Q1
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 17:28:51 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c397ed8681so4528215ad.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694294928; x=1694899728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BdIbh+YYWzBxeexxtVKKu9HRwXkba/c2g9uXv4VrUtE=;
 b=G8vfCqWGgJEfI0rPAX5CtoRkwN4HJUpZhxg1tk+c1oKVIf10lfP7sOoiPL4ftCgyJP
 MTvEgLc8OyzhzOmq/mbGCmBEdJnyaaBD9/V61T+KKpbUj+PBTSQW4vkhhtWHnQSzILqM
 /abhGiB37+yXgdTkpDFNU01R3N/CG6HtiVocdNIeVnw4Nmu1cqSLRVrxDcEq3SGzym2h
 YJcwTvTZm73vRCB7TfTt9VETv20lt6ueU3GgvqpICLVko0SZ4TiX9LGBSKat9L3geYQA
 I5xoamuCMI3JKw9l02HycA3JrHqxfbGWFYzHJCrqc7n4dZScJeodeQspJCnzqth7q2G1
 TGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694294928; x=1694899728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BdIbh+YYWzBxeexxtVKKu9HRwXkba/c2g9uXv4VrUtE=;
 b=MfYS9zTZc+mIS5slYMFTMQMaNntHXCVLzV9e7hzQpzC5Pd+o6h48nm07U9rBHY0Q/O
 V/j1QWkLXi4zML6U9/pBoRFds6muQ2hYis6CLEpVp4+qnlPamzv7WfuwA5U1dNyWStlm
 zw1P+zBarlJeaIyvV7MAKIXn4mDAEJ0gnXRmgn8W9y9cJzc6xo30I3Slpa2pqQv10zBK
 DTqIkoSG2WFZ7+b32k9y+YLC+AY8mvvfu5hgWchhi/+hIuoDQZgyCyDsAFXQtfY+eO+h
 jGWhx/tjrYJiyhF/btaAOkHHgTl9uWpmDs+GkuzD31iHLUPAY8FGg/oHdjolX5vuBZJX
 AvVg==
X-Gm-Message-State: AOJu0YwdrkwPNZmwwiuaTqlEGfLEFUiALpK+Z6WWF+INT5NNs70Io1rB
 tQone/fdhe2dgFfyXzPxMxzDrQ==
X-Google-Smtp-Source: AGHT+IFXt2gNCUwVAmXy3nOOr+mX+AbHmg7r/wzRmA4UQ0QxQAtDjlMteNZf2rjnqHuvHhUzJXpYmw==
X-Received: by 2002:a17:902:dac3:b0:1bc:2c79:c6b6 with SMTP id
 q3-20020a170902dac300b001bc2c79c6b6mr5586086plx.28.1694294928034; 
 Sat, 09 Sep 2023 14:28:48 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 1-20020a170902c10100b001bc2831e1a9sm3664171pli.90.2023.09.09.14.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 14:28:47 -0700 (PDT)
Message-ID: <30d59aff-54c1-9250-67c7-2e6f2d2ff320@linaro.org>
Date: Sat, 9 Sep 2023 14:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] accel/tcg: mttcg remove false-negative halted assertion
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ivan Warren <ivan@vmfacility.fr>
References: <20230829010658.8252-1-npiggin@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829010658.8252-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 8/28/23 18:06, Nicholas Piggin wrote:
> mttcg asserts that an execution ending with EXCP_HALTED must have
> cpu->halted. However between the event or instruction that sets
> cpu->halted and requests exit and the assertion here, an
> asynchronous event could clear cpu->halted.
> 
> This leads to crashes running AIX on ppc/pseries because it uses
> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted = 1 and
> H_PROD sets other cpu->halted = 0 and kicks it.
> 
> H_PROD could be turned into an interrupt to wake, but several other
> places in ppc, sparc, and semihosting follow what looks like a similar
> pattern setting halted = 0 directly. So remove this assertion.
> 
> Reported-by: Ivan Warren <ivan@vmfacility.fr>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   accel/tcg/tcg-accel-ops-mttcg.c | 11 -----------
>   1 file changed, 11 deletions(-)

The adjustments of 'halted' and 'prod' are done under the io lock in both cases, so 
there's no race there.

It is perfectly reasonable that after thread A sets halted and drops the lock, thread B 
may acquire the lock and clear halted before thread A has a chance to complete longjmp and 
cycle through its main loop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index b276262007..d0b6f288d9 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -98,17 +98,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
>               case EXCP_DEBUG:
>                   cpu_handle_guest_debug(cpu);
>                   break;
> -            case EXCP_HALTED:
> -                /*
> -                 * during start-up the vCPU is reset and the thread is
> -                 * kicked several times. If we don't ensure we go back
> -                 * to sleep in the halted state we won't cleanly
> -                 * start-up when the vCPU is enabled.
> -                 *
> -                 * cpu->halted should ensure we sleep in wait_io_event
> -                 */
> -                g_assert(cpu->halted);
> -                break;

I adjusted the patch to keep the case label and update the comment, still dropping the assert.

Queued to tcg-next.


r~

