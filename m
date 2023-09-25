Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 360617ADEE2
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 20:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkqHP-0001Ag-MY; Mon, 25 Sep 2023 14:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHL-00019z-GQ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:55 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkqHJ-0007Ge-Ml
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 14:25:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-405524e6768so48209105e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695666351; x=1696271151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hAahT6/AS5hONO5jfp+ozBHXd8QT6oPJXEKeqLcEc8=;
 b=hRcrDfu+Hb/umbzAteoFpihKxfk8CP8MjWJKMbSc/Agt31QGpvFGOscD5zQums+nqT
 fQrvOg/jTVaHOQSk2umIqeJP1zn743Le2yIWedORMkX/PtWGmhnnSphUIvsQ0mHCGS1B
 13ZsHnjHlR631SPVtXMjS3/JhvJyxiCPam0+Lo+JBEUTKfIQ/cf3e4VGMKL9J9T1zTJA
 yh/8T3plYcFvf29viL61uc9ZREetXtDdVhanclM0tBkWofyB9rom5RjzPwsIjTvWA+MG
 60AGPn7xMjPVHCDnfmZjZ4KICbKblC0v3z/OKNOOxcqycpOj+5SBGL0WrwBxWPlcHUeW
 c4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695666351; x=1696271151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hAahT6/AS5hONO5jfp+ozBHXd8QT6oPJXEKeqLcEc8=;
 b=dBO/VlXtv0csdglaf/f0Z7/LO16suvkIsCJ/mLlNa1fUvXLvoQBg16etuCHozqrQUZ
 zNlaxSI8lX0z+ccJ2/MZSq8zeLBh8fzqM+w4twoaeSE8H86/I8fbSEIABkrC7sTJpg1k
 fNmxfe0n2KXsogv+LLPZjIyKyRr+Cgs/RcQYoldBZCYW7ZzC+BzjSKqRU6OGX711TsmC
 e7L/HBGJdyIXUiwUb71/nAuzhxtVXSXQlgv3J3ycWULiW7xXEQc0b0dGyLNRfsYwjc1I
 fRMeXzn2MI6Slyzt0F/tAhFMdd8xdZYbqT8HILiMujBazn4t2YW/HFT92Fse4Tg7dagm
 RrnA==
X-Gm-Message-State: AOJu0YzkzttOSiiYCf0hljdbQcOLUsOBsPwQJ8DWIFQ0gy2FJEP9yjjH
 03XyGQnJF7L1Hbfxy/ygb7GidvurBok=
X-Google-Smtp-Source: AGHT+IEunHBMRFWPNNVABiiL1wkKEfwXM8R1MYOm1HSZlv+yIa5Hh6VsLkx3g0LQaSPr21rrg445YQ==
X-Received: by 2002:a1c:7406:0:b0:3ff:233f:2cfb with SMTP id
 p6-20020a1c7406000000b003ff233f2cfbmr6526915wmc.23.1695666351126; 
 Mon, 25 Sep 2023 11:25:51 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c229300b00405953973c3sm2232858wmf.6.2023.09.25.11.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 11:25:50 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 00/28] bsd-user: Implement freebsd process related system
 calls.
Date: Mon, 25 Sep 2023 21:23:57 +0300
Message-ID: <20230925182425.3163-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
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



Karim Taha (3):
  bsd-user: define TARGET_RFSPAWN for rfork to use vfork(2) semantics,
    and fix RLIM_INFINITY
  bsd-user: Implement get_filename_from_fd.
  bsd-user: Implement execve(2) and fexecve(2) system calls.

Kyle Evans (1):
  bsd-user: Get number of cpus.

Stacey Son (24):
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

 bsd-user/bsd-proc.c           | 145 ++++++++++
 bsd-user/bsd-proc.h           | 379 +++++++++++++++++++++++++++
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-proc.c    | 479 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-proc.h    | 293 +++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 206 ++++++++++++++-
 bsd-user/main.c               |   2 +-
 bsd-user/meson.build          |   6 +
 bsd-user/qemu-bsd.h           |  38 +++
 bsd-user/qemu.h               |   7 +
 bsd-user/signal-common.h      |   1 +
 bsd-user/signal.c             |   6 +
 bsd-user/syscall_defs.h       |  50 +++-
 13 files changed, 1607 insertions(+), 6 deletions(-)
 create mode 100644 bsd-user/bsd-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


