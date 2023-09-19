Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BB7A681C
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 17:30:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiceU-0007Yh-Mh; Tue, 19 Sep 2023 11:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiceS-0007YF-3w
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:28:36 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiceQ-0006UC-0g
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 11:28:35 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6bd0a0a6766so3887553a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 08:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695137311; x=1695742111; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQbWvFopT946oJ4Pl7ih3CMlhFsm+WcqFUzZQeSJoOM=;
 b=MYY3oqOqVUdHYc9RoWnPO6vSSLuoT5frMu1j62Kq3kMi3+JWlP3FZroeaiklmatV3D
 Ge71v+TZLeiDtbVagG7uX1y1cDaL89N9rsBfZIRMuarc4Y53qtbPyCtXznzJQPC08iEI
 5p0/LmZQs8Ve/htEtIeFa/JGWfHR1znB7QcISUao787sdpXuIpWMk8CM9F7mRkbESSKo
 PPucw+LcZfQEL8WWMVdugJu8TfDJbBIi53eCAyIEB6VZpWsj8Zisz/n5mIK8buVTaq1v
 g2If2Qcns/ElkT62CJrPdypV61wd8d1PQ1feO1v+0k5ZBitBH3K5K3tcChkJ57xSXQ1y
 M6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695137311; x=1695742111;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HQbWvFopT946oJ4Pl7ih3CMlhFsm+WcqFUzZQeSJoOM=;
 b=ovh9quEe8LuOc2rx/hNdsAaqaAFkOQN8MoEXY6DRfqpQTdV8RbXvHcQ6zeIPN+LyNd
 airnFQN4F5aIjGQP74yrioZ0amSh7mQI8H3dSA7GbbwHpgF5w7wa63cGqIeJjm7kgJZh
 wNBY64yWXf3XrQiW0eNjCwUB6ryfbOf1TRehh6jPXyWIW0emDPfRRTZufvkPdgIdhGRi
 SZ7QpO1mZN4ib7Vqd+avlpF/A6G5aio5MEGdhaXjz/7ClxGcRa0ekTHqIpG0/Q5bCUe8
 uteMC/BQoNId0pbuM/02FzfsXASypKP6MXdDzdkro45xM3vnI1U+xIYs6w54j3vSIrMu
 CcVg==
X-Gm-Message-State: AOJu0YwrtEzBPtV3Meropnb0woBcvJ+dh3hrVuLp65xef83WgLUGOjsn
 MJNw2l64b9rCW4HDlSgIWglcCa4BsPZsDh9+W3g=
X-Google-Smtp-Source: AGHT+IH15T4oKSKNFc8GHbCSVVdpn5n8/4I9uvNFGvpcPGrrJviQXJbT0wdG+mlIvpYw2XaNpvUK+H+7qvKJG5Kx23Q=
X-Received: by 2002:a05:6830:18f8:b0:6bd:b0c9:a8d with SMTP id
 d24-20020a05683018f800b006bdb0c90a8dmr11916811otf.25.1695137311295; Tue, 19
 Sep 2023 08:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230919065754.1091394-1-alex.bennee@linaro.org>
In-Reply-To: <20230919065754.1091394-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Sep 2023 11:28:19 -0400
Message-ID: <CAJSP0QUy2e9niaA3uhbyBZm3cw0QW8Wg5u9Cd749VtpZVfXotQ@mail.gmail.com>
Subject: Re: [PULL v2 0/9] testing updates (back to green!)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x329.google.com
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

There is some funny business with tests/lcitool/libvirt-ci. Please
rebase on master and send a v3. Sorry for the trouble, I am afraid I
would mess something up with the submodule if I attempted to resolve
it myself.

(If you don't see a conflict when rebasing, please wait until the end
of the day when the other pull requests queued on the staging branch
are pushed to master.)

Thanks!

