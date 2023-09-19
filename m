Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F67A5A0E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 08:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiUNi-0005L0-Dk; Tue, 19 Sep 2023 02:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiUNh-0005Kj-2G
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:38:45 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qiUNf-0002nf-3R
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 02:38:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so5231093f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 23:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695105521; x=1695710321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CnUeV9yeJLYvr2mZ+IyMlvYvgtIv9ceKhJPGW/sb0Ag=;
 b=TA0eOBTJAoKFThJaU4s4NT0Ng4FtPwHeLDdPefEDIedSa+gHlrRawT0TZj+gF0KR6d
 Yv2QS9OaJLtcpjRCknSzXHPE1isEB+6DXo/M8P8GwrojBJQage2lZv0ph8dpyJ5ubAOG
 i88y2kq73sIb2gfbUTpKJJ50dOvp5XFD0rR98GaF1Bj3z8prW5ezJJ6dk/LIU6bQbLhH
 VkWtjo8jNwcfk5y7dO6JvVbaYKYqgHQyRGby+yUZsFrpz7Ly4EvRE7A3ke/2DqThzpFx
 bx3y//WIKF2vw20FVr4tLG/u+DngZuUxk/H4Dkv5bpvm6YtRpLZNc6xTWYcGfypJGBoa
 o7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695105521; x=1695710321;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CnUeV9yeJLYvr2mZ+IyMlvYvgtIv9ceKhJPGW/sb0Ag=;
 b=quIvJNIa4N7koqAyZX/HKtznb1HZd8bAVxGMCEvxNsCMdhDC9MaCULklxlpRUGhVUa
 yIjF5RyW1BLGda+ggAHrpf09qnzGc4X84d0cAHEinoIt02Eu4OF+PLBB1o6M+lBHgOq9
 wVPIq6iWHGmjWBsn2PYSIDjoc4gJgo072IBFP8WIRz8oelTgrE/+sgkIvVjy/3VK473p
 9VbJaL1qtbAMY+WwL49Jwgq96/lOHLqmNeTOtvG8szdizUrHxgOMXwPzpIo/TNGgOVBg
 dLs4UHfvlGjyBjUxSc5fsq9JRsw4+jIwA0h5vu4NwVk1brrN+/AiNrWBFsq6dOTZDENm
 oVPQ==
X-Gm-Message-State: AOJu0Yyk7oV2DwaL0NV2T39csExZ8aL0AuaStT7cOGAABgCNSMXNYxZk
 mxWbnKGUP4sf9MbkGa9JZJO8KDge7PhJxZGxTbSbXA==
X-Google-Smtp-Source: AGHT+IF1LM0+IoN4aVTgm6dRYCoRdc3dQLWVF936k66qQxrOD+LS08cWNPJzXPf/4tIvZz4ZEbUYTw==
X-Received: by 2002:adf:ec89:0:b0:315:8f4f:81b2 with SMTP id
 z9-20020adfec89000000b003158f4f81b2mr8831615wrn.64.1695105521179; 
 Mon, 18 Sep 2023 23:38:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a05600c218d00b00402f745c5ffsm14212907wme.8.2023.09.18.23.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 23:38:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 426AC1FFBB;
 Tue, 19 Sep 2023 07:38:40 +0100 (BST)
References: <20230915150849.595896-1-alex.bennee@linaro.org>
 <CAJSP0QWjNgTjhWVNgRnyE5A7HLAH3xKjOD3N+C58-G1Ue-wwDw@mail.gmail.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/9] testing updates (back to green!)
Date: Tue, 19 Sep 2023 07:37:42 +0100
In-reply-to: <CAJSP0QWjNgTjhWVNgRnyE5A7HLAH3xKjOD3N+C58-G1Ue-wwDw@mail.gmail.com>
Message-ID: <87bkdywtu7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Looks like the armel image building is broken:

  https://lists.debian.org/debian-arm/2023/09/msg00006.html

So I can drop that backdown for bullseye for now.

>
> I have dropped this pull request for now. Please take a look.
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

