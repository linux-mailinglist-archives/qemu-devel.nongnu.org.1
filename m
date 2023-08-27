Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D578B924
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiYT-00083l-0b; Mon, 28 Aug 2023 16:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYR-00083R-94
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:43 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiYO-0007KH-UX
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:09:42 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99c0cb7285fso479170766b.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253377; x=1693858177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SNKmUNq8vjFrfmjeadE78lwpPLhzoJ8zvJyLtcQaD78=;
 b=LyxjGN7bNzdCEnDvXvstCB6bPxbgCW/vyM6JaHQ4GHUjUagxOkTMfH7Sz6C9GonR+X
 WFPe6T8lgcIBPwwN1AXo5VB13LHYpWKxujvzlJSU01R0ehGCiIN9SjEVylHQJswEvUGw
 zxi/CCrlraRMw8z3ryjea23HuYrs9Vfe16o+PrYW4rWK1qNbtaJ9oKNKZ0g/QUNQzDZa
 AsSUcSwLjfclPujffbjBdVS3OWUuLMWDqb+gSrtADX6mb3vzn5Lq8EveBKq8V9M8Zvcf
 Nv/WhAXF6jeqqka8k9ATMX7cwmpswsLadVYUyDfxjHez+50emUT8mySbEu50M1HvBg+j
 K0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253377; x=1693858177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNKmUNq8vjFrfmjeadE78lwpPLhzoJ8zvJyLtcQaD78=;
 b=BkHB560BhcdkJAZBOD04lj02ehKlmvMCMZQNYtbwGSi/J8TQAkvKz92JpE3lbNa+0l
 i0e5MbkJrREKHHECdeyh7UoenEW1A470j/X/yl2qo9hpfhzYJ8yLcN8qok1F9o9j0jwZ
 siDV1DCcj9lwNr4W/fCOfzx1Z+XuwSH+Y8AfkPFS9UIl9qrLGXRoZw7BOSPfnEugBYXW
 pAgSifgZekVsiSV7ANCncNJVJwVEGoq+xvtmgaS36kLgwuNBbX4Tkr6ZWkmfkzTuOd0S
 CJrnVHnMuEnDZaoQIUjjIyyjwOFRtd5K9SBZdPlXoVN0HqAUExdeqbopdnlsJSMYZZbb
 KlUw==
X-Gm-Message-State: AOJu0YwKRUMgcENTqs72E3+mAbHpfW26VnYAMxS0MvEa44pgaDuCN5Mb
 dNTxAvTxZaNmTbui78jp4UVrCaRqZ/XYdA==
X-Google-Smtp-Source: AGHT+IHzbN6IbViaRVQ4rMnSiRh9BIZgrNzs53T4mQH+cejrTa1LozqyyaOBupbzwJNPI9M0icpxRQ==
X-Received: by 2002:a17:907:7818:b0:99b:d075:18ba with SMTP id
 la24-20020a170907781800b0099bd07518bamr17596372ejc.56.1693253377128; 
 Mon, 28 Aug 2023 13:09:37 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:09:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 00/32] bsd-user: Implement freebsd process related system
 calls.
Date: Sun, 27 Aug 2023 17:57:14 +0200
Message-Id: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-ej1-x62a.google.com
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



Karim Taha (1):
  bsd-user: Add freebsd/os-proc.c to meson.build

Kyle Evans (2):
  bsd-user: define TARGET_RFSPAWN for rfork to use vfork(2) semantics.
  bsd-user: Get number of cpus.

Stacey Son (28):
  bsd-user: Implement procctl(2) system call.
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
  bsd-user: Implement get_filename_from_fd.
  bsd-user: Implement freebsd_exec_common, used in implementing
    execve/fexecve.
  bsd-user: Implement t2h procctl control request commands and h2t
    reaper status struct conversion.
  bsd-user: Implement h2t reaper_pidinfo and h2t/t2h reaper_kill structs
    conversion functions.
  bsd-user: Implement procctl(2) system call.
  bsd-user: Implement execve(2) and fexecve(2) system calls.
  bsd-user: Implement wait4(2) and wait6(2) system calls.
  bsd-user: Implement setloginclass(2) and getloginclass(2) system
    calls.
  bsd-user: Implement pdgetpid(2) and the undocumented setugid.
  bsd-user: Implement fork(2) and vfork(2) system calls.
  bsd-user: Implement rfork(2) system call.
  bsd-user: Implement pdfork(2) system call.

Warner Losh (1):
  bsd-user: Add bsd-proc.c to meson.build

 bsd-user/bsd-proc.c           | 226 ++++++++++++++++
 bsd-user/bsd-proc.h           | 382 +++++++++++++++++++++++++++
 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-proc.c    | 467 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-proc.h    | 283 ++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 204 +++++++++++++++
 bsd-user/main.c               |   2 +-
 bsd-user/meson.build          |   6 +
 bsd-user/qemu-bsd.h           |  38 +++
 bsd-user/qemu.h               |   7 +
 bsd-user/signal-common.h      |   1 +
 bsd-user/signal.c             |   6 +
 bsd-user/syscall_defs.h       |  46 ++++
 13 files changed, 1668 insertions(+), 1 deletion(-)
 create mode 100644 bsd-user/bsd-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.c
 create mode 100644 bsd-user/freebsd/os-proc.h
 create mode 100644 bsd-user/qemu-bsd.h

-- 
2.40.0