Auto-merging tests/docker/dockerfiles/debian-amd64-cross.docker
Auto-merging tests/docker/dockerfiles/debian-amd64.docker
Auto-merging tests/docker/dockerfiles/debian-arm64-cross.docker
Auto-merging tests/docker/dockerfiles/debian-armhf-cross.docker
Auto-merging tests/docker/dockerfiles/debian-ppc64el-cross.docker
Auto-merging tests/docker/dockerfiles/debian-s390x-cross.docker
Failed to merge submodule tests/lcitool/libvirt-ci (not checked out)
CONFLICT (submodule): Merge conflict in tests/lcitool/libvirt-ci
Recursive merging with submodules currently only supports trivial cases.
Please manually handle the merging of each conflicted submodule.
This can be accomplished with the following steps:
 - come back to superproject and run:

      git add tests/lcitool/libvirt-ci

   to record the above merge or update
 - resolve any other conflicts in the superproject
 - commit the resulting index in the superproject
Automatic merge failed; fix conflicts and then commit the result.

Stefan

On Tue, 19 Sept 2023 at 02:59, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> The following changes since commit 13d6b1608160de40ec65ae4c32419e56714bba=
df:
>
>   Merge tag 'pull-crypto-20230915' of https://gitlab.com/rth7680/qemu int=
o staging (2023-09-18 11:04:21 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-190923=
-1
>
> for you to fetch changes up to bb3c01212b54595f5bbdbe235cb353b220f94943:
>
>   tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2023=
-09-19 07:46:02 +0100)
>
> ----------------------------------------------------------------
> testing updates:
>
>   - update most Debian to bookworm
>   - fix some typos
>   - update loongarch toolchain
>   - fix microbit test
>   - handle GitLab/Cirrus timeout discrepancy
>   - improve avocado console handling
>   - disable mips avocado images pending bugfix
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (2):
>       tests: update most Debian images to Bookworm
>       gitlab: fix typo/spelling in comments
>
> Daniel P. Berrang=C3=A9 (4):
>       microbit: add missing qtest_quit() call
>       qtest: kill orphaned qtest QEMU processes on FreeBSD
>       gitlab: make Cirrus CI timeout explicit
>       gitlab: make Cirrus CI jobs gating
>
> Nicholas Piggin (1):
>       tests/avocado: Fix console data loss
>
> Philippe Mathieu-Daud=C3=A9 (1):
>       tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884
>
> Richard Henderson (1):
>       tests/docker: Update docker-loongarch-cross toolchain
>
>  tests/qtest/libqtest.c                                |  7 +++++++
>  tests/qtest/microbit-test.c                           |  2 ++
>  .gitlab-ci.d/base.yml                                 |  2 +-
>  .gitlab-ci.d/cirrus.yml                               |  4 +++-
>  .gitlab-ci.d/cirrus/build.yml                         |  2 ++
>  python/qemu/machine/machine.py                        | 19 +++++++++++++=
++++++
>  tests/avocado/avocado_qemu/__init__.py                |  2 +-
>  tests/avocado/boot_linux_console.py                   |  7 +++++++
>  tests/avocado/machine_mips_malta.py                   |  6 ++++++
>  tests/avocado/replay_kernel.py                        |  7 +++++++
>  tests/avocado/tuxrun_baselines.py                     |  4 ++++
>  tests/docker/dockerfiles/debian-amd64-cross.docker    | 10 +++-------
>  tests/docker/dockerfiles/debian-amd64.docker          | 10 +++-------
>  tests/docker/dockerfiles/debian-arm64-cross.docker    | 10 +++-------
>  tests/docker/dockerfiles/debian-armel-cross.docker    |  2 +-
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
>  .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
>  tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
>  tests/lcitool/libvirt-ci                              |  2 +-
>  tests/lcitool/refresh                                 | 17 +++++++++----=
----
>  23 files changed, 91 insertions(+), 58 deletions(-)
>
> --
> 2.39.2
>
>

