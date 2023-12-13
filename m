Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD39C811B59
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:38:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDTBz-0008Qx-GU; Wed, 13 Dec 2023 12:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTBx-0008Qb-7C
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:38:41 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDTBv-0003zR-LB
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:38:40 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-551ee7d5214so2396018a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702489117; x=1703093917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fu65CklvYUKxCiVFC9rbzedqEWLvaKRYiHp+AiaBXR8=;
 b=UgNg/m00jQAQSTjQnwhm6gKl+1DvOq2dprVmZabsojiYHoJdNugh0OaK9ngyMN/LnZ
 50C6kTvZGJgM4CCXi6stKpx0oIxH9MMTY09wxJYB3Niy9GqdMYEiWnXTg41TiYXGDmvA
 XRUzlqv3njX9UqPJm1dpP85VDQEzw8RJVH3N+HEDDDiUixHBiJlkbC+OJrIyUpDvwsKv
 vyFJ0FMnaBG1babyLHjMkLt7jaJqmNMyHuzsYpgOBWEiPBguZlH68SiR4DYNA1sg4uok
 RW5jTCDyKQc45YyANgioYHQ059spCLqMiOsekJrVO74vtDVaI8z3ITETD3kKQPL68Elb
 Rflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702489117; x=1703093917;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fu65CklvYUKxCiVFC9rbzedqEWLvaKRYiHp+AiaBXR8=;
 b=kaEE7Ox31FjN9pMYqfFbtA2KULPyy/2pXwhYHUeMQ1DbBLj4KYYGKhDvjPZ2TQtl+7
 APh2EHU+ikw+QHtkYBvhiPbwhhN5c6JEYMG3EXsLHVGXXlu3Ohj4mQke7XsiNtUCIsK8
 /XwKp5IL96nw+ziTTag7b8/LUG5O9eOC8L2Ju0G3gjZdj0kaUELIgG95bpwBFWCXVI7r
 5PgaugTGX9sdYMs8LvIgKCtjqTN+DyXSNnim20RHADB9UauTG/sJqlOrHLg6EhHc5G84
 rMN3Rxw6K2T5Y1ue9g68rqXdnkvFWQXLUcBX5tYJt03NvcxKSVxS5Hmli0WT6s5SV37U
 vqhg==
X-Gm-Message-State: AOJu0Ywq4iN/wFkJfoABb8El4N9eBhPGI+nQFwLSduUyGoLkeWpcm4Rs
 9weBRUpugAgLs8VMK3OyAtImI8vBsj1qyXmCxSTFeQ==
X-Google-Smtp-Source: AGHT+IEbQM3gG66s2NzJ4lwa4aHUvMq54FSsK/PM0tUQD8MKesUt2d92RSVxubVNW/9Sn8b+zWaTfg==
X-Received: by 2002:a17:906:4bc5:b0:a1d:4874:1ab7 with SMTP id
 x5-20020a1709064bc500b00a1d48741ab7mr9333284ejv.65.1702489117350; 
 Wed, 13 Dec 2023 09:38:37 -0800 (PST)
Received: from [192.168.79.175] ([93.23.251.22])
 by smtp.gmail.com with ESMTPSA id
 vx12-20020a170907a78c00b00a1ddb5a2f7esm8203849ejc.60.2023.12.13.09.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 09:38:36 -0800 (PST)
Message-ID: <140ad3eb-7cb1-40cc-ba36-984d82e56ebe@linaro.org>
Date: Wed, 13 Dec 2023 18:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0] meson: Allow building binary with no
 target-specific files in hw/
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231121203129.67999-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121203129.67999-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Hi Paolo,

No objection if I queue this patch?

On 21/11/23 21:31, Philippe Mathieu-Daudé wrote:
> Allow  building a qemu-system-foo binary with target-agnostic
> only HW models.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Although this is for 9.0, I wanted to post it today to celebrate :)
> 
> Once reviewed I plan to queue it via my heterogenenous-cpus tree.
> ---
>   meson.build | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index ec01f8b138..9ccfb091e7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -3772,9 +3772,11 @@ foreach target : target_dirs
>       arch_deps += t.dependencies()
>   
>       hw_dir = target_name == 'sparc64' ? 'sparc64' : target_base_arch
> -    hw = hw_arch[hw_dir].apply(config_target, strict: false)
> -    arch_srcs += hw.sources()
> -    arch_deps += hw.dependencies()
> +    if hw_arch.has_key(hw_dir)
> +      hw = hw_arch[hw_dir].apply(config_target, strict: false)
> +      arch_srcs += hw.sources()
> +      arch_deps += hw.dependencies()
> +    endif
>   
>       arch_srcs += config_devices_h[target]
>       link_args += ['@block.syms', '@qemu.syms']


