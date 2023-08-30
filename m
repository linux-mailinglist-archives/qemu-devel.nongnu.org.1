Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9E78D743
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:49:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNQs-0001Rn-BB; Wed, 30 Aug 2023 11:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNQp-0001RX-Fs
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:48:35 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNQm-0005IN-VO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:48:35 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so9158964e87.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693410511; x=1694015311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/4mw9SmvIy3YgT48BGk6E+wOswVwxnu575qnqjB0usY=;
 b=R6/a7AmqFiBgp+vDokb7LI8ZvESE4WygSQqVk9eHObSkh4LousGiWRP3jE7RFzW6CV
 7/ADIV74IR18niV3FrrCS+LoSdAYYGd29YeClPAD0D8gkYgHquCvYdrU6A6APOYDR7q0
 QJFG18yywVh3Nl+nKmnnxg24CfoR2Q1mNt82cua94snPQGkVTJs/X5a/916G6Unoj5tg
 nowLZXJqzn4GVAy5r+xVWGhfdlwj2CBhM7psx+PXmbiJr/OMxi4XAqxzfn3Y4Ni3bCd3
 RwHf3RkZ/W26PQWb9hpPhXmzB9utZIZCQgfumYa4rAiOZEiskNBI//37q/82lZ22KOip
 uKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410511; x=1694015311;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/4mw9SmvIy3YgT48BGk6E+wOswVwxnu575qnqjB0usY=;
 b=O7F7gz2PawfN18EN34Th+fd3YGATFokTv/gMg+xK+gJlJd/55nt9GDCFFoPVg3/RCf
 bnF29TNZSQk5MCcuVFUOI0/1lwogn77pRD0MRMb5jNO/x+pYgJhtFv0x00/cIrYvXeQg
 pdxM/GyQUkO3QYBP55g1TWncf2YLgQRmaSOiR5ytjoLROyQ77NkSIN1yZFVOHmqdeTvK
 2k34oTjoDAJj7wDXLv39fOgBc5/bYDCp+IZ/wuFGNAt8016E8DDL/duCo567RaaIBNPF
 9g2l6CNuz/RpQ0wflREat1aGDKcll/hquIUrm2HJ4MLNy3kR8l+59/nMmGtLDrmaVECk
 TmFA==
X-Gm-Message-State: AOJu0YyzU4M6skeDP2y2WkW6G4lNwtWLVg8pCmHaxUEMk4a0xeoMg+5W
 tXYP1nNef+jPHgjMBTxwf3IVpwkhGnRR+QYOlApHPQob
X-Google-Smtp-Source: AGHT+IFKIxlohdABUY3feVKWFL+1+DPuVFemkRm6PtvfKZG1SLC/m+lZ7u3ndBfqODeAtNB6zPakow==
X-Received: by 2002:a05:6512:33cd:b0:4f8:67f0:7253 with SMTP id
 d13-20020a05651233cd00b004f867f07253mr2560086lfg.49.1693410510733; 
 Wed, 30 Aug 2023 08:48:30 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005233609e39dsm6969047edw.30.2023.08.30.08.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:48:30 -0700 (PDT)
Message-ID: <784947c2-3b2a-6452-b009-c4a21fd67d0a@linaro.org>
Date: Wed, 30 Aug 2023 17:48:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 51/67] build-sys: add optional "pixman" feature
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-52-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-52-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Set CONFIG_PIXMAN accordinly.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   meson.build       | 6 ++++--
>   Kconfig.host      | 3 +++
>   meson_options.txt | 2 ++
>   3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..3bd7046099 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -836,8 +836,8 @@ if 'ust' in get_option('trace_backends')
>                        method: 'pkg-config')
>   endif
>   pixman = not_found
> -if have_system or have_tools
> -  pixman = dependency('pixman-1', required: have_system, version:'>=0.21.8',
> +if not get_option('pixman').auto() or have_system or have_tools
> +  pixman = dependency('pixman-1', required: get_option('pixman'), version:'>=0.21.8',
>                         method: 'pkg-config')
>   endif
>   zlib = dependency('zlib', required: true)
> @@ -2126,6 +2126,7 @@ config_host_data.set('CONFIG_SECCOMP', seccomp.found())
>   if seccomp.found()
>     config_host_data.set('CONFIG_SECCOMP_SYSRAWRC', seccomp_has_sysrawrc)
>   endif
> +config_host_data.set('CONFIG_PIXMAN', pixman.found())
>   config_host_data.set('CONFIG_SNAPPY', snappy.found())
>   config_host_data.set('CONFIG_TPM', have_tpm)
>   config_host_data.set('CONFIG_TSAN', get_option('tsan'))
> @@ -2833,6 +2834,7 @@ have_ivshmem = config_host_data.get('CONFIG_EVENTFD')
>   host_kconfig = \
>     (get_option('fuzzing') ? ['CONFIG_FUZZ=y'] : []) + \
>     (have_tpm ? ['CONFIG_TPM=y'] : []) + \
> +  (pixman.found() ? ['CONFIG_PIXMAN=y'] : []) + \
>     (spice.found() ? ['CONFIG_SPICE=y'] : []) + \
>     (have_ivshmem ? ['CONFIG_IVSHMEM=y'] : []) + \
>     (opengl.found() ? ['CONFIG_OPENGL=y'] : []) + \
> diff --git a/Kconfig.host b/Kconfig.host
> index d763d89269..b6ac2b9316 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -11,6 +11,9 @@ config OPENGL
>   config X11
>       bool
>   
> +config PIXMAN
> +    bool
> +
>   config SPICE
>       bool
>   
> diff --git a/meson_options.txt b/meson_options.txt
> index aaea5ddd77..89654fd77d 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -216,6 +216,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
>          description: 'l2tpv3 network backend support')
>   option('netmap', type : 'feature', value : 'auto',
>          description: 'netmap network backend support')
> +option('pixman', type : 'feature', value : 'auto',
> +       description: 'pixman support')
>   option('slirp', type: 'feature', value: 'auto',
>          description: 'libslirp user mode network backend support')
>   option('vde', type : 'feature', value : 'auto',

Apparently missing:

-- >8 --
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 9da3fe299b..16957ea9f0 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -146,6 +146,7 @@ meson_options_help() {
    printf "%s\n" '  pa              PulseAudio sound support'
    printf "%s\n" '  parallels       parallels image format support'
    printf "%s\n" '  pipewire        PipeWire sound support'
+  printf "%s\n" '  pixman          pixman support'
    printf "%s\n" '  png             PNG support with libpng'
    printf "%s\n" '  pvrdma          Enable PVRDMA support'
    printf "%s\n" '  qcow1           qcow1 image format support'
@@ -397,6 +398,8 @@ _meson_option_parse() {
      --disable-parallels) printf "%s" -Dparallels=disabled ;;
      --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
      --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
+    --enable-pixman) printf "%s" -Dpixman=enabled ;;
+    --disable-pixman) printf "%s" -Dpixman=disabled ;;
      --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
      --enable-png) printf "%s" -Dpng=enabled ;;
      --disable-png) printf "%s" -Dpng=disabled ;;
---

