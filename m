Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78ABB716D01
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44Zo-0000nk-Gs; Tue, 30 May 2023 15:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZW-0000ke-O9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ZU-0000sD-NP
 for qemu-devel@nongnu.org; Tue, 30 May 2023 14:59:54 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso3665484b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473191; x=1688065191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mUjnTj+/HEdql/nR/Y88wioWASWtay8KmAmlQm3wBtk=;
 b=MUfIpRgCxmg7YTeaKMqlmMRe0N1WRzjaiEin98mfcQljoVNLMMiCSOhWwGTuiih9gl
 zOiHn+mq+wXPaKBwZFQET1yHtbTgmNgSxLtmaH+fKP9ExbM02VB1D2M6eMnMPF5mjkwv
 iDXPuTqDxiqIplw5sML131qqXGCaFl+mg0uAguOPMAF3uh/SB2XHcli8KEW6Clk9hWKd
 ZCkZpVSnYFQoMWjyH87EJw/AT5ALz0qGt/jY3vTTfTMJ75Z6A93wZORwV0GuKylOG99C
 thkeOKW+ufEKL4apqb7xV00vo+nxHiAc4mDrXzwd2QMY0vyL0I+RPmTXKEndKj8MZDLf
 OGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473191; x=1688065191;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUjnTj+/HEdql/nR/Y88wioWASWtay8KmAmlQm3wBtk=;
 b=FBNwQ51MPUZi2Y9em5wHxIyhCtUIKiAcwdFC1kVb8XvQmH6404JQjT16i0YG/b1131
 Ioywt2qDyZ7gF7+92Ip6UA3jHaIZkQZNxKiYBoJk/5bwzQaZFuaUuXhzvBRIlZ3dA6+O
 BDDvld8TO9AshSD6cFIEZWCiycmT71RMeW2Yiu7KcV6Ov/ODHlmfAKiO7LLtWolUeIBg
 6j1Pg2IwLnas/qe2xd/Vs3KyX1TCOconPwshTe2+mk8tp2x5bPXP/z0vRga8bgIGJp8z
 k8UTKlZRuk6vRbQE8dGij0Rwoh01no/OQWtw4fMwSLBos5wLSg9EHDQqEOeywA5d0R5f
 P/lg==
X-Gm-Message-State: AC+VfDyBN7grI8hmhyYv8lB8q5b/NCinEltqVVI580Eym4mFxdFdbU25
 bfbTTZzRJ+hYGbbmLXvQOVYoIeT16WkD8M2Zjbo=
X-Google-Smtp-Source: ACHHUZ7WtPFkcVq6NpKVfDHGNJcqIya+BAGpIz1jFtbaIm8bMFEJCP7w7PoP9sQlvZPSmuUPxjn+Jg==
X-Received: by 2002:a05:6a20:160b:b0:104:35ec:c25c with SMTP id
 l11-20020a056a20160b00b0010435ecc25cmr4154406pzj.41.1685473191099; 
 Tue, 30 May 2023 11:59:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/27] tcg patch queue
Date: Tue, 30 May 2023 11:59:22 -0700
Message-Id: <20230530185949.410208-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

The following changes since commit 7fe6cb68117ac856e03c93d18aca09de015392b0:

  Merge tag 'pull-target-arm-20230530-1' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2023-05-30 08:02:05 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20230530

for you to fetch changes up to 276d77de503e8f5f5cbd3f7d94302ca12d1d982e:

  tests/decode: Add tests for various named-field cases (2023-05-30 10:55:39 -0700)

----------------------------------------------------------------
Improvements to 128-bit atomics:
  - Separate __int128_t type and arithmetic detection
  - Support 128-bit load/store in backend for i386, aarch64, ppc64, s390x
  - Accelerate atomics via host/include/
Decodetree:
  - Add named field syntax
  - Move tests to meson

----------------------------------------------------------------
Peter Maydell (5):
      docs: Document decodetree named field syntax
      scripts/decodetree: Pass lvalue-formatter function to str_extract()
      scripts/decodetree: Implement a topological sort
      scripts/decodetree: Implement named field support
      tests/decode: Add tests for various named-field cases

