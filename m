Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147D794291
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 19:57:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdwlO-00081u-VA; Wed, 06 Sep 2023 13:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdwlK-00081J-4Z
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:56:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdwlG-0002SM-Ll
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 13:56:21 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so369745ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 10:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694022976; x=1694627776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=is96DW8xqvs5Fys7lCZRQgZ9HF8he85qd79QL1ZFc40=;
 b=uQHh934IszevuGLf0MN3lOV/MyAIJ3lIQ/pl0Qyso6EvJut3xI40TNM5mz8XjpepRZ
 R/xRMLG1aOuHLvHRD2MFj/YLbHOWWz3ADyNlyATnCzp0NMnBO5oFSBnlTYYdOkELGvPO
 YXPKOJAjio6cPm3Dqq+0AlKEG7j7Z+ETH67WMlqS+hRO7vJUmXVIGaOC8tNnONTk8yue
 RQZX5tFtu2Gw3S2g1KAKrkbcVX3KUWQH7p8qkV8aqzVlf+3ei8HuFZxxZkN8h/pgYBes
 hYfsPWZ5OeEaY4SM9nTopjzBZErRRJ1kUv70paiLiLmdla/zfnXBR7hwkuMCdE5C6CQh
 MNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694022976; x=1694627776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=is96DW8xqvs5Fys7lCZRQgZ9HF8he85qd79QL1ZFc40=;
 b=jMSsSPpjnO8hva6vhOIC4BDjPfhlykMtK1JnDYfaohZCE7Q+OXTbzLfjw2FXB8fQ1D
 /fnPYoNtsUNB3MBfklpxk3ooTkUFIrVar6TBKUvb4Yj7vHKAraDok9RW5cY3AvJbvWUs
 OVcfgCp7r59HvhwsOmmOkR/YMVyJTJfKZDTH7MXVXjnOLhaXwuVHzQ4geaelj3+n2IKY
 yIxyD+nhjUbKzqfjppa631eZtJGGkO4gpKawEAK7JGKlqx8t7KEXTAISoBBN/NRsIeXO
 6vXJ1SBCLT5SdAk+ATLSZTWdtzEvL+S6j+LFViGyghwTYvOYJX7Epb0pdwPQQCK5p2Ad
 2E3Q==
X-Gm-Message-State: AOJu0YyrHqZQz67rSVdQ8/mLoE6TuGKVNvRj/z8mP7n2oma6j0fojTrw
 sykq9PHZ0Vei+vOy00LBGouWBA==
X-Google-Smtp-Source: AGHT+IEpCHJdoXyOPjPjsCFC6KkeUTKhGJBvciusI2AuSbhWrBjPCc7QvFPa4c5NMicFgEleUWXs1A==
X-Received: by 2002:a17:903:2289:b0:1b2:676d:1143 with SMTP id
 b9-20020a170903228900b001b2676d1143mr459861plh.15.1694022976147; 
 Wed, 06 Sep 2023 10:56:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ja19-20020a170902efd300b001b9c960ffeasm11369900plb.47.2023.09.06.10.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 10:56:15 -0700 (PDT)
Message-ID: <34dc2a52-63aa-39a8-df56-88a381fa7671@linaro.org>
Date: Wed, 6 Sep 2023 10:56:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 20/20] linux-user/s390x: Add vdso
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-21-richard.henderson@linaro.org>
 <87fs3uhtde.fsf@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87fs3uhtde.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/4/23 08:00, Alex Bennée wrote:
> Due to the b4 dropping the vdso.so in the patch this fails:
> 
>    Program build-vdso.sh found: YES (/home/alex/lsrc/qemu.git/linux-user/build-vdso.sh)
>    ../../linux-user/s390x/meson.build:24:0: ERROR: File vdso.so does not exist.
>    A full log can be found at /home/alex/lsrc/qemu.git/builds/all/meson-logs/meson-log.txt
>    FAILED: build.ninja
>    /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal regenerate /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/all
>    ninja: error: rebuilding 'build.ninja': subcommand failed
>      BUILD   aarch64-softmmu guest-tests
>    tests/tcg/aarch64-softmmu: -march=armv8.3-a detected
> 
> which makes me think the dependencies are broken anyway because I have a
> working s390x compiler:
> 
>    ➜  cat tests/tcg/s390x-linux-user/config-target.mak
>    # Automatically generated by configure - do not modify
>    TARGET_NAME=s390x
>    TARGET=s390x-linux-user
>    EXTRA_CFLAGS=
>    CC=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    CCAS=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    AR=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-ar -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    AS=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-as -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    LD=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-ld -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    NM=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-nm -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    OBJCOPY=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-objcopy -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    RANLIB=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-ranlib -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    STRIP=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-linux-gnu-strip -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>    BUILD_STATIC=y
>    QEMU=/home/alex/lsrc/qemu.git/builds/all/qemu-s390x
>    HOST_GDB_SUPPORTS_ARCH=y
> 
> We really need to express the dependency on
> docker-image-debian-s390x-cross (when using containers) to ensure we can
> build the vdso.so and not rely on the copy we have.

I think expressing the dependency is a mistake.

The major problem is network unreliability.  I installed a new vm to build test this, and 
it took more than a dozen retrys to get all of the docker images built.

What we do right now is determine if docker or podman is present and works, and then 
*assume* we can make all of the cross-compilers work later, and so register them as 
cross-compilers early.

I think the only moderately reliable thing is to determine what containers are already 
present and working and use only those.  Developers will need to manually rebuild 
containers periodically and then re-run configure to make those visible to the cross-build 
machinery.  Not completely ideal, of course, but nothing else is either.


r~

