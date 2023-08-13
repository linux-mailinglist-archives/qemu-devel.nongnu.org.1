Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C49077A6B8
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:13:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpF-0007zs-Cm; Sun, 13 Aug 2023 10:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpE-0007zk-1s
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:12 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpC-0000mZ-IL
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:11 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31771bb4869so3339776f8f.0
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935928; x=1692540728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZkCQ1yQ2x3vp6dfJTClLuD7tLuUJi1rmlTlilzcOdg=;
 b=bFktTq+kpmdrUUIg70ChhLLOF4n6Yfn4JhR6kh/ljvJnrxlYs+etBjUUQv8Ut+eIoa
 dxX8EoQoph+zCTmA2RU2DZL1Z9T6G0PPNBgTs0JrCyDOUg9kpk3waKBPMzLrBXbvx4Re
 Ssn4QpH46GygAfWzmXOBZL77P5nsB5WZNtiQDAIROlvBZQB+1YaDglamO1kxgWiR1UsM
 OdlAuSpJWVDaol+PlXtP17dqaf467TRDHeOZrxdpnaoQ2KLF/Xf8zTX14V6Vj4rFyFAW
 YHQ6sCHpFJbCmHnLnbO4DIb+o49ACF5dRot7M3t2UruDn/0h4FE/zs7VNyQpfDOs9PCR
 SCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935928; x=1692540728;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZkCQ1yQ2x3vp6dfJTClLuD7tLuUJi1rmlTlilzcOdg=;
 b=KHmBJAIxL+cQ6BgAzgPdCCsy3Li19VHCsABY3DYKj1nsh/tA/u4EffL9aMFqLv7waR
 dYX3uQHj2azxHrNcr0o7d2y1xujbwUzDc9fvoZ5BNYLrjG+pM4bL4hj3+9E38Kk4wQIu
 l2z1jrCTfTDIeBYvWEKSpfRtGiKLp7tFhpEp8ziM/cD/dLeGp1FJz+J6D9ecFNecyHbg
 oRI7n8zwXHl3KcbZCIaV6/qUDlepC3Fu/PPJY8oRWXR6CJSeDY4JEnxG24boK4MTCEgX
 0VNM/MHZT3/TpnBQ8fny7fe4QqEqKCwiXB3P/gWRskP01WPbOMagl8w+gkONtj88SFhJ
 u0iQ==
X-Gm-Message-State: AOJu0Yzy+3xgjROcd+WaiDch55nqmWW/niv0UabrhvjhZDaShjdoWOnr
 ac2fhvIw1zjrSTZxGzERKBYXEYIDWJc=
X-Google-Smtp-Source: AGHT+IGqt8374SsWeHRQBKaxo/w6MIE5GYrfQwoSLqxjUU0gLJzf1sioU1ZYvv2m/bRgiwjxq3M+tQ==
X-Received: by 2002:adf:ee0d:0:b0:317:7062:32d2 with SMTP id
 y13-20020adfee0d000000b00317706232d2mr4953656wrn.54.1691935927871; 
 Sun, 13 Aug 2023 07:12:07 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v2 00/32] Implement the stat system calls for FreeBSD.
Date: Sun, 13 Aug 2023 05:09:41 +0200
Message-Id: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x436.google.com
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


