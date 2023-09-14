Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAB27A0EBD
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgsZQ-0002r2-Hn; Thu, 14 Sep 2023 16:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZN-0002qk-50
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:09 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgsZL-0001SR-E3
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:04:08 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-401ec23be82so14382655e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694721845; x=1695326645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=11WTvmdgwwMkXwm1odvb/AW2+t/eSrG4IN0OwJQKhwI=;
 b=Af845UEfAGBFRZJ/sV/RPDFl/1+D29Owq+8oetPNOyrTXIp88ugIdZtaNFOT9ulhaj
 gIXDzFcWJhtVVnUmTgYhqvFk9DeXpZ0sjt7aji9GaGrtXS/cUNVJWSPAm0pdfToUxauW
 Q94gf3cbLC/fFPr0LKUEzfkEjsil1MHAwOOb1mouFqfBWacNqlWEKdKu4VvBU/Wj9+qn
 tcBCcZzx4gUvzztKPASICIFkhsA3Uv/bNPVLGPpi3clKug2SBYr00rwQGtWveQskgm+y
 iemVA6vU6tc/ppVFF19+NRxQaZwr2PsdEScUsX9nZX8U1lvW3ASroHmtjXEjOZvvZC1Q
 gREw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694721845; x=1695326645;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11WTvmdgwwMkXwm1odvb/AW2+t/eSrG4IN0OwJQKhwI=;
 b=vkjs+J9l56mcD3Ia6TRuCb/3TVInmUpojJC2UDt9zCqE/5ynHdtqyMHtpVrnUsTp1i
 A+LU3rYuh5I3GALMmWPh3pffYCn7zIytKUhHl5sa5BQwWo40r8/kHNIjqJAhv8NGolRf
 MRUqEbx7nBmPTsEe8Tq3d1CYpSeECUaA79XLkbVWCgcPCAVUg71WbTyD/zca49vuSXGn
 Vh0ZIYXjW1elIpiMUsBpwiHQdGzX9cWfKWvzpG8hxUEiLCUK7KdZgwF9ahTvZbxA1fhR
 f7q4mRZkQeJrRMqFmYgc95cvfOPcAJjQ/bOoh4QaVqLdJ7KlxYyn0CWsr6WBEEqKCOxQ
 u6Qg==
X-Gm-Message-State: AOJu0Yy83arCkAoLMzxV2QQQ0elAtpw9h726Tc/bKUYyeKmXCFEHVtEm
 FClofSQo/vt+tbQDl0HFIx8+6LnTGgE=
X-Google-Smtp-Source: AGHT+IEec49f7D2MkITgU2TksoG46XxbWdGtdy1Y41cxjHLFU7pSzOVZ5ZrWTUBWD2klg1arLYVX2g==
X-Received: by 2002:a05:600c:2611:b0:3fb:b5c0:a079 with SMTP id
 h17-20020a05600c261100b003fbb5c0a079mr5671881wma.21.1694721845395; 
 Thu, 14 Sep 2023 13:04:05 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b00402bda974ddsm2851130wmk.6.2023.09.14.13.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:04:04 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 00/23] bsd-user: Implement mmap related system calls for
 FreeBSD.
Date: Thu, 14 Sep 2023 23:02:19 +0300
Message-ID: <20230914200242.20148-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32c.google.com
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

 bsd-user/bsd-mem.c            | 104 ++++++++
 bsd-user/bsd-mem.h            | 452 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-misc.h    |  94 +++++++
 bsd-user/freebsd/os-syscall.c | 112 ++++++++-
 bsd-user/meson.build          |   1 +
 bsd-user/mmap.c               |   2 +-
 bsd-user/qemu-bsd.h           |  45 ++++
 bsd-user/qemu.h               |   1 +
 bsd-user/syscall_defs.h       |  39 +++
 9 files changed, 845 insertions(+), 5 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


