Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A4076DDA8
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 03:55:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRNWY-0000dt-Q9; Wed, 02 Aug 2023 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWV-0000dE-R7
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRNWU-0000hL-5j
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 21:53:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68783b2e40bso292087b3a.3
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 18:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691027584; x=1691632384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+EK90UJfX7jj7sXNQRpX2WTAHgncCgalkEWNrdpmx8=;
 b=bisq2UBJFEGTiv0/XPuz8m5bKEcIBSetXQbV/N3mCmPa08b/R79A3YLn/+yri1rRB/
 IaJlGqPCoP2TKw7eFG+aZHkIZX+O/tk2Uwj5yQztL05NnWAIBReK2sy0JW+WFUZIxQmi
 LqljGVy2P1Iq31OYUbyKVSdHkoxpcKvotVWLfoNPEGgbp9yRAqhJq7IP/SuEZZSHj++j
 xmczLVSzcZvg6Ai/7VwkSvAGdBaQFg/sfSjBhUdbpMwuWBG6yd9q7z3dVgqwgnF0LTcB
 gtbsqwGjwd1rS5bcOn3wu8TGZJ4YXIHqo7vPmL8g2hzQKPSU+ykxzTVsXwHcg/QEYnY6
 f/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691027584; x=1691632384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+EK90UJfX7jj7sXNQRpX2WTAHgncCgalkEWNrdpmx8=;
 b=T6NFd5hNz6GAZqqt8rH/mCEmd0+1ChxuIEPMRLlvuoH+oc9IoHSYKtS07Q+5gkkLMV
 bRGwVmov2Q/lMiFCNYwIeysL+xjGdBXqc1mDUmo7OdiM1/VdGftunkLoKZA2B0C3XCZI
 i1q6TJNeD5GXeaJU92aVeu+hyJzTVwl/LNCZMinGi9BnT0M/ZsVwNVPbrDMS+lVmxHy3
 AfYJw/99+/cGaFFELK4kSSlLo7k0kLq4Pm23Ik9bIsGwEsRgRoDxRBisjCchYQwADlip
 Ohns1TVh1J1vY9CqBumpUgjrKr1c9uF/lism0jk5+XYgtwAD5stBGn2M3/Mk5rczk92e
 Wx3Q==
X-Gm-Message-State: AOJu0YybhSAFA3jBumA1ooagzAXdLlDjeunyAuu6u1Eixltj308zPtUl
 JlUNi46a1vAyp42MfH9b5A0a0ECCzJgcwC2L8QA=
X-Google-Smtp-Source: AGHT+IGJc9laWFnjk+YWayLsvGr0iTt43a4xDb4Cyl1lOHxWYiJgpedQaUKhRMyrLgpjHF/P5Jyhiw==
X-Received: by 2002:a05:6a00:248d:b0:687:8b52:112e with SMTP id
 c13-20020a056a00248d00b006878b52112emr519037pfv.14.1691027583892; 
 Wed, 02 Aug 2023 18:53:03 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:b659:bbad:1a22:7ef9])
 by smtp.gmail.com with ESMTPSA id
 s25-20020a63a319000000b005649cee408fsm157123pge.0.2023.08.02.18.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 18:53:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, laurent@vivier.eu, akihiko.odaki@daynix.com, joel@jms.id.au
Subject: [PATCH v7 00/14] linux-user: brk fixes
Date: Wed,  2 Aug 2023 18:52:48 -0700
Message-Id: <20230803015302.407219-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Builds on Helge's v6, incorporating my feedback plus
some other minor cleanup.


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

Richard Henderson (7):
  linux-user: Remove last_brk
  bsd-user: Remove last_brk
  linux-user: Adjust task_unmapped_base for reserved_va
  linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
  linux-user: Add ELF_ET_DYN_BASE
  linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
  linux-user: Properly set image_info.brk in flatload

 bsd-user/qemu.h                      |  1 -
 linux-user/aarch64/target_mman.h     | 13 ++++
 linux-user/alpha/target_mman.h       | 11 ++++
 linux-user/arm/target_mman.h         | 11 ++++
 linux-user/cris/target_mman.h        | 12 ++++
 linux-user/hexagon/target_mman.h     | 13 ++++
 linux-user/hppa/target_mman.h        |  6 ++
 linux-user/i386/target_mman.h        | 16 +++++
 linux-user/loongarch64/target_mman.h | 11 ++++
 linux-user/m68k/target_mman.h        |  5 ++
 linux-user/microblaze/target_mman.h  | 11 ++++
 linux-user/mips/target_mman.h        | 10 +++
 linux-user/nios2/target_mman.h       | 10 +++
 linux-user/openrisc/target_mman.h    | 10 +++
 linux-user/ppc/target_mman.h         | 20 ++++++
 linux-user/qemu.h                    |  2 -
 linux-user/riscv/target_mman.h       | 10 +++
 linux-user/s390x/target_mman.h       | 20 ++++++
 linux-user/sh4/target_mman.h         |  7 +++
 linux-user/sparc/target_mman.h       | 25 ++++++++
 linux-user/user-mmap.h               |  6 +-
 linux-user/x86_64/target_mman.h      | 15 +++++
 linux-user/xtensa/target_mman.h      | 10 +++
 bsd-user/mmap.c                      |  2 -
 linux-user/elfload.c                 | 94 ++++++++++++++++------------
 linux-user/flatload.c                |  2 +-
 linux-user/main.c                    | 43 ++++++++++++-
 linux-user/mmap.c                    | 68 ++++++++++++--------
 linux-user/syscall.c                 | 69 +++++---------------
 29 files changed, 401 insertions(+), 132 deletions(-)

-- 
2.34.1


