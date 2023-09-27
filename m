Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44F7AF982
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 06:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlMG1-0007Hl-TT; Wed, 27 Sep 2023 00:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlMG0-0007Cc-4r
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 00:34:40 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qlMFx-0000sW-5q
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 00:34:39 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-504809e4494so610691e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 21:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695789274; x=1696394074;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9a+zMM/3FNVrTossZd33IMaxWcQqSsfDM9opLLKwkIM=;
 b=VADfXEn68nvfcjWZ+/LuTTZHSkOEePyBzItk9mep7ZAFqBxbQA8K25VD4jHcVSofyT
 2DSD7ZePbsNi7qBn7/5EJLp5CQbysxWGSUMc2geYt8pC6nSY8RZFkm8dS2zzC7YrUGIj
 delINyC1rdWbBlzGXvK7rpuzLH5+S1CdJz/nCokyq9ulfISlQ87YQz5miTVQUD5bworn
 OkyblnssUckzj0VR8Z5uaZI18G+zSJ83k5jAc+UTM4Hih2Yye7Ts3Nxb250O1yzOvZXU
 eGuErfsP4d8Wi8wCfAm6ZveBwdIBqijIb5597R71e/HFcyF0Ul7jw2SmyVe4Jh9FKhnK
 ASNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695789274; x=1696394074;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9a+zMM/3FNVrTossZd33IMaxWcQqSsfDM9opLLKwkIM=;
 b=qI/pgxWSpjVqHSNST7d+Omh8KFYSJ5b9tCnS4x6+45eugKvd3hLz+W2ZghaLfoHLTT
 k+ViXS3k6dMak4w6uhbu7/cJRzhuAAoLusvCwgXoSSNCjWwOVeacJTFGKVm90uynPSVB
 6Muo90wBgpcGO5BwGBwfat8SvZ9PWrxFWLuNlyGLcHjJyyBeHPRWRVRtKClH/7N9CUvk
 bldccEG2Re7TXzTTfrd7ZqHrzTk4yjRX/HY/rXEsNEllUFXX53/agiKFyFm7lkj2iUmy
 +edbPW8jnve8rXyLf0S3BYMyfD4A5Co07eDCJB125HxUWf7bQRX/H1XAN47dFP3aZxTz
 unVQ==
X-Gm-Message-State: AOJu0YxOPF9DaDmu/J2kR2/ToGPL87YjmMETK8XqBcszlS7lb2kypdlI
 LNz9k7XhgTNeKsXDLs1A0Wg31feDffXhZtzZaQPv4Q==
X-Google-Smtp-Source: AGHT+IHoo59DFnyUPSEsGMBp7n/JBCqFN9MkJbROTQHGqTFLZM0PlD8UtaJeWu3JLP/S56iY1hGwHLx/14Rp7p8AQ4w=
X-Received: by 2002:ac2:546e:0:b0:4fe:3724:fdae with SMTP id
 e14-20020ac2546e000000b004fe3724fdaemr554347lfn.66.1695789274315; Tue, 26 Sep
 2023 21:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
In-Reply-To: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 26 Sep 2023 22:34:24 -0600
Message-ID: <CANCZdfopLkxHynFoMbTjqu6RTdZ=wdjajD5V2QVbD=WfqnVUsQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/23] bsd-user: Implement mmap related system calls
 for FreeBSD.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004f58f406064fb5cd"
