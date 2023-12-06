Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FA806DE3
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:28:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAq4S-0005hI-Tz; Wed, 06 Dec 2023 06:28:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq4Q-0005gr-IM
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:28:02 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq4O-00036G-M6
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:28:02 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a1c7d8f89a5so90800866b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862079; x=1702466879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aKJVQP29uPtfEmKyTTsg1oWH2Ks7ytOXX/bQ+VYl42I=;
 b=RWw8/za9NJNoV/n0+OutwxU4W7l9SiVr44GNQ0rmOO9RcniAHL5wZma9whCrnldjsN
 fn1XnmsH02YU2td+4Wl2YkomHNzgAIhEp0NAQJUAthiLntQDCUJQy9zLW8wyaD3UDISb
 n9gK7ijCzTRELAeUwHL5RWXlb7n4ZyAy3AhzSxvm+QudiJ8t+jHqkv5ktOPXLy3hHRra
 wXYIKrbpZ4vnLSHXQwnyOpZzuai+UTlCISexepilWAhSI3bG97yZQp1WnizAgrzyi9pO
 cdA3Jkt2SgNvK7tJb4ofAUPJqQF9M9uA51PnWzkWJMPgmDzXkhkebyYwygddh2GidacL
 z4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862079; x=1702466879;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aKJVQP29uPtfEmKyTTsg1oWH2Ks7ytOXX/bQ+VYl42I=;
 b=Rm+BxJsjpRjboIPfl6nUNkS2wuEhpRWBLa1yH5CSY6CBVE8Zx67xU15pWF/EbQx4uq
 YFbpsi0N30JcRn2G/k50Uuc2cVWz8w/P+VF2Qw1NHlk643zpCB9NHjeBfXWuiCvuahuo
 qlXqwQibDwS0j6HRHOYUIbZ1vT86gmTTHGPyY2qGY1B+ns/bL5PJA88kl/JCmRUtqfHw
 63GHw2vKKkCwXek1wWge0+V46bsf65NivPQy7mEazDT90SYbvrukWER1g4jQRr28/2/s
 gnXpbtbJQ3muV8onqiH38cyrgQm3wqbCivm/OfkmpZ707kb4rh0WTKkl5JBBx7/KH0pT
 2jLQ==
X-Gm-Message-State: AOJu0YwuwabNn1bvs9H3Q0vsrZSxJ1fyEPkHdoNzvt2GlK++Uf6h5IQ/
 umjSeYFUKh6DLgA1Uxk2P62xCw==
X-Google-Smtp-Source: AGHT+IEo6EZnf6JTj4EG3gIPxjZ2UIjj+S3DrPFqLJ2G2q6+xm19lWjzGv2UIwbHiXvHcUMQLXBVqQ==
X-Received: by 2002:a17:906:168d:b0:a1c:dc26:5c8c with SMTP id
 s13-20020a170906168d00b00a1cdc265c8cmr502410ejd.61.1701862078831; 
 Wed, 06 Dec 2023 03:27:58 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 hr38-20020a1709073fa600b00a1ce97f320dsm1802912ejc.31.2023.12.06.03.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:27:58 -0800 (PST)
Message-ID: <b5868a4c-7711-46d8-ae6d-32595cec8e2d@linaro.org>
Date: Wed, 6 Dec 2023 12:27:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] replay: add proper kdoc for ReplayState
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-7-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 5/12/23 21:41, Alex Bennée wrote:
> Remove the non-standard comment formatting and move the descriptions
> into a proper kdoc comment.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h               | 27 ++++++++++++++++----------

~~~

>   roms/SLOF                              |  2 +-
>   tests/tcg/i386/Makefile.softmmu-target | 19 ++++++++++++++++++
>   3 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 516147ddbc..98ca3748ed 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -63,24 +63,31 @@ enum ReplayEvents {
>       EVENT_COUNT
>   };
>   
> +/**
> + * typedef ReplayState - global tracking Replay state
> + *
> + * This structure tracks where we are in the current ReplayState
> + * including the logged events from the recorded replay stream. Some
> + * of the data is also stored/restored from VMStateDescription when VM
> + * save/restore events take place.
> + *
> + * @cached_clock: Cached clocks values
> + * @current_icount: number of processed instructions
> + * @instruction_count: number of instructions until next event
> + * @data_kind: current event
> + * @has_unread_data: 1 if event not yet processed
> + * @file_offset: offset into replay log at replay snapshot
> + * @block_request_id: current serialised block request id
> + * @read_event_id: current async read event id
> + */
>   typedef struct ReplayState {
> -    /*! Cached clock values. */
>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
> -    /*! Current icount - number of processed instructions. */
>       uint64_t current_icount;
> -    /*! Number of instructions to be executed before other events happen. */
>       int instruction_count;
> -    /*! Type of the currently executed event. */
>       unsigned int data_kind;
> -    /*! Flag which indicates that event is not processed yet. */
>       unsigned int has_unread_data;
> -    /*! Temporary variable for saving current log offset. */
>       uint64_t file_offset;
> -    /*! Next block operation id.
> -        This counter is global, because requests from different
> -        block devices should not get overlapping ids. */
>       uint64_t block_request_id;
> -    /*! Asynchronous event id read from the log */
>       uint64_t read_event_id;
>   } ReplayState;
>   extern ReplayState replay_state;

Up to here:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

The rest doesn't belong to this commit:

> diff --git a/roms/SLOF b/roms/SLOF
> index 3a259df244..6b6c16b4b4 160000
> --- a/roms/SLOF
> +++ b/roms/SLOF
> @@ -1 +1 @@
> -Subproject commit 3a259df2449fc4a4e43ab5f33f0b2c66484b4bc3
> +Subproject commit 6b6c16b4b40763507cf1f518096f3c3883c5cf2d
> diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
> index 5266f2335a..b9bef72dcf 100644
> --- a/tests/tcg/i386/Makefile.softmmu-target
> +++ b/tests/tcg/i386/Makefile.softmmu-target
> @@ -33,5 +33,24 @@ EXTRA_RUNS+=$(MULTIARCH_RUNS)
>   
>   memory: CFLAGS+=-DCHECK_UNALIGNED=1
>   
> +# Simple Record/Replay Test
> +.PHONY: memory-record
> +run-memory-record: memory-record memory
> +	$(call run-test, $<, \
> +	  $(QEMU) -monitor none -display none \
> +		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
> +		  -icount shift=5$(COMMA)rr=record$(COMMA)rrfile=record.bin \
> +		  $(QEMU_OPTS) memory)
> +
> +.PHONY: memory-replay
> +run-memory-replay: memory-replay run-memory-record
> +	$(call run-test, $<, \
> +	  $(QEMU) -monitor none -display none \
> +		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
> +		  -icount shift=5$(COMMA)rr=replay$(COMMA)rrfile=record.bin \
> +		  $(QEMU_OPTS) memory)
> +
> +EXTRA_RUNS+=run-memory-replay
> +
>   # Running
>   QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel


