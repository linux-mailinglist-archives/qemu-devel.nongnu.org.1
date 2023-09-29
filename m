Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2CF7B3BAF
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 22:59:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmKYu-00011d-3I; Fri, 29 Sep 2023 16:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKYo-0000tN-NJ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:58:06 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qmKYl-00078E-Lr
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 16:58:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c752caeaa6so1781935ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696021081; x=1696625881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X4oXjkJaknbu+pZ3/7jm2oGrixDPksf4Gw333ymFenY=;
 b=gzK80EjlZXRlsJIQ36q5OAt9hDcrG3gd9dQj8VeH7tB++9WvT4MvYMkjXF2uUWT4cb
 MqXxa5MVmA7XH/2hXEI9AzJTkuq8d9OpOUDl5r32bUo7DF60JdqgSMfazFbIwFCXcy/f
 y/mXV+lynBsLRwFRQbp5J+r3PZhA9rI20MppmewiZPs4llSBZlJljlMOen61O8H4g0qi
 X9lfl1wi/VlLT7ZT2aAphhAQdWtyH6InrI6OOZH8zv+ZoZf/qyJDts40skjiJpfAcld/
 Vzk00PP/Z6e364sI8Km3C9jRWLW5+YAzaQeMFyLDo9fePGvIls5yQI6eLyN8+eJTVxDx
 YY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696021081; x=1696625881;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X4oXjkJaknbu+pZ3/7jm2oGrixDPksf4Gw333ymFenY=;
 b=Fll/0UnG8iF6jxAKY86G3W3LM2Npl5JyJosDqyP8zgIeh6uf+p9maHSm67/8Yn+ZTA
 N24H/iM2w2d9d0B6kl67zx3qWmk8E3weFx3v2pvh2k1Od9ExmYS9NxalGNPZxgp9xFpn
 A7rG9tj0eorAcMkGx+aaSJMMyEO4LuMTK1tfdncGTa1pTuislV8ZCLID6nMJeaH4cJd1
 pj/tv/1WgMFRNyCjpdDN/+eO3EXs6e9ApJVJ8x01YMI/bFPiQPVi/0/KWA1tMZV9XP2l
 VFMttw3TCUPnid7ulGexmj3jxy6CapIC0P2ZTab9K9C/nKtXDp3SCuWv1mSp6x37Y8wt
 0y1A==
X-Gm-Message-State: AOJu0Yw1eODw15/pudiozTIFGBQzMXmR04imH/g4msfs0WREBgPnQ7DG
 1fc6OgG9CjBV+jnEYHeR43kXXg==
X-Google-Smtp-Source: AGHT+IF5LrJ/VvOVX4aqpsAsEyBGHv/GltwCPiEcRRp2yXkooZJK9OQvYDJ+Tr7kN/PxrgOn6z8klA==
X-Received: by 2002:a17:903:244d:b0:1c3:2ee6:3802 with SMTP id
 l13-20020a170903244d00b001c32ee63802mr5750633pls.47.1696021081152; 
 Fri, 29 Sep 2023 13:58:01 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 6-20020a170902e9c600b001a5260a6e6csm4789108plk.206.2023.09.29.13.58.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 13:58:00 -0700 (PDT)
Message-ID: <a6d0175f-a343-4b1f-232f-280786e7dce3@linaro.org>
Date: Fri, 29 Sep 2023 13:57:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 01/22] target/i386: Only realize existing APIC device
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230918160257.30127-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.295,
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

On 9/18/23 09:02, Philippe Mathieu-Daudé wrote:
> APIC state is created under a certain condition,
> use the same condition to realize it.
> Having a NULL APIC state is a bug: use assert().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/cpu-sysemu.c | 9 +++------
>   target/i386/cpu.c        | 8 +++++---
>   2 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 2375e48178..6a164d3769 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -272,9 +272,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>       APICCommonState *apic;
>       APICCommonClass *apic_class = apic_get_class(errp);
>   
> -    if (!apic_class) {
> -        return;
> -    }
> +    assert(apic_class);

Ok.

>       cpu->apic_state = DEVICE(object_new_with_class(OBJECT_CLASS(apic_class)));
>       object_property_add_child(OBJECT(cpu), "lapic",
> @@ -293,9 +291,8 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
>       APICCommonState *apic;
>       static bool apic_mmio_map_once;
>   
> -    if (cpu->apic_state == NULL) {
> -        return;
> -    }
> +    assert(cpu->apic_state);
> +
>       qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
>   
>       /* Map APIC MMIO area */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b2a20365e1..a23d4795e0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7448,9 +7448,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
>       }
>   
>   #ifndef CONFIG_USER_ONLY
> -    x86_cpu_apic_realize(cpu, &local_err);
> -    if (local_err != NULL) {
> -        goto out;
> +    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
> +        x86_cpu_apic_realize(cpu, &local_err);
> +        if (local_err != NULL) {
> +            goto out;
> +        }

I'm not keen on the replication of the condition.  Testing whether the apic object was 
created seems reasonable.  It probably is clearer with the IF in the caller, as you do.


r~

