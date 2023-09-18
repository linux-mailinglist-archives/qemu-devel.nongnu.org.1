Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9147A4C04
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:24:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiG6i-00075O-Sh; Mon, 18 Sep 2023 11:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiG6c-00074V-Ng
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:24:10 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiG6V-0003Uj-S0
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:24:09 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3ff7d73a6feso52020985e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695050642; x=1695655442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mr94wfB2rFEoRKdG6qE9j+KNTqgDYMFbLDVBQkEpPZ4=;
 b=uvN6zY4IF2hvFiYVCLwvxDTt7uA9u52NEkiNaSjpsDMJraI3WasWa5P8wZCWeyQhGY
 tRD/O2FJLVtS9HGF4M7jEoThe5P52FQoggMKVmX4NMNBxMl/dxUJz4FIZTydjiyZAadU
 ennR0fCCca+m7Q32rm636231tiw3+6/vBdqHO+L0YDFvllz6EH6TgM0zEtl15yOQu/R6
 amPXH1rZ7y6NM0CoxmnJ4m+AgAEMZ6sH6nG57cDHOAI6uRp4jaJ4UmvH2HW/36YlSJsP
 LzOr0dW72ssrjBG9Vl71Qp38i34CJlAhfhv3rzyl4YcWRNupp2w7f/MPYfr7laBmrjE1
 TPGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695050642; x=1695655442;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mr94wfB2rFEoRKdG6qE9j+KNTqgDYMFbLDVBQkEpPZ4=;
 b=Pm8T3lNUxEXkl7NYDeHhS2rd729unZuDsDqI80+uzCRIXf31g4WEKk6m+zdk5EObSS
 +8qEWp95hA5JSfV5BT17pqDh19UO+oXaP7Nn/ZuHRVCKHOS2kLsAeeWDutGkOcUw5lpZ
 Esic3IKxIJBcqMhRqMcbl81/JjU4lID9Ehs9JpnMTitcJdw0I+wOcMmj31a5X9zC+JfW
 knQbURyXmk+QnrkltMmTbVy2EFOHLFW71had5mQvLsZLHKuyT/KA17MSxRxJz21OSGRG
 xUznQwroFQtDDatXG4LdD70ctLrbPfKMMYMdxHNxXoZgsCGNGoOXm72UHK/yutYe6YVP
 jUHQ==
X-Gm-Message-State: AOJu0YyY+QGCm6n+zLOX+u0zKf0hIm30kON3dK8VZ7fflkzkwN4QDvaw
 FA+D1BD/EHuynJ0OSUocJsva7g==
X-Google-Smtp-Source: AGHT+IGrX1Yq+lFwKmlLQAXOubEFHOYgdPqfIyNd4i4G4wecgCBF43CIrWOp4rZrfQPMbW8mgNCIQg==
X-Received: by 2002:a05:600c:114f:b0:402:f503:6d1b with SMTP id
 z15-20020a05600c114f00b00402f5036d1bmr8294499wmz.0.1695050641943; 
 Mon, 18 Sep 2023 08:24:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b0031c6581d55esm12979514wrp.91.2023.09.18.08.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:24:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 210D21FFBB;
 Mon, 18 Sep 2023 16:24:01 +0100 (BST)
References: <20230915150849.595896-1-alex.bennee@linaro.org>
 <CAJSP0QWjNgTjhWVNgRnyE5A7HLAH3xKjOD3N+C58-G1Ue-wwDw@mail.gmail.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] testing updates (back to green!)
Date: Mon, 18 Sep 2023 16:23:10 +0100
In-reply-to: <CAJSP0QWjNgTjhWVNgRnyE5A7HLAH3xKjOD3N+C58-G1Ue-wwDw@mail.gmail.com>
Message-ID: <87fs3bwlm6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Fri, 15 Sept 2023 at 11:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f3=
9e5:
>>
>>   Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/q=
emu-tpm into staging (2023-09-13 13:41:57 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-15092=
3-1
>>
>> for you to fetch changes up to 5acd4bf25dc9becd05b8772b94982722e1fa76a3:
>>
>>   tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (202=
3-09-15 15:17:52 +0100)
>>
>> ----------------------------------------------------------------
>> testing updates:
>>
>>   - update most Debian to bookworm
>
> This breaks the armel-debian-cross-container job:
> https://gitlab.com/qemu-project/qemu/-/jobs/5111108339
>
> I have dropped this pull request for now. Please take a look.

Hmm I think it might be a transient Debian issue as it passed when I run
the tag before sending:

  https://gitlab.com/stsquad/qemu/-/jobs/5100170183

I'll see if I can run it locally.

>
> Thanks,
> Stefan
>
>>   - fix some typos
>>   - update loongarch toolchain
>>   - fix microbit test
>>   - handle GitLab/Cirrus timeout discrepancy
>>   - improve avocado console handling
>>   - disable mips avocado images pending bugfix
>>
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (2):
>>       tests: update Debian images to Bookworm
>>       gitlab: fix typo/spelling in comments
>>
>> Daniel P. Berrang=C3=A9 (4):
>>       microbit: add missing qtest_quit() call
>>       qtest: kill orphaned qtest QEMU processes on FreeBSD
>>       gitlab: make Cirrus CI timeout explicit
>>       gitlab: make Cirrus CI jobs gating
>>
>> Nicholas Piggin (1):
>>       tests/avocado: Fix console data loss
>>
>> Philippe Mathieu-Daud=C3=A9 (1):
>>       tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884
>>
>> Richard Henderson (1):
>>       tests/docker: Update docker-loongarch-cross toolchain
>>
>>  tests/qtest/libqtest.c                                |  7 +++++++
>>  tests/qtest/microbit-test.c                           |  2 ++
>>  .gitlab-ci.d/base.yml                                 |  2 +-
>>  .gitlab-ci.d/cirrus.yml                               |  4 +++-
>>  .gitlab-ci.d/cirrus/build.yml                         |  2 ++
>>  python/qemu/machine/machine.py                        | 19 ++++++++++++=
+++++++
>>  tests/avocado/avocado_qemu/__init__.py                |  2 +-
>>  tests/avocado/boot_linux_console.py                   |  7 +++++++
>>  tests/avocado/machine_mips_malta.py                   |  6 ++++++
>>  tests/avocado/replay_kernel.py                        |  7 +++++++
>>  tests/avocado/tuxrun_baselines.py                     |  4 ++++
>>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 10 +++-------
>>  tests/docker/dockerfiles/debian-amd64.docker          | 10 +++-------
>>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 10 +++-------
>>  tests/docker/dockerfiles/debian-armel-cross.docker    | 10 +++-------
>>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
>>  .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
>>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
>>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
>>  tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
>>  tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
>>  tests/lcitool/libvirt-ci                              |  2 +-
>>  tests/lcitool/refresh                                 | 18 +++++++++---=
------
>>  23 files changed, 93 insertions(+), 65 deletions(-)
>>
>>
>> --
>> 2.39.2
>>
>>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

