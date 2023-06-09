Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 850CC72A2A2
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:53:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hD6-0000xE-CD; Fri, 09 Jun 2023 14:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD0-0000w8-9Z; Fri, 09 Jun 2023 14:51:38 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hCy-0002ln-Ij; Fri, 09 Jun 2023 14:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4Kz8y0Af0iyiDaVRfnHiGCVR/DdurHENOOX2nebe9cQ=; b=BQ++Bhi+ok440NAeZnjchS5FJf
 GNoRy0499epSXw1N0dsNacD3KvuFxryFOrNiSRsFXEHAJD6jjj2TiOEtrPSSHwxPY4ApsIWSB7IIU
 CsABOXL5tygySDTcnf/y4AoFg4HCDpijihVxZFU+rCr6s4wCGLC9vjYJcVzF4QQL7rCmCYwAMp3PM
 3buyWVikjOQKDMmphBcEnyKfAN6ijmnx0kRRJ69OuaTtsoi/Ai9CibnpaIr4rdsudpHvVl4nEVRVe
 GzPZHdUUHWG8jWEXoItvwPTFDuNFBd8Z8wPFbVED2Mgxl3YnN0pxw6/nxrtd396/dLqsr5FpvrgF3
 pT2wAW8PsQ/FNpkROvvjTDzBNEH1E7AlKnfHAtR/VCIMadl4LvA0ULgDSE8Xi3k9DAXz3ozYW2e9W
 liO65/1zI1tAQCz3zOXFVm4I0Nb8j7f+kxRfUQ6C0R9ZL8Rou8I//nBzqFO1nEAyMHUVRVzP2jvt2
 lCLYWuroE50buWzlSqcC6/KH2Hs8gSU5m73tInsqYqLOqDiOke9FpoB3adqXtrdICNaP9Qvf4b0Mr
 yWirx7PH11qyZOsGDLsk92tWQTZbo3oOSroCDP4xMyFdr8OmNlbkSNcN38Hhyxnzag+jEvSpuMct0
 PQDKQsBQX/5pho76WTtEWdJAvbB1dAfFUjz73N6a4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hCm-0000p5-5w; Fri, 09 Jun 2023 19:51:28 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:14 +0100
Message-Id: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/5] cmd646: move device-specific BMDMA registers to separate
 memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series follows on from a comment I made on Bernhard's PCI IDE tidy-up series [1]
that it should be possible to further consolidate the BMDMA registers into the PCI
IDE device with some minor rework to the CMD646 device.

It does this by moving the CMD646 device-specific BMDMA registers to a separate
memory region, and then aliasing the device-specific BMDMA registers from 
the existing BMDMAState memory region. With this in place it should be fairly
trivial to extend the consolidation implementation in [1].

Before "info mtree" output:
    0000000000008200-000000000000820f (prio 1, i/o): cmd646-bmdma
      0000000000008200-0000000000008203 (prio 0, i/o): cmd646-bmdma-bus
      0000000000008204-0000000000008207 (prio 0, i/o): cmd646-bmdma-ioport
      0000000000008208-000000000000820b (prio 0, i/o): cmd646-bmdma-bus
      000000000000820c-000000000000820f (prio 0, i/o): cmd646-bmdma-ioport

After "info mtree" output:
    0000000000008200-000000000000820f (prio 1, i/o): cmd646-bmdma
      0000000000008200-0000000000008203 (prio 0, i/o): cmd646-bmdma-bus
        0000000000008201-0000000000008201 (prio 0, i/o): alias cmd646-bmdma[1] @cmd646-bmdma 0000000000000001-0000000000000001
        0000000000008203-0000000000008203 (prio 0, i/o): alias cmd646-bmdma[3] @cmd646-bmdma 0000000000000003-0000000000000003
      0000000000008204-0000000000008207 (prio 0, i/o): cmd646-bmdma-ioport
      0000000000008208-000000000000820b (prio 0, i/o): cmd646-bmdma-bus
        0000000000008209-0000000000008209 (prio 0, i/o): alias cmd646-bmdma[1] @cmd646-bmdma 0000000000000001-0000000000000001
        000000000000820b-000000000000820b (prio 0, i/o): alias cmd646-bmdma[3] @cmd646-bmdma 0000000000000003-0000000000000003
      000000000000820c-000000000000820f (prio 0, i/o): cmd646-bmdma-ioport

The series was tested by confirming that breakpoints on the CMD646-specific
BMDMA registers were being hit and that my test Debian install ISO still
boots under qemu-system-sparc64.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

[1] https://patchew.org/QEMU/20230422150728.176512-1-shentey@gmail.com/


Mark Cave-Ayland (5):
  cmd646: checkpatch fixes
  cmd646: create separate header and QOM type for CMD646_IDE
  cmd646: use TYPE_CMD646_IDE instead of hardcoded "cmd646-ide" string
  cmd646: rename cmd646_bmdma_ops to bmdma_ops
  cmd646: move device-specific BMDMA registers to separate memory region

 hw/alpha/dp264.c        |   4 +-
 hw/ide/cmd646.c         | 122 ++++++++++++++++++++++++++++++----------
 hw/sparc64/sun4u.c      |   4 +-
 include/hw/ide/cmd646.h |  42 ++++++++++++++
 4 files changed, 139 insertions(+), 33 deletions(-)
 create mode 100644 include/hw/ide/cmd646.h

-- 
2.30.2


