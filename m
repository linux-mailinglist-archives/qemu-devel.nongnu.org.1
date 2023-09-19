Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2347F7A68B6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:16:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidNZ-0006Yv-0Z; Tue, 19 Sep 2023 12:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qidNV-0006YJ-PE
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:15:09 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qidNT-0006Sp-7L
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:15:09 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3ab3aa9ae33so4045960b6e.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695140104; x=1695744904; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3lDtI98BQsNNKHjTtmhtufSytEVvJB7vHiNmswIfFT8=;
 b=Hso1IzkGRXFzC1ajFj81ucnFd6iqdc/WbfKhQ/A8KCA/Bpq6t/igCgQxe2QWIm4z1F
 XCgh2BfA/XUj3+igwUVHmLsMnqW8PSJIRfXm8F6FVfqsKgz9TMtTL3qjftX2hgPbuwtF
 D7KEBOClye+USJeNBQGS9xaVoNzrT2Slh1OuLNKVp7ByJUef9bAvXdN9NoGSzDh+YfcR
 3zsYfrsnGFUQWfMxVXU/AM8w83ktJJUn+UrXIglreDXTGHapSIm3d8khyFMVB7UI8G2N
 +nV8dyHnpbzg3ySD/aGrf6GXvYfYo52sPjn98vpMyaSLCdMGU9IExyVrfqjZ68Z3hwfv
 cjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695140104; x=1695744904;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3lDtI98BQsNNKHjTtmhtufSytEVvJB7vHiNmswIfFT8=;
 b=IZIGhKEt/40g80DefCrWKyRmOMQM28bMSMLAouYeLPblXNeic8aXGpUytN7L21LIs4
 z1vbvId1VdUhOP/nOHBe5sQKOjYrH0FSNygoGR+wtKLf/Naln4YQFIIPA1Rh0xhUG2IY
 Y7VAOl1siZUZ7fI3nPZf4BOg8LRLIomstkgTNvR7sMgCMxT0q/hdgnVdXcJ69yKlrYVR
 OEu8paxWvHobFDTn911HH1K1fKQiExhdASt6wKDfzItD6PTj46KUFizjVjRmp3zVgEgH
 /swaKAqd6WXDBeD9BLLEYS4S9tvMwOjP2VRX1sn+41LRl16QEjX1y+1LSp/+aiWlv1CD
 4SZA==
X-Gm-Message-State: AOJu0Yxcxz22+5mLTA3BuIMmD8yLBSfbzYq2ewo0IIvWlecULNm5s6rB
 J3wC+tw8jAFNHZjno+3g/yiVoieem9t89xa1qOrlUeYJnEQ=
X-Google-Smtp-Source: AGHT+IFo3lzprgdbfZJgXa4gQ4TqIcJwTf6shKSIWJoFoC+p9X5YQ0ByRYlnbwGUn682G5lwLULLmw3zciipGtC1aFs=
X-Received: by 2002:a05:6808:18f:b0:3a0:3144:dd3a with SMTP id
 w15-20020a056808018f00b003a03144dd3amr13321740oic.37.1695140104622; Tue, 19
 Sep 2023 09:15:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230919065754.1091394-1-alex.bennee@linaro.org>
 <CAJSP0QUy2e9niaA3uhbyBZm3cw0QW8Wg5u9Cd749VtpZVfXotQ@mail.gmail.com>
 <8734zaw3tb.fsf@linaro.org>
In-Reply-To: <8734zaw3tb.fsf@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Sep 2023 12:14:52 -0400
Message-ID: <CAJSP0QU3ojRW52mu4HcqPd3eH_xQ-xd5GVBz=jy78=rchi3mVw@mail.gmail.com>
Subject: Re: [PULL v2 0/9] testing updates (back to green!)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 19 Sept 2023 at 12:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Stefan Hajnoczi <stefanha@gmail.com> writes:
>
> > There is some funny business with tests/lcitool/libvirt-ci. Please
> > rebase on master and send a v3. Sorry for the trouble, I am afraid I
> > would mess something up with the submodule if I attempted to resolve
> > it myself.
> >
> > (If you don't see a conflict when rebasing, please wait until the end
> > of the day when the other pull requests queued on the staging branch
> > are pushed to master.)
>
> That's weird, was their another PR in flight which touched libvirt-ci?

It's probably a conflict with Ilya Maximets' patches in Jason Wang's
net pull request:

https://lore.kernel.org/qemu-devel/20230918083132.55423-1-jasowang@redhat.c=
om/

