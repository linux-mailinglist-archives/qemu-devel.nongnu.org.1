Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A53D7FBEC0
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:59:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r80Sr-0008Ux-Bf; Tue, 28 Nov 2023 10:57:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r80Sm-0008UZ-MX
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:57:28 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r80Si-0000L5-W3
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:57:28 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c501bd6ff1so75218451fa.3
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701187042; x=1701791842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5SBZMq91q5w6CAn79AZJ3iQVzLY8ClGUWXTUWbpkRQQ=;
 b=WZaHT32X/vjvuvbTFgw0SfLOz4qxSOFx160svrn92gEyiQteca0AqLQ72e3ZqSDmR3
 r0MLS9PQHl8D9GNmnOBBfswkY0PgJTJHNOmg3Excof4I/vDVtszplnJDV5tiXRHd29eI
 Sp3FyRHBQEj0hfGx8t4IOk8onsKU2/1p4SFz1RnxS/gpccfaRu93KASaCr2oMiUFaoR4
 4+B9RtIsa3aFCD3HUj6ra5ac5sr6KQkoQJ2cxK+I27c48B2CFKCDOegv/+eHlQSE1bCX
 ADp0sd2ymJDCc7ZcCmnH+AvLGU6yo56DaDPE0XlhY8pKInjqXCYqN8a+mE+/fQzGVR8M
 qizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701187042; x=1701791842;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5SBZMq91q5w6CAn79AZJ3iQVzLY8ClGUWXTUWbpkRQQ=;
 b=HGtHEGXr3jKrA+3/gxAH3tN7tYZV7cMrDib6jTkHbTxQCJJk2MgnuygmWT9Lk9zoJ0
 BlPTdmDQpcrN4aZYKnNb7nh2uFJEAwCBI9+q4m4HyhiRGl0l8DOZlLB7R8qmM08Pi5Ue
 pBHui4/bRNPwSWvwiGDXcJgZGxhVO4ctcL8mfsD5KZp06Eo2HX1Vnfdd72MTWlStYJ7S
 EMt6wTVZMN4xyEmaa5L9o880cQdAICd58IvWeEDqlC+lFM1wN2j38oBtJ4YkZpgTbSSr
 b6zG/CEXhAGB/nkbHpJtxdOTFSaIpTZLkz4CdR0MmfKu7lQCb5CJkMOQQMwcrCm+nHPM
 9EJQ==
X-Gm-Message-State: AOJu0Ywub7neHqcwvxQBd3feRibcOFLmH9bzN5/FvalR+Cx9Ca1CRkVs
 CXpLOV6zee/S6XcW7kL36UcFnA==
X-Google-Smtp-Source: AGHT+IESLt2V8FyMjN5dhpFXIogFMPaeEuwUhaaujH72xI4Hps75QNdo42+MLtaTiTcddWdhb94mig==
X-Received: by 2002:a05:651c:4d4:b0:2c9:9a5e:ca2c with SMTP id
 e20-20020a05651c04d400b002c99a5eca2cmr6577590lji.36.1701187042404; 
 Tue, 28 Nov 2023 07:57:22 -0800 (PST)
Received: from [192.168.69.100] (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 e8-20020a170906080800b009fdc15b5304sm6930203ejd.102.2023.11.28.07.57.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Nov 2023 07:57:22 -0800 (PST)
Message-ID: <6776b07c-f1a8-4b96-9527-de8e0ed16980@linaro.org>
Date: Tue, 28 Nov 2023 16:57:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] crypto: Introduce SM4 symmetric cipher algorithm
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <4413f00465bda93eda7a7560afb990ca01191062.1701185032.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Hi Hyman,

On 28/11/23 16:24, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> Use the crypto-sm4 meson build option for enabling this feature.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   crypto/block-luks.c             | 11 ++++++++
>   crypto/cipher-gcrypt.c.inc      |  8 ++++++
>   crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
>   crypto/cipher.c                 |  6 ++++
>   meson.build                     | 23 ++++++++++++++++
>   meson_options.txt               |  2 ++
>   qapi/crypto.json                |  5 +++-
>   scripts/meson-buildoptions.sh   |  3 ++
>   tests/unit/test-crypto-cipher.c | 13 +++++++++
>   9 files changed, 119 insertions(+), 1 deletion(-)


> diff --git a/meson.build b/meson.build
> index ec01f8b138..256d3257bb 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1480,6 +1480,7 @@ endif
>   gcrypt = not_found
>   nettle = not_found
>   hogweed = not_found
> +crypto_sm4 = not_found
>   xts = 'none'
>   
>   if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> @@ -1514,6 +1515,26 @@ if not gnutls_crypto.found()
>         xts = 'private'
>       endif
>     endif
> +  if get_option('crypto_sm4').enabled()

We want to detect it by default (not only when explicitly enabled) ...

> +    if get_option('gcrypt').enabled()
> +      # SM4 ALG is available in libgcrypt >= 1.9
> +      crypto_sm4 = dependency('libgcrypt', version: '>=1.9',
> +                              method: 'config-tool',
> +                              required: get_option('gcrypt'))
> +      # SM4 ALG static compilation
> +      if crypto_sm4.found() and get_option('prefer_static')
> +        crypto_sm4 = declare_dependency(dependencies: [
> +          crypto_sm4,
> +          cc.find_library('gpg-error', required: true)],
> +          version: crypto_sm4.version())
> +      endif
> +    else
> +      # SM4 ALG is available in nettle >= 3.9
> +      crypto_sm4 = dependency('nettle', version: '>=3.9',
> +                              method: 'pkg-config',
> +                              required: get_option('nettle'))
> +    endif

... and if it was forced with --enable-crypto_sm4 AND not found,
display an error.

IIUC your config you try to find the best effort implementation then
if not found, keep going silently.

> +  endif
>   endif


> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 680fa3f581..f189f34829 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -106,6 +106,7 @@ meson_options_help() {
>     printf "%s\n" '  colo-proxy      colo-proxy support'
>     printf "%s\n" '  coreaudio       CoreAudio sound support'
>     printf "%s\n" '  crypto-afalg    Linux AF_ALG crypto backend driver'
> +  printf "%s\n" '  crypto-sm4      SM4 symmetric cipher algorithm support'
>     printf "%s\n" '  curl            CURL block device driver'
>     printf "%s\n" '  curses          curses UI'
>     printf "%s\n" '  dbus-display    -display dbus support'
> @@ -282,6 +283,8 @@ _meson_option_parse() {
>       --disable-coroutine-pool) printf "%s" -Dcoroutine_pool=false ;;
>       --enable-crypto-afalg) printf "%s" -Dcrypto_afalg=enabled ;;
>       --disable-crypto-afalg) printf "%s" -Dcrypto_afalg=disabled ;;
> +    --enable-crypto-sm4) printf "%s" -Dcrypto_sm4=enabled ;;
> +    --disable-crypto-sm4) printf "%s" -Dcrypto_sm4=disabled ;;
>       --enable-curl) printf "%s" -Dcurl=enabled ;;
>       --disable-curl) printf "%s" -Dcurl=disabled ;;
>       --enable-curses) printf "%s" -Dcurses=enabled ;;


