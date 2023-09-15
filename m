Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C5F7A1A27
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:15:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh4uN-0002a4-SI; Fri, 15 Sep 2023 05:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4uM-0002Zc-Ai
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:14:38 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4uK-0002YH-FG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:14:38 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52683b68c2fso2195248a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694769274; x=1695374074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=csH8uynrhAKRyNtySU3G0SLyp0u8KMtuWG9AGTXrGYE=;
 b=eeV8RGuENRVbFrHa6EFByWY5J+f8gMay0l7FYTHweqjf2Gr/P815SEu5sWI0sDEKx7
 1e6QIXube+NkvVJTwGM8pBBJlCkbBEGkDiTqvFsvgdDDgNc9zv5BAuaSNwMOUGh0pWKO
 I2rCOz7YB6HFz+Eay8O8WxPRYiTTJLXLI1w9AgQk3aj40OcqRf4QHvr0xQFqv4wFb6rI
 TOfSIlKiD5IMcsn826W12AEgFxYC7t1S6hagMsuLc3yONTTeghjB3mcwbkGwBG5pMJoS
 7k2un9pq7aHd1JaQVdUK3FBH4bg1GKgTWvWZkKgDV0RXH8XNMKZTxP8yKaL8MfbYFBkR
 P+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694769274; x=1695374074;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=csH8uynrhAKRyNtySU3G0SLyp0u8KMtuWG9AGTXrGYE=;
 b=a4GEjLo3E3bNDiz4BLffHrUYSkSQlpAWy1gHGnxOQBjLH81kWNp1T2AND6YeHM1dKb
 oKc9LipfCHTDwOncRRY9/NjqB4Z4VOj3Atq+0u7i+Xa2nylnBiRGUnjECgm7LTNK8XQD
 pH+Rz8REgnQjz1rpKewmTTWsiyB+DjnABTl//9KwS89HHoUjxzteTT9wtz2GzjaKk7dq
 kznIiXHKErEU9Xy3AnMfbs+dL84CDEZe3oPm3bJoqqckh3YeEc3Iyd9Hq6vSsZG4/QZV
 QPFWjV0p0+O5BJmexiIltjDy9uF+PL6aYynSkWVVwyjWWYiGjkVYdnVSAFIicXiviaRH
 Fuzw==
X-Gm-Message-State: AOJu0YwqIfVt6TAY9hbExUoVh21MR0SLajKqMZZp41V0hoJW0FmHDI+N
 GVQo/NNHgCu/vlQHZNNZqnHjqw==
X-Google-Smtp-Source: AGHT+IGZ8EaVyfDw9TBqdJ0RB7ZP2Pmyqfw5bkWeQJt1slikn5Yy00nkOq7A/UCdrE0Ei0pkv+6ijQ==
X-Received: by 2002:a05:6402:703:b0:523:3889:542a with SMTP id
 w3-20020a056402070300b005233889542amr1023965edx.34.1694769273712; 
 Fri, 15 Sep 2023 02:14:33 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 v15-20020a056402348f00b005308a170845sm532918edc.29.2023.09.15.02.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:14:33 -0700 (PDT)
Message-ID: <30ac04ad-eb02-90ad-57ff-089538413602@linaro.org>
Date: Fri, 15 Sep 2023 11:14:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/9] tests: update Debian images to Bookworm
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Cc: Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-2-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914155422.426639-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/9/23 17:54, Alex Bennée wrote:
> Bookworm has been out a while now. Time to update our containers to
> the current stable. This requires the latest lcitool repo so update
> the sub-module too.
> 
> For some reason the MIPs containers won't build so skip those for now.

Debian removed mipsel:
https://lists.debian.org/debian-devel-announce/2023/09/msg00000.html
https://lists.debian.org/debian-release/2019/08/msg00582.html ...

> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .../dockerfiles/debian-amd64-cross.docker      | 10 +++-------
>   tests/docker/dockerfiles/debian-amd64.docker   | 10 +++-------
>   .../dockerfiles/debian-arm64-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-armel-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-armhf-cross.docker      | 10 +++-------
>   .../dockerfiles/debian-ppc64el-cross.docker    | 10 +++-------
>   .../dockerfiles/debian-s390x-cross.docker      | 10 +++-------
>   tests/docker/dockerfiles/ubuntu2004.docker     |  2 +-
>   tests/docker/dockerfiles/ubuntu2204.docker     |  2 +-
>   tests/lcitool/libvirt-ci                       |  2 +-
>   tests/lcitool/refresh                          | 18 +++++++++---------
>   11 files changed, 33 insertions(+), 61 deletions(-)


> @@ -133,24 +133,24 @@ try:
>       #
>       # Cross compiling builds
>       #
> -    generate_dockerfile("debian-amd64-cross", "debian-11",
> +    generate_dockerfile("debian-amd64-cross", "debian-12",
>                           cross="x86_64",
>                           trailer=cross_build("x86_64-linux-gnu-",
>                                               "x86_64-softmmu,"
>                                               "x86_64-linux-user,"
>                                               "i386-softmmu,i386-linux-user"))
>   
> -    generate_dockerfile("debian-arm64-cross", "debian-11",
> +    generate_dockerfile("debian-arm64-cross", "debian-12",
>                           cross="aarch64",
>                           trailer=cross_build("aarch64-linux-gnu-",
>                                               "aarch64-softmmu,aarch64-linux-user"))
>   
> -    generate_dockerfile("debian-armel-cross", "debian-11",
> +    generate_dockerfile("debian-armel-cross", "debian-12",
>                           cross="armv6l",
>                           trailer=cross_build("arm-linux-gnueabi-",
>                                               "arm-softmmu,arm-linux-user,armeb-linux-user"))
>   
> -    generate_dockerfile("debian-armhf-cross", "debian-11",
> +    generate_dockerfile("debian-armhf-cross", "debian-12",
>                           cross="armv7l",
>                           trailer=cross_build("arm-linux-gnueabihf-",
>                                               "arm-softmmu,arm-linux-user"))
> @@ -165,7 +165,7 @@ try:

... so we have to keep bullseye here:

>      generate_dockerfile("debian-mipsel-cross", "debian-11",
>                           trailer=cross_build("mipsel-linux-gnu-",
>                                               "mipsel-softmmu,mipsel-linux-user"))

but the mips64el should work:

     generate_dockerfile("debian-mips64el-cross", "debian-12",
                         cross="mips64el", ...

Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


