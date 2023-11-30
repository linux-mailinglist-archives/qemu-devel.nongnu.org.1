Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 467397FF0BD
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:51:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hRs-0007dU-4z; Thu, 30 Nov 2023 08:51:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8hRo-0007Xk-Lf
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:51:20 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r8hRm-0001px-HQ
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:51:20 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b85c88710eso502182b6e.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701352277; x=1701957077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cf/2Zvu4Hq15RJi1vO3BfKYdCYK7/8i9PcDCPQknr+A=;
 b=bjHFVkbuW2hSXqCfK7opQk2P6/I1rKf85EaOXm2XnJNeLWeU1MT0KvD+CBRIM6aIuH
 T3dIBoA4w1CsdCGUV9Bbp45LpzTXKfQEM45GCaIMm8H5OnCq5k/t1iRhIq4RGv7GiBdf
 SIn9jH3GDjIah/IH+DDZu5cAMwbiUU77CPFn6kKJM8tb0AJ0b1iI+0qqRdJhEAEtZle1
 pR/nqNXLiqh4jLobCwwSO/M2ZvqwH2+Ey9zmzouBpshwLmfkh7IH4ZwZuyc8AgWrS0kk
 kjZ4xLXlvJ4Gj3f6w2o2oMReg1kjzFR30+3aFqx3cwtvsNhIq6q7e7HkwkCnBoTp75rA
 zcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701352277; x=1701957077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cf/2Zvu4Hq15RJi1vO3BfKYdCYK7/8i9PcDCPQknr+A=;
 b=sHQs1oMjl8tiDWWU0SHerohwHnuZUVirvzZ822WTYk6weTT/XFQl4cqyh6eX793CO6
 pbNejV5bQvHieLS2wQnvfGGlmAVVSa6zfpiuFp9VEXua44uNrbsow2qznqqyt4ckbYHt
 7nd142jKXmDeKMPEioqN0GvSkooA9zUNwbNSKz6v9szZps8LHb5To1477pzqXhMCDVZ1
 vTCedHVLX7zwpeXVPnzRzJ4RbunQxaISn4Rne1j+nV3iMioLXCzBWS5egCgsMV1/BY1j
 S7bJ11YB7iBA827YLfSeA6P8do8TDOMOGI+pOADV/G0XsYk5zAyvNyZkHkNIk750BoLm
 VACg==
X-Gm-Message-State: AOJu0YyAwDZfAMq3wDWwJrL7zeYS/AYyg31sJYTlIN19fniSIpPEgcUE
 DyKe9uOCRJ9fc+UkiSqyUlUS5w==
X-Google-Smtp-Source: AGHT+IGPNIg+tSohi3PYkGeKLnn9cq6kdFZFM9ZqqPoeCFL1n0LzgznAg9EZZ11xFuByv9gBUY5ung==
X-Received: by 2002:a05:6808:14c6:b0:3b8:5c84:291a with SMTP id
 f6-20020a05680814c600b003b85c84291amr22001667oiw.46.1701352277293; 
 Thu, 30 Nov 2023 05:51:17 -0800 (PST)
Received: from [172.20.102.4] (rrcs-71-42-197-3.sw.biz.rr.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 ev25-20020a056808291900b003b2f2724c48sm174558oib.11.2023.11.30.05.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 05:51:16 -0800 (PST)
Message-ID: <768e7409-62a7-441c-960d-dc99ab89c7d0@linaro.org>
Date: Thu, 30 Nov 2023 07:51:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel: Do not set CPUState::can_do_io in non-TCG accels
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, kvm@vger.kernel.org
References: <20231129205037.16849-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231129205037.16849-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 11/29/23 14:50, Philippe Mathieu-Daudé wrote:
> 'can_do_io' is specific to TCG. Having it set in non-TCG
> code is confusing, so remove it from QTest / HVF / KVM.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/dummy-cpus.c        | 1 -
>   accel/hvf/hvf-accel-ops.c | 1 -
>   accel/kvm/kvm-accel-ops.c | 1 -
>   3 files changed, 3 deletions(-)
> 
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index b75c919ac3..1005ec6f56 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -27,7 +27,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>       qemu_mutex_lock_iothread();
>       qemu_thread_get_self(cpu->thread);
>       cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>       current_cpu = cpu;

I expect this is ok...

When I was moving this variable around just recently, 464dacf6, I wondered about these 
other settings, and I wondered if they used to be required for implementing some i/o on 
behalf of hw accel.  Something that has now been factored out to e.g. kvm_handle_io, which 
now uses address_space_rw directly.

I see 3 reads of can_do_io: accel/tcg/{cputlb.c, icount-common.c} and system/watchpoint.c. 
  The final one is nested within replay_running_debug(), which implies icount and tcg.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

>   
>   #ifndef _WIN32
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index abe7adf7ee..2bba54cf70 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -428,7 +428,6 @@ static void *hvf_cpu_thread_fn(void *arg)
>       qemu_thread_get_self(cpu->thread);
>   
>       cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>       current_cpu = cpu;
>   
>       hvf_init_vcpu(cpu);
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index 6195150a0b..f273f415db 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -36,7 +36,6 @@ static void *kvm_vcpu_thread_fn(void *arg)
>       qemu_mutex_lock_iothread();
>       qemu_thread_get_self(cpu->thread);
>       cpu->thread_id = qemu_get_thread_id();
> -    cpu->neg.can_do_io = true;
>       current_cpu = cpu;
>   
>       r = kvm_init_vcpu(cpu, &error_fatal);


