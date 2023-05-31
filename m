Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF5717CAB
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IeN-0002VM-EV; Wed, 31 May 2023 06:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4IeL-0002VD-KX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4IeJ-0005c3-VT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685527307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QDNzIUQGvTS/1KsquaVDanLKDObgwQGqBXEO+C/EQ1k=;
 b=Gc4q4prNng/0zNzKhiENHXzNnxVShIXbWtQaS5dh6T8VsS1cOJOO4fqFX9n65YAA2ImVAZ
 RNMtgcNDuY5oveR4tdmfWePgT8DBYmt4ZHJJxG7PWvVpQBj+DSQVtOsdTuup5ys45vq7Mm
 17eKbtwFm48ldXTinH29tCwUFJx8JE8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-OTbCNri9OG-Apsc09g0JIw-1; Wed, 31 May 2023 06:01:45 -0400
X-MC-Unique: OTbCNri9OG-Apsc09g0JIw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5651d8acfe2so116846857b3.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 03:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685527305; x=1688119305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDNzIUQGvTS/1KsquaVDanLKDObgwQGqBXEO+C/EQ1k=;
 b=bVabmKHM9DjdQlmFtZedBgYxOnBW6Iwk7sJAceF5d8jkjpfDCrpBV2p0LzuxN92M1U
 ESLSpDHiVJPH2Zw52FzNEjwkAHCZLVd50hh1FjBopBgWqgvNJCjx4Ia6lIJcPHnyzGzt
 XfTOMFWA5QItk9CFeEgnBcjpUhRowz6NQPSnJ64TxgU9nOPSxogE2DGlf9CYn/RSmvVZ
 98PQ3yzg+cAzHv4nXBum+quwFo9CD3LynAaznf/yysArE//5jzLek0WQoz8Beg0dqg+0
 WnbTKMuMKBIYVtHpxk9n3M0lx3xIVKjkpDCVIsjLhq656wGWbVz3o/TcuqbmVpNXl6j+
 uDkQ==
X-Gm-Message-State: AC+VfDwXIneep1ZCSzDQGGwTZHW5EIMlqeqAlR/rhD4JNC2GLG5UcGaA
 AYfWSrtGzIEnG+NzCTS8ZTSKN9/861zcGftfBcTnbQ4L+FLRcNtu0yGQVBgE4hl8PCmzO8DmK9X
 nIaijbSrrIxdOfNcc8VFkOhg=
X-Received: by 2002:a25:7287:0:b0:b9e:e5b:14ab with SMTP id
 n129-20020a257287000000b00b9e0e5b14abmr5827186ybc.55.1685527305006; 
 Wed, 31 May 2023 03:01:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58sIPM2VD2OuYeQ+qRxTaOgUZG4I+IT/jTYi2J1NvXWfcAAqaR2vXUlfI+aooW8Ab+sXKFKw==
X-Received: by 2002:a25:7287:0:b0:b9e:e5b:14ab with SMTP id
 n129-20020a257287000000b00b9e0e5b14abmr5827174ybc.55.1685527304784; 
 Wed, 31 May 2023 03:01:44 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-178-4.web.vodafone.de. [109.43.178.4])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a25b08c000000b00ba6ffc7ef35sm4125094ybj.65.2023.05.31.03.01.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 03:01:44 -0700 (PDT)
Message-ID: <7a14dabc-41e1-1a57-c69c-67290482f7c6@redhat.com>
Date: Wed, 31 May 2023 12:01:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tests/vm/freebsd: Install more feature libraries in the
 FreeBSD VM
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230531090415.40421-1-thuth@redhat.com>
 <a1b5449d-b5cd-e443-daa3-04f46c2b7b96@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <a1b5449d-b5cd-e443-daa3-04f46c2b7b96@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 31/05/2023 11.52, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 31/5/23 11:04, Thomas Huth wrote:
