Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CDC77AAEE
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 21:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVGzT-0007jk-69; Sun, 13 Aug 2023 15:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzQ-0007in-IZ
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVGzP-0002Lo-2C
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 15:43:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fe4ad22e36so34159965e9.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 12:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691955781; x=1692560581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZkCQ1yQ2x3vp6dfJTClLuD7tLuUJi1rmlTlilzcOdg=;
 b=rzYIPmaS4F8EPJDXOsFS8BXNbo4Nb+3Dm/FC7Bmukl3G1DpySV66JhvktdqCeS9rik
 zG0x7wrQzXHI54LH92gbs3RnbhKpaWyk+HPRBDxQd9k+kqLz9ysa4uQ295yz7TVqWciv
 xi2Vp/TpexbmEnPvdabnSJ7jvrqypNwI44gJ63r2tDXjm8OQmvizmhsny2gZWmvgDiww
 370vTWkXFrZG/WaOeo/At4M3u14YOSSjxnOxZOUfJ8FH0App+6nxuOIlHfLTa8w1kLpS
 EwX13HgSMwW73D+Ck2QlzxiW4LtdFlT6UJ7RKpo7XuviFFbdBvKgsplre3LGK/Q8QMkN
 d7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691955781; x=1692560581;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZkCQ1yQ2x3vp6dfJTClLuD7tLuUJi1rmlTlilzcOdg=;
 b=Z2DHw0CtDhCGibD9vv8VhaIC4aKI8HUio02/9i5iFWoMl0YHx3DBPiaxQ2h0jddzYG
 8t8VjU0yNkVHk3/0k7BF+DjswwePYuN/HtsoiUf+LmKzWwSIhA1zlLC6JJJesnHVQdz7
 vYtzSXfEIl+DwMyJmlWBoNNiwopmB08LFZN8LhMqnMPX3gFBWgqU5L/V5ZH4uIHzLEQY
 ZNGwYWZRjD1sVtJQq7L35SK40Vi+H33ga02Wlwb4UMLNEj2pv+XuWLAlYgUxZnXPeBxJ
 07qhMMFLO1i0WFcikK42hClhmcUQI65TWvCqHz3cTnzqihyTBiS4Ng1IaaALiG/qFxiw
 lRjA==
X-Gm-Message-State: AOJu0YysKtguLLxy95UvrcUJu3I0XGhAqR2DP6VP062pyX57E+SmO/jC
 3OYqXo7gfuAiJdk4WgWkbosz56mLvpo=
X-Google-Smtp-Source: AGHT+IESS42+NtN4KG8n4z01TeE76l0O6GKwx2eTpPvRPw4WLtnmkrisvOGM+5B2hPzHUzrHdWVTBw==
X-Received: by 2002:adf:e390:0:b0:319:650f:60e2 with SMTP id
 e16-20020adfe390000000b00319650f60e2mr4170835wrm.11.1691955780478; 
 Sun, 13 Aug 2023 12:43:00 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 t20-20020a7bc3d4000000b003fe263dab33sm12234536wmj.9.2023.08.13.12.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 12:42:59 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v3 00/32] Implement the stat system calls for FreeBSD.
Date: Sun, 13 Aug 2023 10:41:21 +0200
Message-Id: <20230813084153.6510-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
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

Upstream the implementation of the stat system calls from the
qemu-bsd-user fork, the following system calls are implemented:
stat(2), lstat(2), fstat(2), fstatat(2), nstat, nfstat, nlstat
getfh(2), lgetfh(2), fhopen(2), fhstat(2), fhstatfs(2), statfs(2)
fstatfs(2), getfsstat(2), getdents(2), getdirentries(2), fcntl(2)

Karim Taha (1):
  Add os-stat.c to the build

Kyle Evans (2):
  Disable clang warnings
  Define safe_fcntl macro in bsd-user/syscall_defs.h

Michal Meloun (8):
  Add struct target_stat to bsd-user/syscall_defs.h
  Add struct target_statfs to bsd-user/syscall_defs.h
  Implement h2t_freebsd_stat and h2t_freebsd_statfs functions
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls
  Implement freebsd11 stat related syscalls

Mikaël Urankar (1):
  Implement do_freebsd_realpathat syscall

Stacey Son (13):
  Declarations of h2t and t2h conversion functions.
  Add struct target_freebsd11_stat to bsd-user/syscall_defs
  Add structs target_freebsd11_nstat and target_freebsd11_statfs to
    bsd-user/syscall_defs.h
  Add struct target_freebsd_fhandle and fcntl flags to
    bsd-user/syscall_defs.h
  Implement h2t_freebsd11_stat h2t_freebsd_nstat
  Implement h2t_freebsd_fhandle t2h_freebsd_fhandle functions
  Implement h2t_freebds11_statfs
  Implement target_to_host_fcntl_cmd
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls
  Implement stat related syscalls

Warner Losh (7):
  Move _WANT_FREEBSD macros to include/qemu/osdep.h
  Update the definitions of __put_user and __get_user macros
  Rename target_freebsd_time_t to target_time_t
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:
  Add glue to call the following syscalls to the freebsd_syscall
    function:

 bsd-user/freebsd/meson.build  |   1 +
 bsd-user/freebsd/os-stat.c    | 262 ++++++++++++++
 bsd-user/freebsd/os-stat.h    | 663 ++++++++++++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 121 ++++++-
 bsd-user/freebsd/qemu-os.h    |  50 +++
 bsd-user/qemu.h               |  82 ++---
 bsd-user/signal.c             |   5 +-
 bsd-user/syscall_defs.h       | 221 +++++++++++-
 include/qemu/compiler.h       |  30 ++
 include/qemu/osdep.h          |  13 +
 10 files changed, 1382 insertions(+), 66 deletions(-)
 create mode 100644 bsd-user/freebsd/os-stat.c
 create mode 100644 bsd-user/freebsd/os-stat.h
 create mode 100644 bsd-user/freebsd/qemu-os.h

-- 
2.40.0


