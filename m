Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5CE804E48
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:45:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rARyb-0004qQ-Fs; Tue, 05 Dec 2023 04:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rARyY-0004q2-LV
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:44:22 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rARyX-00028H-0q
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:44:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c0873cf84so27273965e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 01:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701769459; x=1702374259; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3BNi9AliG2z++0r2YBuoPltqUX8sWnzDSdCV27+5l14=;
 b=gRaGZy6e6Yh7K1RHf+QT8dAB1j+ZWGafC3AcKsd0uI/5LnW4vATCRwkwxANS0YA4BH
 bQXB2x1BaHfrC9YeB3zzgYCRpfUeJTgpUsGORqvuBMSh4Xy18mpDoklsTKrXFetmvuRf
 6UL8RIPgeiecwBvS6Bg4gF5cwtJ7rexd/ko8WEoTeabmGvCC8kjpoVIrj9CQm2NcgN8e
 JnBGk0+NAqk4pdTqBCN/UbwJf/WbOh3EhkNrAtvno1Y4q27uUVHerH5R4QhSYn3K6sdw
 9CMJw56Sy+sEG53N0/dmH97p3NEW4cGSTkL5NXyZJAU1Syq8LoCHwpPNhf6PdBQKso13
 yDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701769459; x=1702374259;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3BNi9AliG2z++0r2YBuoPltqUX8sWnzDSdCV27+5l14=;
 b=tC7JxQ2blPalHOb+Bn3G2mU8wtoaq8jtUC788XizEtiMAPXMSxtBEGdymz8Aw6Uv6z
 MCRKz0Ymv8dIGeHkGX/akxdEty6jTPjUcrHo3+4fkvHEbP5r98Hjxvf++1/Nmt5Ldkca
 DZJdzpCIbZ1XiDGXsA7XuygVy/eoIys4dqNmWLlpOC5nFpK2Yx2HSwcS3rbZa4/EMVLc
 wh1GetpFBwn3JBvEkv0OKH/XOv9wv9vFlxyW/U8Wxu8ako46ueYiSp1j/79AKcUXMwo8
 BgObDqH5hJ07PaiUrJji2+shjuS0pwLwnm1zSFHtBWng0RMdaneegeCXPJcDtoia1CWM
 gckg==
X-Gm-Message-State: AOJu0YwcG/a2quPgZd8Ab4GgEfMr7QMhhbYpQosACpAcfRYbKSwsy5UT
 HfauG25/SrSrDfdqetjCpKImOaq01cl8abYy4DA=
X-Google-Smtp-Source: AGHT+IHlsHHCo+BPMprUjWiOUMfMPxoNL1IZwLv8jUwri4D8bIRKiKwDWqROEzs1u32VmZnQNmozkw==
X-Received: by 2002:a05:600c:4e94:b0:408:575e:f24f with SMTP id
 f20-20020a05600c4e9400b00408575ef24fmr303132wmq.28.1701769459000; 
 Tue, 05 Dec 2023 01:44:19 -0800 (PST)
Received: from [192.168.69.100] ([176.187.201.231])
 by smtp.gmail.com with ESMTPSA id
 ay31-20020a05600c1e1f00b004080f0376a0sm18116463wmb.42.2023.12.05.01.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Dec 2023 01:44:18 -0800 (PST)
Message-ID: <f873dd1e-b5ee-452e-9dd7-2f25ef2ada7b@linaro.org>
Date: Tue, 5 Dec 2023 10:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Content-Language: en-US
To: Annie Li <annie.li@oracle.com>, qemu-devel@nongnu.org, imammedo@redhat.com
Cc: miguel.luis@oracle.com
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205002356.1239-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Annie,

On 5/12/23 01:23, Annie Li wrote:
> Following hmp/qmp commands are implemented for pressing virtual
> sleep button,
> 
> hmp: system_sleep
> qmp: { "execute": "system_sleep" }
> 
> These commands put the guest into suspend or other power states
> depending on the power settings inside the guest.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hmp-commands.hx            | 14 ++++++++++++++
>   hw/core/machine-hmp-cmds.c |  5 +++++
>   hw/core/machine-qmp-cmds.c |  9 +++++++++
>   include/monitor/hmp.h      |  1 +
>   qapi/machine.json          | 18 ++++++++++++++++++
>   qapi/pragma.json           |  1 +
>   6 files changed, 48 insertions(+)


> index b6d634b30d..3ac69df92f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -297,6 +297,24 @@
>   ##
>   { 'command': 'system_reset' }
>   
> +##
> +# @system_sleep:

@since 9.0

> +#
> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
> +# sleep button.
> +#
> +# Notes: A guest may or may not respond to this command. This command
> +#        returning does not indicate that a guest has accepted the request
> +#        or that it has gone to sleep.
> +#
> +# Example:
> +#
> +# -> { "execute": "system_sleep" }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'system_sleep' }

Do we want a 'mode' argument, starting here with control_method?

> +
>   ##
>   # @system_powerdown:
>   #

