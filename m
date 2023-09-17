Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD4D7A3E81
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 00:27:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi0Bb-0006SK-P5; Sun, 17 Sep 2023 18:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BX-0006RV-L9
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:11 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qi0BV-0002tK-Ee
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 18:24:10 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso3695434f8f.0
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694989447; x=1695594247; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8CkTawIAHKcNROsQeg+oZvvojFPdKNuju/1K0TLyts=;
 b=PHfYN1OjJT50hcK1fh8zvBYOT+vc+GNMyzN/akIZpXNUGH0fypDIC7Kh1f3eEKLFah
 sN2AB4h6TY4mLlWlSm3aJVPsuvUpxc2WSrNrGI4dIgwCtFZqHHi+2BPTj7OU9xxMiktA
 PGZ/yIAU3KZM1JJ7+SeMxTaIfN71QqiWv2+ZctY9RVe87eb6rtVRp8tS5wvrd6S7sn2m
 yd2z2tgZhcQ7plbMHYw3mzNi5hF+NCMHIaHelTZv9DzFMULcM7PowV4W20SZT2fe0nwV
 fJgkK0/cTK3IrOKPJzSMbs74Z3qlOQSD6Uwc7Lotpr7F9rZmD3MOtu52G5MXClSrFLPS
 gZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694989447; x=1695594247;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8CkTawIAHKcNROsQeg+oZvvojFPdKNuju/1K0TLyts=;
 b=iGRdPEsjBoggnLjbWLgPgQ3e4kf+dg8GhLwkbTLjVecE5ETuliWBg2mYaipI+PqQvt
 0jpN8bC43trGvb0zexqRUc1/3S3L3E6oofSFbGIK0BdcVT/CuXb+/u1hyR/eweOmlEhl
 yoL5MMk7BrXwAKgan0la5SodtcDQKNoQkoYHJ99Cw6NKwsYvdbiSHfVl4gs10FivdOv2
 ucEtD7NX3nI6ZiouXe3lRTKRrKJvUAhaAGsxGkqE7FIvZLTYUPbJYlLY9wm+lMw25Ajz
 pJl4PDb4eHMQwk2I2uW+1U/p9r1x4kLUshi0bi6oNavpX4R/kK0tMrKo93DyUUX1oBwq
 Evdw==
X-Gm-Message-State: AOJu0YwegYUExU+FpwlPjKUpD7MSuny39lCoya+bp0dKHzV4gegFo7is
 QdUkN12oEb01tjSsepkaLBZKgZmxvTY=
X-Google-Smtp-Source: AGHT+IE1EnpkLFn1DXDXCvXzth0jB3X2gt8yoJlA8J8T852FSBW7e1bptnRi09FC7/WLlakpz2cGnA==
X-Received: by 2002:adf:f782:0:b0:317:e766:d5e9 with SMTP id
 q2-20020adff782000000b00317e766d5e9mr6272048wrp.3.1694989447252; 
 Sun, 17 Sep 2023 15:24:07 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 f7-20020adff987000000b0031c8a43712asm10652527wrr.69.2023.09.17.15.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 15:24:06 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 00/28] bsd-user: Implement freebsd process related system
 calls.
Date: Mon, 18 Sep 2023 01:22:17 +0300
Message-ID: <20230917222246.1921-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
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

 bsd-user/bsd-proc.c           | 144 ++++++++++
 bsd-user/bsd-proc.h           | 379 +++++++++++++++++++++++++++
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-proc.c    | 480 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-proc.h    | 286 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 206 ++++++++++++++-
 bsd-user/main.c               |   2 +-
 bsd-user/meson.build          |   6 +
 bsd-user/qemu-bsd.h           |  38 +++
 bsd-user/qemu.h               |   7 +
 bsd-user/signal-common.h      |   1 +
 bsd-user/signal.c             |   6 +
 bsd-user/syscall_defs.h       |  50 +++-
 13 files changed, 1600 insertions(+), 6 deletions(-)
 create mode 100644 bsd-user/bsd-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.42.0


