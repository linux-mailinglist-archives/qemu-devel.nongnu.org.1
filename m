Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9C827B4F
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMymX-0002Nc-Cd; Mon, 08 Jan 2024 18:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMymV-0002N9-4Z
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:11:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMymS-0006XN-Un
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:11:42 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so22115705e9.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704755498; x=1705360298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SG32AEuv0G8eleWJzocVL/qwMWC3RU2VJS/Q+uRXSY4=;
 b=IoUK0KV28c2Wna1eWlcFz78J9dXYECD/NylLstMUIsOPv/HbZCXyFl7XNFehoonlaK
 QQ9hDzcGOhb2zMzEj4XndIVYj/asLJBhXYE154vcGJQyW3Cu26cBBOeeM7PRGWy83JOA
 00TumQOF9WteSLes1g7/nf2T+c+iFpYHUfNgDTFzUsdIdIPJ46FDbcE++uLqoyCMZI8s
 Y9rbddefuY4yyb0F45AZhhII4FNSYUM1X8JwS8e9fblublTrDdRolxlYfvGnGfKwYJeb
 SLDNlwjfSble26FDUXy8S0M7vmvvNvARaZNf6NAshDvKibPXWdUOjeYuGZMkwsi9bbxa
 1EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704755498; x=1705360298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SG32AEuv0G8eleWJzocVL/qwMWC3RU2VJS/Q+uRXSY4=;
 b=rEKiGj/H1JT2keiTvaXlWPlzfZ4Sk4JCA8/b5LbSsQ9CXnivss0MK6xIn/LyVLCzyZ
 r01Er5+AGKZQdtXsHHTlA4cnnuT2henGl+O6aZjckOX5raQ0bWb1N+HW/UZt7IVc7dnp
 eTyRxGRJ3CxOy19UaGBIWqsvqmaN03dpkjpH7D4yJQiqOBiS10GwpFbwqYeUH/7/f4cs
 hCPcewvPYlryMVAOZgnfNO6nr2xMwZZXj3YCeGrdes5la98ohWXXGaVvZ+JLoVIgG7p+
 zIVZqeCn5zwtxkNAqkXlDH1xOhPq1C5pCISMACAphKQTh7ChcLwws2leCZMiWQIjzXkL
 EIRg==
X-Gm-Message-State: AOJu0Yzy87E+OCwOFD0zMsanXREJaspESwzjjMFEdbwgL3q/p9SRMXqM
 GlBWdR6JXX9zF3UOFdFN4m4dH0N0CrAj5g==
X-Google-Smtp-Source: AGHT+IFFuq1DAKx/V73ZG+X+7rKiL02+YruWdEeufnrxZylZN8xxiYAyy7qeZd3u+o0IWGrVTzLtow==
X-Received: by 2002:a05:600c:3b9a:b0:40e:42b4:23b6 with SMTP id
 n26-20020a05600c3b9a00b0040e42b423b6mr1873931wms.55.1704755498193; 
 Mon, 08 Jan 2024 15:11:38 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 k30-20020a05600c1c9e00b0040d887fda00sm1293186wms.26.2024.01.08.15.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 15:11:37 -0800 (PST)
Message-ID: <55b697ed-381f-47f8-bcaa-d8258c75b2a2@linaro.org>
Date: Tue, 9 Jan 2024 00:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/sh4: Deprecate the shix machine
Content-Language: en-US
To: Samuel Tardieu <sam@rfc1149.net>, qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, devel@lists.libvirt.org, qemu-block@nongnu.org
References: <20240108171523.2487291-1-sam@rfc1149.net>
 <20240108171523.2487291-2-sam@rfc1149.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108171523.2487291-2-sam@rfc1149.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Samuel,

On 8/1/24 18:15, Samuel Tardieu wrote:
> The shix machine has been designed and used at Télécom Paris from 2003
> to 2010. It had been added to QEMU in 2005 and has not been maintained
> since. Since nobody is using the physical board anymore nor interested
> in maintaining the QEMU port, it is time to deprecate it.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>   docs/about/deprecated.rst | 5 +++++
>   hw/sh4/shix.c             | 1 +
>   2 files changed, 6 insertions(+)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2e15040246..e6a12c9077 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -269,6 +269,11 @@ Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
>   
>   The Nios II architecture is orphan.
>   
> +``shix`` (since 9.0)
> +''''''''''''''''''''
> +
> +The machine is no longer in existence and has been long unmaintained
> +in QEMU.
>   
>   Backend options
>   ---------------
> diff --git a/hw/sh4/shix.c b/hw/sh4/shix.c
> index aa812512f0..58530b8ede 100644
> --- a/hw/sh4/shix.c
> +++ b/hw/sh4/shix.c
> @@ -80,6 +80,7 @@ static void shix_machine_init(MachineClass *mc)
>       mc->init = shix_init;
>       mc->is_default = true;
>       mc->default_cpu_type = TYPE_SH7750R_CPU;
> +    mc->deprecation_reason = "old and unmaintained - use a newer machine instead";

"use a newer machine instead" bugs me, what would that be?

Could we stick to "old and unmaintained"?

>   }
>   
>   DEFINE_MACHINE("shix", shix_machine_init)


