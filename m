Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A9830122
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ16T-0002To-Kz; Wed, 17 Jan 2024 03:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ16Q-0002Rm-5d
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:16:50 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ16N-0005Lj-WB
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:16:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so8339716f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705479406; x=1706084206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AlxsjJZYXggIMACrUuRwWMGKD8R5I9pjdYcJlM6rhkI=;
 b=rbQ5hIoxlNs1BpiqNzZEBjW7IYKMWORLBugdYzd7KexrkGZ2wLVB3EdlvgcZTPNV7m
 umvQ08gU2IGySN92J6i53vAQMKz4zi6HFymtR+xAoU407m1yV02isa9du5HDrZk4eWrw
 rhs7pY8fBMuxIxx5pZ0+1bDW3GWVQJLKozCF6hqVzG/Cw7JAVdNb0cncUeam49i+Axhj
 6hvSsOHm+kdKP/GT/hucID0zdOTYi/VdBl7QaOdUI06NfkE+NErmJzxq8LsSwTDYg3Mx
 Y/APjzhH0FAJIx6/CiJV4Pci6t+ZTZv1z6QoJ2gP0E41qMpay2SzetY42hPwuDGhnvld
 VjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705479406; x=1706084206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AlxsjJZYXggIMACrUuRwWMGKD8R5I9pjdYcJlM6rhkI=;
 b=sNc6gCojyQK+1lv6hZ9dpBCMLFf84PdEeit35FhftOw0ef0myMjFoCLxXR2K2luqYa
 iaUOq/HDyEfMNjloNy7lw+M1BDkIKGB0VqkJO+BTW3uuRldTyanf77Km5iCtNhFz6sIR
 Ef+uiSwMS6J5ObXAYpbK0tqX18vSZ17ts5XmxgEGyFpIfXYKrqMnli+jzH96ReJcCMqQ
 0/2aqzQDTXOGBahxmgIQDEWn4+ulHd2eX5TnpzdjpOxe3GWi+ZkvZ9yhOboCu7lg0dNB
 z2BiC5h+mOUvEMVIxRMqjuaEqNgMnmHSM9jFHyPT6/SvKr6tprr1uUJj2YsEG6ScNMab
 Fpcw==
X-Gm-Message-State: AOJu0YxjM/HN63P/1/YE813hflKJ0mEiHwWSWb6SB+lkZs08ACbeXN6e
 p10Iar2Nk1wyJrTiWDO1d9t2UKl/hfgrAQ==
X-Google-Smtp-Source: AGHT+IFAoS1zKS95JR6zJPyrK3UT3OnhzENG6QvNgkE5vo4L+lnkFNT4fqVexEyadpOGxQ1xRFD+dQ==
X-Received: by 2002:a5d:54c6:0:b0:337:6eac:2cad with SMTP id
 x6-20020a5d54c6000000b003376eac2cadmr5094394wrv.133.1705479406323; 
 Wed, 17 Jan 2024 00:16:46 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a5d51cd000000b0033673ddd81csm1033645wrv.112.2024.01.17.00.16.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:16:45 -0800 (PST)
Message-ID: <72b5b527-09aa-4f4c-8f0f-bbdba58a7400@linaro.org>
Date: Wed, 17 Jan 2024 09:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/docker: Add sqlite3 module to openSUSE Leap
 container
Content-Language: en-US
To: Andrea Bolognani <abologna@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240116230924.23053-1-farosas@suse.de>
 <45c847e8-01e9-42f0-a2a7-2061fc9e08e2@redhat.com>
 <CABJz62OD0ZZSY16sDNRiTuPEBygy9Y6rUgRrwoA6N_yg8cgGAQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABJz62OD0ZZSY16sDNRiTuPEBygy9Y6rUgRrwoA6N_yg8cgGAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 17/1/24 08:44, Andrea Bolognani wrote:
> On Wed, Jan 17, 2024 at 08:18:27AM +0100, Thomas Huth wrote:
>> On 17/01/2024 00.09, Fabiano Rosas wrote:
>>> Avocado needs sqlite3:
>>>
>>>     Failed to load plugin from module "avocado.plugins.journal":
>>>     ImportError("Module 'sqlite3' is not installed.
>>>     Use: sudo zypper install python311 to install it")
>>>
>>> Include the appropriate package in the dockerfile.
>>>
>>>   From 'zypper info python311':
>>>     "This package supplies rich command line features provided by
>>>     readline, and sqlite3 support for the interpreter core, thus forming
>>>     a so called "extended" runtime."
> 
> Weird choice on Python's part to have sqlite3 support as part of the
> standard library IMO, but that's "batteries included" for you :)
> 
>>> +++ b/tests/docker/dockerfiles/opensuse-leap.docker
>>> @@ -90,6 +90,7 @@ RUN zypper update -y && \
>>>               pcre-devel-static \
>>>               pipewire-devel \
>>>               pkgconfig \
>>> +           python311 \
>>>               python311-base \
>>>               python311-pip \
>>>               python311-setuptools \
>>
>> AFAIK tests/docker/dockerfiles/opensuse-leap.docker is auto-generated, so
>> this will be lost once somebody else runs lcitool again...
>>
>> I don't really have a clue, but I guess this has to be fixed in the upstream
>> lcitool first ( https://gitlab.com/libvirt/libvirt-ci ), and then we need to
>> update our lcitool status in QEMU afterwards. Maybe Daniel can advise for
>> the right stteps here...?
> 
> It looks like a bunch of mappings are maintained in
> tests/lcitool/mappings.yml instead of the main lcitool repository.

See commit 32c0613113 for mapping override use:

     ci, docker: update CentOS and OpenSUSE Python to non-EOL versions

     Python 3.6 is at end-of-life.  Update the libvirt-ci module to a
     version that supports overrides for targets and package mappings;
     this way, QEMU can use the newer versions provided by CentOS 8
     (Python 3.8) and OpenSUSE 15.3 (Python 3.9).

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 11c651ca08..362a26698b 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -479,6 +479,12 @@ first to contribute the mapping to the 
``libvirt-ci`` project:
     contains the ``mappings.yml`` update.  Then add the prerequisite and
     run ``make lcitool-refresh``.

+For enterprise distros that default to old, end-of-life versions of the
+Python runtime, QEMU uses a separate set of mappings that work with more
+recent versions.  These can be found in ``tests/lcitool/mappings.yml``.
+Modifying this file should not be necessary unless the new pre-requisite
+is a Python library or tool.

> So
> I think you need to apply the diff below, then run
> 
>    $ git submodule update --init tests/lcitool/libvirt-ci
>    $ tests/lcitool/refresh
> 
> to propagate the changes to the generated files.
> 
> 
> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
> index 0b908882f1..407c03301b 100644
> --- a/tests/lcitool/mappings.yml
> +++ b/tests/lcitool/mappings.yml
> @@ -59,6 +59,10 @@ mappings:
>       CentOSStream8:
>       OpenSUSELeap15:
> 
> +  python3-sqlite3:
> +    CentOSStream8: python38
> +    OpenSUSELeap15: python311
> +
>     python3-tomli:
>       # test using tomllib
>       apk:
> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
> index 82092c9f17..149b15de57 100644
> --- a/tests/lcitool/projects/qemu.yml
> +++ b/tests/lcitool/projects/qemu.yml
> @@ -97,6 +97,7 @@ packages:
>    - python3-pip
>    - python3-sphinx
>    - python3-sphinx-rtd-theme
> + - python3-sqlite3
>    - python3-tomli
>    - python3-venv
>    - rpm2cpio

LGTM.

