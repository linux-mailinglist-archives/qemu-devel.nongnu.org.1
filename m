Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29BC70A90F
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:27:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PPm-0003W2-Pc; Sat, 20 May 2023 12:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPk-0003Un-Bm
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:40 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PPi-000340-EL
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:26:40 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae50da739dso29708815ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684599996; x=1687191996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gW6qXN1WtXN+SLgifrY57n7JMPAv6WKP6fLj1EEUBDI=;
 b=fyhMRrkiKPuoQ4uUBEfhdM4FzTgmt1imfcX11Dz8IdooQ/YE54TQD4iLHBUgxC6rcQ
 P7Z621YIbvxQaTrSKBTX7EGDpTk0qOf1QXODM8XhpVgN4qb4mCMvAfdWKJhRZ/C5DJPK
 vNde2HFu/ugW0G6XZS8MYYBmR17zNVuvcS1nnlm9VxO45J0RmywAppU/mjcMXkPdq/y0
 5UuOK1pfPfGqHXlDg4B+i4lV8twSGKLFbWz6NvjVMl238xdnSzFjTVejdvhLnv6RwZvU
 cUWC18UJMSg0vMRKSwy7cxgVKlTcpw7o1doFjzOQ6fABq1WMdpL1OQETZ/L1WETihCnf
 uomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684599996; x=1687191996;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gW6qXN1WtXN+SLgifrY57n7JMPAv6WKP6fLj1EEUBDI=;
 b=KzrUZuZuYdpBPDjDrUbBJmTg7Fh7Ri3OyrYXFujSqAF1fRp+HbnIAK5FEufd+HByHl
 Vw0EK7d3HWHmYaojnkdV/Y/hyTT2/SBc1JgTGQL7yBUVUea4lpbcei4gV6FSLlEy5KV2
 0wc9tqmeMXoV1KzXtJpheHjzfbUI462S9zaaIoIf4J9cRfr+eJa09R9qPf4seWAZjp9z
 1WLjxA4ML4t+EzSxHQmmfDMQKSb6tS6N56pRCTqAeGbKxC7HyKVVecrMJ9iJMNqPdeNj
 dPW7gVTvZE3Ef7crS5S/gkBo2z+DAtq2RV2IRdZervch3ygFrvSuOYn2uI9vdg7WB8YF
 tXmQ==
X-Gm-Message-State: AC+VfDxUmSi2Dfe9WQoKPNCszTrxXYf4fxaBy7FhfWBIZDomSkHIKpHT
 7ZFOFQ3sY0Km5+ancx6Es5uqVmGNOh533UGYh6k=
X-Google-Smtp-Source: ACHHUZ7ynIapO3EcenDSb2fo0+e7eE+G7XjiYq57sKxxwhPJbrGi+yS9rdVCMSbl/xRqy/F+PwE0Sg==
X-Received: by 2002:a17:902:b496:b0:1ac:aac1:e344 with SMTP id
 y22-20020a170902b49600b001acaac1e344mr6258712plr.36.1684599996388; 
 Sat, 20 May 2023 09:26:36 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 00/27] accel/tcg: Improvements to atomic128.h
Date: Sat, 20 May 2023 09:26:07 -0700
Message-Id: <20230520162634.3991009-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Peter raised a good point about it not being ideal to mix inline assembly
into the middle of accel/tcg/ldst_atomicity.c.  We now have a host-specific
structure in which to put those.

Additionally, Peter noticed that clang will incorrectly use a read-write
sequence for __atomic_load_16 on AArch64, which might fault for our usage
in user-only emulation.

Fixing both of these simultaneously splits atomic16_read into
atomic16_read_{ro,rw}, because there is in fact room for both
in the emulation -- we currently use cmpxchg directly where we
can allow a read with write side-effect.

Additionally, prepare for runtime detection.  Both x86_64 and aarch64
have architecture extensions that *do* allow 128-bit load and store
without using cmpxchg.

To make runtime detection work, we need to remove preprocessor use
of HAVE_ATOMIC128*.  It turns out this was only used for the legacy
helper_atomic_{ld,st}o_{be,le}_mmu functions.  These uses within
ppc64 and s390x can now be updated to tcg_gen_qemu_{ld,st}_i128 and
cpu_{ld,st}16_mmu.  After doing that, we can remove the problematic
#if's entirely.


