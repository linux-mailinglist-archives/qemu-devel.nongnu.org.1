Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201CD7A2298
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 17:40:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhAuH-0003FV-Q8; Fri, 15 Sep 2023 11:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAuC-0003F2-Cu
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:52 -0400
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1qhAu9-0007KS-Hh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 11:38:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B85EEB82CC7;
 Fri, 15 Sep 2023 15:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D707C433C8;
 Fri, 15 Sep 2023 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1694792324;
 bh=g0TXvUhufHEnZNGcQlb60TNhnSlA3Q1CgMsvY7Ipt1c=;
 h=From:To:Cc:Subject:Date:From;
 b=PZxbFr0awlY7kFq+hzhif/kY3lauUMflVAE5fvROICMTMaF5qtFzf1+3irSAqTCsu
 TC7E7EV8kq0KIA8TiMbyGjfYll/Li5VcLK6ZHti2nbTW8JCQticNfFEui6OGIdCEyR
 PNy9vQps2jLX6jKb7G8XgYENjVi8YQA30+EfRqfLcLxH/IbfwU7UMSzND/jenZBnXS
 +7xHftRBLsQu9HUUzGsVn0GIslsfoKi9kuu802iB3buonQ1PUxfouKIeR9DZUEI/CN
 Ax9UMRqmssM/g6d2dGiW2eKTm4/Ms8QmG1rqoTG8JNTEBaAXUuOLHGmSGgg4dGSrtt
 8iSot5gEHOA+Q==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 0/6] Add Block-TLB support for hppa target
Date: Fri, 15 Sep 2023 17:38:35 +0200
Message-ID: <20230915153841.57564-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4601:e00::1;
 envelope-from=deller@kernel.org; helo=ams.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

All 32-bit hppa CPUs allow a fixed number of TLB entries to have a
different page size than the default 4k.
Those are called "Block-TLBs" and are created at startup by the
operating system and managed by the firmware of hppa machines
through the firmware PDC_BLOCK_TLB call.

This patchset adds the necessary glue to SeaBIOS-hppa and
qemu to allow up to 16 BTLB entries in the emulation.

Signed-off-by: Helge Deller <deller@gmx.de>

Patch series can be pulled from branch
https://github.com/hdeller/qemu-hppa.git   hppa-btlb

v2:
- no code changes, just rephrased commit title and
  commit message of patches #3 and #4

Helge Deller (6):
  target/hppa: Update to SeaBIOS-hppa version 9
  target/hppa: Allow up to 16 BTLB entries
  target/hppa: Report and clear BTLBs via fw_cfg at startup
  target/hppa: Add BTLB support to hppa TLB functions
  target/hppa: Extract diagnose immediate value
  target/hppa: Wire up diag instruction to support BTLB

 hw/hppa/machine.c         |  10 +--
 pc-bios/hppa-firmware.img | Bin 720216 -> 732376 bytes
 roms/seabios-hppa         |   2 +-
 target/hppa/cpu.h         |  11 ++-
 target/hppa/helper.h      |   1 +
 target/hppa/insns.decode  |   2 +-
 target/hppa/int_helper.c  |   2 +-
 target/hppa/mem_helper.c  | 179 ++++++++++++++++++++++++++++++++------
 target/hppa/op_helper.c   |   3 +-
 target/hppa/translate.c   |  15 +++-
 10 files changed, 184 insertions(+), 41 deletions(-)

-- 
2.41.0


