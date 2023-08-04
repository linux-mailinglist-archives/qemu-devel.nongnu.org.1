Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F576F72B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:48:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjsv-0002gd-Fb; Thu, 03 Aug 2023 21:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsY-0002ca-Cm
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:28 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjsW-00056d-Ij
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:45:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686f38692b3so1471852b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113518; x=1691718318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ixv99LquuqtXKj4m2MuqwATlbOBr82tZDoKAbP0Cr28=;
 b=StMNcGhLuUJgTvJQzEZhJKep+Xdshe0xuiVJ27mDdJH36GK/tsFD7gpCkEmZhAEjeB
 ncPCe6RAoAMV2e7QzSDwwujAGfihsjeB2POUjTx5iEjY7Yg8bCQTzzle537fHz24w98c
 TCOX1+MMSJ50lBjpBGwumbEDNIwP1G4C7ayRzKtD8ogrpRV/gcIPjfVYCJ2reakzYg7b
 VOI8tuQUpjVBkDbq8CfbMcRzE9OnRnVxrmSbgm+sIFapyBzr3J4YCxDibyXkzH1fAVM2
 IAFTZQhUfnek7MG2RI93cvmLNy+IXOOQz+jWLqzXVadgHrAsQjC4JGKWl0v4eTWxcHwg
 9Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113518; x=1691718318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ixv99LquuqtXKj4m2MuqwATlbOBr82tZDoKAbP0Cr28=;
 b=fNit41mdvcHAQ96Bw2y+BLKS6PmPULUhX/Eywktib/7mOm4bdhkIgm6u8fx5rHN+Lg
 l+wTitC0Ce3D4UcE8tHmjH6kKfCC9s2ecefbYnPat1m7CLCWcYTIOEy4OCEeyCPaRdKS
 MLjVEsCZjRxHJtERUE5W3eyj3FFM0K7uf1xSm8OPk1RSICh9iHb9ilwnzOlP9pvwYE+l
 Qv5c1oRH7z47V+vmaH0VA6csmMtNMFtWwaeI1EAqYTj5dyX2Rm3RiW8FWKiQB5zi+RE5
 ehfuIJvTTk5GrcEdojsRHJxprHkZMlFs7ALzdBWubemWXSuQB3jKO5qHN7h+Q8cxufn6
 a41g==
X-Gm-Message-State: AOJu0YzRfWHMNuO0rP3AnhRuoQMMTUy8Vw+d2EbxIOWZ06NhjuOZufj8
 NIvpmZczKwBfiwPBI7060JCMMnTyC90RBh8+kWM=
X-Google-Smtp-Source: AGHT+IG7mCR8GhTcYpgovNLlIGcFjSWPPCki9/BBAWVFxEuBW5pZuM4iIZDdHsKloiVbKQSAOknX0w==
X-Received: by 2002:a05:6a20:3c8a:b0:130:11e4:d693 with SMTP id
 b10-20020a056a203c8a00b0013011e4d693mr363622pzj.53.1691113518622; 
 Thu, 03 Aug 2023 18:45:18 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 c5-20020aa78c05000000b0066f37665a63sm456138pfd.73.2023.08.03.18.45.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 18:45:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, akihiko.odaki@daynix.com, laurent@vivier.eu, deller@gmx.de
Subject: [PATCH for-8.1 v8 00/17] linux-user: brk fixes
Date: Thu,  3 Aug 2023 18:45:00 -0700
Message-Id: <20230804014517.6361-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Changes for v8:
  * Remove adjustments to the image mapping for host page size.
    Instead, rely on target_mmap to do its job in that respect.
    This was the root cause of the 64k host page size issues.

Please review.


r~


Akihiko Odaki (6):
  linux-user: Unset MAP_FIXED_NOREPLACE for host
  linux-user: Fix MAP_FIXED_NOREPLACE on old kernels
  linux-user: Do not call get_errno() in do_brk()
  linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
  linux-user: Do nothing if too small brk is specified
  linux-user: Do not align brk with host page size

Helge Deller (1):
  linux-user: Adjust initial brk when interpreter is close to executable

Richard Henderson (10):
  linux-user: Remove last_brk
  linux-user: Adjust task_unmapped_base for reserved_va
  linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
  linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
  linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
  linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
  linux-user: Properly set image_info.brk in flatload
  linux-user: Do not adjust image mapping for host page size
  linux-user: Do not adjust zero_bss for host page size
  linux-user: Use zero_bss for PT_LOAD with no file contents too

 linux-user/aarch64/target_mman.h     |  13 ++
 linux-user/alpha/target_mman.h       |  11 ++
 linux-user/arm/target_mman.h         |  11 ++
 linux-user/cris/target_mman.h        |  12 ++
 linux-user/hexagon/target_mman.h     |  13 ++
 linux-user/hppa/target_mman.h        |   6 +
 linux-user/i386/target_mman.h        |  16 +++
 linux-user/loongarch64/target_mman.h |  11 ++
 linux-user/m68k/target_mman.h        |   5 +
 linux-user/microblaze/target_mman.h  |  11 ++
 linux-user/mips/target_mman.h        |  10 ++
 linux-user/nios2/target_mman.h       |  10 ++
 linux-user/openrisc/target_mman.h    |  10 ++
 linux-user/ppc/target_mman.h         |  20 +++
 linux-user/qemu.h                    |   2 -
 linux-user/riscv/target_mman.h       |  10 ++
 linux-user/s390x/target_mman.h       |  20 +++
 linux-user/sh4/target_mman.h         |   7 ++
 linux-user/sparc/target_mman.h       |  25 ++++
 linux-user/user-mmap.h               |   6 +-
 linux-user/x86_64/target_mman.h      |  15 +++
 linux-user/xtensa/target_mman.h      |  10 ++
 linux-user/elfload.c                 | 181 ++++++++++++---------------
 linux-user/flatload.c                |   2 +-
 linux-user/main.c                    |  35 +++++-
 linux-user/mmap.c                    |  68 ++++++----
 linux-user/syscall.c                 |  69 +++-------
 27 files changed, 417 insertions(+), 192 deletions(-)

-- 
2.34.1


