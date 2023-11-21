Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1167F3920
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 23:28:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ZCZ-0008G8-Tl; Tue, 21 Nov 2023 17:26:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r5ZCS-0008Fa-Uj
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:26:35 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r5ZCR-0004LZ-6a
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 17:26:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 393CE61B71;
 Tue, 21 Nov 2023 22:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C4BC433C7;
 Tue, 21 Nov 2023 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700605588;
 bh=wdeDRxs15THQLtJ+H2Ism+fLWXU59/oUCpNmSf2cdBw=;
 h=From:To:Cc:Subject:Date:From;
 b=E1sXu3qEa7bsO2674bRLz4KlqeILZrVpxyvEMMfcR0J5XZIzGYyLjF/kibTPsdGEw
 x3d5ALUu7NchJ8DOFW3HRnKNr1CIdxTjnzL3SFmBqQpz3V9uvVPNRqz64iW2jfTFde
 +yacvMBJKyVSa3Vy0mnt5ztH4SJjNnSf2756YW98GDPw8riZET0z1mR7SY7dOS5G0q
 b4VR2EqFEhX5dex6RyVH5hFtOQPReiCEHrT1Wqrd08AatbMi6esdMk2Osz/QiY1YQf
 RK2LPutzO+I1QMkVxHD6az3Y7WqWq8yKt65nL5fMbraPku9dpeyMOJmx8o+f1Yxf1e
 VbjiWkaOyPdog==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 0/1] Seabios hppa v13 patches
Date: Tue, 21 Nov 2023 23:26:24 +0100
Message-ID: <20231121222625.131341-1-deller@kernel.org>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
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

The following changes since commit ea6a33e776f0a4bda94460ab0945d953fc801dd1:

  Revert "tests/avocado: Enable reverse_debugging.py tests in gitlab CI" (2023-11-21 10:28:55 -0500)

are available in the Git repository at:

  https://github.com/hdeller/qemu-hppa.git tags/seabios-hppa-v13-pull-request

for you to fetch changes up to 69c224816eeb6c760bb1e73073da03a19368df0e:

  target/hppa: Update SeaBIOS-hppa to version 13 (2023-11-21 21:23:03 +0100)

----------------------------------------------------------------
SeaBIOS-hppa v13

Please pull an update of SeaBIOS-hppa to v13 to fix
a system reboot crash in qemu-system-hppa as reported in
https://gitlab.com/qemu-project/qemu/-/issues/1991

----------------------------------------------------------------

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 13

 pc-bios/hppa-firmware.img | Bin 681332 -> 681388 bytes
 roms/seabios-hppa         |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


