Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98912799A95
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 21:39:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qf3mo-0005Z0-Tt; Sat, 09 Sep 2023 15:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mm-0005YT-VZ
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:28 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qf3mk-0003Bz-Lq
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 15:38:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401da71b7faso36634765e9.2
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694288304; x=1694893104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NH4nM2QU0axbBZlPsWjD+0kSETUxU7WtW1nIMzTrypY=;
 b=Qk8dMr8x/aDqL4Oj4gefZLtYfkw5aPGvMoeJeLuEKX6a6z40TxLFQ7sVefk3o7xZFP
 yQKKtUhqgWQ4cCTwc0T+i8wyM0QwQ2a6szntuAaVoOtuZ9tChZDaJ3FSCtY1YmhadxvR
 jP3Dm7ItOXL7BLDZnZTzsXBqBiCHUd87JX9gAhdJDtOK9U77s3xJTAFFG4eKCHfy3Mqb
 FQc/58UXQNWRe0CDVB4ZexTxz3v81Xf2Iavd5PNnlZ7Th2Im2s81jmCqlhC4r+kzVuts
 NFOPRX5eQ5uHi5M3gPAP9qHBp0X/rhuEAGB2ShSmyzPILGoQayp6luqaJvva53pUjBSv
 dajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694288304; x=1694893104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NH4nM2QU0axbBZlPsWjD+0kSETUxU7WtW1nIMzTrypY=;
 b=TB4kE6LmNNVpkzx8QpqW5DKivBx6Fc5rq+zzPPG0fu9Woq8mi3lBH9hStOfv6zfkCb
 ria1Q/ZikNyd3zC2m/C4J9qfKYyUcGxIwoXRbAqEm26rhmCuPTbaK5dQ913WFWkTZtaa
 7x2c13sgArZlSH9/5gfoocbl9rN+J7Aa0GtkVI/cdbskMkfM5G1jrpMgg1lf63QvuMaH
 JxpABnUQMTHs+HcmjSO1Jy+cgUgd6h7uFGEHhq4acCAm5Sx700trZCYz/4Ixxboof1Ey
 BHiJI/E+2n3gvjngSV9dI4qVZUAMW7nvT8IjSS6c5GkGI7/KUda+xZNwgbfWqoVStotF
 ggAQ==
X-Gm-Message-State: AOJu0YwWKwYE7/qTBDNiTm9f8kix4m/N+z1ZjaolYfVrcCgs+7yMaR6y
 jHG5JmqjIuzsDBvrtUFeIi4HYwWfar8=
X-Google-Smtp-Source: AGHT+IGxFTxXljtDGv++LBAbI3/qfD8TGseCapNbGNc5W2hamo68Z5PVAoPbkOfGU+2KkG401afzDw==
X-Received: by 2002:a05:600c:3782:b0:3fe:19cf:93c9 with SMTP id
 o2-20020a05600c378200b003fe19cf93c9mr5069508wmr.1.1694288304104; 
 Sat, 09 Sep 2023 12:38:24 -0700 (PDT)
Received: from karim.my.domain ([197.39.250.27])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a05600c260d00b003fe4ca8decdsm8612812wma.31.2023.09.09.12.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 12:38:23 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 00/23] bsd-user: Implement mmap related system calls for
 FreeBSD.
Date: Sat,  9 Sep 2023 22:36:41 +0300
Message-ID: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x333.google.com
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

Karim Taha (2):
  bsd-user: Add bsd-mem.c to meson.build
  bsd-user: Implment madvise(2) to match the linux-user implementation.

Kyle Evans (2):
  bsd-user: Implement shm_open2(2) system call
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

 bsd-user/bsd-mem.c            | 100 ++++++++
 bsd-user/bsd-mem.h            | 440 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-misc.h    |  94 ++++++++
 bsd-user/freebsd/os-syscall.c | 112 ++++++++-
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  45 ++++
 bsd-user/syscall_defs.h       |  39 +++
 7 files changed, 827 insertions(+), 4 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


