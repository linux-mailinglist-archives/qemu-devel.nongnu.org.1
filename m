Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6287CFA61
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSih-0006Cb-Sf; Thu, 19 Oct 2023 09:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSiA-0005sM-4q; Thu, 19 Oct 2023 09:05:15 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtSi6-0005gK-7q; Thu, 19 Oct 2023 09:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rbsc1vlp43hxHeUk6Y2M8pGxhFMSZDSxCNdhbJSBRv4=; b=OWPk58lrzwDxJ1Qgu1j5agISnT
 yxsbKV+taYMeRJFzhPKFrS1NVxsee27hZAjYjl0+n8jzwhqmUaREmd4fbdvP2G3WiWfaEJCf/X/gR
 t4uAWV2GhV2cFyDtMNTMyEbuL3ovZri2cyfYLpL+XWgf05LLUmwNrfzqaj88b28GI1LLt2t7KOdpP
 FXAz03MAZgXwAcotsefgR5aiKV/nKTLnYrGcDIXWzC2PPKMj+nV8emw0JamxrXR7QLnytWaIxoCEk
 6H/6dKSXGb8c7rWbLache7xE4DUXbsxTo5cpKEZG6cCLqJ2Y5Zofaz9ReB62yLuSUKWhcl1Zem5Qj
 jAGCfedQK3h5iMn5hcwC3MXG+l/Q3Y8e7uGFGirgKdUtszxHcnUWpQjYwFKM3rJQh80vM4MvePVUO
 ubsFztP9ZOn8njGZk+876qTXvmjJUnJP8k9uS4nmOBYxmV/swe6oXH75G8yVqTwj0UXOeewTKZIkM
 iOCMCBOSZW3trhrtT5itMSeN8ZaY6TmP7HPXMc5rO5/XhDm59x927o5PUnOZ7tdy5at5RMsei/qfk
 mJRe/tBU7Er/pLC04AXWpLBxViWxiEr4KdWTez3eUq1tdEH7E3tbC+PvIovw9lX60kvdTw3izRQTP
 9dEN7QIV22EVXG2Ndk4QExQiA5EcYr5qwztwH+CIo=;
Received: from host86-130-37-248.range86-130.btcentralplus.com
 ([86.130.37.248] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qtShs-0006iW-9h; Thu, 19 Oct 2023 14:05:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 balaton@eik.bme.hu, philmd@linaro.org, shentey@gmail.com
Date: Thu, 19 Oct 2023 14:04:50 +0100
Message-Id: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.248
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 0/2] ide: implement simple legacy/native mode switching for
 PCI IDE controllers
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

This series adds a simple implementation of legacy/native mode switching for PCI
IDE controllers and updates the via-ide device to use it.

The approach I take here is to add a new pci_ide_update_mode() function which handles
management of the PCI BARs and legacy IDE ioports for each mode to avoid exposing
details of the internal logic to individual PCI IDE controllers.

As noted in [1] this is extracted from a local WIP branch I have which contains
further work in this area. However for the moment I've kept it simple (and
restricted it to the via-ide device) which is good enough for Zoltan's PPC
images whilst paving the way for future improvements after 8.2.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


[1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html

Mark Cave-Ayland (2):
  ide/pci.c: introduce pci_ide_update_mode() function
  hw/ide/via: implement legacy/native mode switching

 hw/ide/pci.c         | 90 ++++++++++++++++++++++++++++++++++++++++++++
 hw/ide/via.c         | 20 +++++++++-
 include/hw/ide/pci.h |  1 +
 3 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.39.2


