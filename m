Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B35987ADF18
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:37:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqK3-0007ze-5e; Mon, 25 Sep 2023 14:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJx-0007rJ-S8
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqJv-0007ik-I1
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:28:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3200bc30666so5973755f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666512; x=1696271312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5aGLz8oBnOZPN5J2PkFZqC2aseft3FksbBB5k0tP8yQ=;
 b=CKZraKwsvBkCZGF9j/SSdzPaoIS3jdyM6VbCFduTP5sHxU2Z7B3g4uLr0ipStWXSTd
 Dp9qIVhyWWALER8c4oJqiFWFj+TEqKNqVN2nMrNp+aFaq51FXBIoJTMPdy2h4PkleZkX
 jqGrd4qkUkPPXJol8H0gL+QXfBZ/mx4dMYmxDVjxQspI6mZhkceKbYUXWr7VBSZOqjMg
 IkGg5yXe6ddB018ahGKPSUvWstTJVwN2MumxxlKsK7SO3FDCyv6a4XWH2MjanTpNzdLu
 qB+aCM8vDOxKSRJvjas8lEzjneMFct182Mn2A8I/hEj0V04KW4mQDt8iJ7efvueYpqCR
 6VVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666512; x=1696271312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5aGLz8oBnOZPN5J2PkFZqC2aseft3FksbBB5k0tP8yQ=;
 b=V666vNeXAza64i95mKGUxxKD/LlCRPg8rs5tszTVirVcP0yakZ71Jsuk4yI6jk4XY0
 VwXNK3MJBi/lciDYVfCgGqgZeoepTXu6Fz/NioiGx+5ZCroKZKSMwUL42gvMHNALH3++
 RLfteR+cI+4J6wCFrRMpx5VK5nfsFqfhVlI9nMVLWhwHo4rM8+Xz+sTyrdz4al4W8czF
 b4fAYkaAHjk8XTWpQqP+F1Xb8fdt8pEHeJvlv4wYQx+bb6Uwx1j4Em7BrP/14VzYWI43
 I3BqpYHwabeqHiYgZXcRG97aB7LRXa9iXhBDr8IutZO0KdVyUDZRunMkQLwXiTLXZof4
 P7hw==
X-Gm-Message-State: AOJu0Yxh8vfzIbjR0id6CAfT/CU2obcUCbEawmKcvf09WBsT5+y4pOPY
 9bYSco14E/CNwZa7+UxUhhRbZ5YFm4c=
X-Google-Smtp-Source: AGHT+IHiQljDaPpvyl81SPeteZx5Vu0XPYXDMYK/ouK62zmqFgG0XaDEORdfjEye43YMv7huVomXyg==
X-Received: by 2002:adf:fdc8:0:b0:31c:6420:ff4 with SMTP id
 i8-20020adffdc8000000b0031c64200ff4mr6496986wrs.36.1695666512530; 
 Mon, 25 Sep 2023 11:28:32 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 u21-20020adfa195000000b00323293bd023sm3412320wru.6.2023.09.25.11.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:28:32 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v6 00/23] bsd-user: Implement mmap related system calls for
 FreeBSD.
Date: Mon, 25 Sep 2023 21:26:46 +0300
Message-ID: <20230925182709.4834-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x435.google.com
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


