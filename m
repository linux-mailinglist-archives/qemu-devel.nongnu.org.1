Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C78297EF824
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 21:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r455p-0004AK-1W; Fri, 17 Nov 2023 15:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r455n-00049Z-AK
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:05:31 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r455l-0003id-Cu
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 15:05:31 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 9824ECE23F2;
 Fri, 17 Nov 2023 20:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DAEC433C7;
 Fri, 17 Nov 2023 20:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700251524;
 bh=IS/nhEOsiNrACLyKNIN8VlCG4dBnh4wdDR/nHEUdNto=;
 h=From:To:Cc:Subject:Date:From;
 b=eGlze0+4pd+HIPAUJxEKRyv6atM0icagdBMq31TXtcEkAi5JmjgLac2u8TI+hkzgS
 uK9qSWrS832fh42lCQSwgW+7ID4HvmJcJkLgER3d7bqWZyj9UT1NuUY6eNN6a8NxgX
 1lwxq/cgWKto/4p3XwYaUGaRGFHa4VxMgxR/6MZRm68hd1nxgz/ngLz5MnOCcTo62v
 L8aLdpelw2XYITcI7NIzqknzK+JJsF6mbWhxP+hsHq/1rcpa9xR0c2q/H3MYiTsGEZ
 Z5xJCXHaPg/2Q7dEeTy1bhanAU0z+5niqkaPHgbf7UVlzPr/mlUIXrBa2CVMO1RuMD
 0dIcSal8mpjWg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/2] hppa64 fixes
Date: Fri, 17 Nov 2023 21:05:19 +0100
Message-ID: <20231117200521.417330-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55; envelope-from=deller@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 34a5cb6d8434303c170230644b2a7c1d5781d197:

  Merge tag 'pull-tcg-20231114' of https://gitlab.com/rth7680/qemu into staging (2023-11-15 08:05:25 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa64-fixes-pull-request

for you to fetch changes up to 2f926bfd5b79e6219ae65a1e530b38f37d62b384:

  disas/hppa: Show hexcode of instruction along with disassembly (2023-11-17 18:36:36 +0100)

----------------------------------------------------------------
HPPA64 fixes for 8.2

The SHRPD patch fixes a real translation bug which then allows to boot
the 64-bit Linux kernels of the Debian-11 and Debian-12 installation CDs.

The second patch adds the instruction byte sequence to the
assembly log. This is not an actual bug fix, but it's important since
it helps a lot when trying to fix qemu translation bugs on hppa.

----------------------------------------------------------------

Helge Deller (2):
  target/hppa: Fix 64-bit SHRPD instruction
  disas/hppa: Show hexcode of instruction along with disassembly

 disas/hppa.c            | 6 +++++-
 target/hppa/translate.c | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.41.0


