Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1F5789FE3
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 17:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaHWh-00086E-1f; Sun, 27 Aug 2023 11:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWX-00084R-Us
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:17:58 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qaHWV-0006Lm-GP
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 11:17:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EE29760B45;
 Sun, 27 Aug 2023 15:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35278C433C8;
 Sun, 27 Aug 2023 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693149470;
 bh=t7djIhBxdxzBftR/8D2uF9d45AwL2exoVvZZTmdReus=;
 h=From:To:Cc:Subject:Date:From;
 b=iTR7wycpoQDbueaROUsbqMGxrxvFcTPX7QAmyy3PBDCicEtsaR8E3cF4xnKNMiQEu
 +oddI5hlkPGPf99yKQwYo+B0L6E9nYeBKiK82Xfp6+lJtQJAATP3/hXMOaAD1TYQ9W
 7USuBsJsO8DS780e44xUStPNPLJbjNXkF5Tfjh5XmX7p16LEenZs8q9jWXuXlMjWig
 uIta/VHn8wVIDbc8P7NlmE7g8s4VYlwNsw8W4tLZ9T9EwoKK5RzbcxINoKdKgFDqRs
 F7KSIJjr9t+V8VSRXtVKYhBFLIqy5XwMoTNloGumUwTml1zzwavizmp1It3XQCN7zm
 NaVqam18r3k3g==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PULL 0/5] Devel hppa priv cleanup2 patches
Date: Sun, 27 Aug 2023 17:17:41 +0200
Message-ID: <20230827151747.290653-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217; envelope-from=deller@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

The following changes since commit 7e5a8bb22368b3555644cb2debd3df24592f3a21:

  Update version for v8.1.0 release (2023-08-22 07:13:44 -0700)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/devel-hppa-priv-cleanup2-pull-request

for you to fetch changes up to 2ad04500543094bc83f5f13dbb099000f010e008:

  target/hppa: Switch to use MMU indices 11-15 (2023-08-27 17:15:19 +0200)

----------------------------------------------------------------
target/hppa: Clean up conversion from/to MMU index and privilege level

Make the conversion between privilege level and QEMU MMU index
consistent, and afterwards switch to MMU indices 11-15.

Signed-off-by: Helge Deller <deller@gmx.de>

----------------------------------------------------------------

Helge Deller (5):
  target/hppa: Add missing PL1 and PL2 privilege levels
  target/hppa: Add privilege to MMU index conversion helpers
  target/hppa: Do not use hardcoded value for tlb_flush_*()
  target/hppa: Use privilege helper in hppa_get_physical_address()
  target/hppa: Switch to use MMU indices 11-15

 target/hppa/cpu.h        | 19 +++++++++++++++----
 target/hppa/helper.c     |  2 +-
 target/hppa/mem_helper.c | 16 ++++++++--------
 target/hppa/translate.c  |  9 +++++----
 4 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.41.0


