Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB86C78BBA1
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalri-0003fG-SH; Mon, 28 Aug 2023 19:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrd-0003ek-89
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:46 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalra-0006fv-9C
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:44 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79216d8e2cfso124957939f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266099; x=1693870899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ytFotB4zxgoQ1vGu1NiBucJbf1o9vQIasBiDr1QOAnI=;
 b=5kB6ObKK2eza/c2RyWJ9gRUddkzAuhlN1osQZRFkDt9yQHNZERndpapgfKMHHzuguv
 UQuv861k4quX8omGj80chjmIrh1F6TwEJC/uu8AtsR3E06g2MXTaY/Tm/VbuN7c2uCWK
 rQ5MrLgOF2azSQQ0WKv0AjPWyPcuSva/H+bLOU/lZBpDXu1U4qSXSUD5qmD24G/26K1Q
 tbE1/+S/jAfIBxhTURvliMwAy+54q+Y4rfKXoLuTG5Cnj8LNx3wPXSQqzrEDg6+yxKGd
 3KW5Ey0FqN2jZBdhXnYppPCgDQxY14Z+X62B+dGN7582J1TDT30zggi1bFgfwAO4RXkK
 DsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266099; x=1693870899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytFotB4zxgoQ1vGu1NiBucJbf1o9vQIasBiDr1QOAnI=;
 b=luhw6LGkhx/2uCAWIFgpenH0h2lijJfmps02XQIpCGSJqfo5Sg31v9WsgphO0tbhNq
 6/E/E9X+lbdHMi5a5km7o7ADw6kQB2HrAe1/d3Qc8QWK/ra78oNvXegfTbodDA/rK0sB
 jr1B/kmKIBcKcZuDh+9bdMhCTsgYaeZiJJyhrThcCSPnuKG5uRD3zOxRX9IWX5X/T6Y+
 MvLXQRLqLbOonkVuINW09f2GwkHuhk+Ov9Ne2zwy3WhUr/wAtk/WXsFt/2NQ4TlcAdvx
 g1TruWN+7s3o/DAw3qKJ+L5QpWQ7cW/vH9lXNUWfxb+qPLmO+/y8mRGT11o66weI7p+r
 oS1Q==
X-Gm-Message-State: AOJu0Yz4WovV+9iy8MNEO+YRA/AghqmkHuz3nasq69asJ47omMj5mgNr
 wqJG71lBH1JLacs/wmiY8REn9nPXafmsQ3jJEuI=
X-Google-Smtp-Source: AGHT+IE69T7Ytiw7ciWPuC9d4Dqm8/xBbIxG4d3mgQAqVHFO7rbSMLwbyEIqSEtapjUx0VvthNzmbw==
X-Received: by 2002:a05:6e02:ee7:b0:349:3c0:395d with SMTP id
 j7-20020a056e020ee700b0034903c0395dmr16637382ilk.1.1693266099130; 
 Mon, 28 Aug 2023 16:41:39 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>
Subject: [PULL 00/36] 2023q3 bsd user patches
Date: Mon, 28 Aug 2023 17:37:45 -0600
Message-ID: <20230828233821.43074-1-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
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

The following changes since commit 50e7a40af372ee5931c99ef7390f5d3d6fbf6ec4:

  Merge tag 'pull-target-arm-20230824' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-08-24 10:08:33 -0400)

are available in the Git repository at:

  git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request

for you to fetch changes up to f51e7c41acb4b17d28fc74f9f10df50a4a65fbcc:

  bsd-user: Add missing break after do_bsd_preadv (2023-08-28 12:16:18 -0600)

----------------------------------------------------------------
Pull request for bsd-user 2023 Q3 (first batch)

First batch of commits submitted by my GSoC student Karim Taha

These implement	the stat, statfs, statfh and dirents system calls.

