Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC2C7B7518
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:37:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovC-00040P-0F; Tue, 03 Oct 2023 19:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov8-0003xJ-PE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:18 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov1-0006gP-85
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:18 -0400
Received: by mail-io1-xd44.google.com with SMTP id
 ca18e2360f4ac-79fce245bf6so58295639f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376107; x=1696980907;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RUL9UFh0OlgtOXBBvW2u27+qW68S+nSgMNZp08Kprg=;
 b=MIEPzA6bXfD/+oHbgO2plhCsCiycdmq7xxiOJI/7vQMnxWb9UdnCIRss3k8z88+xdT
 d4Fh9TK6le1Zz6qvrRmT4i/uN3Yntc0LDJb1yWh/lnncuCHRIRzCuE+Ucvkz+iqIf6d4
 Fk1I2al0uGbmGdS3pSuJ4Ltz7OvtcsPMlMFEjPDi5FO/MqebyadSw5ME/60YfovOXtOY
 ie3xIRvwUTTkqBbnHgGtha15XwueM8h393PS8Vr9yuh4hBKuyYEM1wbcMUbU21k550XJ
 wP8hezLRG1tvYJLe/b6PZfiXMYVJIsJov+1EHamF67aJowXZQSp+pnO22cb359AWvGLp
 pSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376107; x=1696980907;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RUL9UFh0OlgtOXBBvW2u27+qW68S+nSgMNZp08Kprg=;
 b=eUkyPhjhpieg7tS/oRprBu4RlL/SxzteKQSz7uYtePeZP54g8R9YUVGDKtwUjrSh2O
 BS4ouLYk8IQEZKIqFzpqKqv1DRLxHRQkblGMkzQd59YFvLlEG5460abeHEV6FvDn4Nry
 ayG2u08zcHHGRQTgD00Ha6y/skmEVY0lQ3ElcKr6ehMBg7xQUPdTe84PA0L8WxO8ItDQ
 FKg3f2ABU8adLavMDDxcMs4AAJTmXdoorsjLUIeiu9C1sELx3GLOx+stBlZ+8kwNBGpK
 ztGlVATjRVNDrR0fm6jDHP+1q6sqQ8jlUzJzqAkPNNE2kF3SXA2bP0aMqZBDJMsDLnVs
 2dMw==
X-Gm-Message-State: AOJu0YxmKdZoKLPnm+Zo6tyxtHgJia8l0dFvibzbizcpAeAGEdEs0K00
 5TX4selOXvJAYNHDw92gFMio8aLgctizk6sO8B36VzL1
X-Google-Smtp-Source: AGHT+IG9+x06noMB8qRJsTYYPoDbSpnIcIM//pYmT3oy2BopVFTHfB4GS0//1r81b3rYcFaiinH0ZA==
X-Received: by 2002:a5e:a915:0:b0:794:eddf:daae with SMTP id
 c21-20020a5ea915000000b00794eddfdaaemr887440iod.12.1696376106850; 
 Tue, 03 Oct 2023 16:35:06 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>
Subject: [PULL 00/51] Bsd user mmap patches
Date: Tue,  3 Oct 2023 17:31:24 -0600
Message-ID: <20231003233215.95557-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d44;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd44.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit da1034094d375afe9e3d8ec8980550ea0f06f7e0:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2023-10-03 07:43:44 -0400)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu.git tags/bsd-user-mmap-pull-request

for you to fetch changes up to dfa1d915756b2d9d22946cbd7d2587f30cdcb7a3:

  bsd-user: Add stubs for vadvise(), sbrk() and sstk() (2023-10-03 17:14:07 -0600)

----------------------------------------------------------------
bsd-user mmap and exec branches from gsoc

This pull request represents the mmap and exec changes from Karim Taha
for his GSoC project.

They represent all the mmap and exec related system calls and get bsd-user to
the point that a dynamic hello-world works (at least for armv7).

There are a couple of patch check errors, but they are the lessor evil: I made
purposely bad style choices to ensure all the commits compiled (and i undid the
style choices in subsequent commits).

I pushed an earlier version to gitlab, and all but the riscv64 pipelines were
green.  Since bsd-user doesn't change anything related to ricsv64 (there's no
support in qemu-project repo, though we do have it in the bsd-user fork: coming
soon).

I think this is good to go.

https://gitlab.com/bsdimp/qemu.git