>> The standalone freebsd VM image misses a lot of libraries compared
>> to the image that we use in the Gitlab-CI (see the file
>> .gitlab-ci.d/cirrus/freebsd-13.vars). Let's extend the list here
>> and while we're at it, re-arrange the list in alphabetical order
>> without the cumbersome grouping into categories.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/vm/freebsd | 76 +++++++++++++++++++++++++++++-------------------
>>   1 file changed, 46 insertions(+), 30 deletions(-)
>>
>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>> index 11de6473f4..8143637905 100755
>> --- a/tests/vm/freebsd
>> +++ b/tests/vm/freebsd
>> @@ -32,43 +32,59 @@ class FreeBSDVM(basevm.BaseVM):
>>       csum = 
>> "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
>>       size = "20G"
>>       pkgs = [
>> -        # build tools
>> -        "git",
>> -        "pkgconf",
>> -        "bzip2",
>> -        "python39",
>> -        "ninja",
>> -
>> -        # gnu tools
>> +        "alsa-lib",
>>           "bash",
>> -        "gmake",
>> -        "gsed",
>> +        "bison",
>> +        "bzip2",
>> +        "capstone4",
>> +        "curl",
>> +        "cyrus-sasl",
>> +        "dbus",
>> +        "diffutils",
>> +        "dtc",
>> +        "flex",
>> +        "fusefs-libs3",
>>           "gettext",
>> -
>> -        # libs: crypto
>> +        "git",
>> +        "glib",
>> +        "gmake",
>>           "gnutls",
>> -
>> -        # libs: images
>> -        "jpeg-turbo",
>> -        "png",
>> -
>> -        # libs: ui
>> -        "sdl2",
>> +        "gsed",
>>           "gtk3",
>> -        "libxkbcommon",
>> -
>> -        # libs: opengl
>>           "libepoxy",
>> -        "mesa-libs",
>> -
>> -        # libs: migration
>> -        "zstd",
>> -
>> -        # libs: networking
>> +        "libffi",
>> +        "libgcrypt",
>> +        "libjpeg-turbo",
>> +        "libnfs",
>>           "libslirp",
>> -
>> -        # libs: sndio
>> +        "libspice-server",
>> +        "libssh",
>> +        "libtasn1",
>> +        "libxkbcommon",
>> +        "lzo2",
>> +        "mesa-libs",
>> +        "meson",
>> +        "ncurses",
>> +        "nettle",
>> +        "ninja",
>> +        "pixman",
>> +        "pkgconf",
>> +        "png",
>> +        "py39-pip",
>> +        "py39-sphinx",
>> +        "py39-sphinx_rtd_theme",
>> +        "py39-yaml",
>> +        "python3",
>> +        "sdl2",
>> +        "sdl2_image",
>> +        "snappy",
>>           "sndio",
>> +        "spice-protocol",
>> +        "usbredir",
>> +        "virglrenderer",
>> +        "vte3",
>> +        "xorriso",
>> +        "zstd",
>>       ]
> 
> What about directly filling pkgs[] from 
> .gitlab-ci.d/cirrus/freebsd-13.vars's PKGS line? Quick & dirty example:
> 
>  >>> list(filter(lambda y: y.startswith('PKGS'), 
> open('.gitlab-ci.d/cirrus/freebsd-13.vars', 
> 'r').readlines()))[0].split("'")[1].split()
> ['alsa-lib', 'bash', 'bison', 'bzip2', 'ca_root_nss', 'capstone4', 'ccache', 
> 'cmocka', 'ctags', 'curl', 'cyrus-sasl', 'dbus', 'diffutils', 'dtc', 'flex', 
> 'fusefs-libs3', 'gettext', 'git', 'glib', 'gmake', 'gnutls', 'gsed', 'gtk3', 
> 'json-c', 'libepoxy', 'libffi', 'libgcrypt', 'libjpeg-turbo', 'libnfs', 
> 'libslirp', 'libspice-server', 'libssh', 'libtasn1', 'llvm', 'lzo2', 
> 'meson', 'mtools', 'ncurses', 'nettle', 'ninja', 'opencv', 'pixman', 
> 'pkgconf', 'png', 'py39-numpy', 'py39-pillow', 'py39-pip', 'py39-sphinx', 
> 'py39-sphinx_rtd_theme', 'py39-yaml', 'python3', 'rpm2cpio', 'sdl2', 
> 'sdl2_image', 'snappy', 'sndio', 'socat', 'spice-protocol', 'tesseract', 
> 'usbredir', 'virglrenderer', 'vte3', 'xorriso', 'zstd']

Sure, that's a good idea, too! Could you please send this as a proper patch?

  Thomas



