Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E67A3DEB
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 23:40:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhzUM-0004Rc-8Z; Sun, 17 Sep 2023 17:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUK-0004RD-IM
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:32 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qhzUI-0004EM-Du
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 17:39:31 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31f737b8b69so3715763f8f.3
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1694986767; x=1695591567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o8CkTawIAHKcNROsQeg+oZvvojFPdKNuju/1K0TLyts=;
 b=QmB4y2bdz6IAUEFSu+Lrk518nV38AR/e7KDhaHHxzPU+X8HnJ8PTHSOn/CC8D/qWdJ
 LAzhRcwOJ2UojVoJKpNriAgb0LLLpIpaF9yTQw2MmVFFCmQLyX6ryOToN2C7P4mp7bn9
 XqhX1QyNFoBjVqGwcPzlMdvMki4QpqcOaIexVeYat+30oNU4LnqwXqTLvMAXebp33uoY
 5S//x2w1bcK7wEm7voXTi6iIFO0/bMgaPFj5xAfx+eOjOvIrmOV6cDGEohtMdJ/+IhcE
 807iCbbZ6biBL5essAuJR/+Kryq7DTnndV/m9QoEl+9JnBvZMLObsbtVb0jAQfIGMtkx
 J74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694986767; x=1695591567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o8CkTawIAHKcNROsQeg+oZvvojFPdKNuju/1K0TLyts=;
 b=J/ZsERnq6qGTe8Y5BgMH4CFhB02ubFCoYx7LRJ7q0evNdIwew5pcF7KXwge/uDgi6i
 kwDXavdkWlvZkgcUqMgwD+A+cCYOr2CjvOX7aMMIi8OiibdCvdBJeFdYdgSkCct1l+y1
 W6c/9PQ0JzGpAqORkm3M+QDUkJiFbZqewh+9YivRR+/K0LfJV4+4Z3qK2LVsR0fujKtM
 wp+bV4wJ9orJWI5CPL9dQTsLP2U9+ju8PmrmW6kodm8Hdh1JA/T6VRcfPDeDwAolsWn3
 Jlc2oPkFlI+xxzwoIotBMAHNAr0i4dJZ83vkD4l8feaF7/WJNJcfWIHMOK8nL1q6CQEo
 fXLQ==
X-Gm-Message-State: AOJu0Yzgvn/40IJN/7CDhf8VAf6sh/8Xtn8wA4/mc+mG6t4JVwocVwj7
 /7Egug9vygTphM0atNS9FYOYyksReCU=
X-Google-Smtp-Source: AGHT+IFVRJ88BLTSu89fc8CjedLfszxFJJyeG8MSz1voKKmiuNJumgx4GiywSWktKd/tslaIcYFekQ==
X-Received: by 2002:adf:e181:0:b0:320:9fa:d928 with SMTP id
 az1-20020adfe181000000b0032009fad928mr2902756wrb.68.1694986767201; 
 Sun, 17 Sep 2023 14:39:27 -0700 (PDT)
Received: from karim.my.domain ([197.39.215.8])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a5d484b000000b00317ddccb0d1sm10561735wrs.24.2023.09.17.14.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Sep 2023 14:39:26 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Richard Henderson <richard.henderson@linaro.org>,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 00/28] bsd-user: Implement freebsd process related system
 calls.
Date: Mon, 18 Sep 2023 00:37:35 +0300
Message-ID: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x432.google.com
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