Richard Henderson (22):
      tcg: Fix register move type in tcg_out_ld_helper_ret
      accel/tcg: Fix check for page writeability in load_atomic16_or_exit
      meson: Split test for __int128_t type from __int128_t arithmetic
      qemu/atomic128: Add x86_64 atomic128-ldst.h
      tcg/i386: Support 128-bit load/store
      tcg/aarch64: Rename temporaries
      tcg/aarch64: Reserve TCG_REG_TMP1, TCG_REG_TMP2
      tcg/aarch64: Simplify constraints on qemu_ld/st
      tcg/aarch64: Support 128-bit load/store
      tcg/ppc: Support 128-bit load/store
      tcg/s390x: Support 128-bit load/store
      accel/tcg: Extract load_atom_extract_al16_or_al8 to host header
      accel/tcg: Extract store_atom_insert_al16 to host header
      accel/tcg: Add x86_64 load_atom_extract_al16_or_al8
      accel/tcg: Add aarch64 lse2 load_atom_extract_al16_or_al8
      accel/tcg: Add aarch64 store_atom_insert_al16
      tcg: Remove TCG_TARGET_TLB_DISPLACEMENT_BITS
      decodetree: Add --test-for-error
      decodetree: Fix recursion in prop_format and build_tree
      decodetree: Diagnose empty pattern group
      decodetree: Do not remove output_file from /dev
      tests/decode: Convert tests to meson

 docs/devel/decodetree.rst                         |  33 ++-
 meson.build                                       |  15 +-
 host/include/aarch64/host/load-extract-al16-al8.h |  40 ++++
 host/include/aarch64/host/store-insert-al16.h     |  47 ++++
 host/include/generic/host/load-extract-al16-al8.h |  45 ++++
 host/include/generic/host/store-insert-al16.h     |  50 ++++
 host/include/x86_64/host/atomic128-ldst.h         |  68 ++++++
 host/include/x86_64/host/load-extract-al16-al8.h  |  50 ++++
 include/qemu/int128.h                             |   4 +-
 tcg/aarch64/tcg-target-con-set.h                  |   4 +-
 tcg/aarch64/tcg-target-con-str.h                  |   1 -
 tcg/aarch64/tcg-target.h                          |  12 +-
 tcg/arm/tcg-target.h                              |   1 -
 tcg/i386/tcg-target.h                             |   5 +-
 tcg/mips/tcg-target.h                             |   1 -
 tcg/ppc/tcg-target-con-set.h                      |   2 +
 tcg/ppc/tcg-target-con-str.h                      |   1 +
 tcg/ppc/tcg-target.h                              |   4 +-
 tcg/riscv/tcg-target.h                            |   1 -
 tcg/s390x/tcg-target-con-set.h                    |   2 +
 tcg/s390x/tcg-target.h                            |   3 +-
 tcg/sparc64/tcg-target.h                          |   1 -
 tcg/tci/tcg-target.h                              |   1 -
 tests/decode/err_field10.decode                   |   7 +
 tests/decode/err_field7.decode                    |   7 +
 tests/decode/err_field8.decode                    |   8 +
 tests/decode/err_field9.decode                    |  14 ++
 tests/decode/succ_named_field.decode              |  19 ++
 tcg/tcg.c                                         |   4 +-
 accel/tcg/ldst_atomicity.c.inc                    |  80 +------
 tcg/aarch64/tcg-target.c.inc                      | 243 +++++++++++++++-----
 tcg/i386/tcg-target.c.inc                         | 191 +++++++++++++++-
 tcg/ppc/tcg-target.c.inc                          | 108 ++++++++-
 tcg/s390x/tcg-target.c.inc                        | 107 ++++++++-
 scripts/decodetree.py                             | 265 ++++++++++++++++++++--
 tests/decode/check.sh                             |  24 --
 tests/decode/meson.build                          |  64 ++++++
 tests/meson.build                                 |   5 +-
 38 files changed, 1312 insertions(+), 225 deletions(-)
 create mode 100644 host/include/aarch64/host/load-extract-al16-al8.h
 create mode 100644 host/include/aarch64/host/store-insert-al16.h
 create mode 100644 host/include/generic/host/load-extract-al16-al8.h
 create mode 100644 host/include/generic/host/store-insert-al16.h
 create mode 100644 host/include/x86_64/host/atomic128-ldst.h
 create mode 100644 host/include/x86_64/host/load-extract-al16-al8.h
 create mode 100644 tests/decode/err_field10.decode
 create mode 100644 tests/decode/err_field7.decode
 create mode 100644 tests/decode/err_field8.decode
 create mode 100644 tests/decode/err_field9.decode
 create mode 100644 tests/decode/succ_named_field.decode
 delete mode 100755 tests/decode/check.sh
 create mode 100644 tests/decode/meson.build

