Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 282E295E402
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Aug 2024 16:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siEbu-0002SH-JA; Sun, 25 Aug 2024 10:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbs-0002Re-ES
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1siEbp-0005v0-NF
 for qemu-devel@nongnu.org; Sun, 25 Aug 2024 10:52:51 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-202089e57d8so22147785ad.0
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2024 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724597567; x=1725202367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wUFMsUC88AV4RiT6qrMrOJRw58r01m7e9EfSewF/uRg=;
 b=G5AqYQmDkNWqP37PFOMT5Wl4RMeTT+GQjp55w6JlqMyNFtSf9jom9qZVbpqXlyaefn
 AogCCX2tqTV9Wkfo2Db50fO2Mtf7XwqaZBPE/3T3eT+buUN8ghQhIYEEsLZPEMGd9weT
 rW1K/nSuKoIHK86/ufpA8sJHvM9zceExJLKLM3byu+ojSqhbaVPybocLj32vinQLxPOL
 3QT8/Kd6roCmCjmUtaJ8ZUPkeVL0R/4rBZe8vZIArIwGVOl7DwJL3EOTHAFFYBBFQiKk
 cNyHqxDFiP+PhNQUeuHByfw9ERsVwX6E907gS+EfJZMrx3ayWuhtXfSjK7+dU0vPWv16
 M/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724597567; x=1725202367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUFMsUC88AV4RiT6qrMrOJRw58r01m7e9EfSewF/uRg=;
 b=BWvdXEzTmlmVwI7NkWzwzxN0ioA/jcrDEJCbBYkHNQkYB32UHYBcciJXChC6WerfWH
 E7vrPEe2GjSykB/1n82gFSU3MtsmZqlYB0VTo9OqDdVybsXFjz71rg+QQF0l+4P5d30Q
 tdpNnB/o1KbN5Ixq9N5RZNXxSE6DNdA9AqAwzS4jnZzMVlbBym3jrXGbNVBsNRUnkRmT
 NYXeq7u+uLPH7fQtNOwYa1XXV5Fltm6fGA5abya3D9U9r9GT1qPlvk0BRi27ph6COcEz
 /wzcgY5z+VwrqSKttgk21WKPXJRYqTsLIhh+MhtV0k5wQCgv7qXEOJxmVs2nglEjYxH5
 wkTA==
X-Gm-Message-State: AOJu0YwXosARXCVRfFc1M6D6ccDQrmm88OoCjx0T4ES3j+MFaYpWF2YG
 Pnbb3INw2oTkaAiLdfs20mNAW7b6CBkP0TzIL23skH6ZsDa9HD1LMcbUgh7i5Vkyy0h4jraHFRq
 JprE=
X-Google-Smtp-Source: AGHT+IEKTP3VIHyhfCm2C6Kk05Vv5fCGJ7ITVHvQhUHxynqFdmubKlIeEOu1tjE0Cq+kHEs16GA0mQ==
X-Received: by 2002:a17:902:d488:b0:200:79c1:a69f with SMTP id
 d9443c01a7336-2037fe15a46mr207305695ad.20.1724597567130; 
 Sun, 25 Aug 2024 07:52:47 -0700 (PDT)
Received: from amd.. ([2804:7f0:b400:bb79:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203b0e164b8sm24698805ad.236.2024.08.25.07.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Aug 2024 07:52:46 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 0/4] gdbstub: Add support for MTE in system mode
Date: Sun, 25 Aug 2024 14:52:04 +0000
Message-Id: <20240825145208.46774-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
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

This patchset makes handle_q_memtag, handle_q_isaddresstagged, and
handle_Q_memtag stubs build for system mode, allowing all GDB
'memory-tag' subcommands to work with QEMU gdbstub on aarch64 system
mode.

It also extends the MTE gdbstub tests to run in system mode, sharing the
tests between QEMU user mode and system mode.

For running the tests, a GDB that supports MTE for baremetal targets is
necessary. This support has just landed GDB's master branch.

GDB can be built and installed into a /tmp directory in a simple way:
after cloning GDB's master branch, inside a build directory, configure
GDB and build it:

 $ git clone --depth 1 https://sourceware.org/git/binutils-gdb.git --branch master gdb_master && cd gdb_master
 $ mkdir build && cd build
 $ ../configure --disable-binutils --disable-ld --disable-gold --disable-gas --disable-sim --disable-gprof --disable-gprofng --with-python=python3 --enable-libctf --enable-unit-tests --prefix=/tmp/gdb --with-additional-debug-dirs=/usr/lib/debug --enable-targets=all
 $ make -j 32
 $ make install

Configure QEMU, specifying where GDB is installed. For example:

 $ cd build
 $ ../configure --target-list=aarch64-linux-user,aarch64-softmmu --disable-docs --gdb=/tmp/gdb/bin/gdb
 $ make -j 32
 $ cd..

And finally run the MTE gdbstub tests for QEMU system mode:

 $ make -C build -j 32 run-tcg-tests-aarch64-softmmu

v2:
 - Use of cpu_mmu_index() instead of arm_mmu_idx() (Richard's review)
 - Converted mte.c test to mte.S
 - Set tcr_el1, mair_el1, and sctlr_el1 in mte.S instead of in boot.S (Richard's review) 
 - Allowed use of argparse in test scripts to get passed arguments from run-test.py (Alex's review)
 - Fixed test output to be stored in run-gdbstub-mte.out instead of printed to stdout
 - Added detection of GDB supporting MTE in baremetal
 
v3:
 - No need of ARM_MMU_IDX_COREIDX_MASK with cpu_mmu_index() (Richard's review)
 - Define a symbol for mte_page instead of a whole section (Richard's review)


Cheers,
Gustavo

Gustavo Romero (4):
  gdbstub: Use specific MMU index when probing MTE addresses
  gdbstub: Add support for MTE in system mode
  tests/guest-debug: Support passing arguments to the GDB test script
  tests/tcg/aarch64: Extend MTE gdbstub tests to system mode

 configure                                 |   5 +
 target/arm/gdbstub64.c                    |  21 +++--
 tests/guest-debug/run-test.py             |   6 ++
 tests/guest-debug/test_gdbstub.py         |   5 +
 tests/tcg/aarch64/Makefile.softmmu-target |  49 +++++++++-
 tests/tcg/aarch64/Makefile.target         |   3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     |  71 +++++++++-----
 tests/tcg/aarch64/system/boot.S           |  11 +++
 tests/tcg/aarch64/system/kernel.ld        |   7 ++
 tests/tcg/aarch64/system/mte.S            | 109 ++++++++++++++++++++++
 10 files changed, 252 insertions(+), 35 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.S

-- 
2.34.1


