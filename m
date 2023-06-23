Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C773C421
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 00:31:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCpIC-0000WL-MU; Fri, 23 Jun 2023 18:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCpIA-0000WB-Up
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 18:30:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCpI1-0003M3-Fr
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 18:30:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa7eb35a13so9148315e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 15:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687559399; x=1690151399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2N0xPfZXCRkX2q7uosKBjA618nIZ+d4K9nkwBl8PKeI=;
 b=jVuoxpRAIfBsDR9Oig9KxUZrH6e9zBhrXmixeLNRN4i45k3I9hHtxnOdUFlK3wJhZZ
 hJalvdpHZrBhF21jG2eZof6EbHdqhAcsLWqIeIBKl5rcUlby93lJKKsRsRlFyQb2gEy7
 kxIdDlTP1MwdBJfNPZi69+WWTUf3lJmeiIuYMDJvTkuPrW5OQJ/XitSdQhb5v5OpAypR
 j9qHkWIgXW3yT38tCmkKyDBcOemo0JNOtOUP4a1G78bm4dVKCLxUdOqfNwMb3t3mQDPM
 B4Oov8fHjrFa9L7/j42KMylYtMz409En+qCHHNRoFKXg/xxxFqq2uO3rQY5AjwmVWCg7
 Eoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687559399; x=1690151399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2N0xPfZXCRkX2q7uosKBjA618nIZ+d4K9nkwBl8PKeI=;
 b=fgzjIjsUXOVEozpsSMiGIoAhIhH749Fpjq0ZdT/gYyoxmB+2FcdW5efWf1FBSka/y6
 vPJ++brzfn8rJyR8b66Rh3jUAXqon7dzgUjNhhkDIxYbBazJHudmsxJNnI0M51uN0r0E
 YXtyCBcF1h7Xc2cY7i8olas8gBwq9cYRI04/jwrH4AHCeVuSlDPq9G7S1nvE0ZIGFrDl
 qLMLAzjPlFGuFLbd5Sh/jFxshnXRwhAOLjGaepZU8y7II7biUsHh6upm63a6bh+B4Na7
 cW+QSrL7mi7SXxX3nKgsKsHY/XX0MteF13pdJrjStME0IVRL7AwPvla9veDbiNRR9neT
 BSKw==
X-Gm-Message-State: AC+VfDz4Z46QGc/teGZV0byDf86IC+zBVARPC3DQUSDnxUPNzWu7fcnA
 vTTR2dO+g8A72ySr9PaxSuu6NQ==
X-Google-Smtp-Source: ACHHUZ7VxVXYgp10ZE0W5DMK2aTwFqwUDxCzNbxt7JFP75PUq4rI5Nqv9SnHxu1qLXm9i/W+ydHOCA==
X-Received: by 2002:a05:600c:202:b0:3fa:7828:df2c with SMTP id
 2-20020a05600c020200b003fa7828df2cmr3346587wmi.16.1687559398812; 
 Fri, 23 Jun 2023 15:29:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.168.147])
 by smtp.gmail.com with ESMTPSA id
 o23-20020a05600c379700b003f8f884ebe5sm552917wmr.2.2023.06.23.15.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 15:29:58 -0700 (PDT)
Message-ID: <c4782597-91f8-93c2-dea1-1b755fdec17e@linaro.org>
Date: Sat, 24 Jun 2023 00:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PULL 10/14] tests/docker: Remove old Debian 9 containers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
 <20201002113645.17693-11-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20201002113645.17693-11-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 2/10/20 13:36, Alex Bennée wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We do not support Debian 9 in QEMU anymore, and the Debian 9 containers
> are now no longer used in the gitlab-CI. Time to remove them.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Message-Id: <20200921174320.46062-6-thuth@redhat.com>
> Message-Id: <20200925154027.12672-14-alex.bennee@linaro.org>


> --- a/tests/docker/dockerfiles/debian-win64-cross.docker
> +++ /dev/null
> @@ -1,45 +0,0 @@
> -#
> -# Docker mingw64 cross-compiler target
> -#
> -# This docker target builds on the debian Stretch MXE base image.
> -#
> -FROM qemu/debian9-mxe
> -
> -MAINTAINER Philippe Mathieu-Daudé <f4bug@amsat.org>
> -
> -ENV TARGET x86-64
> -
> -ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
> -
> -ENV PKG_CONFIG_PATH \
> -    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
> -
> -RUN apt-get update && \
> -    DEBIAN_FRONTEND=noninteractive eatmydata \
> -    apt-get install -y --no-install-recommends \
> -        mxe-$TARGET-w64-mingw32.shared-bzip2 \
> -        mxe-$TARGET-w64-mingw32.shared-curl \
> -        mxe-$TARGET-w64-mingw32.shared-glib \
> -        mxe-$TARGET-w64-mingw32.shared-libgcrypt \
> -        mxe-$TARGET-w64-mingw32.shared-libusb1 \
> -        mxe-$TARGET-w64-mingw32.shared-lzo \
> -        mxe-$TARGET-w64-mingw32.shared-nettle \
> -        mxe-$TARGET-w64-mingw32.shared-ncurses \
> -        mxe-$TARGET-w64-mingw32.shared-nsis \
> -        mxe-$TARGET-w64-mingw32.shared-pixman \
> -        mxe-$TARGET-w64-mingw32.shared-pkgconf \
> -        mxe-$TARGET-w64-mingw32.shared-pthreads \
> -        mxe-$TARGET-w64-mingw32.shared-sdl2 \
> -        mxe-$TARGET-w64-mingw32.shared-sdl2-mixer \
> -        mxe-$TARGET-w64-mingw32.shared-sdl2-gfx \
> -        mxe-$TARGET-w64-mingw32.shared-zlib \
> -        curl && \
> -    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvEmulation.h \
> -        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvemulation.h?format=raw" && \
> -    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/WinHvPlatform.h \
> -        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatform.h?format=raw" && \
> -    curl -s -S -o /usr/lib/mxe/usr/x86_64-w64-mingw32.shared/include/winhvplatformdefs.h \
> -        "https://sourceforge.net/p/mingw-w64/mingw-w64/ci/master/tree/mingw-w64-headers/include/winhvplatformdefs.h?format=raw"
> -
> -# Specify the cross prefix for this image (see tests/docker/common.rc)
> -ENV QEMU_CONFIGURE_OPTS --cross-prefix=x86_64-w64-mingw32.shared-

I just realized this was the image cross-building the WHPX accel.

Presumably we don't test it since 2.5 years.

Sunil, is it still working for you?

