Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEC799647
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 06:36:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qepfA-0000xL-Ck; Sat, 09 Sep 2023 00:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf7-0000xA-UO
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qepf5-0002v5-KO
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 00:33:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so28942985e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 21:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694234014; x=1694838814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YM7N/kYX2kO7QKHFJH5IBsi6zNuP+q51bHDN9/Iqf6c=;
 b=R4npo2LWkIEWaybZd/vX51Zby6ZaZTmX8U9Kkk/u9MIsVDuNeHOeGl/Wmiak5OeCHC
 J75yd6DJ58xm/2iT4oQVSyYNBjPn5MxxfnUIdECr1yKz8lcYXVthSsLCwQeeuQ/HAqpi
 9G27ht9gyn6JEl4Gqy564qUIo+0dfJf9h9xA6WyCI7D5+0+MQJZ52CT6UVOnO6E/v5qi
 2ABohkJ1RLegINk0meakkDgMc/HHT9xbBshYKJXhbSIPwGQN6E2Y4EVjoXggSMqGhKVt
 E7/fuqCxjMnaH9IcJ1OAcSIsLMYaP1PhBHRzrXpEbbjeIS9UWIhO6AJWCTP/J25K4mtQ
 DYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694234014; x=1694838814;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YM7N/kYX2kO7QKHFJH5IBsi6zNuP+q51bHDN9/Iqf6c=;
 b=O8KHbCr9kl8O3Mi3XUdWMq3h5bvidUofF+a9W7fqWaMRg10rX/tgKmu5E5QACB6vy/
 IY7H5U6j9OA6beU/fkBo9Q022pZohajKbLLaOm5YtZsh/wWajyC4FdyzoNACJ0xgxBiX
 pElBt/xmVBI1tthNYZ2e8OexAoGjaGvOcxDerzMhAOVfpKc4+UJYls+ZTrFLPh82FFb7
 d96aHx3kr8Z5N7zaolCmiTRMzNX5yHpfchRjeHcZKGCKj0JdKeewzflOy2CXyOT0T9+3
 7PhhfkiHWhAMfxb22lURsn7ZRiz03WGSzSuUJXuT3qlAwj6xV6BJ7BlshBy8UMVQvNO8
 0FsA==
X-Gm-Message-State: AOJu0YxW07SuWpA2CNSbtMWf2DQPwx+uO0vJCbw3diXfQKHBIh2Jw6I/
 YMChVmacGOYapZg7HyzV5IweOcW/l/g=
X-Google-Smtp-Source: AGHT+IHKp6LnKZxLvPm2qwO1KfKIMwgYKniGHUQD5YoTl4+rMj9p69XYXQQzLv/EHDercAXD2tYelA==
X-Received: by 2002:a5d:5103:0:b0:319:731f:748c with SMTP id
 s3-20020a5d5103000000b00319731f748cmr3271963wrt.34.1694234013672; 
 Fri, 08 Sep 2023 21:33:33 -0700 (PDT)
Received: from karim.my.domain ([197.39.120.250])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adff2d0000000b0031981c500aasm3615102wrp.25.2023.09.08.21.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 21:33:33 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 00/23] bsd-user: Implement mmap related system calls for
 FreeBSD.
Date: Thu,  7 Sep 2023 09:42:39 +0200
Message-ID: <20230907074302.79234-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 bsd-user/bsd-mem.h            | 434 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-misc.h    |  94 ++++++++
 bsd-user/freebsd/os-syscall.c | 112 ++++++++-
 bsd-user/meson.build          |   1 +
 bsd-user/qemu-bsd.h           |  45 ++++
 bsd-user/syscall_defs.h       |  39 +++
 7 files changed, 821 insertions(+), 4 deletions(-)
 create mode 100644 bsd-user/bsd-mem.c
 create mode 100644 bsd-user/bsd-mem.h
 create mode 100644 bsd-user/freebsd/os-misc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


