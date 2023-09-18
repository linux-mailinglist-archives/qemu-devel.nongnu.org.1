Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4B7A4AC9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 15:51:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiEc1-0003LF-3E; Mon, 18 Sep 2023 09:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiEbw-0003HQ-TK
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:48:25 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qiEbl-0007eO-J5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 09:48:24 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-576918d0a42so2724076eaf.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 06:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695044888; x=1695649688; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWp9jSWTn55LZBK9/I9QlyxCbRD/H6HZz+N6jDiYcn8=;
 b=c/QRwz0DICXP8WyCnLjESZ7jORr/l5IrhQSfYqu8SrKRBUETRte84H/IQKOtx4jvIB
 SoQ+XNKtRjznIiOfynkMeauvlRNKTCn6TioU7FxXy1c317EMyjilGZqfsHpBGd6l3BFS
 wDQ7gJekBvd6Hn7Wfkg09zwMPVw97G6KDB/pAGUxCHI2zqUxMPJeBScyqBKF8SXC5R2w
 CQ8DTrQ3CibK0SHHjtjoOjuTYuWJkQH3Y6C3NdhPPguWArjWZvi0c/1z7DqktALc8TlQ
 jxgdrEXEmtT0J4cE6ultmcehIGowgY8fKKMyXXq2+04D89S3+eBNuDnoICGtjqKzJle2
 6yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695044888; x=1695649688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWp9jSWTn55LZBK9/I9QlyxCbRD/H6HZz+N6jDiYcn8=;
 b=tNyC7NGGOn0D6kOCjCTubSvU01CS9vvXpPWQWlZ6c/uwzUsf138vLtieRyj1vzLAC4
 sIztZliEhJpQonQs9Sf9BZ4+i1v99WjeX5YKQS0C4Ur3GWwEU9XQnDZBF1yukfLCaFsH
 eayubYz3kzzzq5Sob1j7wAp5l4jn0yNMAB+PsHYFptQKD0Ez7C/rYBV6hEMxC8jKKPVf
 ZLj1kpdVBiJCAuM2+bKYgd27Lo5lFtUw7m1K5kbRwB9wuQMImhkFDt8aWhrHPyQQEIbQ
 BKE1QH1nGqQ13e6O+sLugk9/DX3zopp2cdaCAh3NI14WTsBQ4+Lf1brXLRyJ/nJ99Ayo
 oPwQ==
X-Gm-Message-State: AOJu0YwSEZT70t0zKLTvKhDLIQKU1hRxZZ16caA9xa8QD7FRHj3j37UT
 4esv7yWrqYtGzu3zyTFbaZSp46a3pDNhTk23+TN4Aqv6koQ=
X-Google-Smtp-Source: AGHT+IGRCyg/Mu5XMVNih3MZGzKCsnVUA5qqvGKhe3kJJjY9HrST+Ff6oyuumaU9eIXdJkIrkGlWjgL3im5iiXvmsFQ=
X-Received: by 2002:a4a:6559:0:b0:56c:820e:7f02 with SMTP id
 z25-20020a4a6559000000b0056c820e7f02mr8889100oog.0.1695044888295; Mon, 18 Sep
 2023 06:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230915150849.595896-1-alex.bennee@linaro.org>
In-Reply-To: <20230915150849.595896-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 18 Sep 2023 09:47:56 -0400
Message-ID: <CAJSP0QWjNgTjhWVNgRnyE5A7HLAH3xKjOD3N+C58-G1Ue-wwDw@mail.gmail.com>
Subject: Re: [PULL 0/9] testing updates (back to green!)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Fri, 15 Sept 2023 at 11:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39=
e5:
>
>   Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qe=
mu-tpm into staging (2023-09-13 13:41:57 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-ominbus-150923=
-1
>
> for you to fetch changes up to 5acd4bf25dc9becd05b8772b94982722e1fa76a3:
>
>   tests/avocado: Disable MIPS Malta tests due to GitLab issue #1884 (2023=
-09-15 15:17:52 +0100)
>
> ----------------------------------------------------------------
> testing updates:
>
>   - update most Debian to bookworm

This breaks the armel-debian-cross-container job:
https://gitlab.com/qemu-project/qemu/-/jobs/5111108339

I have dropped this pull request for now. Please take a look.

Thanks,
Stefan

>   - fix some typos
>   - update loongarch toolchain
>   - fix microbit test
>   - handle GitLab/Cirrus timeout discrepancy
>   - improve avocado console handling
>   - disable mips avocado images pending bugfix
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (2):
>       tests: update Debian images to Bookworm
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
>  tests/docker/dockerfiles/debian-armel-cross.docker    | 10 +++-------
>  tests/docker/dockerfiles/debian-armhf-cross.docker    | 10 +++-------
>  .../docker/dockerfiles/debian-loongarch-cross.docker  |  2 +-
>  tests/docker/dockerfiles/debian-ppc64el-cross.docker  | 10 +++-------
>  tests/docker/dockerfiles/debian-s390x-cross.docker    | 10 +++-------
>  tests/docker/dockerfiles/ubuntu2004.docker            |  2 +-
>  tests/docker/dockerfiles/ubuntu2204.docker            |  2 +-
>  tests/lcitool/libvirt-ci                              |  2 +-
>  tests/lcitool/refresh                                 | 18 +++++++++----=
-----
>  23 files changed, 93 insertions(+), 65 deletions(-)
>
>
> --
> 2.39.2
>
>

