Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7207A0F1D
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAb-00037l-1J; Thu, 14 Sep 2023 16:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAW-000377-PI
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:32 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAU-0006FQ-Nb
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:32 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-404539209ffso11639655e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724147; x=1695328947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5aGLz8oBnOZPN5J2PkFZqC2aseft3FksbBB5k0tP8yQ=;
 b=sAejkxIbu9V2ZLcoK5hd1M4v6Jlzyzxg5T0wOVaO0DDRSxNnx3bfOc+UCAFV7wgfv0
 tG/wRIg4MCajmT1XJ2pIPE6LvFrPQ3phxm4DzWeFJ1QvCcsec+W9A/3m8YL0afBpCnb8
 idRMmdEbALpdlHMFQzPR8MpF2Qy9xlO3sQBdOmbftBv2D+Tb8Aru8WhT0X7BhM1zQPG7
 r8DTRcS0wIWd79XOc6Sh3LgLFF23c60jW7+OQ6cDSlMjTgoieTTj75dlONiTdX0yEyaM
 hqF9KlCN3WZwzfE7YzsbIMwftWbu7M4lJBT3SIZCfLpAogJkdJk/nrFC2WQgHLUTaPSG
 13uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724147; x=1695328947;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aGLz8oBnOZPN5J2PkFZqC2aseft3FksbBB5k0tP8yQ=;
 b=wLiZLU0efursoq+Z0Npusz4NTJEidJjlEKjUoDwgvv362KidIEes6OVUzy8fz+rMfD
 iQ5cHaTRen7lJF/jF9fl0187av05LndVQTCadrxawSzkhBvqTwT2a3RadEfv7Q9JPlGZ
 L9RbajcarMFjZ8OOr0LisEkSrRcIY03D3o8Y+WcvQcc9gZefD8ypMTppxGBC97I9BB4J
 Qyti71sHaG0nUa6RCyg8DH82V1Pui5QYghZxB5hw2H44Mi2XSt4dQa/JcMEqRTM0UU7T
 02bC/bLHYLhvW4sKZos8+221GjjnLroZmAAaSS2rKpsYmQjTZNT/Yc99J5+9LDpNqnIa
 BMHw==
X-Gm-Message-State: AOJu0Yx/SH5nP7plVQbHl3Q1uzRmm3JDkUqIAL6uXSAlZhRdb5Abp/fy
 GJzeCejRw8OS4RpoZhIf7MEm9jLGgdE=
X-Google-Smtp-Source: AGHT+IHix5l8+f8GL2xPEzLsahKXQ/T9sz9r6SN2S+hYFsSwWc3SM8/a0QuVloOlrKPQC+JBLdKh8Q==
X-Received: by 2002:a5d:538f:0:b0:317:51da:83b9 with SMTP id
 d15-20020a5d538f000000b0031751da83b9mr5662652wrv.49.1694724147137; 
 Thu, 14 Sep 2023 13:42:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 00/23] bsd-user: Implement mmap related system calls for
 FreeBSD.
Date: Thu, 14 Sep 2023 23:40:44 +0300
Message-ID: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Upstream the implementation of the following mmap system calls, from the
qemu-bsd-user fork:
   mmap(2), munmap(2),
   mprotect(2),
   msync(2),
   mlock(2), munlock(2), mlockall(2), munlockall(2), mincore(2),
   madvise(2),
   minherit(2),
   shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmget(2), shmctl(2), shmat(2),
   shmdt(2)
   brk(2)

Karim Taha (3):
  bsd-user: Implement shm_open2(2) system call
  bsd-user: Add bsd-mem.c to meson.build
  bsd-user: Implment madvise(2) to match the linux-user implementation.

Kyle Evans (1):
  bsd-user: Implement shm_rename(2) system call

Stacey Son (18):
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
 bsd-user/bsd-mem.h            | 452 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-misc.h    |  94 +++++++
 bsd-user/freebsd/os-syscall.c | 109 +++++++-
 bsd-user/meson.build          |   1 +
 bsd-user/mmap.c               |   2 +-
 bsd-user/qemu-bsd.h           |  45 ++++
 bsd-user/qemu.h               |   1 +
 bsd-user/syscall_defs.h       |  39 +++
 9 files changed, 842 insertions(+), 5 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


