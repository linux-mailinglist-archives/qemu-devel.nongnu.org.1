Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 406B97F48FB
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 15:32:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5oGK-0008PH-MX; Wed, 22 Nov 2023 09:31:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5oGF-0008NB-A4
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:31:27 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5oGC-0004rM-Cq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 09:31:26 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so4835520f8f.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700663482; x=1701268282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDu5YukkB3ZS1KgWL9j/MeBCZ5GDWh8KF2kzwO0JtuU=;
 b=YRB8kFDh2wI952np7DGZ46sKDzF12GrdmVPm5X4inFoQLYQ4z0hTy2CJyVg8uiClTn
 /II9NZxRMG3b/kUeBzycasbofhxsnDr9LMgD2AfGvXVm6vqHknW252bvJmrck7151yl1
 lZTDWFqVHhWcJwMVsOwygeuNZEHoL+9oSPLldkx1krLvm3hBn/TFWNmZ2Btt1MKmtCza
 EvvzB7YtoHtf2Qdoix38lcttDx6fLLI78JA7lxLx0w3f0I9HeIEniShseQMA2/YAeIvY
 +xiWMQmB7sozi4hT28b5FqnwOKCXe0LLJk5ndxIcQGRVAxE5vDFlAE9PknQ6JP/GqfL8
 kn4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700663482; x=1701268282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDu5YukkB3ZS1KgWL9j/MeBCZ5GDWh8KF2kzwO0JtuU=;
 b=K9RYPJuA6A5ZpoBIQmDSl83RZ2ywdEXqtC7HPgPrPYoB+ndsBN1arClloeI68BNBgY
 vIU69t/xYQ0lm5/HLL73NOtBx5uTvxeml9GjEqCu3Fc/PvIyBhvL5VS14sTiiTKS+id5
 UDCzZg99AgrfeVLnjy3tWPoMZnRY/+3bg9lH8q/2NJqU3T35AihrQonkqtWU0o0KZxrn
 yJE8hHQ5FmP6obE7lZh5mwKBaEI//oRvg/mnD2atHsp0Uy+1RqMZO7fqnqNYAGPrVWu5
 RxMyhTb/Dp3Yw+2ExaCwzWxnqgCMdpz81bTzEPAmWS8lUtZfIckFN1JxJ6bgClNNcXMp
 vEMA==
X-Gm-Message-State: AOJu0YyhKur9tAW2uHr5Z9T54yzno6e3RTdfLdi4OI48R/UZlS1KOMUE
 h3P5syVKvcwQOcfqXz3ZCbjJOBSdBVR3dJiPQhE=
X-Google-Smtp-Source: AGHT+IE9LaF0DEkwL5cpm+egX3eckmYkjKInOZe9vISBv3nWLuReaotsdNUpNeOFr5NfOocYLjHarA==
X-Received: by 2002:a5d:6a82:0:b0:32c:ea14:89e5 with SMTP id
 s2-20020a5d6a82000000b0032cea1489e5mr1623441wru.39.1700663481801; 
 Wed, 22 Nov 2023 06:31:21 -0800 (PST)
Received: from [192.168.69.100] (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 s5-20020adfdb05000000b0032d8eecf901sm17541286wri.3.2023.11.22.06.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Nov 2023 06:31:21 -0800 (PST)
Message-ID: <e2ccbaeb-0059-4cdd-b67a-a9d0c1af5d21@linaro.org>
Date: Wed, 22 Nov 2023 15:31:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] hw/i386: Rename kvmvapic.c -> vapic.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230905145159.7898-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20230905145159.7898-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Ping for review?

Otherwise I plan to merge this when 9.0 opens.

Thanks, Phil.

On 5/9/23 16:51, Philippe Mathieu-Daudé wrote:
> vAPIC isn't KVM specific, so having its name prefixed 'kvm'
> is misleading. Rename it simply 'vapic'. Rename the single
> function prefixed 'kvm'.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Interestingly there is a strong dependency on (Kconfig) APIC,
> but I couldn't get a single x86 machine building without the
> Kconfig 'APIC' key.
> ---
>   hw/i386/{kvmvapic.c => vapic.c} | 5 ++---
>   hw/i386/meson.build             | 2 +-
>   2 files changed, 3 insertions(+), 4 deletions(-)
>   rename hw/i386/{kvmvapic.c => vapic.c} (99%)
> 
> diff --git a/hw/i386/kvmvapic.c b/hw/i386/vapic.c
> similarity index 99%
> rename from hw/i386/kvmvapic.c
> rename to hw/i386/vapic.c
> index 43f8a8f679..35e3a56b35 100644
> --- a/hw/i386/kvmvapic.c
> +++ b/hw/i386/vapic.c
> @@ -747,8 +747,7 @@ static void do_vapic_enable(CPUState *cs, run_on_cpu_data data)
>       s->state = VAPIC_ACTIVE;
>   }
>   
> -static void kvmvapic_vm_state_change(void *opaque, bool running,
> -                                     RunState state)
> +static void vapic_vm_state_change(void *opaque, bool running, RunState state)
>   {
>       MachineState *ms = MACHINE(qdev_get_machine());
>       VAPICROMState *s = opaque;
> @@ -793,7 +792,7 @@ static int vapic_post_load(void *opaque, int version_id)
>   
>       if (!s->vmsentry) {
>           s->vmsentry =
> -            qemu_add_vm_change_state_handler(kvmvapic_vm_state_change, s);
> +            qemu_add_vm_change_state_handler(vapic_vm_state_change, s);
>       }
>       return 0;
>   }
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index cfdbfdcbcb..4909703a89 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -1,7 +1,7 @@
>   i386_ss = ss.source_set()
>   i386_ss.add(files(
>     'fw_cfg.c',
> -  'kvmvapic.c',
> +  'vapic.c',
>     'e820_memory_layout.c',
>     'multiboot.c',
>     'x86.c',


