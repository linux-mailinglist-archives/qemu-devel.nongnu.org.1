Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9211D82C081
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHDm-0005a6-OV; Fri, 12 Jan 2024 08:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDN-0004ek-RH
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:57 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHDI-0003AW-R0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=smlVZmV9rs78GsLFFCye6cQ56AeVA+Z6TX5m3wCBznI=; b=gD9pWl1DA0Tg8GR5qxvqAL0QF5
 d6MggctbhvMeI6mmCs04lVEr8OIWSNn7gRc8Yx4GMPMyMQDJGUNGBY61Q4zSQQlZe1V0A8nHAnymr
 lyrWDovjH0VJuBVImsF8Bld1bmTNgACCV2gnTtdQaQBV4ulJSovVq123QlOwlUtG7E2UIwIe+WJ2a
 Sja1wDHO8+8vyHk3o5fgMfF7ygo3QBawXFVweKh5VU/8XA3md7TWJ04F0Ouu9QRjHfOwRRxwPfst/
 x5ndvMlFx/2Fd7xwpJOjy7ggzg5nGCiJQp0WXZK4qopyq+SLVmzeotyc6d+OTI1JWItrvOb2nNJfB
 0ycb7HpWgJtnCm2tMZ2OViyiw2zH8/N2PPASyFttyV6tRz48G+lhQA81NlKh9ci5i/4MJUGMRkis/
 U7/zaZojlU1DbxmrZCu2bx4XepAjtxbnSTRItq4KdlB1CWjRh7WLDHxojcYLWmbbe0OcC7gDHljX0
 A799Vz69Boaz76CU2NB/RfjgXM4ui5kGExNQCsg4oUUq1/Cae7NrO7H0hzDXCE909jDH3ovqX6VMm
 yHu7g3uzEleA2c+76iy8XEZqaBBq1gQgMiH0O9yRhUPNHX50y8rdPxIu2DFKd6xNvSdEb8NGljXIE
 QCbmJ4y5oZPMMUNReNgdSjbA0YXrICGyd2Mv9HHVg=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH7Q-0008jM-PF; Fri, 12 Jan 2024 12:58:40 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:54:20 +0000
Message-Id: <20240112125420.514425-89-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 88/88] esp.c: add my copyright to the file
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

This series has involved rewriting and/or updating a considerable part of the ESP
emulation so update the copyright in esp.c to reflect this.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index b8762d5ee0..590ff99744 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2005-2006 Fabrice Bellard
  * Copyright (c) 2012 Herve Poussineau
+ * Copyright (c) 2023 Mark Cave-Ayland
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
-- 
2.39.2


