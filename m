Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCBC7D7F2D
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 10:58:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvwB5-0005j2-Dx; Thu, 26 Oct 2023 04:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwB2-0005iF-B7
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:17 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAy-00060T-SX
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 04:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xzbl2+nmqsuvbaVNTBKEPdqvnkGn+rbkethfRvA1FuI=; b=A179mfefxFB+baHPYTSXNM0Ehk
 ZKvGi6wnvsRB4nbgB+KZkRKEkKmpWAk02FlJjRr+EEDaJbTzUQNT8J1kfYQfl/jlsRg2KT/26qOiW
 SpnpMPvU1y7NHeXvzc7Pzs4gh5wujvtXk2ie/VEE1zDzqqn2erQfXUtAoSbZHSAqdLY9rnEEEDyBD
 NM0tFP/2g0rg7EcxQCnvizikBSC7CJHCY5taFfrNE9p7mlkIUiU9NKiJ60Re1p0M9cJ989TVzTicu
 1fvbzCD+0UOByx2LZKfMYuYP69/Lf62+ssTDYD/KOH4Blt++yvFGMuN3rd90bYf4DU9GK+SufOfOv
 Bn+CYM52AQuup+S88fqlWAVkZL9Uakgcf1fdKFxeSxpTdmopzqmcyv85/h9VSyD1BnDFzmJn7IRjO
 tEen7znxSyhsZhZmgwNaLdQzwCJV887kf4uzsp4eVbQYtGv4XIAnn+n+NaGn/4U4OMn3mB6nqCG8L
 +ZyM4fr28keJJeG6R+1YhGfO0OdPkR/vNW9wf9SEv2US5HbHl8IcfpOWHE8/UQFLoZSAMDjbwJ995
 bD70dJtnJP2xf76kESJpedhQXKQU2OCZzE1VRo80/6q8kUGbPCkdePlW6FhKtU4W5HHvBXlvyXtGu
 UGPB7WIUCFiJKiU3jMWz9tkJHrjC/ZMhk4hFmuGJE=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qvwAa-0000md-EU; Thu, 26 Oct 2023 09:56:52 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Thu, 26 Oct 2023 09:56:46 +0100
Message-Id: <20231026085650.917663-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/4] macfb: A/UX fixes for colour LUT
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

This fixes an issue discovered in A/UX whereby attempts to read the colour
LUT from the macfb device returned zero (black) for all colours. The problem
was that the DAFB_RESET register is actually used to set the current colour
palette array index: fixing that and allowing larger access sizes allows the
test case to work.

This series implements these changes, along with renaming the DAFB_RESET
register to DAFB_LUT_INDEX which better describes its purpose.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk


Mark Cave-Ayland (4):
  macfb: don't clear interrupts when writing to DAFB_RESET
  macfb: rename DAFB_RESET to DAFB_LUT_INDEX
  macfb: allow larger write accesses to the DAFB_LUT register
  macfb: allow reads from the DAFB_LUT register

 hw/display/macfb.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

-- 
2.39.2


