Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8740379F316
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:46:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWj0-0007wO-J9; Wed, 13 Sep 2023 16:44:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWix-0007wF-Ak
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:35 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWir-0007NR-9t
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f85EQLiDUBhqOaHd6sZZzCF1CsMMno0wVrqlAwKexag=; b=lxZfgFqBzKbIfGQy4tMuGuoutK
 ANZd8V33JNVbh6lYf8G8tMh1uooYd0RehGHPKwKHvIKXQLN0dEtb4u/s9KkhYyF8Y2P6MsmF7vfyz
 qaAAt4ROizAO7ZSai29gAK9Dx2AF7YjTsZtnuIiGqWiO4I1mTXtTiAo9uZv//F+nwIhXsBtJIxck3
 vM3hvyCgLMdJYfBRB4hCHcaOebVxozcVpF81BCUb8B4SueCD18ImDPFc0jZkVkm8+idahuJQM+Xrd
 xt3VHWsfvYF7Qu9jTv/Fkv8Fui4QjMF0jcWJIMo6cMdJgVRRCOoCX4SkSbs4aG/XU1iw7yktBN3Uv
 2pYjsT4WLKl2+0ag0D/NXJx7yljAd+6PBym8ofYwPDajCeVinXbsU9xKWaWMs6XWu3QjB5vyUBTFD
 UBCKtAhGBdjpxOu/XFwNy6iHaKqlxCZuB6u6GLWarC0GTORYMtLmOsiq8Jix4yEBxbF9FjiQg27LC
 UT85Bsg4pIKaLHWERyic9bs+4sEO4WqQhVpPLLtdWsfw4YnL8SIRLU2KxMxdla+c1EpDPqUMXhAz8
 4+HW3ahlVI4NbInJrw+G5Qi1og7guDPhkTqKLiuwVUZmnryxjqu2oNEX8s9uooXeZTHHz6D/zmE6X
 Rmx8uVja416jdB76LNmZh+Uj6yo/J+FDEoZT4PFb0=;
Received: from [2a00:23c4:8baf:5f00:38a1:1ac:b42:501a]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qgWiZ-0003uU-FV; Wed, 13 Sep 2023 21:44:15 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 13 Sep 2023 21:44:07 +0100
Message-Id: <20230913204410.65650-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8baf:5f00:38a1:1ac:b42:501a
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/3] esp/scsi: minor fixes
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Here are a couple of ESP/SCSI fixes related to issue #1810, along with another
patch that fixes a problem with the DMA enable signal I discovered whilst
testing some future ESP changes.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


Mark Cave-Ayland (3):
  esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
  esp: restrict non-DMA transfer length to that of available data
  scsi-disk: ensure that FORMAT UNIT commands are terminated

 hw/scsi/esp.c       | 5 +++--
 hw/scsi/scsi-disk.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.39.2


