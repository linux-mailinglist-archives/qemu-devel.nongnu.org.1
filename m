Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BA3772B20
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 18:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3ET-00073o-7O; Mon, 07 Aug 2023 12:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3EF-000705-Jy
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:11 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT3ED-0002fo-8H
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 12:37:11 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bc34b32785so30425785ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691426227; x=1692031027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rTEYzTPoM/fbCujo5zbTspvESM8sKNHvbhzgwiK7eFU=;
 b=lcRCYuM6jhJMuaQ7EDo49QBjiqzx17RDE2Nh8cMjMBc73/daSzDonbt9enGEUhdpSX
 zTBuZ47PTfnOOLcSZZpYMRkkhdvfHnsBOMMvGfg3Cpubqm+lg3Ig9GQ6arf5ffxX7jKv
 9DB/+DcbZ0i9Mglk2QsWkmVpuR/6Nad7F87ixluS6skTVVWJGlpSar+Ac0OX8zFntQR8
 oTThYvtWev2UZLnmnmPshnSyN5Z9mJL9YAaN1lIB/ov/C6H1JRHnE0REfjSi+dIC2vNZ
 G4McSZZs+jUrLAwDlpTPVPZCi3gwSiJ1SQAeQyiuQrSCoo/AH5v0BIQr2yxxwVE1UVd+
 qUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691426227; x=1692031027;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rTEYzTPoM/fbCujo5zbTspvESM8sKNHvbhzgwiK7eFU=;
 b=Pk9XKOhUwBF5oM4j0mgOKfWH5obIee16jMe8lDNCWVNakh36frk1PJWXiOfjynNdhU
 H3IJ0R9xRNtu/5Eu+ah7AiP5sRPbxZb7JvpQRcHw1/JH+XOgJ9svA6MbiHWS0YoZPVqz
 yqCB+AB1PzdNO1j9lNSw74Dhq0c8cH4yZgO4ePeWM9A8SXZ7kQJ+X2fgAEWboP5dRgOH
 mJ0S/si26B1U4ilRGouRCdy5Q+lY9yalkCN28thKfiQxfzmH7c8dSSAluf2675R6dzXh
 o9Y45IyXAQhDuu+xEZm6S8TLsCOftI8KpOKLCI8JV8hvuzoEvHwb7HMtJK1+491W1JS0
 GUpw==
X-Gm-Message-State: AOJu0YzToG2PZlc8I8kTKGaPps0gkgwhQ8/V/QB7lDPmB0cHiW1bRAwx
 OUxlrJdgj2sF/xxls7zkhkQZx1jP5x7Wpi6++T0=
X-Google-Smtp-Source: AGHT+IGYVw9een1mPCjm29jiab4oYdbkAYGFhAyHDNKvCJUM22xC1uUKC+IfkJWGj7yPcWnoycFJtw==
X-Received: by 2002:a17:903:2281:b0:1bb:6875:5a73 with SMTP id
 b1-20020a170903228100b001bb68755a73mr9620578plh.2.1691426226747; 
 Mon, 07 Aug 2023 09:37:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a170902d34600b001b9df8f14d7sm7119837plk.267.2023.08.07.09.37.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 09:37:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v10 00/14] linux-user: image mapping fixes
Date: Mon,  7 Aug 2023 09:36:51 -0700
Message-Id: <20230807163705.9848-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This is the second half of

https://patchew.org/QEMU/20230804220032.295411-1-richard.henderson@linaro.org/

which I held back because of regressions with s390x testing.

It turns out that patch 4, "Use MAP_FIXED_NOREPLACE for initial image mmap"
actually triggered EEXIST, which meant that probe_guest_base did not
do its job to select unused host virtual memory.  It's a mystery why
we have not seen larger problems because of this.

As I kept digging, I found quite a number of problems within
probe_guest_base and its subroutines.  I have rewritten it completely.
Hopefully it is much easier to understand in its new form.

Testing this has been difficult, because it is most visible with
non-PIE executables, and most modern distros default to PIE, and
our current implementation of --disable-pie does not work.


r~


Helge Deller (1):
  linux-user: Adjust initial brk when interpreter is close to executable

Richard Henderson (13):
  linux-user: Adjust task_unmapped_base for reserved_va
  linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
  linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
  linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
  linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
  linux-user: Do not adjust image mapping for host page size
  linux-user: Do not adjust zero_bss for host page size
  linux-user: Use zero_bss for PT_LOAD with no file contents too
  util/selfmap: Rewrite using qemu/interval-tree.h
  linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base
  linux-user: Consolidate guest bounds check in probe_guest_base
  linux-user: Rewrite fixed probe_guest_base
  linux-user: Rewrite non-fixed probe_guest_base

 include/qemu/selfmap.h               |  20 +-
 linux-user/aarch64/target_mman.h     |  13 +
 linux-user/alpha/target_mman.h       |  11 +
 linux-user/arm/target_mman.h         |  11 +
 linux-user/cris/target_mman.h        |  12 +
 linux-user/hexagon/target_mman.h     |  13 +
 linux-user/hppa/target_mman.h        |   6 +
 linux-user/i386/target_mman.h        |  16 +
 linux-user/loongarch64/target_mman.h |  11 +
 linux-user/m68k/target_mman.h        |   5 +
 linux-user/microblaze/target_mman.h  |  11 +
 linux-user/mips/target_mman.h        |  10 +
 linux-user/nios2/target_mman.h       |  10 +
 linux-user/openrisc/target_mman.h    |  10 +
 linux-user/ppc/target_mman.h         |  20 +
 linux-user/qemu.h                    |   1 -
 linux-user/riscv/target_mman.h       |  10 +
 linux-user/s390x/target_mman.h       |  20 +
 linux-user/sh4/target_mman.h         |   7 +
 linux-user/sparc/target_mman.h       |  25 +
 linux-user/user-mmap.h               |   5 +-
 linux-user/x86_64/target_mman.h      |  15 +
 linux-user/xtensa/target_mman.h      |  10 +
 linux-user/elfload.c                 | 788 +++++++++++++--------------
 linux-user/main.c                    |  43 ++
 linux-user/mmap.c                    |  19 +-
 linux-user/syscall.c                 |  15 +-
 util/selfmap.c                       | 114 ++--
 28 files changed, 777 insertions(+), 474 deletions(-)

-- 
2.34.1