r~


Cc: qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Greg Kurz <groug@kaod.org>

Cc: qemu-s390x@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>


Richard Henderson (27):
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
  qemu/atomic128: Add x86_64 atomic128-ldst.h

 accel/tcg/atomic_template.h                |  93 +---
 host/include/aarch64/host/atomic128-cas.h  |  45 ++
 host/include/aarch64/host/atomic128-ldst.h |  79 ++++
 host/include/aarch64/host/cpuinfo.h        |  22 +
 host/include/generic/host/atomic128-cas.h  |  47 +++
 host/include/generic/host/atomic128-ldst.h |  81 ++++
 host/include/generic/host/cpuinfo.h        |   4 +
 host/include/i386/host/cpuinfo.h           |  39 ++
 host/include/x86_64/host/atomic128-ldst.h  |  54 +++
 host/include/x86_64/host/cpuinfo.h         |   1 +
 include/exec/cpu_ldst.h                    |  67 +--
 include/qemu/atomic128.h                   | 146 +------
 include/tcg/debug-assert.h                 |  17 +
 include/tcg/tcg.h                          |   9 +-
 migration/xbzrle.h                         |   5 +-
 target/ppc/cpu.h                           |   1 -
 target/ppc/helper.h                        |   9 -
 target/s390x/cpu.h                         |   3 -
 target/s390x/helper.h                      |   4 -
 tcg/aarch64/tcg-target.h                   |   6 +-
 tcg/i386/tcg-target.h                      |  28 +-
 accel/tcg/cputlb.c                         | 211 +++------
 accel/tcg/user-exec.c                      | 332 ++++-----------
 migration/ram.c                            |  34 +-
 migration/xbzrle.c                         | 268 ++++++------
 target/arm/tcg/m_helper.c                  |   4 +-
 target/ppc/mem_helper.c                    |  48 ---
 target/ppc/translate.c                     |  34 +-
 target/s390x/tcg/mem_helper.c              | 136 ++----
 target/s390x/tcg/translate.c               |  30 +-
 target/sparc/ldst_helper.c                 |  18 +-
 tests/bench/xbzrle-bench.c                 | 469 ---------------------
 tests/unit/test-xbzrle.c                   |  49 +--
 util/bufferiszero.c                        | 126 ++----
 util/cpuinfo-aarch64.c                     |  67 +++
 util/cpuinfo-i386.c                        |  99 +++++
 accel/tcg/atomic_common.c.inc              |  14 -
 accel/tcg/ldst_atomicity.c.inc             | 135 +-----
 accel/tcg/ldst_common.c.inc                |  24 +-
 meson.build                                |  10 +-
 migration/meson.build                      |   1 -
 target/ppc/translate/fixedpoint-impl.c.inc |  51 +--
 target/s390x/tcg/insn-data.h.inc           |   2 +-
 tcg/aarch64/tcg-target.c.inc               |  40 --
 tcg/i386/tcg-target.c.inc                  | 123 +-----
 tests/bench/meson.build                    |   6 -
 util/meson.build                           |   6 +
 47 files changed, 1081 insertions(+), 2016 deletions(-)
 create mode 100644 host/include/aarch64/host/atomic128-cas.h
 create mode 100644 host/include/aarch64/host/atomic128-ldst.h
 create mode 100644 host/include/aarch64/host/cpuinfo.h
 create mode 100644 host/include/generic/host/atomic128-cas.h
 create mode 100644 host/include/generic/host/atomic128-ldst.h
 create mode 100644 host/include/generic/host/cpuinfo.h
 create mode 100644 host/include/i386/host/cpuinfo.h
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h
 create mode 100644 host/include/x86_64/host/cpuinfo.h
 create mode 100644 include/tcg/debug-assert.h
 delete mode 100644 tests/bench/xbzrle-bench.c
 create mode 100644 util/cpuinfo-aarch64.c
 create mode 100644 util/cpuinfo-i386.c

-- 
2.34.1


