Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 916C77E1DD1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:03:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwRF-0004Jr-8s; Mon, 06 Nov 2023 05:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzwRB-0004JY-7m
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:02:30 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzwR7-0000sm-97
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:02:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so37583755e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699264943; x=1699869743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TFGqwGC6y0GfcVY0rvhrsKNs6fX5amoN6qwZJEx2U8o=;
 b=F+7Bb9R8eXypfzahm7yxpie3wFq1TMxO3AWAdjvtxIvcabeI+6wVV3WYMw4kaJRnS1
 YqYDumK288RJgCWNln0oZwyLdMkAkGUXcEkQ8Q6HqfaFjiDWn63qiOCvi01kJgxC2eQ4
 VyWMoSsuYeDIbqZiCWrijpzYrflGsS5dFiHsZHf63lpfLMz1sQ6PGVxfHItSDts3Ks13
 +MhrcpkY1R3sq3z+bqaIFNwrS07xNftdfn3PLnIfpKa7H0rAF/d3wpBIhB+/Kng+qnI1
 iNu/gF2w2uhcP8QwkRjMZKGWRodRHV6YulOplQVOtHGVv3b85irbed7U5+889qq2hjhp
 fsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699264943; x=1699869743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TFGqwGC6y0GfcVY0rvhrsKNs6fX5amoN6qwZJEx2U8o=;
 b=JfwBbJxh0eG+JaRo3w4tM2UDoG9bAv3G5SCjIeaJvlJDzYintuQD6oBeb1/zSYGjH1
 Xt65+VjdUSsjxAa5sxAwCtnL04yMBmUjvF4mCree3vf2Kc6LRIUbSng6b1L00Vf+eZy5
 MRkX0s0bhblK8ndEPMvdAzPujKkwACzgd9OXx9ZOr+vOAmpnSM77/bAgO3j5eyJwQArm
 adwASqw5hZSJNzPaco8n9f2cJstNHM92tQEQk2pk4B6IoBq3fRhiO3hwqs7HD+74YWAm
 4X5DGW+5Uk3gpoJ2i0/g1cw4hr1D8Qk0l6WbvdMY4YQgFq/2jHLsF3r1svsDZVWWYO2p
 FpQA==
X-Gm-Message-State: AOJu0YzCSLHWOBE+BGGwr7TkzpLjeKW7ONQ8BChlg7JwkTem1YVRs0Uo
 YLCNgctanTgCqbeeAOdAnR1YdQ==
X-Google-Smtp-Source: AGHT+IF3/iVG4FPJmOM+8wfiyYUTxk5/G3wxZPIccjZTYDkti8bBPbdswEG4lhnfEPL9xryxgWzR0Q==
X-Received: by 2002:a05:600c:4f53:b0:406:7021:7d8 with SMTP id
 m19-20020a05600c4f5300b00406702107d8mr24315856wmq.20.1699264942934; 
 Mon, 06 Nov 2023 02:02:22 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 h15-20020a05600c314f00b004094d4292aesm11543716wmo.18.2023.11.06.02.02.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 02:02:22 -0800 (PST)
Message-ID: <4da573ce-756e-d31b-5c13-4e0f8245dd08@linaro.org>
Date: Mon, 6 Nov 2023 11:02:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PULL v2 22/24] hw/display: make ATI_VGA depend on PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231106095542.1852973-1-marcandre.lureau@redhat.com>
 <20231106095542.1852973-23-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106095542.1852973-23-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi Marc-André,

Cc'ing Fuloong maintainers,

On 6/11/23 10:55, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> To avoid a kconfig cycle, change "depends on PCI" to "select PCI".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Acked-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   configs/devices/mips64el-softmmu/default.mak | 3 +--
>   hw/display/Kconfig                           | 3 ++-
>   hw/display/meson.build                       | 2 +-
>   hw/mips/Kconfig                              | 2 ++
>   4 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/configs/devices/mips64el-softmmu/default.mak b/configs/devices/mips64el-softmmu/default.mak
> index d5188f7ea5..4d80d60511 100644
> --- a/configs/devices/mips64el-softmmu/default.mak
> +++ b/configs/devices/mips64el-softmmu/default.mak
> @@ -1,9 +1,8 @@
>   # Default configuration for mips64el-softmmu
>   
>   include ../mips-softmmu/common.mak
> -CONFIG_FULOONG=y
> +#CONFIG_FULOONG=y

Why is the justification to disable this board? From the
bare "avoid a kconfig cycle" commit message, it is not
obvious to me.

>   CONFIG_LOONGSON3V=y
> -CONFIG_ATI_VGA=y
>   CONFIG_RTL8139_PCI=y
>   CONFIG_JAZZ=y
>   CONFIG_VT82C686=y
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 1aafe1923d..8219225a1c 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -125,7 +125,8 @@ config DPCD
>   config ATI_VGA
>       bool
>       default y if PCI_DEVICES
> -    depends on PCI
> +    depends on PIXMAN
> +    select PCI
>       select VGA
>       select BITBANG_I2C
>       select DDC
> diff --git a/hw/display/meson.build b/hw/display/meson.build
> index 9c06aaee20..344dfe3d8c 100644
> --- a/hw/display/meson.build
> +++ b/hw/display/meson.build
> @@ -62,7 +62,7 @@ system_ss.add(when: 'CONFIG_XLNX_DISPLAYPORT', if_true: files('xlnx_dp.c'))
>   
>   system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
>   
> -system_ss.add(when: [pixman, 'CONFIG_ATI_VGA'], if_true: files('ati.c', 'ati_2d.c', 'ati_dbg.c'))
> +system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
>   
>   
>   if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
> diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
> index ac1eb06a51..5d40795c0b 100644
> --- a/hw/mips/Kconfig
> +++ b/hw/mips/Kconfig
> @@ -32,7 +32,9 @@ config JAZZ
>   
>   config FULOONG
>       bool
> +    default y if MIPS64
>       select PCI_BONITO
> +    depends on ATI_VGA
>   
>   config LOONGSON3V
>       bool


