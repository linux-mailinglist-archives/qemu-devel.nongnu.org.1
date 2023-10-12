Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD47C642E
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 06:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqnY9-0001lh-A9; Thu, 12 Oct 2023 00:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnY5-0001lH-2q
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:43:49 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqnXz-000169-WC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 00:43:48 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9ba1eb73c27so84549566b.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 21:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697085821; x=1697690621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NsQdNAt772Lk3sYaY/eE2FLNruWxHL/eoU/amETLWU4=;
 b=XcOGXKZI2TR9r9FdM1UJoZTSC4RWFwCn4CrItZfBkUKhgfzrTkTX6YKnqWKxu6O6LF
 v+RrR9aouOxZiDwcC6HrYUMH1vgGYo3SUsVWqvSGbaVke3dLFqQoJVJgHO6NerEGExau
 i+rPYeRpsDZR+5Pp1FMQIMsTJWckMwmStS7/lrXGDILE40QiafdabVV+hnjr657kga+B
 tupcm9vrpw+dUZv8aAGX8pETfc3etZuUtGiL0gjXwmZDoh7SSa6Tbgpcocrx6Txc25rj
 1Y1NrRXvdAIYcr/YmvASyKpJQ9pinQqyaG5sDf2cf0jO62hS0HfBABkSRXs1UmN9SI3D
 HLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697085821; x=1697690621;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsQdNAt772Lk3sYaY/eE2FLNruWxHL/eoU/amETLWU4=;
 b=lFFE2xj2GROrFKADr6x4yDGmO+HSDg9mbVLvw4mBVKjDh7Y5v0MoFeE8GZ55BQ/JbP
 QgUMCc5qtRsAbwAMlHzo1RwcWrJEFZTqal09vXeM6de19Juykbyl44uNSdZUnyU+DNYB
 KKmbwVUYkOIvT1UCzOirKrRlYXV1wSPDT0Uplbd6nPGzmKPZ7nyjuV634+xA8lJiO2yb
 rXrMNNr7Vqk0cZsR2M0qQGDAFX436Yfo4O5i+IcrcrkREdDqJdoB3/986xrdjXrFoyFK
 p5w1tiavdTf28z1qg6lfA0Ay4vw7WM7ikOinToiimWHnkDYBlgPQjlDXYyu8u0Re5/Eb
 Kp1A==
X-Gm-Message-State: AOJu0YxqNNbTfRRPtREsYmtt2xh27K+M5OcNjJmz4Qj0S2zSI3lollUc
 d0LXLWCw+mn0+FecrwAPId9jfg==
X-Google-Smtp-Source: AGHT+IGIlo5zl7YzfkbZUbUX0S0sbo88NwmvU+qedr6hKf7evlCiDKmmKb8Mi9eP7OZWl4Pecf8n5Q==
X-Received: by 2002:a17:907:1dd2:b0:9ae:406c:3425 with SMTP id
 og18-20020a1709071dd200b009ae406c3425mr21222384ejc.0.1697085821305; 
 Wed, 11 Oct 2023 21:43:41 -0700 (PDT)
Received: from [192.168.69.115] (dcs23-h01-176-173-173-31.dsl.sta.abo.bbox.fr.
 [176.173.173.31]) by smtp.gmail.com with ESMTPSA id
 lf8-20020a170906ae4800b00992e14af9c3sm10706076ejb.143.2023.10.11.21.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 21:43:40 -0700 (PDT)
Message-ID: <d2287b37-cd40-10ec-e20f-135a9d27e3fe@linaro.org>
Date: Thu, 12 Oct 2023 06:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC/PATCH v0 10/12] gunyah: CPU execution loop
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20231011165234.1323725-1-quic_svaddagi@quicinc.com>
 <20231011165234.1323725-11-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231011165234.1323725-11-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 11/10/23 18:52, Srivatsa Vaddagiri wrote:
> Complete the cpu execution loop. At this time, we recognize exits
> associated with only MMIO access. Future patches will add support for
> recognizing other exit reasons, such as PSCI calls made by guest.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   accel/gunyah/gunyah-accel-ops.c |   1 +
>   accel/gunyah/gunyah-all.c       | 216 ++++++++++++++++++++++++++++++--
>   include/hw/core/cpu.h           |   6 +
>   include/sysemu/gunyah.h         |   1 +
>   include/sysemu/gunyah_int.h     |   3 +
>   target/arm/gunyah.c             |  13 ++
>   6 files changed, 229 insertions(+), 11 deletions(-)


> @@ -110,17 +125,6 @@ int gunyah_create_vm(void)
>       return 0;
>   }
>   
> -void *gunyah_cpu_thread_fn(void *arg)
> -{
> -    CPUState *cpu = arg;
> -
> -    do {
> -        /* Do nothing */
> -    } while (!cpu->unplug || cpu_can_run(cpu));
> -
> -    return NULL;
> -}

This diff could be nicer if you define gunyah_cpu_thread_fn()
in the final place in previous patches, so you don't need to
move it here.

>   #define gunyah_slots_lock(s)    qemu_mutex_lock(&s->slots_lock)
>   #define gunyah_slots_unlock(s)  qemu_mutex_unlock(&s->slots_lock)

[...]

> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index fdcbe87352..b3901e134d 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -240,6 +240,7 @@ typedef struct SavedIOTLB {
>   
>   struct KVMState;
>   struct kvm_run;
> +struct gh_vcpu_run;
>   
>   /* work queue */
>   
> @@ -443,6 +444,11 @@ struct CPUState {
>   
>       /* track IOMMUs whose translations we've cached in the TCG TLB */
>       GArray *iommu_notifiers;
> +
> +    struct {
> +        int fd;
> +        struct gh_vcpu_run *run;
> +    } gunyah;

NACK. Please declare as struct AccelCPUState in gunyah_int.h.

>   };


