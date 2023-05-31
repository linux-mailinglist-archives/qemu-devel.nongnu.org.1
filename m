Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6771D718AD7
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:10:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4S9I-0008E0-Ln; Wed, 31 May 2023 16:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S9G-0007zn-2S
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:10:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4S9E-0007EE-1U
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:10:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30789a4c537so43816f8f.0
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685563818; x=1688155818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NVlwiIMqz6zrojTfDPG2ofFyo4j9g9KfAnS3FzRPDA8=;
 b=pnLawzJLrqABNC5Ls2Uy6RdQFjjBeZHxezo91ADYF0wkzE/Krk2HPOMn0w0epqyGqy
 WhxxdZZNOBzufa1IPjRTuV/pwXQJz02zfO1OswreJImYOlnVncOvm8yS4E3EqzIzTXg6
 Iyd3xzttojqKleFU+cpGL5fLzJ5Jaq47iTunQzgxAfqIEf/ARi1TOaGCN654reXZjUw6
 KMyempWXI+u0jerc1eds2avsBIpYrhHDRe8VmkjaqD7/RmU6rk2aLdBBGvsdHRPk2h9Q
 AO+qO1VGcm23mIGoG4EDxeaUOxdnuyajIr1kojTLu6qN79E/BWCfsxlJXOKfQQxMIdvF
 C5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685563818; x=1688155818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NVlwiIMqz6zrojTfDPG2ofFyo4j9g9KfAnS3FzRPDA8=;
 b=Fk1QhzcOI5IirgaZYTV+WPTqBRL+YCqcoXbTRDx4KMymzyWaKysVzKztIDa3oN8HuN
 D0TSRNsoK+ujTHWAPtG1WNMK/lfmyS10cV84t7aC6cnIFO7E/B8k2w0RfZMRNggydZZF
 ECqcZAPt4SLN3sSfQO8Y1i783hrTm4xk+qwIY2IAn/PLBAVN8qbRX9F32FcDjkI6cxGi
 W93FcRZ8KZsw70TlCsjVoixXRFKbMc/R1GX/UIOruGocpHNyiPhudiEi+1EGmOJx989/
 rJWBF2eFX58sjo0LJ8I/zOHTQIwDMMJGQJFyiddJ0ZVErGUbASkMMPtiywtTZd3cX0Uy
 9HMw==
X-Gm-Message-State: AC+VfDxvJvRiNo+NUCV1kc8HU0D2Nu3c2yAH2FFtuL6Xx7XCxnjXtYOh
 TbkDMjgCDdEJ/qnWeftfDfhnuA==
X-Google-Smtp-Source: ACHHUZ5iWqUOogHWH/UPwbSJMhFkWasLY4FQYitu401awa26mzZcC0aAiOzCm3bkkQFr+5XtZCJysQ==
X-Received: by 2002:adf:e5c8:0:b0:30a:e9cb:1a2e with SMTP id
 a8-20020adfe5c8000000b0030ae9cb1a2emr101482wrn.65.1685563818411; 
 Wed, 31 May 2023 13:10:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5302000000b003047ae72b14sm7821817wrv.82.2023.05.31.13.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 13:10:18 -0700 (PDT)
Message-ID: <eea545f4-dcf7-388b-d93e-b81ed9d79c30@linaro.org>
Date: Wed, 31 May 2023 22:10:15 +0200
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
 <a1b5449d-b5cd-e443-daa3-04f46c2b7b96@linaro.org>
 <7a14dabc-41e1-1a57-c69c-67290482f7c6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <7a14dabc-41e1-1a57-c69c-67290482f7c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 31/5/23 12:01, Thomas Huth wrote:
> On 31/05/2023 11.52, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 31/5/23 11:04, Thomas Huth wrote:
>>> The standalone freebsd VM image misses a lot of libraries compared
>>> to the image that we use in the Gitlab-CI (see the file
>>> .gitlab-ci.d/cirrus/freebsd-13.vars). Let's extend the list here
>>> and while we're at it, re-arrange the list in alphabetical order
>>> without the cumbersome grouping into categories.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/vm/freebsd | 76 +++++++++++++++++++++++++++++-------------------
>>>   1 file changed, 46 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/tests/vm/freebsd b/tests/vm/freebsd
>>> index 11de6473f4..8143637905 100755
>>> --- a/tests/vm/freebsd
>>> +++ b/tests/vm/freebsd
>>> @@ -32,43 +32,59 @@ class FreeBSDVM(basevm.BaseVM):
>>>       csum = 
>>> "a4fb3b6c7b75dd4d58fb0d75e4caf72844bffe0ca00e66459c028b198ffb3c0e"
>>>       size = "20G"
>>>       pkgs = [
>>> -        # build tools
>>> -        "git",
>>> -        "pkgconf",
>>> -        "bzip2",
>>> -        "python39",
>>> -        "ninja",
>>> -
>>> -        # gnu tools
>>> +        "alsa-lib",
>>>           "bash",
>>> -        "gmake",
>>> -        "gsed",
>>> +        "bison",
>>> +        "bzip2",
>>> +        "capstone4",
>>> +        "curl",
>>> +        "cyrus-sasl",
>>> +        "dbus",
>>> +        "diffutils",
>>> +        "dtc",
>>> +        "flex",
>>> +        "fusefs-libs3",
>>>           "gettext",
>>> -
>>> -        # libs: crypto
>>> +        "git",
>>> +        "glib",
>>> +        "gmake",
>>>           "gnutls",
>>> -
>>> -        # libs: images
>>> -        "jpeg-turbo",
>>> -        "png",
>>> -
>>> -        # libs: ui
>>> -        "sdl2",
>>> +        "gsed",
>>>           "gtk3",
>>> -        "libxkbcommon",
>>> -
>>> -        # libs: opengl
>>>           "libepoxy",
>>> -        "mesa-libs",
>>> -
>>> -        # libs: migration
>>> -        "zstd",
>>> -
>>> -        # libs: networking
>>> +        "libffi",
>>> +        "libgcrypt",
>>> +        "libjpeg-turbo",
>>> +        "libnfs",
>>>           "libslirp",
>>> -
>>> -        # libs: sndio
>>> +        "libspice-server",
>>> +        "libssh",
>>> +        "libtasn1",
>>> +        "libxkbcommon",
>>> +        "lzo2",
>>> +        "mesa-libs",
>>> +        "meson",
>>> +        "ncurses",
>>> +        "nettle",
>>> +        "ninja",
>>> +        "pixman",
>>> +        "pkgconf",
>>> +        "png",
>>> +        "py39-pip",
>>> +        "py39-sphinx",
>>> +        "py39-sphinx_rtd_theme",
>>> +        "py39-yaml",
>>> +        "python3",
>>> +        "sdl2",
>>> +        "sdl2_image",
>>> +        "snappy",
>>>           "sndio",
>>> +        "spice-protocol",
>>> +        "usbredir",
>>> +        "virglrenderer",
>>> +        "vte3",
>>> +        "xorriso",
>>> +        "zstd",
>>>       ]
>>
>> What about directly filling pkgs[] from 
>> .gitlab-ci.d/cirrus/freebsd-13.vars's PKGS line? Quick & dirty example:
>>
>>  >>> list(filter(lambda y: y.startswith('PKGS'), 
>> open('.gitlab-ci.d/cirrus/freebsd-13.vars', 
>> 'r').readlines()))[0].split("'")[1].split()
>> ['alsa-lib', 'bash', 'bison', 'bzip2', 'ca_root_nss', 'capstone4', 
>> 'ccache', 'cmocka', 'ctags', 'curl', 'cyrus-sasl', 'dbus', 
>> 'diffutils', 'dtc', 'flex', 'fusefs-libs3', 'gettext', 'git', 'glib', 
>> 'gmake', 'gnutls', 'gsed', 'gtk3', 'json-c', 'libepoxy', 'libffi', 
>> 'libgcrypt', 'libjpeg-turbo', 'libnfs', 'libslirp', 'libspice-server', 
>> 'libssh', 'libtasn1', 'llvm', 'lzo2', 'meson', 'mtools', 'ncurses', 
>> 'nettle', 'ninja', 'opencv', 'pixman', 'pkgconf', 'png', 'py39-numpy', 
>> 'py39-pillow', 'py39-pip', 'py39-sphinx', 'py39-sphinx_rtd_theme', 
>> 'py39-yaml', 'python3', 'rpm2cpio', 'sdl2', 'sdl2_image', 'snappy', 
>> 'sndio', 'socat', 'spice-protocol', 'tesseract', 'usbredir', 
>> 'virglrenderer', 'vte3', 'xorriso', 'zstd']
> 
> Sure, that's a good idea, too! Could you please send this as a proper 
> patch?

Sent, see 
https://lore.kernel.org/qemu-devel/20230531200906.17790-1-philmd@linaro.org/

