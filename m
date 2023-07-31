Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F18076996B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:23:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTnw-0005Db-0V; Mon, 31 Jul 2023 10:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTnp-000586-FC
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:23:17 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTnn-0000e5-Pu
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:23:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-307d20548adso4098129f8f.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690813394; x=1691418194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZZcB9Z+1fkeLt/d1VCn+ga9XJ/QfNhwxcjth8l7Z9nM=;
 b=n5CGc3YCsRexafqEMkTQJXIu3/LKHqEvnjDdb9vb/mPOGS51r9c3F4spu+1k/Wr+Yn
 cYmQq+09+CpKwLE+tSmjNhrcbCk49217gFtfcCtJAib8By8QMr0Dm+P0wBiLhCBXzgXj
 mtUSPtclwvT3ifq0EMNWsSeulqpOiELP+rkPcPVqu3B+zLehnqJqpMWMBi7RKgRwY4mH
 KSniI1zZ7ULjzE4vepN2bcNqV3p6tmNcA+z+PtgjPVcnOFmVBOhYyX59zCRzQCN3qOYG
 XHiUhRb0lMzJIR2QNVOSgIBZIcWiULu+2x66dQ/mT+Os5hATl5ys0A7QH5nJ5wOz9OyQ
 2gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690813394; x=1691418194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZcB9Z+1fkeLt/d1VCn+ga9XJ/QfNhwxcjth8l7Z9nM=;
 b=S2iwGvDcGdDOvzLNz79usHcTtFFEkz3O3FB7LyWOCSICe19fH4wqTe0F18xwTb2z90
 i9iDup/wi+LH4a1tqCeeRyaxGuNUlTWXzuUlJD5SUaV3THddXJ/mIDzBiKSzWaJPqsO9
 gYVs9VcR5RAoNYsn5xglHQOK7CdVp+5fjj00+e7lG1dLwIkQ0sdiU/iCqiBljqYmv4Z+
 nLveOPxOT5dU0HDVzm3PjhNxaYi1eF7kzXyGGuBPapxrSo/QQxRbmGmQvmEiDlkqbVn8
 vNFLSPk6IvvTL8zTls65yaDvF5qRAXb5hj5U/k2ohVveXq8NI91idq3ncVuEaCoyw2zP
 YTSA==
X-Gm-Message-State: ABy/qLamoC6N4Biy5PB/8FZD95muXQ9EyVVNZVpJ9AavS+et9r19oOa+
 ADWaNRGA4+kUVEx27f/gVABfAQ==
X-Google-Smtp-Source: APBJJlECc345k7d9c6dthcWZ3U5QD1YwjUKgQuIuBaMzS7tpQ53iJQbBELAts8J3KByCjE4RLDq8vA==
X-Received: by 2002:a5d:67c5:0:b0:317:3f0e:8cb1 with SMTP id
 n5-20020a5d67c5000000b003173f0e8cb1mr6905068wrw.45.1690813394108; 
 Mon, 31 Jul 2023 07:23:14 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 l11-20020adfe9cb000000b00314329f7d8asm13237129wrn.29.2023.07.31.07.23.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:23:13 -0700 (PDT)
Message-ID: <62b923c2-5c22-44c5-99cd-95351fd200db@linaro.org>
Date: Mon, 31 Jul 2023 16:23:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 6/6] gitlab-ci.d/windows: Use Clang for compiling in
 the 64-bit MSYS2 job
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-7-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230728142748.305341-7-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 28/7/23 16:27, Thomas Huth wrote:
> We are struggeling with timeouts in the 64-bit MSYS2 job. Clang seems
> to be a little bit faster, so let's use this compiler now instead.
> 
> There is a problem with compiling the spice headers with Clang, though,
> so we can only test this in the 32-bit builds with GCC now. And we have
> to disable dbus-display - otherwise the compilation aborts in the CI.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .gitlab-ci.d/windows.yml | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index f086540e40..ff9e9af4bb 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -43,7 +43,6 @@
>         $MINGW_TARGET-curl
>         $MINGW_TARGET-cyrus-sasl
>         $MINGW_TARGET-dtc
> -      $MINGW_TARGET-gcc
>         $MINGW_TARGET-glib2
>         $MINGW_TARGET-gnutls
>         $MINGW_TARGET-gtk3
> @@ -63,9 +62,9 @@
>         $MINGW_TARGET-SDL2
>         $MINGW_TARGET-SDL2_image
>         $MINGW_TARGET-snappy
> -      $MINGW_TARGET-spice
>         $MINGW_TARGET-usbredir
> -      $MINGW_TARGET-zstd "
> +      $MINGW_TARGET-zstd
> +      $EXTRA_PACKAGES "
>     - $env:CHERE_INVOKING = 'yes'  # Preserve the current working directory
>     - $env:MSYS = 'winsymlinks:native' # Enable native Windows symlink
>     - mkdir build
> @@ -77,13 +76,15 @@
>   msys2-64bit:
>     extends: .shared_msys2_builder
>     variables:
> -    MINGW_TARGET: mingw-w64-x86_64
> -    MSYSTEM: MINGW64
> +    MINGW_TARGET: mingw-w64-clang-x86_64
> +    MSYSTEM: CLANG64

OK to use Clang, but I'm tempted to keep the GCC job in manual mode...

