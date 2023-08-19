Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D17818AE
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 11:51:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXIZr-00083S-Hx; Sat, 19 Aug 2023 05:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZK-0007sC-Qu
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qXIZD-0004Ew-Ax
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 05:48:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so1526526f8f.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692438499; x=1693043299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gIOzCwpT0OWMG+AqDQshzp0/M+4VUxUbsyCbQU3Vczo=;
 b=OSRNt7jA2EUchSU73znQOH6FpQw57Muuz47zd9n0lvqjB1V5LFwmx1d6nmBHLWcxoD
 E1kEka4zQBQ5h6WxAZd7Tf7D4o2utK44O2zeE/llO9VHIE94KN1CWH7PnktNF9DLEWwW
 puGTQNW6l2HI/Rsshxke6tqVDnZ3ZM/KxnGdimhWI5w1l89Cf5Tc5TGGHIJepj0yIZdg
 WXjWWZ1enD0xHhLC44qjaDrBZA3I8t9mbK/0NXjvp5NgHdTvMGO7R5aegsZdSz2SlewL
 gz+Qz9YM8MmjRQetRz7BGCJnEWorFAcU9oEcX0Kv8h04oZJWB257ZloyVdYA7KTegO+5
 q3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692438499; x=1693043299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gIOzCwpT0OWMG+AqDQshzp0/M+4VUxUbsyCbQU3Vczo=;
 b=GEXZePdv94mfhiDW6OEovX+CZKkU3htLnqPWymN0fC9/sdRn2llIl1+zscIQZhEC2p
 j/Bzvp1MNFxtTZCcRE4jY3mAWWleZDPCReu43Sr8+PXTxWpIIlHjkl/YLpiJ1PoCZNzC
 PzVreXGmW3fejRQqKSW/TCn00yZ6bkyVVQ7Un0mN55uIBK0Og+U2FzhDlv3I+7FvmQ1v
 whdO1hwsYFVpJwK8f6NAa7fOvg8bn8USOP3w4xbrRgbTmu6Jv9U7tn5IzolGBd/hrtVb
 D1moFkJJxATq2c+IIYEeVRLs3DELeocyeyqcGy/gp8XHfEv3R+1cTvQ+3ootY5NPRFBy
 f/iw==
X-Gm-Message-State: AOJu0Yz0v/mqGyDV7rOJ/t758ym6ORXlcrKwiqHg/vwiErViqrs1r9/r
 tY37YiOI/hMgBTkVppJEuPuzmsLCzRQ=
X-Google-Smtp-Source: AGHT+IFWn8fT9Y9mQXmBGfkjburZjC7aKgxExSn8/NNj95bLKhMWe5wtjsvZJMS0A7OP4wlpsNrNnA==
X-Received: by 2002:adf:fed1:0:b0:317:5747:b955 with SMTP id
 q17-20020adffed1000000b003175747b955mr1190528wrs.17.1692438499089; 
 Sat, 19 Aug 2023 02:48:19 -0700 (PDT)
Received: from karim.my.domain ([197.39.34.171])
 by smtp.gmail.com with ESMTPSA id
 o18-20020adfead2000000b003143b14848dsm5617216wrn.102.2023.08.19.02.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 02:48:18 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 00/22] Implement the mmap system call for FreeBSD.
Date: Sat, 19 Aug 2023 11:47:44 +0200
Message-Id: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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
   mmap(2), munmap(2), mprotect(2), msync(2), mlock(2), munlock(2), mlockall(2)
   munlockall(2), madvise(2), minherit(2), mincore(2),
   shm_open(2),shm_open2(2), shm_rename2(2), shm_unlink(2), shmget(2), shmctl(2), shmat(2),
   shmdt(2)

Karim Taha (1):
  Add bsd-mem.c to meson.build

Kyle Evans (2):
  Implement shm_open2(2) system call
  Implement shm_rename(2) system call

Stacey Son (19):
  Implement struct target_ipc_perm
  Implement struct target_shmid_ds
  Declarations for ipc_perm and shmid_ds conversion functions
  Introduce freebsd/os-misc.h to the source tree
  Implement target_set_brk function in bsd-mem.c instead of os-syscall.c
  Implement ipc_perm conversion between host and target.
  Implement shmid_ds conversion between host and target.
  Introduce bsd-mem.h to the source tree
  Implement mmap(2) and munmap(2)
  Implement mprotect(2)
  Implement msync(2)
  Implement mlock(2), munlock(2), mlockall(2), munlockall(2),
    madvise(2), minherit(2)
  Implement mincore(2)
  Implement do_obreak function
  Implement shm_open(2)
  Implement shm_unlink(2) and shmget(2)
  Implement shmctl(2)
  Implement shmat(2) and shmdt(2)
  Add stubs for vadvise(), sbrk() and sstk()

 bsd-user/bsd-mem.c            | 125 ++++++++++
 bsd-user/bsd-mem.h            | 431 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-misc.h    | 104 ++++++++
 bsd-user/freebsd/os-syscall.c | 112 ++++++++-
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  45 ++++
 bsd-user/syscall_defs.h       |  37 +++
 7 files changed, 851 insertions(+), 4 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.40.0