>
> >
> > Thanks!
> >
> > Auto-merging tests/docker/dockerfiles/debian-amd64-cross.docker
> > Auto-merging tests/docker/dockerfiles/debian-amd64.docker
> > Auto-merging tests/docker/dockerfiles/debian-arm64-cross.docker
> > Auto-merging tests/docker/dockerfiles/debian-armhf-cross.docker
> > Auto-merging tests/docker/dockerfiles/debian-ppc64el-cross.docker
> > Auto-merging tests/docker/dockerfiles/debian-s390x-cross.docker
> > Failed to merge submodule tests/lcitool/libvirt-ci (not checked out)
> > CONFLICT (submodule): Merge conflict in tests/lcitool/libvirt-ci
> > Recursive merging with submodules currently only supports trivial cases=
.
> > Please manually handle the merging of each conflicted submodule.
> > This can be accomplished with the following steps:
> >  - come back to superproject and run:
> >
> >       git add tests/lcitool/libvirt-ci
> >
> >    to record the above merge or update
> >  - resolve any other conflicts in the superproject
> >  - commit the resulting index in the superproject
> > Automatic merge failed; fix conflicts and then commit the result.
> >
> > Stefan
> >
> > On Tue, 19 Sept 2023 at 02:59, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
> >>
> >> The following changes since commit 13d6b1608160de40ec65ae4c32419e56714=
bbadf:
> >>
> >>   Merge tag 'pull-crypto-20230915' of https://gitlab.com/rth7680/qemu =
into staging (2023-09-18 11:04:21 -0400)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-190=
923-1
> >>
> >> for you to fetch changes up to bb3c01212b54595f5bbdbe235cb353b220f9494=
3:
> >>
> >>   tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2=
023-09-19 07:46:02 +0100)
> >>
> >> ----------------------------------------------------------------
> >> testing updates:
> >>
> >>   - update most Debian to bookworm
> >>   - fix some typos
> >>   - update loongarch toolchain
> >>   - fix microbit test
> >>   - handle GitLab/Cirrus timeout discrepancy
> >>   - improve avocado console handling
> >>   - disable mips avocado images pending bugfix
> >>
> >> ----------------------------------------------------------------
> >> Alex Benn=C3=A9e (2):
> >>       tests: update most Debian images to Bookworm
> >>       gitlab: fix typo/spelling in comments
> >>
> >> Daniel P. Berrang=C3=A9 (4):
> >>       microbit: add missing qtest_quit() call
> >>       qtest: kill orphaned qtest QEMU processes on FreeBSD
> >>       gitlab: make Cirrus CI timeout explicit
> >>       gitlab: make Cirrus CI jobs gating
> >>
> >> Nicholas Piggin (1):
> >>       tests/avocado: Fix console data loss
> >>
> >> Philippe Mathieu-Daud=C3=A9 (1):
> >>       tests/avocado: Disable MIPS Malta tests due to GitLab issue #188=
4
> >>
> >> Richard Henderson (1):
> >>       tests/docker: Update docker-loongarch-cross toolchain
> >>
> >>  tests/qtest/libqtest.c                                |  7 +++++++
> >>  tests/qtest/microbit-test.c                           |  2 ++
> >>  .gitlab-ci.d/base.yml                                 |  2 +-
> >>  .gitlab-ci.d/cirrus.yml                               |  4 +++-
> >>  .gitlab-ci.d/cirrus/build.yml                         |  2 ++
> >>  python/qemu/machine/machine.py                        | 19 ++++++++++=
+++++++++
> >>  tests/avocado/avocado_qemu/__init__.py                |  2 +-
> >>  tests/avocado/boot_linux_console.py                   |  7 +++++++
> >>  tests/avocado/machine_mips_malta.py                   |  6 ++++++
> >>  tests/avocado/replay_kernel.py                        |  7 +++++++
> >>  tests/avocado/tuxrun_baselines.py                     |  4 ++++
> >>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 10 +++-------
> >>  tests/docker/dockerfiles/debian-amd64.docker          | 10 +++-------
> >>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 10 +++-------
> >>  tests/docker/dockerfiles/debian-armel-cross.docker    |  2 +-
> >>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
> >>  .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
> >>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
> >>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
> >>  tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
> >>  tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
> >>  tests/lcitool/libvirt-ci                              |  2 +-
> >>  tests/lcitool/refresh                                 | 17 +++++++++-=
-------
> >>  23 files changed, 91 insertions(+), 58 deletions(-)
> >>
> >> --
> >> 2.39.2
> >>
> >>
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

