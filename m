Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D877FDF26
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:14:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8P3F-0002lN-Cr; Wed, 29 Nov 2023 13:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8P3D-0002kr-80
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:12:43 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8P38-0000bk-LY
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:12:42 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c9c149848fso1116281fa.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701281556; x=1701886356; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W+SAwFCgzjTGbYYX57PnFPnKNJzdZPh7wPIM2FCdJgU=;
 b=yK3/wd0bbwFsmTIedhmkyZCZXX0HIkDzraLQTN/2T4m/BMNZSyJ8Jx9LK3E7KEFNXK
 LM4bHFITmMVQPY8oeTGvKeefWObWd0aCIoExMnhdc+S/mQmRIuVom+/TNf39KdQ3mOKF
 BqbhDaL5bytuWBO1zYa1sz+fC7SPjzP5VyZPxbATZbvhK/9pCq2eS7YUpICikhYIvak7
 TAQ2J/Ahv293EV/4IROjjXn6eYYsNIDxwvjM7VxaYCieS63od8u+FgqNT/GbY0pa66Ju
 Aw1Pq6zr2SbZKYqMPQ+XMwiW8DAyl8LOYwxoQSlM+kA3sncO/LYZaWxIrIHNFAfZqZZ7
 aing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281556; x=1701886356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W+SAwFCgzjTGbYYX57PnFPnKNJzdZPh7wPIM2FCdJgU=;
 b=ZbpIlR41BK2qrqAohUeq/u8rZAhmAcN2OvdAq7gvE8Wz60z3nbTGgbgcpSzLJ6QTlf
 Lr9wLXxPuNMdOSIYKKarapJ9BArOn08l5swTxl2ycOnrWl0iG/d2qCI3kX7V/teSalU6
 biv29BGdsvN5wyylHdEjCY8ufaNJhJm0jZR5tqeyUOl4EgjJOeRGX7LfBneky8KBwpWk
 A1/I3slOcmyJfX7wTRuXWBicwSWHadSBmUjBvdIr/LkIJPoRMu7aakmNcj3Rlq77zbbz
 6yWWT6YYwNnwo9FVRaM+rOTdiqnI22UPTx0/6jPqz/KetAeWs+HnMgC1uHdQGpyhy94L
 ohiA==
X-Gm-Message-State: AOJu0YzNGVNx8RJi4JffJ0HjB77ihSBVE8Z2/KCKVMuSozIZMpGjRZVq
 uF6YPrEuIdK2503IbOPknArUFQ==
X-Google-Smtp-Source: AGHT+IEhI8htPAVzC6vKTXhGann0MqXFeiVYlIed9jIdEJxpW5rGCviIQIz/ZmKGpnd8K77qqxi2/g==
X-Received: by 2002:a2e:7804:0:b0:2c9:af50:da62 with SMTP id
 t4-20020a2e7804000000b002c9af50da62mr5012974ljc.14.1701281556142; 
 Wed, 29 Nov 2023 10:12:36 -0800 (PST)
Received: from [192.168.110.175] (28.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.28]) by smtp.gmail.com with ESMTPSA id
 t6-20020a05600001c600b00332ff21038fsm10038958wrx.106.2023.11.29.10.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 10:12:35 -0800 (PST)
Message-ID: <519d21d5-5773-4686-ab2b-0cb3ae94abb3@linaro.org>
Date: Wed, 29 Nov 2023 19:12:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] crypto: Introduce SM4 symmetric cipher algorithm
Content-Language: en-US
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <3c9608d818225af1e20478f98501594a5fea9353.1701270110.git.yong.huang@smartx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3c9608d818225af1e20478f98501594a5fea9353.1701270110.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
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

On 29/11/23 16:17, Hyman Huang wrote:
> Introduce the SM4 cipher algorithms (OSCCA GB/T 32907-2016).
> 
> SM4 (GBT.32907-2016) is a cryptographic standard issued by the
> Organization of State Commercial Administration of China (OSCCA)
> as an authorized cryptographic algorithms for the use within China.
> 
> Use the crypto-sm4 meson build option to explicitly control the
> feature, which would be detected by default.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   crypto/block-luks.c             | 11 ++++++++
>   crypto/cipher-gcrypt.c.inc      |  8 ++++++
>   crypto/cipher-nettle.c.inc      | 49 +++++++++++++++++++++++++++++++++
>   crypto/cipher.c                 |  6 ++++
>   meson.build                     | 42 ++++++++++++++++++++++++++++
>   meson_options.txt               |  2 ++
>   qapi/crypto.json                |  5 +++-
>   scripts/meson-buildoptions.sh   |  3 ++
>   tests/unit/test-crypto-cipher.c | 13 +++++++++
>   9 files changed, 138 insertions(+), 1 deletion(-)


> diff --git a/meson.build b/meson.build
> index ec01f8b138..765f9c9f50 100644
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
> @@ -1505,6 +1506,28 @@ if not gnutls_crypto.found()
>            cc.find_library('gpg-error', required: true)],
>           version: gcrypt.version())
>       endif
> +    crypto_sm4 = gcrypt
> +    # SM4 ALG is available in libgcrypt >= 1.9
> +    if gcrypt.found() and not cc.links('''
> +      #include <gcrypt.h>
> +      int main(void) {
> +        gcry_cipher_hd_t handler;
> +        gcry_cipher_open(&handler, GCRY_CIPHER_SM4, GCRY_CIPHER_MODE_ECB, 0);
> +        return 0;
> +      }''', dependencies: gcrypt)
> +      crypto_sm4 = not_found
> +      if get_option('crypto_sm4').enabled()
> +        error('could not link sm4')

'could not link libsm4'? Up to the maintainer.

> +      else
> +        warning('could not link sm4, disabling')
> +      endif
> +    endif
> +    if crypto_sm4.found() and get_option('prefer_static')
> +      crypto_sm4 = declare_dependency(dependencies: [
> +        gcrypt,
> +        cc.find_library('gpg-error', required: true)],
> +        version: gcrypt.version())
> +    endif
>     endif
>     if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
>       nettle = dependency('nettle', version: '>=3.4',
> @@ -1513,6 +1536,23 @@ if not gnutls_crypto.found()
>       if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
>         xts = 'private'
>       endif
> +    crypto_sm4 = nettle
> +    # SM4 ALG is available in nettle >= 3.9
> +    if nettle.found() and not cc.links('''
> +      #include <nettle/sm4.h>
> +      int main(void) {
> +        struct sm4_ctx ctx;
> +        unsigned char key[16] = {0};
> +        sm4_set_encrypt_key(&ctx, key);
> +        return 0;
> +      }''', dependencies: nettle)
> +      crypto_sm4 = not_found
> +      if get_option('crypto_sm4').enabled()
> +        error('could not link sm4')

Ditto, otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +      else
> +        warning('could not link sm4, disabling')
> +      endif
> +    endif
>     endif
>   endif


