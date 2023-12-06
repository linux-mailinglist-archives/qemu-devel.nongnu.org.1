Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 171978075CC
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:51:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAv7J-0006aO-Sc; Wed, 06 Dec 2023 11:51:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv7H-0006Zw-CO
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:51:19 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv7F-0005wo-L2
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:51:19 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-286d6c95b8cso31657a91.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701881476; x=1702486276; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CH8oEA41sAVJ5h7gwZQoJQL2O2gbtggA96MVAG3tu98=;
 b=mky3orsJskTAUIJMP0ycpf/hUgBmI6Y92aD6TesYX2S3zWEbhn+gWizH10PuKY3SJI
 FXFV+HOCAl0whC8oTxfs1HqRiVKRA2sRbYY1WQKQDQz6MCyNDCSBg6dPwLkjJJOsEo7Q
 OnEfm5uacoC4/JhOz7tF0sGVDUHuUhqXpKKsoof/uQEQELr2oVQnhJlId+OjDJrurlbS
 G88ryENLhw826n6sU2aAhc6hvkKbOGq2lBOTGGFlNyH+iNFm+S5v3dyHOy0GBmhF8C6U
 3yDhSTi3ehbf3ybaHYEQvewteSNh9dHAP7Ir0gQI25kSrvJ/nQBC9G0rhD12hGBj32IR
 QVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701881476; x=1702486276;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CH8oEA41sAVJ5h7gwZQoJQL2O2gbtggA96MVAG3tu98=;
 b=px5zKhFGUCmm2IEW/NkQYLBG6lFLQfswpBpP9ZAEUjKK8qkAEsAgCQBoqEFCZQuCqq
 RzSy5zHol9Y92/w9LR0PwGVArMn2tMhxUV1K1R3pU+xJ9n35wOlvAd8i6GThf0LtWTYH
 8JCxGRrsT5VbXu/XEu/c7nNjgBkkALLXp9Irc5t9ZNXalhG6FBgSmR6S1YyGvY3hVV+N
 Lhwcx7+pxMNq9DGucJAAhBAYcSWvF3n6SSZHhdEfOIN2WujIJiPaBjWwqi7IIzzIav9T
 K5I4cWms5X16N0d548qofXnWMTWfYfPR3Qm0ng9k5hVnAhKhIVsDfGHOb/pnAK0KUwGa
 TKJA==
X-Gm-Message-State: AOJu0YyLq7F13aM//OR2/dVp2W15f6TBXfsEBgM/Cao/rT/Mzbg/2Ad/
 OPyqAHHvNrF6IIn0zDqGmt3PeQ==
X-Google-Smtp-Source: AGHT+IE4Ivnm5QAORwr7T44RWfdl8azBjDTsgVh4AYe+qs5e16QwfDcS4BNX0iU8SUSam70TQfaF9g==
X-Received: by 2002:a17:90b:3812:b0:27c:f309:f381 with SMTP id
 mq18-20020a17090b381200b0027cf309f381mr1222015pjb.6.1701881476227; 
 Wed, 06 Dec 2023 08:51:16 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 gk24-20020a17090b119800b00286d75e10e4sm90829pjb.37.2023.12.06.08.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:51:15 -0800 (PST)
Message-ID: <4ba45fcf-12cf-44a1-ba94-b2a8c0c69f5c@linaro.org>
Date: Wed, 6 Dec 2023 08:51:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] replay: stop us hanging in rr_wait_io_event
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 12/5/23 12:41, Alex Bennée wrote:
> A lot of the hang I see are when we end up spinning in
> rr_wait_io_event for an event that will never come in playback. As a
> new check functions which can see if we are in PLAY mode and kick us
> us the wait function so the event can be processed.
> 
> This fixes most of the failures in replay_kernel.py
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2013
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>   include/sysemu/replay.h      |  5 +++++
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   replay/replay.c              | 24 ++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 08aae5869f..83995ae4bd 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -70,6 +70,11 @@ int replay_get_instructions(void);
>   /*! Updates instructions counter in replay mode. */
>   void replay_account_executed_instructions(void);
>   
> +/**
> + * replay_can_wait: check if we should pause for wait-io
> + */
> +bool replay_can_wait(void);
> +
>   /* Processing clocks and other time sources */
>   
>   /*! Save the specified clock */
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 611932f3c3..825e35b3dc 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>   {
>       CPUState *cpu;
>   
> -    while (all_cpu_threads_idle()) {
> +    while (all_cpu_threads_idle() && replay_can_wait()) {
>           rr_stop_kick_timer();
>           qemu_cond_wait_iothread(first_cpu->halt_cond);
>       }
> diff --git a/replay/replay.c b/replay/replay.c
> index e83c01285c..042a6a9636 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -347,6 +347,30 @@ void replay_start(void)
>       replay_enable_events();
>   }
>   
> +/*
> + * For none/record the answer is yes.
> + */
> +bool replay_can_wait(void)
> +{
> +    if (replay_mode == REPLAY_MODE_PLAY) {
> +        /*
> +         * For playback we shouldn't ever be at a point we wait. If
> +         * the instruction count has reached zero and we have an
> +         * unconsumed event we should go around again and consume it.
> +         */
> +        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
> +            return false;
> +        } else {
> +            fprintf(stderr, "Error: Invalid replay state\n");
> +            fprintf(stderr,"instruction_count = %d, has = %d, event_kind = %d\n",
> +                    replay_state.instruction_count, replay_state.has_unread_data, replay_state.data_kind);
> +            abort();

error_report.


r~

> +        }
> +    }
> +    return true;
> +}
> +
> +
>   void replay_finish(void)
>   {
>       if (replay_mode == REPLAY_MODE_NONE) {


