Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE57C829DEC
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 16:50:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNapY-0007aT-LK; Wed, 10 Jan 2024 10:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNapW-0007Zx-II
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:49:22 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNapU-0002rB-NE
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 10:49:22 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so3889574f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 07:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704901759; x=1705506559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NZRqVuenPWIeJ0HEFm/EdEMDQu8jxtzURv+23qvhkQs=;
 b=POCI+gS7iKW+2WXYYYLWLBUnolPgW7Y7ThVVuxgAVvtDaGD4IP+iN5+l/1bNljl8N9
 QDaiQptC/tV3LbpzGiUlFPmprXx2mn30M8QwgbFu5WTcrkkptJQ2DBW80wDs5EoOWctx
 t0lsEDZ0Cn85sNnfWA6xvbLde+mXXp4EivCplLBSlOa+qRNofClhYLhrm3DpZMDtAkoM
 Sz33arlxfqU/tgRZMwHVs8VRFZlqPgQJ1kcQNf85JKSyiYGis/OzerVZoxFhSgmkcOpi
 X/eF+3A0Mvr0rl3QolrUfBno0ODKui0I5Vh314M3cZ8m0XBAnLGsfzvCWv/cD9rRGqDN
 6Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704901759; x=1705506559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NZRqVuenPWIeJ0HEFm/EdEMDQu8jxtzURv+23qvhkQs=;
 b=l3UGSQzSk6zf+6s4RK6HV0/39d2uXP/Wi0mtwC2wvP4mjtbZhWJin/xBK67ZJSKk72
 zGeBafCwNl3BL9MuodnK0koKLz70xKajAgg6+7blIKFHnuZUD62ZPF1dJLoWKNv5/wif
 ez6a8C2QflDfxguATAhVTmMAF8RR5f7RZsiQB2HjLLNAKNPM4eaeYhI/jq8lYv5xPiBE
 BsqIwo8PouTfKjl0rZmMU7y6a9dBesDuNVP6MCGSmSf1XVWBOk15pRuw2Uf8pyzctGEx
 SuKILNr7FG3YBVDha79Fzo4JYL0VXIREforavhZ1cBqJKsl4bgtFbDPxPGjpg0I/PcKk
 rdzA==
X-Gm-Message-State: AOJu0YzVvRNoJEASDqFFX+Xf1AfPKUAJRZQGZbS70XTWx0lFwyEgmbTC
 jT2cIryE5SmyL2K05PpyH6viGZI4FgqKVA==
X-Google-Smtp-Source: AGHT+IFxNI5vhPQCV5LzUmJPobJtINCRB0tNkmx3QMkuJ1PwzLGXQC+feJmWLQLEOPpY/NDrET3CJg==
X-Received: by 2002:a5d:5309:0:b0:336:73d6:b42b with SMTP id
 e9-20020a5d5309000000b0033673d6b42bmr664244wrv.117.1704901759168; 
 Wed, 10 Jan 2024 07:49:19 -0800 (PST)
Received: from [192.168.69.100] (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 m2-20020adfa3c2000000b00336c9ad1173sm5236966wrb.26.2024.01.10.07.49.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:49:18 -0800 (PST)
Message-ID: <c6c3f9e3-c658-4f5f-b0d9-c57d83a61610@linaro.org>
Date: Wed, 10 Jan 2024 16:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/PATCH v1 09/11] gunyah: CPU execution loop
Content-Language: en-US
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, peter.maydell@linaro.org, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: quic_tsoni@quicinc.com, quic_pheragu@quicinc.com,
 quic_eberman@quicinc.com, quic_yvasi@quicinc.com, quic_cvanscha@quicinc.com,
 quic_mnalajal@quicinc.com
References: <20240109090039.1636383-1-quic_svaddagi@quicinc.com>
 <20240109090039.1636383-10-quic_svaddagi@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240109090039.1636383-10-quic_svaddagi@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Hi Srivatsa,

On 9/1/24 10:00, Srivatsa Vaddagiri wrote:
> Complete the cpu execution loop. At this time, we recognize exits
> associated with only MMIO access. Future patches will add support for
> recognizing other exit reasons, such as PSCI calls made by guest.
> 
> Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
> ---
>   accel/gunyah/gunyah-accel-ops.c |   7 ++
>   accel/gunyah/gunyah-all.c       | 201 +++++++++++++++++++++++++++++++-
>   include/hw/core/cpu.h           |   1 +
>   include/sysemu/gunyah_int.h     |   9 ++
>   target/arm/gunyah.c             |  13 +++
>   5 files changed, 230 insertions(+), 1 deletion(-)


> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 238c02c05e..ef248a658b 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -371,6 +371,7 @@ struct CPUWatchpoint {
>   
>   struct KVMState;
>   struct kvm_run;
> +struct gh_vcpu_run;

Please do not forward-declare this structure here, it is not required.

>   
>   /* work queue */
>   
> diff --git a/include/sysemu/gunyah_int.h b/include/sysemu/gunyah_int.h
> index dc5b4847a9..72b3027e4e 100644
> --- a/include/sysemu/gunyah_int.h
> +++ b/include/sysemu/gunyah_int.h
> @@ -46,12 +46,21 @@ struct GUNYAHState {
>       bool preshmem_reserved;
>       uint32_t preshmem_size;
>       uint32_t nr_irqs;
> +    uint32_t vm_started;
> +};
> +
> +struct AccelCPUState {
> +    int fd;
> +    struct gh_vcpu_run *run;
>   };
>   
>   int gunyah_create_vm(void);
> +void gunyah_start_vm(void);
>   int gunyah_vm_ioctl(int type, ...);
>   void *gunyah_cpu_thread_fn(void *arg);
>   int gunyah_add_irqfd(int irqfd, int label, Error **errp);
>   GUNYAHState *get_gunyah_state(void);
> +int gunyah_arch_put_registers(CPUState *cs, int level);
> +void gunyah_cpu_synchronize_post_reset(CPUState *cpu);
>   
>   #endif    /* GUNYAH_INT_H */


