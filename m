Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0615E7F37B7
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 21:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Xfw-0006Tt-NR; Tue, 21 Nov 2023 15:48:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r5Xfu-0006TN-UZ
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 15:48:51 -0500
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1r5Xft-0001R9-AI
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 15:48:50 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id F1C41B80E38;
 Tue, 21 Nov 2023 20:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59426C433C8;
 Tue, 21 Nov 2023 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700599725;
 bh=b5JDNG5D1oid5zJva2n6bH3ZY9CIfq10xUCjBJGtfDg=;
 h=From:To:Cc:Subject:Date:From;
 b=R0auejX2eINBNVaG3tmho+MwnI8QP9U0EWG2bv6+9UynDwc8TCkSC9GKMLfZIb5QW
 7y7YDOEh03HT9XFwgd7QcfIPJGXgg6VKMUFuu2RJjthBMV7laR8CaR2Bz+mAuPDcZF
 js9Nmd+YHkae0FSh7SpdJz++3ZdzyxcWoUz1N4ZrHUE5WFDSkZaABCOLxOTNV0zzpU
 m56iVWtl3fUekcJVXoTTOu7fdofi19HA7jkY9WgzYc2Vc0iWKI+yKj0kxOJpk9ovHg
 glvwBe8J0tYL81KatJ9ekxx2rbKeAgiSPEGH8POiqSNUe7AW1zL9i9mqZn17C0oWcA
 iSyunGvPQTRnQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/1 for qemu-8.2] SeaBIOS-hppa v13
Date: Tue, 21 Nov 2023 21:48:40 +0100
Message-ID: <20231121204842.25320-1-deller@kernel.org>
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

Please pull an update of SeaBIOS-hppa to v13 to fix
a system reboot crash in qemu-system-hppa as reported in
https://gitlab.com/qemu-project/qemu/-/issues/1991

Helge Deller (1):
  target/hppa: Update SeaBIOS-hppa to version 13

 pc-bios/hppa-firmware.img | Bin 681332 -> 681388 bytes
 roms/seabios-hppa         |   2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

-- 
2.41.0


