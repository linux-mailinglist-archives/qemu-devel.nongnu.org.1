Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A87E1DD5
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:03:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwSS-00056R-NP; Mon, 06 Nov 2023 05:03:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzwSQ-000562-0E
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:03:46 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzwSO-0001Gm-4V
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:03:45 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso25481005e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699265022; x=1699869822; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fj0WBiV1csBTaHU0QtEeb5jVwc1imS5gZRFLUWkKBkg=;
 b=F20SQHw4UfdSo9lY0MYiWCaqT42O103Fqwaq569nAsSV89KE3xiaqxby5yMj/wYMCI
 vOp1tebR5De2vUbz7bFJ+gE8anc8OzOaP8pwfyHW2KSUPqlFrAKXtXn+YIQKRDUmbuCp
 SUPu512Ai/usplIj5VrP8p7xLVM/SufCYI+zxaF+kFc6SOdHc1VU4VFWz3skmBKaxTCK
 dLg0qTgzUY7Erdb5CTAP5yl9xz8njPmwObZp61qn3PnnQlsTo7ZAjoo/WybFwkee+Pw5
 wGamxE659sDfk4Mkal+d2+o6H7AxYRhGqvFmOPwsBT5kGAkb9BgKbIPrehfUwhPQlyAF
 UYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699265022; x=1699869822;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fj0WBiV1csBTaHU0QtEeb5jVwc1imS5gZRFLUWkKBkg=;
 b=FNPdw0UzhgXSL5CAPPq4NeH/CbtNhNRr1w4wI6izBVGadgeGBpa6mVzxzBY0raKTyR
 MCsfpl48rpO7/acJcZ1wzExrdgqCxf+vWgZFisJACmnyowOLSxM1LDrcYxrEHF3FoHjK
 ALKZzlX8ymWCrZAfWmYfGYDeeJiDoJ2pcHbYwrk1hzAaCyDlPyogGWG/GLv28s9n024s
 hzaHX/M4tXoh13jl3XhsItzxYKia9/ecBvWE7KLrSqIvboOkSGYagJDtzXZIHC0y1cnD
 uwBvxKjV075SuZpdaVorbuVnbrE3ijWFOA83BN4pJcECkiutwHcp4GOO8sZA33yM8w+E
 gTYg==
X-Gm-Message-State: AOJu0YwbVJYk7pPQLgdhsCQcnFeN404QaNGqA77+2snBMOm5YNitce9J
 fEfFn0XJiu2DMxc/JVM3w1JIuqJwpuU6V3qCbBM=
X-Google-Smtp-Source: AGHT+IGsHSvH1uScU5+IfG0M1BXPnEl8qqMIJsn7tj8PYPcFZ+Dpszay0a8lo6m6vHSy45J33fChWw==
X-Received: by 2002:a05:600c:229a:b0:405:2d29:1648 with SMTP id
 26-20020a05600c229a00b004052d291648mr10508846wmf.19.1699265022391; 
 Mon, 06 Nov 2023 02:03:42 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 i17-20020a05600c481100b004063d8b43e7sm11419678wmo.48.2023.11.06.02.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 02:03:42 -0800 (PST)
Message-ID: <804c3e5b-ae33-f9c6-7a0d-9d0dcf00ee13@linaro.org>
Date: Mon, 6 Nov 2023 11:03:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL v2 23/24] hw/mips: FULOONG depends on VT82C686
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-24-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106095542.1852973-24-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.137,
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

On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Pulled patch missing R-b, so I'm giving one:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   hw/mips/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index 5d40795c0b..c120b784aa 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -34,6 +34,7 @@ config FULOONG
>       bool
>       default y if MIPS64
>       select PCI_BONITO
> +    select VT82C686
>       depends on ATI_VGA
>   
>   config LOONGSON3V


