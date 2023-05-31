Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF05717DEC
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 13:23:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Jv9-00005Q-Vt; Wed, 31 May 2023 07:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Jul-0008U5-2j; Wed, 31 May 2023 07:22:54 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1q4Juh-0006OR-Jl; Wed, 31 May 2023 07:22:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4C625628FE;
 Wed, 31 May 2023 11:22:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CA2C4339B;
 Wed, 31 May 2023 11:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685532164;
 bh=z5SffpKIWfX1XJolbtBvJVAkGB89HsC1bTP1NQPmykU=;
 h=From:To:Cc:Subject:Date:From;
 b=f65hAQ5IVRLC+zaA++OMCn7KICRcG/A+GGk9nFp5PpgapGdiXL0OhlyTHBlG2mXiD
 lyOgo26ubEpyDQPV7pOb7bMUUAx1fNjRFSypouXfLJYkPIhUyY+Qzscg+W8dkYhPwi
 li7jGpiflAmrUsjfenDtzzE7irDrS7t5hRBD2qu1dU2m0UESa5gRe7aCqAyHrlDSrI
 c4nyItodyJQJ4V7c0Pld15rHEZGCmHBJWo6X+yV9O4/qXH9io6Il3jKQMzO3Yn+Ywv
 2dY4cDCILmRmSasZL3KTaZ93QzDMJSJvDuZ+0o15qswckqx925FibXgSWIVMNYLWyb
 IO6rwR+pzF7xQ==
From: Ard Biesheuvel <ardb@kernel.org>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 0/2] Implement AES on ARM using x86 instructions and vv
Date: Wed, 31 May 2023 13:22:37 +0200
Message-Id: <20230531112239.3164777-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3330; i=ardb@kernel.org;
 h=from:subject; bh=z5SffpKIWfX1XJolbtBvJVAkGB89HsC1bTP1NQPmykU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIaVc96dKZ+KcKZ7BvMnHBf7v3Ov90Zntg7xSR6GtUu4n5
 WdVBhs6SlkYxDgYZMUUWQRm/3238/REqVrnWbIwc1iZQIYwcHEKwETsahn+h196XHI/JrYsxSZ9
 csq+xQzh9dPfZjB1Wzjuqz7rVNb9kOF/nGx1ReZCCYeiyfrHdK7favv+aYvBufn6szOVv7vMOOX
 ODAA=
X-Developer-Key: i=ardb@kernel.org; a=openpgp;
 fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Use the host native instructions to implement the AES instructions
exposed by the emulated target. The mapping is not 1:1, so it requires a
bit of fiddling to get the right result.

This is still RFC material - the current approach feels too ad-hoc, but
given the non-1:1 correspondence, doing a proper abstraction is rather
difficult.

Changes since v1/RFC:
- add second patch to implement x86 AES instructions on ARM hosts - this
  helps illustrate what an abstraction should cover.
- use cpuinfo framework to detect host support for AES instructions.
- implement ARM aesimc using x86 aesimc directly

Patch #1 produces a 1.5-2x speedup in tests using the Linux kernel's
tcrypt benchmark (mode=500)

Patch #2 produces a 2-3x speedup. The discrepancy is most likely due to
the fact that ARM uses two instructions to implement a single AES round,
whereas x86 only uses one.

Note that using the ARM intrinsics is fiddly with Clang, as it does not
declare the prototypes unless some builtin CPP macro (__ARM_FEATURE_AES)
is defined, which will be set by the compiler based on the command line
arch/cpu options. However, setting this globally for a compilation unit
is dubious, given that we test cpuinfo for AES support, and only emit
the instructions conditionally. So I used inline asm() instead.

As for the design of an abstraction: I imagine we could introduce a
host/aes.h API that implements some building blocks that the TCG helper
implementation could use.

Quoting from my reply to Richard:

Using the primitive operations defined in the AES paper, we basically
perform the following transformation for n rounds of AES (for n in {10,
12, 14})

for (n-1 rounds) {
  AddRoundKey
  ShiftRows
  SubBytes
  MixColumns
}
AddRoundKey
ShiftRows
SubBytes
AddRoundKey

AddRoundKey is just XOR, but it is incorporated into the instructions
that combine a couple of these steps.

So on x86, we have

aesenc:
  ShiftRows
  SubBytes
  MixColumns
  AddRoundKey

aesenclast:
  ShiftRows
  SubBytes
  AddRoundKey

and on ARM we have

aese:
  AddRoundKey
  ShiftRows
  SubBytes

aesmc:
  MixColumns

So a generic routine that does only ShiftRows+SubBytes could be backed by
x86's aesenclast and ARM's aese, using a NULL round key argument in each
case. Then, it would be up to the TCG helper code for either ARM or x86
to incorporate those routines in the right way.

I suppose it really depends on whether there is a third host
architecture that could make use of this, and how its AES instructions
map onto the primitive AES ops above.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <f4bug@amsat.org>

Ard Biesheuvel (2):
  target/arm: use x86 intrinsics to implement AES instructions
  target/i386: Implement AES instructions using AArch64 counterparts

 host/include/aarch64/host/cpuinfo.h |  1 +
 host/include/i386/host/cpuinfo.h    |  1 +
 target/arm/tcg/crypto_helper.c      | 37 ++++++++++-
 target/i386/ops_sse.h               | 69 ++++++++++++++++++++
 util/cpuinfo-aarch64.c              |  1 +
 util/cpuinfo-i386.c                 |  1 +
 6 files changed, 107 insertions(+), 3 deletions(-)

-- 
2.39.2


