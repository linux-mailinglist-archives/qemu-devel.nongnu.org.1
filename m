Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 556F8717C76
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:54:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IVM-00082b-3y; Wed, 31 May 2023 05:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4IVH-00080X-IT
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:52:27 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4IVF-0003ke-9A
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:52:27 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso4007632f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685526743; x=1688118743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=alYyHoDFqXTFqaUkXhwD4SS2OXrK6wO15AbJrZ0kvsY=;
 b=o1pC6nhCjwqkS/HJnoX54rQiwnczrxTtuxqPAAB9J67Z06VigHlhrGM9FgeBi0x6Ci
 txW927+aE6YP3Sngzi0O+UltxAEpOaEA61QYHq4CqFUwAieFE81IWbOoHwzGaIaz7Uze
 LYNnJPzKG6KfJ3BZGWrwzdZuBXOfWJOy6sKF+eT84+DFEFoEQaORDQsTSK332g1mupzB
 Dworq4FEZEj7mh76/PgxHQMPj2QDw1EoJKSY2qATT0sbIa5K79aR24dUlf9kAKhhGvEM
 BCUE6kVgUWz4xQMfI1DbDsxGyAlHa5soV1tW9DfED6XVd6nIxrKQgagMay3O1BZuELUc
 Y9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685526743; x=1688118743;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=alYyHoDFqXTFqaUkXhwD4SS2OXrK6wO15AbJrZ0kvsY=;
 b=b06orvpp2+38x8+v0zIXCVbDHC1BUmn19Firj4aXtmc6wqom5VVUVq8Uk0sEZoNiKH
 fikW0mxjIT4CFo8WlnupCxQdYgjUfER8IT0Lbn7OPEeVoTBHHktH0NWQyRR1AzdJ70ea
 GbZOJ2eEp0KGjKeNvYHayEhwXRwR300QPvz5O6c4UqzXmFaHVCCmFzl9HdAw3PaOhuLg
 JIiXAJB9PPjmTPxELUpxvana0AeoxnMh934FhbBB6Xu1TmmLNLWLd0kM5GxaEmhuMudH
 KEojO4+K/0lwMu6nkdzgWE9uOLLC46ekymk+2KrEiV40YLdN0O8ccbluHtIgFEbDWsJZ
 XDHQ==
X-Gm-Message-State: AC+VfDxijSGfPMk43r4PBwifx/L+LPnvjxcRn8VRxp4GBexPbLBrN5jn
 iu9qYYbXDd2WnjDdGzkXdZcs0A==
X-Google-Smtp-Source: ACHHUZ4q4BkQBcyJMIXRsLdQxstlHnYi6K7t+kpZwqqM0fWIbAQlaNzKR2QnfyDL6b2dTPbxS2bqgA==
X-Received: by 2002:a5d:4952:0:b0:2f5:ace2:8737 with SMTP id
 r18-20020a5d4952000000b002f5ace28737mr3800722wrs.32.1685526742856; 
 Wed, 31 May 2023 02:52:22 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 v11-20020adfedcb000000b0030ae87bd3e3sm6047365wro.18.2023.05.31.02.52.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 02:52:22 -0700 (PDT)
Message-ID: <a1b5449d-b5cd-e443-daa3-04f46c2b7b96@linaro.org>
Date: Wed, 31 May 2023 11:52:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] tests/vm/freebsd: Install more feature libraries in the
 FreeBSD VM
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20230531090415.40421-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531090415.40421-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Thomas,

On 31/5/23 11:04, Thomas Huth wrote:
> The standalone freebsd VM image misses a lot of libraries compared
> to the image that we use in the Gitlab-CI (see the file
> .gitlab-ci.d/cirrus/freebsd-13.vars). Let's extend the list here
> and while we're at it, re-arrange the list in alphabetical order
> without the cumbersome grouping into categories.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/vm/freebsd | 76 +++++++++++++++++++++++++++++-------------------
>   1 file changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
> index 11de6473f4..8143637905 100755
> --- a/tests/vm/freebsd
> +++ b/tests/vm/freebsd
> @@ -32,43 +32,59 @@ class FreeBSDVM(basevm.BaseVM):
>       csum = "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
>       size = "20G"
>       pkgs = [
> -        # build tools
> -        "git",
> -        "pkgconf",
> -        "bzip2",
> -        "python39",
> -        "ninja",
> -
> -        # gnu tools
> +        "alsa-lib",
>           "bash",
> -        "gmake",
> -        "gsed",
> +        "bison",
> +        "bzip2",
> +        "capstone4",
> +        "curl",
> +        "cyrus-sasl",
> +        "dbus",
> +        "diffutils",
> +        "dtc",
> +        "flex",
> +        "fusefs-libs3",
>           "gettext",
> -
> -        # libs: crypto
> +        "git",
> +        "glib",
> +        "gmake",
>           "gnutls",
> -
> -        # libs: images
> -        "jpeg-turbo",
> -        "png",
> -
> -        # libs: ui
> -        "sdl2",
> +        "gsed",
>           "gtk3",
> -        "libxkbcommon",
> -
> -        # libs: opengl
>           "libepoxy",
> -        "mesa-libs",
> -
> -        # libs: migration
> -        "zstd",
> -
> -        # libs: networking
> +        "libffi",
> +        "libgcrypt",
> +        "libjpeg-turbo",
> +        "libnfs",
>           "libslirp",
> -
> -        # libs: sndio
> +        "libspice-server",
> +        "libssh",
> +        "libtasn1",
> +        "libxkbcommon",
> +        "lzo2",
> +        "mesa-libs",
> +        "meson",
> +        "ncurses",
> +        "nettle",
> +        "ninja",
> +        "pixman",
> +        "pkgconf",
> +        "png",
> +        "py39-pip",
> +        "py39-sphinx",
> +        "py39-sphinx_rtd_theme",
> +        "py39-yaml",
> +        "python3",
> +        "sdl2",
> +        "sdl2_image",
> +        "snappy",
>           "sndio",
> +        "spice-protocol",
> +        "usbredir",
> +        "virglrenderer",
> +        "vte3",
> +        "xorriso",
> +        "zstd",
>       ]

What about directly filling pkgs[] from 
.gitlab-ci.d/cirrus/freebsd-13.vars's PKGS line? Quick & dirty example:

 >>> list(filter(lambda y: y.startswith('PKGS'), 
open('.gitlab-ci.d/cirrus/freebsd-13.vars', 
'r').readlines()))[0].split("'")[1].split()
['alsa-lib', 'bash', 'bison', 'bzip2', 'ca_root_nss', 'capstone4', 
'ccache', 'cmocka', 'ctags', 'curl', 'cyrus-sasl', 'dbus', 'diffutils', 
'dtc', 'flex', 'fusefs-libs3', 'gettext', 'git', 'glib', 'gmake', 
'gnutls', 'gsed', 'gtk3', 'json-c', 'libepoxy', 'libffi', 'libgcrypt', 
'libjpeg-turbo', 'libnfs', 'libslirp', 'libspice-server', 'libssh', 
'libtasn1', 'llvm', 'lzo2', 'meson', 'mtools', 'ncurses', 'nettle', 
'ninja', 'opencv', 'pixman', 'pkgconf', 'png', 'py39-numpy', 
'py39-pillow', 'py39-pip', 'py39-sphinx', 'py39-sphinx_rtd_theme', 
'py39-yaml', 'python3', 'rpm2cpio', 'sdl2', 'sdl2_image', 'snappy', 
'sndio', 'socat', 'spice-protocol', 'tesseract', 'usbredir', 
'virglrenderer', 'vte3', 'xorriso', 'zstd']

