Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C670E9D8
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:59:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1btM-00049A-VK; Tue, 23 May 2023 19:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btJ-000484-Qn
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btH-0001lP-U4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d5f65a2f7so103743b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886286; x=1687478286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kSuirE6CDqKl3kLQNhBT0Wh4WvhflSXCGvBB6DAsT4Q=;
 b=xoJsBNJ4BgLavbV5acO1OCe5uJ+awZ0URbl1sxZ5lqKHgJ/lEtbT/uSmFiDOSGZrWu
 CwqdYAVIZnhAjiOUI9FwU6VzzRiclWH3jMqJmO12qH2rSWWUjKhuuG+uzgk7AHB01zil
 hQZOYsANu4BNt/9Gvm1rg0y6TvTUvQP/A24LbaeMffhAOCMXPZaNnTxGpy7UtS+0EONy
 LGn/pBxh69yc7TxptX1KDJM8DXfg77rP4AOQpTlmlsECMkdu5tx5oL+ct+gdFhGzJ6m3
 OvghYWUIf6Yf5YEgQBtwrdO74YH0Y8fpdtKzGZ8whh0hN8ydDrxJjhGc3YkFiKVe7MPS
 rWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886286; x=1687478286;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kSuirE6CDqKl3kLQNhBT0Wh4WvhflSXCGvBB6DAsT4Q=;
 b=CsSVrOgBrZj9ESVLo1dN8fPzrK5v/6Z09w9LyMzXsXE4LC0QpsyCUGFF8uypeuvpNJ
 ZdHZqJE+LMS1ogiDQQES3uilys3yFFcFCEzFFBQ2STjOaMI539SJLAA4bFqp+dXzAVHH
 eM3RqBT+AB3ob7ztj4rgPWUuhIUP8KdNcQeA4zDDryp0+jPCP9RcDR7mawLcoQXt1HqB
 jDgRqNkuWyB+L7KV3IWb1wZJC/g+WL6NwIKyw/pOds19d4FOEV2tYDu7YnRibBfcAQb6
 lBOoeMT2p9yXaKkiF8gtLAv6Q/vl/6sIcrI0xC8Nf2VPaBLy3KQ1EWZx9qmxk533dTlM
 qQcg==
X-Gm-Message-State: AC+VfDxaiy9HtjI/+uL1Bp3hL2lxNgPTn20L9lH/pp9z5Xam+1jIjeqX
 fqGncm/War7HW8ooTX9ky/SGvyzJ3w4g263k1Ks=
X-Google-Smtp-Source: ACHHUZ6ffmxeJlsfsjlOnu1Cxv4MITrd4z9JFqlfJjYLf0KvO4XX6Zuj4LgwqYxwVSCLv5n2jLUMQQ==
X-Received: by 2002:a05:6a00:c92:b0:64f:4586:83fc with SMTP id
 a18-20020a056a000c9200b0064f458683fcmr791869pfv.31.1684886286231; 
 Tue, 23 May 2023 16:58:06 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/28] tcg patch queue
Date: Tue, 23 May 2023 16:57:36 -0700
Message-Id: <20230523235804.747803-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The following changes since commit aa33508196f4e2da04625bee36e1f7be5b9267e7:

  Merge tag 'mem-2023-05-23' of https://github.com/davidhildenbrand/qemu into staging (2023-05-23 10:57:25 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230523

for you to fetch changes up to 30d56836f98c7ed2d309bff1dde8854f3d0b5634:

  tcg: Remove USE_TCG_OPTIMIZATIONS (2023-05-23 16:52:39 -0700)

----------------------------------------------------------------
util: Host cpu detection for x86 and aa64
util: Use cpu detection for bufferiszero
migration: Use cpu detection for xbzrle
tcg: Replace and remove cpu_atomic_{ld,st}o*
host/include: Split qemu/atomic128.h
tcg: Remove DEBUG_DISAS
tcg: Remove USE_TCG_OPTIMIZATIONS

