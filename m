Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4277A6884
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:02:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qid9x-0002H1-25; Tue, 19 Sep 2023 12:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qid9j-0002BM-IY
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:00:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qid9g-0001nT-Mg
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:00:55 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso62144225e9.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695139250; x=1695744050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FUgl8qbgPkE0Y3xcruXztkrW8DQ+8tu5AZMIltrCMTc=;
 b=WTBm5yIKEQF9J+5X94w4TiD/lIEAbwhtjPCpkbzx63UO3sXKJipHNi/8+njD3eVbSK
 6R3Rcq+TsTlumqmtBVTCH3iME6pXUaMKInnUNNX5KwMrcsAr3vDzSbW85CEoHqoJjRrm
 XA5Rpy5DKp1xDI+ebLv2lTPDNhhrgzepgG1+cGweKFY+XwEHkHPyPI/oevXgNp4U+e5f
 Uobj1PPKYDaajDA+s5ugCHeLbPgPYCIwq4ZucVpybyzyw5g8dreUATwUotIrQUeXMvKZ
 C39KamnCH7ieWuYEjvcJdB7jjWzZfa2Tbgs+vSwW1f8BDw5FSxw4AeITOO9d3qxPF07U
 cuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139250; x=1695744050;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUgl8qbgPkE0Y3xcruXztkrW8DQ+8tu5AZMIltrCMTc=;
 b=aTOE8f9AhYy5jmvzyJ94/9J2jent5ic3tNDTUralG09YAMXGA5g7rXRONk/IJxGfr1
 DV4FCQLYV48Hs0qAApbm+H2lZB9gVDjNQubpCClFg4/RXKkOSQopM6VvOki7BHKV9l7U
 RQHmIza9qkh7liX7IcWRlSaPPbpY2fn8CQ2NeGInw+hes2UHN6XtqmzrOGskHYed3wkj
 9gGws+pel02pWHZSzscxzTU8PzA8HW2asBOeU+1xHoNOTNWYq6lpPd3P2FgLICut9fFB
 ijqZGujpC5TMTpOsS6QnWD/luJqiJcoqSeaTe9jZjpAC2a/26lVhEkoP00ElwKlI876q
 uQ+A==
X-Gm-Message-State: AOJu0YxErp6gOb5wNsyF24vPLogvbaGiSJlIGo0z+44By34xAMTR0Seq
 AZzLasq3BjqxRRg6LVQRxo+e7w==
X-Google-Smtp-Source: AGHT+IEYENQvx9wMa2JS1WUI8iLYnjpDG93qCxq4QeH8ldoYczePJ7eReMSWizpfAZBUzbOKGmWASg==
X-Received: by 2002:a7b:c7cb:0:b0:402:ee71:29 with SMTP id
 z11-20020a7bc7cb000000b00402ee710029mr195787wmk.10.1695139249751; 
 Tue, 19 Sep 2023 09:00:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w11-20020a05600c014b00b00400268671c6sm15693627wmm.13.2023.09.19.09.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:00:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D2EBB1FFBB;
 Tue, 19 Sep 2023 17:00:48 +0100 (BST)
References: <20230919065754.1091394-1-alex.bennee@linaro.org>
 <CAJSP0QUy2e9niaA3uhbyBZm3cw0QW8Wg5u9Cd749VtpZVfXotQ@mail.gmail.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL v2 0/9] testing updates (back to green!)
Date: Tue, 19 Sep 2023 17:00:09 +0100
In-reply-to: <CAJSP0QUy2e9niaA3uhbyBZm3cw0QW8Wg5u9Cd749VtpZVfXotQ@mail.gmail.com>
Message-ID: <8734zaw3tb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Stefan Hajnoczi <stefanha@gmail.com> writes:

> There is some funny business with tests/lcitool/libvirt-ci. Please
> rebase on master and send a v3. Sorry for the trouble, I am afraid I
> would mess something up with the submodule if I attempted to resolve
> it myself.
>
> (If you don't see a conflict when rebasing, please wait until the end
> of the day when the other pull requests queued on the staging branch
> are pushed to master.)

That's weird, was their another PR in flight which touched libvirt-ci?

>
> Thanks!
>
> Auto-merging tests/docker/dockerfiles/debian-amd64-cross.docker
> Auto-merging tests/docker/dockerfiles/debian-amd64.docker
> Auto-merging tests/docker/dockerfiles/debian-arm64-cross.docker
> Auto-merging tests/docker/dockerfiles/debian-armhf-cross.docker
> Auto-merging tests/docker/dockerfiles/debian-ppc64el-cross.docker
> Auto-merging tests/docker/dockerfiles/debian-s390x-cross.docker
> Failed to merge submodule tests/lcitool/libvirt-ci (not checked out)
> CONFLICT (submodule): Merge conflict in tests/lcitool/libvirt-ci
> Recursive merging with submodules currently only supports trivial cases.
> Please manually handle the merging of each conflicted submodule.
> This can be accomplished with the following steps:
>  - come back to superproject and run:
>
>       git add tests/lcitool/libvirt-ci
>
>    to record the above merge or update
>  - resolve any other conflicts in the superproject
>  - commit the resulting index in the superproject
> Automatic merge failed; fix conflicts and then commit the result.
>
> Stefan
>
> On Tue, 19 Sept 2023 at 02:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> The following changes since commit 13d6b1608160de40ec65ae4c32419e56714bb=
adf:
>>
>>   Merge tag 'pull-crypto-20230915' of https://gitlab.com/rth7680/qemu in=
to staging (2023-09-18 11:04:21 -0400)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-19092=
3-1
>>
>> for you to fetch changes up to bb3c01212b54595f5bbdbe235cb353b220f94943:
>>
>>   tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (202=
3-09-19 07:46:02 +0100)
>>
>> ----------------------------------------------------------------
>> testing updates:
>>
>>   - update most Debian to bookworm
>>   - fix some typos
>>   - update loongarch toolchain
>>   - fix microbit test
>>   - handle GitLab/Cirrus timeout discrepancy
>>   - improve avocado console handling
>>   - disable mips avocado images pending bugfix
>>
>> ----------------------------------------------------------------
>> Alex Benn=C3=A9e (2):
>>       tests: update most Debian images to Bookworm
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
>>  tests/docker/dockerfiles/debian-armel-cross.docker    |  2 +-
>>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
>>  .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
>>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
>>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
>>  tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
>>  tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
>>  tests/lcitool/libvirt-ci                              |  2 +-
>>  tests/lcitool/refresh                                 | 17 +++++++++---=
-----
>>  23 files changed, 91 insertions(+), 58 deletions(-)
>>
>> --
>> 2.39.2
>>
>>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

