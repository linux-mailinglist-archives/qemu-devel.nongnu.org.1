Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D71C78D790
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 18:20:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNvb-0005jx-NO; Wed, 30 Aug 2023 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNvZ-0005j9-LT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:20:21 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbNvX-0005OL-03
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 12:20:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso35470585ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693412417; x=1694017217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UjLsk6gqNV1/48HplNgS+r2vtKikXz8vwkFTyORY1tU=;
 b=i082SPa0me5LvXWxItiHv6vaBMDFgw5Xtk1IcCNWnvQVOVT71mLVQPDI+qSvREyXDM
 7KQX8LmOLouZTFeHQelX4hNnm+Tf/zBTHUpk3shh7S5qtq4dmUkzoJvQFd0lvG1VgwFC
 hGW4hxwzAUVfwwCQ9TfjruSfRuESvOMKJTNdIWO/k+4Hvzl4QAt7UyEVJItYsf13QHCL
 m6uobV0CMzRwSRZEGw8zTQcuHdHtyxttz7YKzOewWWUXiTGGt8Yn72PSlGv7JGI1GRY3
 IiaTbKVLtjulbelyvXFlyUUHT4qSy5nxWIqXnq0NvX33ktrdpYPwGFNVoUsj5jJt66BM
 tanQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693412417; x=1694017217;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UjLsk6gqNV1/48HplNgS+r2vtKikXz8vwkFTyORY1tU=;
 b=hAGCmngwO0dEkJdxgWQaS+EwDi8DVQrgrVUudLoZT+j1CbNPXh/WQ3438PxZCcOgZG
 7sL7R3E4LZagZSddYysA/4KlAAodRwI5seNXw5BCZebxyD83JHqcsHRJcycZ11aq2GZs
 ncahuOhEm9OPO9qwoK/1j1KFNjAfc4VOuIbK8JUi5/SHxx/5SzEc5aYiX4vsUO6Ih5ny
 bdlhIXVe069hmLTxjrDAQxUbDj5AQTdfg56Y8J8KSwk+ek8UWdIiBbpJxvOLTAZuVxj6
 DRky9DZJ+Fb+1fBVnEjDGvGVOTebTJgKVQW1E2ArGOeij1zt/E6z/v70TN4Fmzq9T70b
 EqQg==
X-Gm-Message-State: AOJu0YwicRsqVfgE9s6tmw37qVa5Q91su+x2rzPWoy0ha/8Cf3ToysPZ
 iUtjgKRE/h30F8eay/Kgd4cWgV1qMjnGzyhKL1I=
X-Google-Smtp-Source: AGHT+IGJFgfSv/IuUEHRew6VPjhcWsxmLno7QIdVmmh5VvB+t8/4S4okSvISb8ZxUFGU7xRYKcj4sg==
X-Received: by 2002:a17:902:f550:b0:1b9:e591:db38 with SMTP id
 h16-20020a170902f55000b001b9e591db38mr2706708plf.8.1693412417395; 
 Wed, 30 Aug 2023 09:20:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a170902b58b00b001bc9bfaba3esm11320987pls.126.2023.08.30.09.20.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 09:20:16 -0700 (PDT)
Message-ID: <efc935f7-67c2-8877-98aa-1aebfcafa534@linaro.org>
Date: Wed, 30 Aug 2023 09:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 00/20] linux-user: Implement VDSOs
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <31a0da15-2d40-6779-091a-fc19207399bc@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 8/30/23 07:52, Helge Deller wrote:
> On 8/30/23 00:02, Richard Henderson wrote:
>> Changes for v5:
>>    * Integrated cross-compile, via new build-vdso.sh and meson rules.
>>      However, keep the binaries in the tree for hosts which do not
>>      have all of the cross-compile machinery.
>>    * Update our loongarch64 docker image to avoid a binutils bug.
>>
>> Just in case the list eats a binary:
>>    https://gitlab.com/rth7680/qemu/-/tree/lu-vdso
> 
> I pulled that on top of git head, and ran into the build problem below.
> Do I miss something?

No idea, since it worked for me.  Looks like some sort of docker.py problem.  Alex?

In the short term, use --disable-containers so that you only use the cross-compilers that 
you have locally installed.


r~

> 
> Helge
> 
> [62/1742] Generating linux-user/aarch64/vdso-be.so with a custom command
> FAILED: linux-user/aarch64/vdso-be.so
> /home/cvs/qemu/qemu/linux-user/build-vdso.sh -B /srv/_build -C 
> /home/cvs/qemu/qemu/linux-user/aarch64 -T aarch64-linux-user -o 
> linux-user/aarch64/vdso-be.so -- -nostdlib -shared -Wl,-h,linux-vdso.so.1 
> -Wl,--build-id=sha1 -Wl,--hash-style=both 
> -Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.ld 
> ../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S -mbig-endian
> Error: short-name resolution enforced but cannot prompt without a TTY
> Traceback (most recent call last):
>    File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 683, in <module>
>      sys.exit(main())
>               ^^^^^^
>    File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 679, in main
>      return args.cmdobj.run(args, argv)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 657, in run
>      return Docker().run(cmd, False, quiet=args.quiet,
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 370, in run
>      ret = self._do_check(["run", "--rm", "--label",
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/home/cvs/qemu/qemu/tests/docker/docker.py", line 247, in _do_check
>      return subprocess.check_call(self._command + cmd, **kwargs)
>             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>    File "/usr/lib64/python3.11/subprocess.py", line 413, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--label', 
> 'com.qemu.instance.uuid=e746f7e345ed420088a9cc30e884a7e8', '--userns=keep-id', '-u', 
> '1000', '-w', '/srv/_build', '-v', '/srv/_build:/srv/_build:rw', '-v', 
> '/home/cvs/qemu/qemu:/home/cvs/qemu/qemu:ro,z', 'qemu/debian-arm64-cross', 
> 'aarch64-linux-gnu-gcc-10', '-o', 'linux-user/aarch64/vdso-be.so', '-nostdlib', '-shared', 
> '-Wl,-h,linux-vdso.so.1', '-Wl,--build-id=sha1', '-Wl,--hash-style=both', 
> '-Wl,-T,../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.ld', 
> '../../home/cvs/qemu/qemu/linux-user/aarch64/vdso.S', '-mbig-endian']' returned non-zero 
> exit status 125.
> filter=--filter=label=com.qemu.instance.uuid=e746f7e345ed420088a9cc30e884a7e8
> 