In addition, fix a missing break statment, and submit Richard Henderson's
elf stat mmap cleansup.
-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQIzBAABCgAdFiEEIDX4lLAKo898zeG3bBzRKH2wEQAFAmTtL6EACgkQbBzRKH2w
EQALHQ//WOoHYxpNS1hy+oYIAvjW0JOqz9gCSFR0d56mDBShm7WO/9FZA6eGAzYQ
i5kBSVFwEBlM76K5vLTbRvCbCbAwlpAdMgI7HXValjspNhvu/66DNWmdil6GnXKu
4QRaM/QGrobmYrNmf4SdgyjlMVH7wGyTrCTpXfvPfktZLAbQq7dCyNPTsOYXJP2V
LASk8j2gyW6fDi3z1AxTNVfS7BJX6DWMhPhlvC/aUOLVVGgj9Hw9uxPaKXC1t47D
bpZ+wJb4GMkcsmuiGJ40CXowjQ+M1lBrA4rN+lTMJNttZJ+TUYmizTFkYhX+B28h
Q2JZy5eLXlsxxRByOkOwFczfDT6jlG4BlK4jmDOvKlrTPLaWIHjezztTavWIZDlU
ce1oXQo3KEdWoa/QEsuxLeBbE+uZpu5+NqLeCk1cU4GPks8nbAcD7BGl6dDHKXM4
8vCcOMZLwO+xi5Etgcf/MtTPMpSO0rD9fTq2VSdYX0H197mkOdyCDAXjfKPsBUIE
VLAnCFfajMNRc5ITobEbz4GiMD/xy5s8eDZNeefG8lgySpl9XB2Lvw7SWDz1imsL
nBgQH6RHznU65wEvVGtnCGMj5kIMbohY2AGR75iGkRdgR+t2zMjUIiaU/qivD+6z
IEJ2jqDWqtQb81jFNrFzJlsim+GYRl0HcaEmyye2bgf5LHRSSNM=
=ORJ7
-----END PGP SIGNATURE-----

----------------------------------------------------------------

Karim Taha (1):
  bsd-user: Add os-stat.c to the build

Kyle Evans (2):
  bsd-user: Disable clang warnings
  bsd-user: Define safe_fcntl macro in bsd-user/syscall_defs.h

Michal Meloun (8):
  bsd-user: Add struct target_stat to bsd-user/syscall_defs.h
  bsd-user: Add struct target_statfs
  bsd-uesr: Implement h2t_freebsd_stat and h2t_freebsd_statfs functions
  bsd-user: Implement freebsd11 stat related syscalls
  bsd-user: Implement freebsd11 fstat and fhstat related syscalls
  bsd-user: Implement freebsd11 statfs related syscalls
  bsd-user: Implement freebsd11 getdirents related syscalls
  bsd-user: Implement freebsd11 netbsd stat related syscalls

Mikaël Urankar (1):
  bsd-user: Implement do_freebsd_realpathat syscall

Richard Henderson (3):
  bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
  bsd-user: Remove image_info.mmap
  bsd-user: Remove image_info.start_brk

Stacey Son (13):
  bsd-user: Declarations of h2t and t2h conversion functions.
  bsd-user: Add struct target_freebsd11_stat to bsd-user/syscall_defs
  bsd-user: Add structs target_freebsd11_{nstat,statfs}
  bsd-user: Add struct target_freebsd_fhandle and fcntl flags
  bsd-user: Implement h2t_freebsd11_stat h2t_freebsd_nstat
  bsd-user: Implement h2t_freebsd_fhandle t2h_freebsd_fhandle
  bsd-user: Implement h2t_freebds11_statfs
  bsd-user: Implement target_to_host_fcntl_cmd
  bsd-user: Implement stat related syscalls
  bsd-user: Implement statfh related syscalls
  bsd-user: Implement statfs related syscalls
  bsd-user: Implement getdents related syscalls
  bsd-user: Implement stat related syscalls

Warner Losh (8):
  bsd-user: Move _WANT_FREEBSD macros to include/qemu/osdep.h
  bsd-user; Update the definitions of __put_user and __get_user macros
  bsd-user: Rename target_freebsd_time_t to target_time_t
  bsd-user: Add glue for the freebsd11_stat syscalls
  bsd-user: Add glue for getfh and related syscalls
  bsd-user: Add glue for statfs related system calls
  bsd-user: Add getdents and fcntl related system calls
  bsd-user: Add missing break after do_bsd_preadv

 bsd-user/arm/target_arch_elf.h    |   1 -
 bsd-user/elfload.c                |   4 +-
 bsd-user/freebsd/meson.build      |   1 +
 bsd-user/freebsd/os-stat.c        | 262 ++++++++++++
 bsd-user/freebsd/os-stat.h        | 663 ++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c     | 122 +++++-
 bsd-user/freebsd/qemu-os.h        |  50 +++
 bsd-user/i386/target_arch_elf.h   |   1 -
 bsd-user/main.c                   |   2 -
 bsd-user/qemu.h                   |  85 ++--
 bsd-user/signal.c                 |   5 +-
 bsd-user/syscall_defs.h           | 221 +++++++++-
 bsd-user/x86_64/target_arch_elf.h |   1 -
 include/qemu/compiler.h           |  30 ++
 include/qemu/osdep.h              |  13 +
 15 files changed, 1384 insertions(+), 77 deletions(-)
 create mode 100644 bsd-user/freebsd/os-stat.c
 create mode 100644 bsd-user/freebsd/os-stat.h
 create mode 100644 bsd-user/freebsd/qemu-os.h

-- 
2.41.0