Received-SPF: none client-ip=2a00:1450:4864:20::129;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--0000000000004f58f406064fb5cd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 25, 2023 at 12:28=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> Upstream the implementation of the following mmap system calls, from the
> qemu-bsd-user fork:
>    mmap(2), munmap(2),
>    mprotect(2),
>    msync(2),
>    mlock(2), munlock(2), mlockall(2), munlockall(2), mincore(2),
>    madvise(2),
>    minherit(2),
>    shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmget(2),
> shmctl(2), shmat(2),
>    shmdt(2)
>    brk(2)
>
> Karim Taha (3):
>   bsd-user: Implement shm_open2(2) system call
>   bsd-user: Add bsd-mem.c to meson.build
>   bsd-user: Implment madvise(2) to match the linux-user implementation.
>
> Kyle Evans (1):
>   bsd-user: Implement shm_rename(2) system call
>
> Stacey Son (18):
>   bsd-user: Implement struct target_ipc_perm
>   bsd-user: Implement struct target_shmid_ds
>   bsd-user: Declarations for ipc_perm and shmid_ds conversion functions
>   bsd-user: Introduce freebsd/os-misc.h to the source tree
>   bsd-user: Implement target_set_brk function in bsd-mem.c instead of
>     os-syscall.c
>   bsd-user: Implement ipc_perm conversion between host and target.
>   bsd-user: Implement shmid_ds conversion between host and target.
>   bsd-user: Introduce bsd-mem.h to the source tree
>   bsd-user: Implement mmap(2) and munmap(2)
>   bsd-user: Implement mprotect(2)
>   bsd-user: Implement msync(2)
>   bsd-user: Implement mlock(2), munlock(2), mlockall(2), munlockall(2),
>     minherit(2)
>   bsd-user: Implement mincore(2)
>   bsd-user: Implement do_obreak function
>   bsd-user: Implement shm_open(2)
>   bsd-user: Implement shm_unlink(2) and shmget(2)
>   bsd-user: Implement shmctl(2)
>   bsd-user: Implement shmat(2) and shmdt(2)
>
> Warner Losh (1):
>   bsd-user: Add stubs for vadvise(), sbrk() and sstk()
>
>  bsd-user/bsd-mem.c            | 104 ++++++++
>  bsd-user/bsd-mem.h            | 452 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-misc.h    |  94 +++++++
>  bsd-user/freebsd/os-syscall.c | 109 +++++++-
>  bsd-user/meson.build          |   1 +
>  bsd-user/mmap.c               |   2 +-
>  bsd-user/qemu-bsd.h           |  45 ++++
>  bsd-user/qemu.h               |   1 +
>  bsd-user/syscall_defs.h       |  39 +++
>  9 files changed, 842 insertions(+), 5 deletions(-)
>  create mode 100644 bsd-user/bsd-mem.c
>  create mode 100644 bsd-user/bsd-mem.h
>  create mode 100644 bsd-user/freebsd/os-misc.h
>  create mode 100644 bsd-user/qemu-bsd.h
>

queued to bsd-user-topo

with minor conflicts from rebasing it and the proc system call changes onto
one branch.

I did fix one issue: in the blitz bsd-user fork branch, we called shm_open2
directly, which
you copied to this patch series. This works when compiling static, but not
when compiling
dynamically. In the blitz branch, we always do static building. But since
qemu's CI process
uses dynamic, there was an error. Turns out that shm_open2 is a 'hidden'
system call that's
used to implement other pseudo system calls. As such, it was purposely
hidden in the dynamic
case, exporting only the __sys_shm_open2 system call (normally there're
several ways to get
to these symbols for different threading models that aren't relevant for
this).  By the time I figured
out why it was failing, the history here, etc, it was easier to just make
the minor correction rather
than send it back to you for this one last trivial change. Especially since
the directions for
building bsd-user are recommend --static.

With these changes, I'm able to execute dynamically compiled hello-world:
% ./qemu-arm -L /vidpool/qemu/jails/jails/131armv7 ~/hello-13
Hello
%
which is the first time ever I've been able to run even a full trivial
program that's dynamically
linked. Well done!

Once I get these through the CI pipeline, I'll submit the pull request. And
then learn how to edit
the wiki page for the release notes :)


On Mon, Sep 25, 2023 at 12:28=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> Upstream the implementation of the following mmap system calls, from the
> qemu-bsd-user fork:
>    mmap(2), munmap(2),
>    mprotect(2),
>    msync(2),
>    mlock(2), munlock(2), mlockall(2), munlockall(2), mincore(2),
>    madvise(2),
>    minherit(2),
>    shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmget(2),
> shmctl(2), shmat(2),
>    shmdt(2)
>    brk(2)
>
> Karim Taha (3):
>   bsd-user: Implement shm_open2(2) system call
>   bsd-user: Add bsd-mem.c to meson.build
>   bsd-user: Implment madvise(2) to match the linux-user implementation.
>
> Kyle Evans (1):
>   bsd-user: Implement shm_rename(2) system call
>
> Stacey Son (18):
>   bsd-user: Implement struct target_ipc_perm
>   bsd-user: Implement struct target_shmid_ds
>   bsd-user: Declarations for ipc_perm and shmid_ds conversion functions
>   bsd-user: Introduce freebsd/os-misc.h to the source tree
>   bsd-user: Implement target_set_brk function in bsd-mem.c instead of
>     os-syscall.c
>   bsd-user: Implement ipc_perm conversion between host and target.
>   bsd-user: Implement shmid_ds conversion between host and target.
>   bsd-user: Introduce bsd-mem.h to the source tree
>   bsd-user: Implement mmap(2) and munmap(2)
>   bsd-user: Implement mprotect(2)
>   bsd-user: Implement msync(2)
>   bsd-user: Implement mlock(2), munlock(2), mlockall(2), munlockall(2),
>     minherit(2)
>   bsd-user: Implement mincore(2)
>   bsd-user: Implement do_obreak function
>   bsd-user: Implement shm_open(2)
>   bsd-user: Implement shm_unlink(2) and shmget(2)
>   bsd-user: Implement shmctl(2)
>   bsd-user: Implement shmat(2) and shmdt(2)
>
> Warner Losh (1):
>   bsd-user: Add stubs for vadvise(), sbrk() and sstk()
>
>  bsd-user/bsd-mem.c            | 104 ++++++++
>  bsd-user/bsd-mem.h            | 452 ++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-misc.h    |  94 +++++++
>  bsd-user/freebsd/os-syscall.c | 109 +++++++-
>  bsd-user/meson.build          |   1 +
>  bsd-user/mmap.c               |   2 +-
>  bsd-user/qemu-bsd.h           |  45 ++++
>  bsd-user/qemu.h               |   1 +
>  bsd-user/syscall_defs.h       |  39 +++
>  9 files changed, 842 insertions(+), 5 deletions(-)
>  create mode 100644 bsd-user/bsd-mem.c
>  create mode 100644 bsd-user/bsd-mem.h
>  create mode 100644 bsd-user/freebsd/os-misc.h
>  create mode 100644 bsd-user/qemu-bsd.h
>