----------------------------------------------------------------
Richard Henderson (28):
      util: Introduce host-specific cpuinfo.h
      util: Add cpuinfo-i386.c
      util: Add i386 CPUINFO_ATOMIC_VMOVDQU
      tcg/i386: Use host/cpuinfo.h
      util/bufferiszero: Use i386 host/cpuinfo.h
      migration/xbzrle: Shuffle function order
      migration/xbzrle: Use i386 host/cpuinfo.h
      migration: Build migration_files once
      util: Add cpuinfo-aarch64.c
      include/host: Split out atomic128-cas.h
      include/host: Split out atomic128-ldst.h
      meson: Fix detect atomic128 support with optimization
      include/qemu: Move CONFIG_ATOMIC128_OPT handling to atomic128.h
      target/ppc: Use tcg_gen_qemu_{ld,st}_i128 for LQARX, LQ, STQ
      target/s390x: Use tcg_gen_qemu_{ld,st}_i128 for LPQ, STPQ
      accel/tcg: Unify cpu_{ld,st}*_{be,le}_mmu
      target/s390x: Use cpu_{ld,st}*_mmu in do_csst
      target/s390x: Always use cpu_atomic_cmpxchgl_be_mmu in do_csst
      accel/tcg: Remove cpu_atomic_{ld,st}o_*_mmu
      accel/tcg: Remove prot argument to atomic_mmu_lookup
      accel/tcg: Eliminate #if on HAVE_ATOMIC128 and HAVE_CMPXCHG128
      qemu/atomic128: Split atomic16_read
      accel/tcg: Correctly use atomic128.h in ldst_atomicity.c.inc
      tcg: Split out tcg/debug-assert.h
      qemu/atomic128: Improve cmpxchg fallback for atomic16_set
      qemu/atomic128: Add runtime test for FEAT_LSE2
      tcg: Remove DEBUG_DISAS
      tcg: Remove USE_TCG_OPTIMIZATIONS

 accel/tcg/atomic_template.h                |  93 +-----
 host/include/aarch64/host/atomic128-cas.h  |  45 +++
 host/include/aarch64/host/atomic128-ldst.h |  79 +++++
 host/include/aarch64/host/cpuinfo.h        |  22 ++
 host/include/generic/host/atomic128-cas.h  |  47 +++
 host/include/generic/host/atomic128-ldst.h |  81 +++++
 host/include/generic/host/cpuinfo.h        |   4 +
 host/include/i386/host/cpuinfo.h           |  39 +++
 host/include/x86_64/host/cpuinfo.h         |   1 +
 include/exec/cpu_ldst.h                    |  67 +----
 include/exec/exec-all.h                    |   3 -
 include/qemu/atomic128.h                   | 146 ++-------
 include/tcg/debug-assert.h                 |  17 ++
 include/tcg/tcg.h                          |   9 +-
 migration/xbzrle.h                         |   5 +-
 target/ppc/cpu.h                           |   1 -
 target/ppc/helper.h                        |   9 -
 target/s390x/cpu.h                         |   3 -
 target/s390x/helper.h                      |   4 -
 tcg/aarch64/tcg-target.h                   |   6 +-
 tcg/i386/tcg-target.h                      |  28 +-
 accel/tcg/cpu-exec.c                       |   2 -
 accel/tcg/cputlb.c                         | 211 ++++---------
 accel/tcg/translate-all.c                  |   2 -
 accel/tcg/translator.c                     |   2 -
 accel/tcg/user-exec.c                      | 332 ++++++--------------
 migration/ram.c                            |  34 +--
 migration/xbzrle.c                         | 268 +++++++++--------
 target/arm/tcg/m_helper.c                  |   4 +-
 target/ppc/mem_helper.c                    |  48 ---
 target/ppc/translate.c                     |  34 +--
 target/s390x/tcg/mem_helper.c              | 137 ++-------
 target/s390x/tcg/translate.c               |  30 +-
 target/sh4/translate.c                     |   2 -
 target/sparc/ldst_helper.c                 |  18 +-
 target/sparc/translate.c                   |   2 -
 tcg/tcg.c                                  |  14 +-
 tests/bench/xbzrle-bench.c                 | 469 -----------------------------
 tests/unit/test-xbzrle.c                   |  49 +--
 util/bufferiszero.c                        | 127 +++-----
 util/cpuinfo-aarch64.c                     |  67 +++++
 util/cpuinfo-i386.c                        |  99 ++++++
 MAINTAINERS                                |   3 +
 accel/tcg/atomic_common.c.inc              |  14 -
 accel/tcg/ldst_atomicity.c.inc             | 135 ++-------
 accel/tcg/ldst_common.c.inc                |  24 +-
 meson.build                                |  12 +-
 migration/meson.build                      |   1 -
 target/ppc/translate/fixedpoint-impl.c.inc |  51 +---
 target/s390x/tcg/insn-data.h.inc           |   2 +-
 tcg/aarch64/tcg-target.c.inc               |  40 ---
 tcg/i386/tcg-target.c.inc                  | 123 +-------
 tests/bench/meson.build                    |   6 -
 util/meson.build                           |   6 +
 54 files changed, 1035 insertions(+), 2042 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/aarch64/host/atomic128-ldst.h
 create mode 100644 host/include/aarch64/host/cpuinfo.h
 create mode 100644 host/include/generic/host/atomic128-cas.h
 create mode 100644 host/include/generic/host/atomic128-ldst.h
 create mode 100644 host/include/generic/host/cpuinfo.h
 create mode 100644 host/include/i386/host/cpuinfo.h
 create mode 100644 host/include/x86_64/host/cpuinfo.h
 create mode 100644 include/tcg/debug-assert.h
 delete mode 100644 tests/bench/xbzrle-bench.c
 create mode 100644 util/cpuinfo-aarch64.c
 create mode 100644 util/cpuinfo-i386.c

