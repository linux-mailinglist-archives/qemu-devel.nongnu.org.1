Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7D579712F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeBD7-0004bg-Ht; Thu, 07 Sep 2023 05:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeBD5-0004bS-9A
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:21:59 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qeBD2-0006d4-KW
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:21:58 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2bcc187e0b5so13117001fa.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694078515; x=1694683315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qDdnfGVxt89P2WvaZzI62z4eY1CMn70/LegjBxuUt6I=;
 b=rU2G/1i09bXAOAViNFpYETaaeYOZwd5v3ozdLTQ9sWEaGSl1je6sHX5GWQ1X4PlGec
 o62I2lDaVclIbkbklOwRSuOx8TSPdtDlSZWDELG3NnHazwTroYPETz6+BMt/4nfmQKP7
 JKoQ3QjUj9/T1pNkFcWsFoEnjtlScO/pHOPGCpIgadxEuC1nqch6v0rGb21wCULI4H0M
 ZWqi8s71VvEFYPKGyzDwCmt9UfRzfJIGDr+94v+sluIU4O16GBt3YFXz5WRToY58PFsC
 GQFZgEE863RhOCF0Pl4emuEnBWSrqIq+kcQsNcRsEBOk2o6CLFWNCsQNn447mhhe82Uu
 sMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694078515; x=1694683315;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qDdnfGVxt89P2WvaZzI62z4eY1CMn70/LegjBxuUt6I=;
 b=L2nsrOsr4RhRrLBmrYQuPOCTyk1JnF1eRyjj7eK2cn35CfNn40RE5WA6K9oNLcxOSi
 tHYJBtCZegPfKFfDSW90SFWa9gLqQMcS21dTCZeV0BbPyKeLhfE659Rg1lYmLS5a1Qi2
 gDEz9P3AT8Uze0Q2DKS6HZWaL0E1oastpqNUIVqestJM+RJcdlbrYLMp5jPuuhhHZfVM
 13FxX51uy+VbaN6ItAgYRf9GYiGErLI+9XsmSwTM23ztFGAmVTsJCW0NsE6DPTOOrNpA
 ZY+N2NBLQU3U5I/Jjwb5FYwzV/sYZ9SteWVj+LZQbIFiTF1YxXRKIhdx9j6uvjjB04Ww
 xLnw==
X-Gm-Message-State: AOJu0YwYUoCQt7gQW7GMRDVniL6ykb6x8hWWCb5mL3PIK4YTnavaTEnc
 uwsD2Py+UDzSPJsbU+mKJM6pvA==
X-Google-Smtp-Source: AGHT+IEKRywQySR63dYZnogokcFeKHIt+iPhA+zTydojQisKoej3NFyogkCvy87po7u7MCeJcxPuzA==
X-Received: by 2002:a2e:95c3:0:b0:2bc:e51e:b007 with SMTP id
 y3-20020a2e95c3000000b002bce51eb007mr4209787ljh.41.1694078514840; 
 Thu, 07 Sep 2023 02:21:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1c7c03000000b003fefaf299b6sm1921888wmc.38.2023.09.07.02.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 02:21:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DFA481FFBB;
 Thu,  7 Sep 2023 10:21:52 +0100 (BST)
References: <20230829220228.928506-1-richard.henderson@linaro.org>
 <20230829220228.928506-21-richard.henderson@linaro.org>
 <87fs3uhtde.fsf@linaro.org>
 <34dc2a52-63aa-39a8-df56-88a381fa7671@linaro.org>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Subject: Re: [PATCH v5 20/20] linux-user/s390x: Add vdso
Date: Thu, 07 Sep 2023 10:20:46 +0100
In-reply-to: <34dc2a52-63aa-39a8-df56-88a381fa7671@linaro.org>
Message-ID: <871qfa2v9r.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 9/4/23 08:00, Alex Benn=C3=A9e wrote:
>> Due to the b4 dropping the vdso.so in the patch this fails:
>>    Program build-vdso.sh found: YES
>> (/home/alex/lsrc/qemu.git/linux-user/build-vdso.sh)
>>    ../../linux-user/s390x/meson.build:24:0: ERROR: File vdso.so does not=
 exist.
>>    A full log can be found at /home/alex/lsrc/qemu.git/builds/all/meson-=
logs/meson-log.txt
>>    FAILED: build.ninja
>>    /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson --internal regen=
erate /home/alex/lsrc/qemu.git /home/alex/lsrc/qemu.git/builds/all
>>    ninja: error: rebuilding 'build.ninja': subcommand failed
>>      BUILD   aarch64-softmmu guest-tests
>>    tests/tcg/aarch64-softmmu: -march=3Darmv8.3-a detected
>> which makes me think the dependencies are broken anyway because I
>> have a
>> working s390x compiler:
>>    =E2=9E=9C  cat tests/tcg/s390x-linux-user/config-target.mak
>>    # Automatically generated by configure - do not modify
>>    TARGET_NAME=3Ds390x
>>    TARGET=3Ds390x-linux-user
>>    EXTRA_CFLAGS=3D
>>    CC=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    CCAS=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /hom=
e/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-l=
inux-gnu-gcc -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    AR=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-ar -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    AS=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-as -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    LD=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-ld -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    NM=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /home/=
alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-lin=
ux-gnu-nm -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    OBJCOPY=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /=
home/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390=
x-linux-gnu-objcopy -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git =
--
>>    RANLIB=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /h=
ome/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x=
-linux-gnu-ranlib -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    STRIP=3D/home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/python3 -B /ho=
me/alex/lsrc/qemu.git/tests/docker/docker.py --engine docker cc --cc s390x-=
linux-gnu-strip -i qemu/debian-s390x-cross -s /home/alex/lsrc/qemu.git --
>>    BUILD_STATIC=3Dy
>>    QEMU=3D/home/alex/lsrc/qemu.git/builds/all/qemu-s390x
>>    HOST_GDB_SUPPORTS_ARCH=3Dy
>> We really need to express the dependency on
>> docker-image-debian-s390x-cross (when using containers) to ensure we can
>> build the vdso.so and not rely on the copy we have.
>
> I think expressing the dependency is a mistake.
>
> The major problem is network unreliability.  I installed a new vm to
> build test this, and it took more than a dozen retrys to get all of
> the docker images built.
>
> What we do right now is determine if docker or podman is present and
> works, and then *assume* we can make all of the cross-compilers work
> later, and so register them as cross-compilers early.

Fair enough. I'm all for making the normal case easy, but then how do we
express the explicit "please build the binary for me"?

>
> I think the only moderately reliable thing is to determine what
> containers are already present and working and use only those.
> Developers will need to manually rebuild containers periodically and
> then re-run configure to make those visible to the cross-build
> machinery.  Not completely ideal, of course, but nothing else is
> either.
>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