queued to bsd-user-topo

with minor conflicts from rebasing it and the proc system call changes onto
one branch.

I did fix one issue: in the blitz bsd-user fork branch, we called shm_open2
directly, which
you copied to this patch series. This works when compiling static, but not
when compiling
dynamically. In the blitz branch, we always do static building. But since
qemu's CI process
uses dynamic, there was an error. Turns out that shm_open2 is a 'hidden'
system call that's
used to implement other pseudo system calls. As such, it was purposely
hidden in the dynamic
case, exporting only the __sys_shm_open2 system call (normally there's
several ways to get
to these symbols for different threading models that aren't relevant for
this).  By the time I figured
out why it was failing, the history here, etc, it was easier to just make
the minor correction rather
than send it back to you for this one last trivial change.

With these changes, I'm able to execute dynamically compiled hello-world:
% ./qemu-arm -L /vidpool/qemu/jails/jails/131armv7 ~/hello-13
Hello
%
which is one

Warner

--0000000000004f58f406064fb5cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 25, 2023 at 12:28=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Upstream the implementation of the following mmap system call=
s, from the<br>
qemu-bsd-user fork:<br>
=C2=A0 =C2=A0mmap(2), munmap(2),<br>
=C2=A0 =C2=A0mprotect(2),<br>
=C2=A0 =C2=A0msync(2),<br>
=C2=A0 =C2=A0mlock(2), munlock(2), mlockall(2), munlockall(2), mincore(2),<=
br>
=C2=A0 =C2=A0madvise(2),<br>
=C2=A0 =C2=A0minherit(2),<br>
=C2=A0 =C2=A0shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmge=
t(2), shmctl(2), shmat(2),<br>
=C2=A0 =C2=A0shmdt(2)<br>
=C2=A0 =C2=A0brk(2)<br>
<br>
Karim Taha (3):<br>
=C2=A0 bsd-user: Implement shm_open2(2) system call<br>
=C2=A0 bsd-user: Add bsd-mem.c to meson.build<br>
=C2=A0 bsd-user: Implment madvise(2) to match the linux-user implementation=
.<br>
<br>
Kyle Evans (1):<br>
=C2=A0 bsd-user: Implement shm_rename(2) system call<br>
<br>
Stacey Son (18):<br>
=C2=A0 bsd-user: Implement struct target_ipc_perm<br>
=C2=A0 bsd-user: Implement struct target_shmid_ds<br>
=C2=A0 bsd-user: Declarations for ipc_perm and shmid_ds conversion function=
s<br>
=C2=A0 bsd-user: Introduce freebsd/os-misc.h to the source tree<br>
=C2=A0 bsd-user: Implement target_set_brk function in bsd-mem.c instead of<=
br>
=C2=A0 =C2=A0 os-syscall.c<br>
=C2=A0 bsd-user: Implement ipc_perm conversion between host and target.<br>
=C2=A0 bsd-user: Implement shmid_ds conversion between host and target.<br>
=C2=A0 bsd-user: Introduce bsd-mem.h to the source tree<br>
=C2=A0 bsd-user: Implement mmap(2) and munmap(2)<br>
=C2=A0 bsd-user: Implement mprotect(2)<br>
=C2=A0 bsd-user: Implement msync(2)<br>
=C2=A0 bsd-user: Implement mlock(2), munlock(2), mlockall(2), munlockall(2)=
,<br>
=C2=A0 =C2=A0 minherit(2)<br>
=C2=A0 bsd-user: Implement mincore(2)<br>
=C2=A0 bsd-user: Implement do_obreak function<br>
=C2=A0 bsd-user: Implement shm_open(2)<br>
=C2=A0 bsd-user: Implement shm_unlink(2) and shmget(2)<br>
=C2=A0 bsd-user: Implement shmctl(2)<br>
=C2=A0 bsd-user: Implement shmat(2) and shmdt(2)<br>
<br>
Warner Losh (1):<br>
=C2=A0 bsd-user: Add stubs for vadvise(), sbrk() and sstk()<br>
<br>
=C2=A0bsd-user/bsd-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 104 +++=
+++++<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 452 +++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 |=C2=A0 94 +++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 109 +++++++-<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
1 +<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
5 ++++<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 39 +++<br>
=C2=A09 files changed, 842 insertions(+), 5 deletions(-)<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.c<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-misc.h<br>
=C2=A0create mode 100644 bsd-user/qemu-bsd.h<br></blockquote><div><br></div=
><div>queued to bsd-user-topo</div><div><br></div><div>with minor conflicts=
 from rebasing it and the proc system call changes onto one branch.</div><d=
