Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414982C0BD
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:19:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHOL-0004JW-AG; Fri, 12 Jan 2024 08:16:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHO2-0003xB-Hw
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHNz-0008H5-KD
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8paX28OJGfUOS3s6Yvq590PKmGdw1+t0e5WyZbicG+E=; b=BB3XexgjS0ro8IJGP21wE6NVSt
 JsYVa2sUr0/G2yqDUjMU0YNn4O6lvU7glOmYyYBWPpA4c7tYGDjxZG5eywY27LlTuPwzcPapYIk2F
 apmdws7XuowRx/1dQ6C2MixObGrbAK3LNLB/nt3wuQdDzjwRjrkrf5JUPF61ChUqfQMK3ZVBIlJ5A
 cX1GXBOE+2tAk+Y8974I+wvCUo3JJJmxJzQKFZLCBmWi4lYCuz0O/gnUyJrNiA/EsXCqpduMAY+yx
 ACmAku+uWZPfYyotgAUcT1FJfVPTzrI6YNqRw8OnKVQ6zvnGBlYBCwq5ANay88z1QIRdhBvkFiBtj
 tyZnCOfa1GJ4i9rCluRHq2Fzg0Sc+F6sm2fZGNEeN4gyjQr9augH855N9VJhMQiJ79OhGOlLxz7xP
 j5RWWiVFo4R2QrXwc+9NFku1reUUIMBjjlHAxkGPH019ziM5chF7ZyW1eaeJt0ZLAbxqbwZszJlm1
 VpRoYIRiQatFrDwa+KYR0Q65HxlETdDaJiSW5hMndXZdLjAudz/Y/vF8gyJEo+RlTd6XnLLZ9s/bn
 amNAASeGVVWqKFdE1yi3vItI6NMLnO1ti8TqzxZ5FjaFBqFXAH9FvJoMVvRmS+xW1W8gyKE5moQGG
 eTyLb+9CXGO0icy5OAPql52Ftdnfz8cR0WGK/sTUI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHNG-0009Gy-RF; Fri, 12 Jan 2024 13:15:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org, deller@gmx.de,
 linux@roeck-us.net, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 13:15:25 +0000
Message-Id: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/4] esp-pci: fixes for Linux and MS-DOS
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

This series contains fixes for the esp-pci device (am53c974 or dc390) for a
few issues spotted whilst testing the previous ESP series.

Patches 1-3 are fixes for issues found by Helge/Guenter whilst testing the
hppa C3700 machine with the amd53c974/dc390 devices under Linux, whilst patch
4 fixes an issue that was exposed by testing MS-DOS and Windows drivers.

With this series applied on top of the reworked ESP device, it is possible to
boot Linux under qemu-system-hppa without any errors and also boot and install
Win98SE from a DC390 PCI SCSI controller (no IDE!) using an MS-DOS boot floppy.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Based-on: 20240112125420.514425-1-mark.cave-ayland@ilande.co.uk


Mark Cave-Ayland (4):
  esp-pci.c: use correct address register for PCI DMA transfers
  esp-pci.c: generate PCI interrupt from separate ESP and PCI sources
  esp-pci.c: synchronise setting of DMA_STAT_DONE with ESP completion
    interrupt
  esp-pci.c: set DMA_STAT_BCMBLT when BLAST command issued

 hw/scsi/esp-pci.c | 61 +++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

-- 
2.39.2


