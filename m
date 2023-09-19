Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ADC7A6B5D
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 21:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qigEa-0005wG-LN; Tue, 19 Sep 2023 15:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qigEY-0005vd-E0
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:18:06 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qigEW-00081l-2z
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 15:18:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE6061691;
 Tue, 19 Sep 2023 19:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550C8C433C7;
 Tue, 19 Sep 2023 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695151080;
 bh=JfNEErCZhzMjCz1V22BRScasGGjCNulRuZ4SYeyHFbk=;
 h=From:To:Cc:Subject:Date:From;
 b=lH3LVoAGkG2Ub/VznkS04TpiBtwvlV3cVEINYTY24L+/Mm5psj6Wyp/jStdF1U/vA
 bHa5+ZVFUii/xVD45lsJwlDGimmfPazOcnGN2DKLpWRza8ZjXVPAOXhbDXtp02Uzbc
 Hsrs1ZKTYqZyUq5bs+M398EqrlBrtMuqWSX88oz8SjvKU385tCmN5+yHcwMFp6ZmXV
 NxqZvlmwf/k8u5Kq2Zh0qzT6HvSZccfn/bvpaMLveUjSLnBNzUAzJ0wzyWIDdYwJpv
 ThFA9YXLYlkByojkZBsJ17JlrWO51/yrGrgn7yNerrux0DsCW+OpDkQ+63lDrnB0jm
 p+DwhlGVHwPdw==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL v2 0/8] Hppa btlb patches
Date: Tue, 19 Sep 2023 21:17:48 +0200
Message-ID: <20230919191757.98889-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
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

The following changes since commit 9ef497755afc252fb8e060c9ea6b0987abfd20b6:

  Merge tag 'pull-vfio-20230911' of https://github.com/legoater/qemu into staging (2023-09-11 09:13:08 -0400)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/hppa-btlb-pull-request

for you to fetch changes up to 5b1270ef1477bb7f240c3bfe2cd8b0fe4721fd51:

  linux-user/hppa: lock both words of function descriptor (2023-09-19 21:12:18 +0200)

----------------------------------------------------------------
Block-TLB support and linux-user fixes for hppa target

All 32-bit hppa CPUs allow a fixed number of TLB entries to have a
different page size than the default 4k.
Those are called "Block-TLBs" and are created at startup by the
operating system and managed by the firmware of hppa machines
through the firmware PDC_BLOCK_TLB call.

This patchset adds the necessary glue to SeaBIOS-hppa and
qemu to allow up to 16 BTLB entries in the emulation.

Two patches from Mikulas Patocka fix signal delivery issues
in linux-user on hppa.

----------------------------------------------------------------

Helge Deller (6):
  target/hppa: Update to SeaBIOS-hppa version 9
  target/hppa: Allow up to 16 BTLB entries
  target/hppa: Report and clear BTLBs via fw_cfg at startup
  target/hppa: Add BTLB support to hppa TLB functions
  target/hppa: Extract diagnose immediate value
  target/hppa: Wire up diag instruction to support BTLB

Mikulas Patocka (2):
  linux-user/hppa: clear the PSW 'N' bit when delivering signals
  linux-user/hppa: lock both words of function descriptor

 hw/hppa/machine.c         |  10 +--
 linux-user/hppa/signal.c  |   6 +-
 pc-bios/hppa-firmware.img | Bin 720216 -> 732376 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.h         |  11 ++-
 target/hppa/helper.h      |   1 +
 target/hppa/insns.decode  |   2 +-
 target/hppa/int_helper.c  |   2 +-
 target/hppa/mem_helper.c  | 179 ++++++++++++++++++++++++++++++++------
 target/hppa/op_helper.c   |   3 +-
 target/hppa/translate.c   |  15 +++-
 11 files changed, 188 insertions(+), 43 deletions(-)

-- 
2.41.0