iv><br></div><div>I did fix one issue: in the blitz bsd-user fork branch, w=
e called shm_open2 directly, which</div><div>you copied to this patch serie=
s. This works when compiling static, but not when compiling</div><div>dynam=
ically. In the blitz branch, we always do static building. But since qemu&#=
39;s CI process</div><div>uses dynamic, there was an error. Turns out that =
shm_open2 is a &#39;hidden&#39; system call that&#39;s</div><div>used to im=
plement other pseudo system calls. As such, it was purposely hidden in the =
dynamic</div><div>case, exporting only the __sys_shm_open2 system call (nor=
mally there&#39;re several ways to get</div><div>to these symbols for diffe=
rent threading models that aren&#39;t relevant for this).=C2=A0 By the time=
 I figured</div><div>out why it was failing, the history here, etc, it was =
easier to just make the minor correction rather</div><div>than send it back=
 to you for this one last trivial change. Especially since the directions f=
or</div><div>building bsd-user are recommend --static.<br></div><div><br></=
div>With these changes, I&#39;m able to execute dynamically compiled hello-=
world:</div><div class=3D"gmail_quote">% ./qemu-arm -L /vidpool/qemu/jails/=
jails/131armv7 ~/hello-13<br>Hello</div><div class=3D"gmail_quote">%</div><=
div class=3D"gmail_quote">which is the first time ever I&#39;ve been able t=
o run even a full trivial program that&#39;s dynamically</div><div class=3D=
"gmail_quote">linked. Well done!</div><div class=3D"gmail_quote"><br></div>=
<div class=3D"gmail_quote">Once I get these through the CI pipeline, I&#39;=
ll submit the pull request. And then learn how to edit</div><div class=3D"g=
mail_quote">the wiki page for the release notes :)<br><table class=3D"gmail=
-cf gmail-An" id=3D"gmail-undefined" cellpadding=3D"0"><tbody><tr><td class=
=3D"gmail-Ap"><div id=3D"gmail-:3ot" class=3D"gmail-Ar gmail-Au" style=3D"d=
isplay:block"><div id=3D"gmail-:3op" class=3D"gmail-Am gmail-Al editable gm=
ail-LW-avf gmail-tS-tW gmail-tS-tY" aria-label=3D"Message Body" role=3D"tex=
tbox" aria-multiline=3D"true" style=3D"direction:ltr;min-height:85px" tabin=
dex=3D"1" aria-controls=3D":3ro"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Sep 25, 2023=
 at 12:28=E2=80=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.=
com">kariem.taha2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">Upstream the implementation of the following m=
map system calls, from the<br>
qemu-bsd-user fork:<br>
=C2=A0 =C2=A0mmap(2), munmap(2),<br>
=C2=A0 =C2=A0mprotect(2),<br>
=C2=A0 =C2=A0msync(2),<br>
=C2=A0 =C2=A0mlock(2), munlock(2), mlockall(2), munlockall(2), mincore(2),<=
br>
=C2=A0 =C2=A0madvise(2),<br>
=C2=A0 =C2=A0minherit(2),<br>
=C2=A0 =C2=A0shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmge=
t(2), shmctl(2), shmat(2),<br>
=C2=A0 =C2=A0shmdt(2)<br>
=C2=A0 =C2=A0brk(2)<br>
<br>
Karim Taha (3):<br>
=C2=A0 bsd-user: Implement shm_open2(2) system call<br>
=C2=A0 bsd-user: Add bsd-mem.c to meson.build<br>
=C2=A0 bsd-user: Implment madvise(2) to match the linux-user implementation=
.<br>
<br>
Kyle Evans (1):<br>
=C2=A0 bsd-user: Implement shm_rename(2) system call<br>
<br>
Stacey Son (18):<br>
=C2=A0 bsd-user: Implement struct target_ipc_perm<br>
=C2=A0 bsd-user: Implement struct target_shmid_ds<br>
=C2=A0 bsd-user: Declarations for ipc_perm and shmid_ds conversion function=
s<br>
=C2=A0 bsd-user: Introduce freebsd/os-misc.h to the source tree<br>
=C2=A0 bsd-user: Implement target_set_brk function in bsd-mem.c instead of<=
br>
=C2=A0 =C2=A0 os-syscall.c<br>
=C2=A0 bsd-user: Implement ipc_perm conversion between host and target.<br>
=C2=A0 bsd-user: Implement shmid_ds conversion between host and target.<br>
=C2=A0 bsd-user: Introduce bsd-mem.h to the source tree<br>
=C2=A0 bsd-user: Implement mmap(2) and munmap(2)<br>
=C2=A0 bsd-user: Implement mprotect(2)<br>
=C2=A0 bsd-user: Implement msync(2)<br>
=C2=A0 bsd-user: Implement mlock(2), munlock(2), mlockall(2), munlockall(2)=
,<br>
=C2=A0 =C2=A0 minherit(2)<br>
=C2=A0 bsd-user: Implement mincore(2)<br>
=C2=A0 bsd-user: Implement do_obreak function<br>
=C2=A0 bsd-user: Implement shm_open(2)<br>
=C2=A0 bsd-user: Implement shm_unlink(2) and shmget(2)<br>
=C2=A0 bsd-user: Implement shmctl(2)<br>
=C2=A0 bsd-user: Implement shmat(2) and shmdt(2)<br>
<br>
Warner Losh (1):<br>
=C2=A0 bsd-user: Add stubs for vadvise(), sbrk() and sstk()<br>
<br>
=C2=A0bsd-user/bsd-mem.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 104 +++=
+++++<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 452 +++=
+++++++++++++++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 |=C2=A0 94 +++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 109 +++++++-<br>
=C2=A0bsd-user/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0=
1 +<br>
=C2=A0bsd-user/mmap.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0bsd-user/qemu-bsd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
5 ++++<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A01 +<br>
=C2=A0bsd-user/syscall_defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 39 +++<br>
=C2=A09 files changed, 842 insertions(+), 5 deletions(-)<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.c<br>
=C2=A0create mode 100644 bsd-user/bsd-mem.h<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-misc.h<br>
=C2=A0create mode 100644 bsd-user/qemu-bsd.h<br></blockquote><div><br></div=
><div>queued to bsd-user-topo</div><div><br></div><div>with minor conflicts=
 from rebasing it and the proc system call changes onto one branch.</div><d=
iv><br></div><div>I did fix one issue: in the blitz bsd-user fork branch, w=
e called shm_open2 directly, which</div><div>you copied to this patch serie=
s. This works when compiling static, but not when compiling</div><div>dynam=
ically. In the blitz branch, we always do static building. But since qemu&#=
39;s CI process</div><div>uses dynamic, there was an error. Turns out that =
shm_open2 is a &#39;hidden&#39; system call that&#39;s</div><div>used to im=
plement other pseudo system calls. As such, it was purposely hidden in the =
dynamic</div><div>case, exporting only the __sys_shm_open2 system call (nor=
mally <span class=3D"gmail-Lm gmail-ng gmail-Vs">there&#39;s several</span>=
 ways to get</div><div>to these symbols for different threading models that=
 aren&#39;t relevant for this).=C2=A0 By the time I figured</div><div>out w=
hy it was failing, the history here, etc, it was easier to just make the mi=
nor correction rather</div><div>than send it back to you for this one last =
trivial change.<br></div><div><br></div>With these changes, I&#39;m able to=
 execute dynamically compiled hello-world:</div><div class=3D"gmail_quote">=
% ./qemu-arm -L /vidpool/qemu/jails/jails/131armv7 ~/hello-13<br>Hello</div=
><div class=3D"gmail_quote">%</div><div class=3D"gmail_quote">which is one =
<br></div></div></div></td></tr></tbody></table></div><div class=3D"gmail_q=
uote"><br></div><div class=3D"gmail_quote">Warner<br></div></div>

--0000000000004f58f406064fb5cd--

