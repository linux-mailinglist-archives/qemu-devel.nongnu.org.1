Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9D379703F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 08:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe8Ki-0001Pt-21; Thu, 07 Sep 2023 02:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8Ke-0001Oo-1v
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:17:36 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qe8Kb-0001Vx-2s
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 02:17:35 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c136ee106so61233366b.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694067451; x=1694672251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1C70gQfSsVGoX2XgvwL5KX1FaAG8rb1sIp4E1ENd194=;
 b=fKOs5JHI2u2k+WvNQbaf0qh/vGHOGdkmLNycEUW7e3/Ym9bsnjuAYdUSEORW7qS2tg
 pCTlK4Y4gvyxHfs00AZEULV+bAmkXg0mQc2gPvwPjr5LpDFfIfJ1RJ3se0B6drIBnSd+
 u9ZOlLtOciVcPgWVcIaQ+QftjtfWoKzH13fsAKkSVv2MlTM0rKH4NnTvpOA00b/K0kEw
 J863uxanm/F/X8rS9jlDkkH2CQGJzOn0+cvRfQjPtza18/8ekzxziAV2T7gpyfJ3ExCg
 Ld9xa2PHlY+HebpU9L7je3qCxtqV9BGUtDHFphXBVEgtazwW60rfDd4v2vJSoxBtpa/H
 ZFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694067451; x=1694672251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1C70gQfSsVGoX2XgvwL5KX1FaAG8rb1sIp4E1ENd194=;
 b=fIpqqQdoLEAf3jeHFXjtpdLIMNIh5+THdCx6BYU3w84tLt2JGoZa9d2ABJK4FTptu2
 4YFrjpMNw2W4CnzQuFloS3IDqZLS84nShHYmJ1LYbw1MM811Y8yAZfseGsTntq3YUpxG
 JRC1bwYnBMD73T5C60IgXRbTr/LUqhaz1GbW61cLqSD/GwP+hyhsJNq9oSIrRWN0wITB
 3WGjUj3iV75495wyB0ij4BiuinAsol8In4YllTkGhGmCkpNsxdegLasJmtdOP/h9NfUg
 vf2rkdtq6tu3VZDNjTMtBnZi0NKMkVtJBFQgfXCDtbTnfvR+JdxnAjxz1gwmIEDGtbdt
 YxzQ==
X-Gm-Message-State: AOJu0YxG11VkWaIjnjmLubimM4l8pOOk3Sp/aKxf59D7r2GGwQIC7QLA
 8qfVL73VAMwyqyEByiHEq/OMRQ==
X-Google-Smtp-Source: AGHT+IFL6WWCP8aoOlFaEaEpsxDiWXIN4XKGbJn3nqq8CATZO3h1BSi0ANc8iTl43x0C8eYefLuFYg==
X-Received: by 2002:a17:906:51c9:b0:99c:ae35:8cc with SMTP id
 v9-20020a17090651c900b0099cae3508ccmr4149342ejk.26.1694067450978; 
 Wed, 06 Sep 2023 23:17:30 -0700 (PDT)
Received: from [192.168.69.115] (176-131-222-226.abo.bbox.fr.
 [176.131.222.226]) by smtp.gmail.com with ESMTPSA id
 jo26-20020a170906f6da00b00982d0563b11sm9868406ejb.197.2023.09.06.23.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 23:17:30 -0700 (PDT)
Message-ID: <b0cc966c-44a6-6595-d7b3-a63e8c191942@linaro.org>
Date: Thu, 7 Sep 2023 08:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v5 20/20] linux-user/s390x: Add vdso
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-21-richard.henderson@linaro.org>
 <87fs3uhtde.fsf@linaro.org> <34dc2a52-63aa-39a8-df56-88a381fa7671@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <34dc2a52-63aa-39a8-df56-88a381fa7671@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 6/9/23 19:56, Richard Henderson wrote:
> On 9/4/23 08:00, Alex Bennée wrote:
>> Due to the b4 dropping the vdso.so in the patch this fails:
>>
>>    Program build-vdso.sh found: YES 
>> (/home/alex/lsrc/qemu.git/linux-user/build-vdso.sh)
>>    ../../linux-user/s390x/meson.build:24:0: ERROR: File vdso.so does 
>> not exist.
>>    A full log can be found at 
>> /home/alex/lsrc/qemu.git/builds/all/meson-logs/meson-log.txt
>>    FAILED: build.ninja
>>    /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal 
>> regenerate /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/all
>>    ninja: error: rebuilding 'build.ninja': subcommand failed
>>      BUILD   aarch64-softmmu guest-tests
>>    tests/tcg/aarch64-softmmu: -march=armv8.3-a detected
>>
>> which makes me think the dependencies are broken anyway because I have a
>> working s390x compiler:
>>
>>    ➜  cat tests/tcg/s390x-linux-user/config-target.mak
>>    # Automatically generated by configure - do not modify
>>    TARGET_NAME=s390x
>>    TARGET=s390x-linux-user
>>    EXTRA_CFLAGS=
>>    CC=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-gcc -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    CCAS=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-gcc -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    AR=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-ar -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    AS=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-as -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    LD=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-ld -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    NM=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-nm -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    OBJCOPY=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-objcopy -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    RANLIB=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-ranlib -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    STRIP=/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B 
>> /home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc 
>> --cc s390x-linux-gnu-strip -i qemu/debian-s390x-cross -s 
>> /home/alex/lsrc/qemu.git --
>>    BUILD_STATIC=y
>>    QEMU=/home/alex/lsrc/qemu.git/builds/all/qemu-s390x
>>    HOST_GDB_SUPPORTS_ARCH=y
>>
>> We really need to express the dependency on
>> docker-image-debian-s390x-cross (when using containers) to ensure we can
>> build the vdso.so and not rely on the copy we have.
> 
> I think expressing the dependency is a mistake.
> 
> The major problem is network unreliability.  I installed a new vm to 
> build test this, and it took more than a dozen retrys to get all of the 
> docker images built.
> 
> What we do right now is determine if docker or podman is present and 
> works, and then *assume* we can make all of the cross-compilers work 
> later, and so register them as cross-compilers early.
> 
> I think the only moderately reliable thing is to determine what 
> containers are already present and working and use only those.  
> Developers will need to manually rebuild containers periodically and 
> then re-run configure to make those visible to the cross-build 
> machinery.  Not completely ideal, of course, but nothing else is either.

We discussed this 1 or 2 years ago. My suggestion was when we tag
a release, we also tag the gitlab docker images (with all the distro
packages installed from that tag). Then those working with the release
can pull the pre-installed image from the tag; since it won't need
newer package, no need for network access within the image.

During the latest development cycle, we can either use the latest
tagged image if sufficient, or we have to deal with the same issues
you mentioned (network stability, broken package deps from time to
time).

