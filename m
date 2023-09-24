Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42B7ACE49
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 04:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkbSf-0003Dc-4d; Sun, 24 Sep 2023 22:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSd-0003Au-0w
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qkbSY-0008UN-LU
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 22:36:34 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4053c6f0e50so45859845e9.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 19:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695609388; x=1696214188; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2hAahT6/AS5hONO5jfp+ozBHXd8QT6oPJXEKeqLcEc8=;
 b=WgGr2TUVX/sfq+33E12cN5AeqTY5aG0o/JfmXite6eeLW7D2kzOa6R0VYQaidyKlZq
 zLcSfUmhULv246ADxRFhPzg6G6v1LjMDAeMX7vpZHs0ivAwHK1vt7/SI763DuHJGNcgA
 L6LcioYUj7CwPyGDz4BXZdVcoRsvRGKYgWXOuWup8M8cmqzYpy2COlCnAVxg09NenUHi
 kGR6pvp7wXpNRQeefJrj/21laAWj+aug9tgQx9J7sfoJRnr1rtJUfYkEOEM45CFeDBMH
 p4bmLabYpnLwFYdeBlfU8YZpdZar4hYksNRbAFpYm1Fr9vCXtDQUaUr4KYwzuE6iIAt1
 qVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695609388; x=1696214188;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2hAahT6/AS5hONO5jfp+ozBHXd8QT6oPJXEKeqLcEc8=;
 b=WHmFcpT0dgKUcPIVI6Zr/65KSeg+PAL/3fUVn3Tyam24A5Ds6fjdZsiwD/lMS3C54k
 3VxhwOrrk+QvYMgcHaRcCM/gBf+qBIFkfaAFTaODT9d3MrT0Rknd0hi3GW1ey5KMo4Rx
 M+d11dxb5XXWuBK30/qWtQ0jIvFbQ7/yLKOmHeGP3D5moWHeUJBCvY+tJ4uO1urMxQPH
 twFqL+ZD1V7lQ9qcOxuB7Ner0BwCWVxWm3hjEs5XeISuLEWyehLoPGgqHKZAXuFdnsFF
 K7Ey55immpYuuWmg7voQ4aFn/RGc5NKkXAiAtCP/40oXOlxTrlM9kksy2/tv0OuDfsrm
 AIrg==
X-Gm-Message-State: AOJu0YyEJpX4xGqP6HBmN9Q2K/PaTsuGxS160jZvYYTyX8LvlqWmcVX+
 S8eSIJBeGTzymHnkZOAvBI+ZItF5+pw=
X-Google-Smtp-Source: AGHT+IErUmX9IncJxo9xhkTerf5D+sp8Y/ys7n5NzT5VqstOCqedOFUJMYnK/C48SZ3mZRi6yTtU7w==
X-Received: by 2002:a05:6000:1b04:b0:317:5d3d:c9df with SMTP id
 f4-20020a0560001b0400b003175d3dc9dfmr5022816wrz.18.1695609387869; 
 Sun, 24 Sep 2023 19:36:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.209.18])
 by smtp.gmail.com with ESMTPSA id
 s28-20020adfa29c000000b003232f167df5sm1683wra.108.2023.09.24.19.36.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 19:36:27 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v4 00/28] bsd-user: Implement freebsd process related system
 calls.
Date: Mon, 25 Sep 2023 00:01:08 +0300
Message-ID: <20230924210136.11966-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
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