Warner
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmUcpC4ACgkQbBzRKH2w
EQDD9xAA3Rg0AnfnFrd+AoWRb/1/gOuO0v+dEGXj50qnGY8OmHeYtg3XecYPArBq
EicZzL/OG7UZKMl5OfrmGP9tbr32yfeRUTe3AGGHfmnSb11q0yeSaEFZI7felLHj
9nlq4H/2EDRrY+7EnG1TWqtnuqDJAJf/7M0giiVxIk77XGX+USUNPOSG4NP/yc8E
D5p2GN23pUsvnI0jBZkyP3gyeXVNCNG5+KobwqJM3r6OjEiTRmLEVBw98YzG12bh
OY9ekMtVUKHi4Cvsf+2TtkDGRya0wX4uqm4UB1TtV1VUDoCWhYgEKBHp3ozCoVjB
J+ygbx7/jNfY53cpgEpKUBFH7rnOq1yQQ+ad5Ap5hbp4j6WSvPwdp1N3RCnkZzd/
L50VIaySd+P6enAgPO5Mbt3kMMVd/eDGhQDWdzNToIjyhXBb5hUNfumg9AgdEwTh
rW/kKT39YLYWLO123hIJCy2CKU9nvoea9588ExkKb22v0ltrtDcAlWfCbZvZYxNN
wRzh+MFBt7Cd/bqk7HaJ0J/YyPToqImoUjNuBnBSDPqZQP2H4U8v/FoICQ0mm5kR
jZCmGLMEP1PiDlusjUjaW0iamHvXiSP8KEzaAbIxx5UUiTWTTkQm4CKY/xPxC9VQ
0ygJqJVrKHlNrAY9u6ggJAXtorVwmC55z4ZqIVQH6cbzUYFMuJU=
=WpL4
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Karim Taha (6):
  bsd-user: define TARGET_RFSPAWN for rfork to use vfork(2) semantics,
    and fix RLIM_INFINITY
  bsd-user: Implement get_filename_from_fd.
  bsd-user: Implement execve(2) and fexecve(2) system calls.
  bsd-user: Implement shm_open2(2) system call
  bsd-user: Add bsd-mem.c to meson.build
  bsd-user: Implment madvise(2) to match the linux-user implementation.

Kyle Evans (2):
  bsd-user: Get number of cpus.
  bsd-user: Implement shm_rename(2) system call

Stacey Son (42):
  bsd-user: Define procctl(2) related structs
  bsd-user: Implement host_to_target_siginfo.
  bsd-user: Add freebsd_exec_common and do_freebsd_procctl to qemu.h.
  bsd-user: add extern declarations for bsd-proc.c conversion functions
  bsd-user: Implement target_to_host_resource conversion function
  bsd-user: Implement target_to_host_rlim and host_to_target_rlim
    conversion.
  bsd-user: Implement host_to_target_rusage and host_to_target_wrusage.
  bsd-user: Implement host_to_target_waitstatus conversion.
  bsd-user: Implement getgroups(2) and setgroups(2) system calls.
  bsd-user: Implement umask(2), setlogin(2) and getlogin(2)
  bsd-user: Implement getrusage(2).
  bsd-user: Implement getrlimit(2) and setrlimit(2)
  bsd-user: Implement several get/set system calls:
  bsd-user: Implement get/set[resuid/resgid/sid] and issetugid.
  bsd-user: Add stubs for profil(2), ktrace(2), utrace(2) and ptrace(2).
  bsd-user: Implement getpriority(2) and setpriority(2).
  bsd-user: Implement freebsd_exec_common, used in implementing
    execve/fexecve.
  bsd-user: Implement procctl(2) along with necessary conversion
    functions.
  bsd-user: Implement wait4(2) and wait6(2) system calls.
  bsd-user: Implement setloginclass(2) and getloginclass(2) system
    calls.
  bsd-user: Implement pdgetpid(2) and the undocumented setugid.
  bsd-user: Implement fork(2) and vfork(2) system calls.
  bsd-user: Implement rfork(2) system call.
  bsd-user: Implement pdfork(2) system call.
  bsd-user: Implement struct target_ipc_perm
  bsd-user: Implement struct target_shmid_ds
  bsd-user: Declarations for ipc_perm and shmid_ds conversion functions
  bsd-user: Introduce freebsd/os-misc.h to the source tree
  bsd-user: Implement target_set_brk function in bsd-mem.c instead of
    os-syscall.c
  bsd-user: Implement ipc_perm conversion between host and target.
  bsd-user: Implement shmid_ds conversion between host and target.
  bsd-user: Introduce bsd-mem.h to the source tree
  bsd-user: Implement mmap(2) and munmap(2)
  bsd-user: Implement mprotect(2)
  bsd-user: Implement msync(2)
  bsd-user: Implement mlock(2), munlock(2), mlockall(2), munlockall(2),
    minherit(2)
  bsd-user: Implement mincore(2)
  bsd-user: Implement do_obreak function
  bsd-user: Implement shm_open(2)
  bsd-user: Implement shm_unlink(2) and shmget(2)
  bsd-user: Implement shmctl(2)
  bsd-user: Implement shmat(2) and shmdt(2)

Warner Losh (1):
  bsd-user: Add stubs for vadvise(), sbrk() and sstk()

 bsd-user/bsd-mem.c            | 104 ++++++++
 bsd-user/bsd-mem.h            | 452 ++++++++++++++++++++++++++++++++
 bsd-user/bsd-proc.c           | 145 ++++++++++
 bsd-user/bsd-proc.h           | 379 +++++++++++++++++++++++++++
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-misc.h    |  98 +++++++
 bsd-user/freebsd/os-proc.c    | 480 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-proc.h    | 293 +++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 313 +++++++++++++++++++++-
 bsd-user/main.c               |   2 +-
 bsd-user/meson.build          |   7 +
 bsd-user/mmap.c               |   2 +-
 bsd-user/qemu-bsd.h           |  58 ++++
 bsd-user/qemu.h               |   8 +
 bsd-user/signal-common.h      |   1 +
 bsd-user/signal.c             |   6 +
 bsd-user/syscall_defs.h       |  89 ++++++-
 17 files changed, 2428 insertions(+), 10 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/bsd-proc.c
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/freebsd/os-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.41.0


