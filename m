Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B78EB7A9158
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjAgK-0007J7-O3; Wed, 20 Sep 2023 23:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjAgI-0007Ij-2s
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:48:46 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjAgE-0008QI-Ug
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 23:48:45 -0400
Received: from localhost.localdomain
 (ppp14-2-88-115.adl-apt-pir-bras31.tpg.internode.on.net [14.2.88.115])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7DA7C20034;
 Thu, 21 Sep 2023 11:48:30 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1695268112;
 bh=fKATgifygTzEgYZhNWQMOW/IpF3BRJSj3iGAqUio0JQ=;
 h=From:To:Cc:Subject:Date;
 b=YWlwKf3kryhq/ebLoYre53+LieZO5kPiPvolQJvaXXt1cggCI1u+dPA+rOQRm16Wz
 HcC0NeGSlyrayIMzdHVYPaMJgPbYn8v5N/o69XCmuEx1CWJauJEBd79A8i6EH1apUk
 q5o/RrSWZYmkPv8G0ZrZ2OSfF0OEfP2MIcGD8nh3YFP0BEAP3DUb6BjIKwmLnYFacS
 ww2E9caqFNr/lTLrR2vADBJvoE7sUXsgJX3w1CKOwAiOet5SI4riTg/vlEBMulasAY
 hNMI4FbQRbUVAM6P/UCNIHI7Of8D36dLiSCga+0KDO0iB2s8qxyL6cgE+oQlXUEX5W
 BQioQYnapCa6A==
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, clg@kaod.org, peter@pjd.dev,
 joel@jms.id.au, cminyard@mvista.com
Subject: [PATCH] eeprom_at24c: Model 8-bit data addressing for 16-bit devices
Date: Thu, 21 Sep 2023 13:18:16 +0930
Message-Id: <20230921034816.320655-1-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

It appears some (many?) EEPROMs that implement 16-bit data addressing
will accept an 8-bit address and clock out non-uniform data for the
read. This behaviour is exploited by an EEPROM detection routine in part
of OpenBMC userspace with a reasonably broad user base:

https://github.com/openbmc/entity-manager/blob/0422a24bb6033605ce75479f675fedc76abb1167/src/fru_device.cpp#L197-L229

The diversity of the set of EEPROMs that it operates against is unclear,
but this code has been around for a while now.

Separately, The NVM Express Management Interface Specification dictates
the provided behaviour in section 8.2 Vital Product Data:

> If only one byte of the Command Offset is provided by the Management
> Controller, then the least significant byte of the internal offset
> shall be set to that value and the most-significant byte of the
> internal offset shall be cleared to 0h

https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interface-Specification-1.2c-2022.10.06-Ratified.pdf

This change makes it possible to expose NVMe VPD in a manner that can be
dynamically detected by OpenBMC.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 hw/nvram/eeprom_at24c.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 613c4929e327..64a61cc0e468 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -98,12 +98,20 @@ uint8_t at24c_eeprom_recv(I2CSlave *s)
     EEPROMState *ee = AT24C_EE(s);
     uint8_t ret;
 
-    /*
-     * If got the byte address but not completely with address size
-     * will return the invalid value
-     */
     if (ee->haveaddr > 0 && ee->haveaddr < ee->asize) {
-        return 0xff;
+        /*
+         * Provide behaviour that aligns with NVMe MI 1.2c, section 8.2.
+         *
+         * https://nvmexpress.org/wp-content/uploads/NVM-Express-Management-Interface-Specification-1.2c-2022.10.06-Ratified.pdf
+         *
+         * Otherwise, the clocked-out data is meaningless anyway, and so reading
+         * off memory is as good a behaviour as anything. This also happens to
+         * help the address-width detection heuristic in OpenBMC's userspace.
+         *
+         * https://github.com/openbmc/entity-manager/blob/0422a24bb6033605ce75479f675fedc76abb1167/src/fru_device.cpp#L197-L229
+         */
+        ee->haveaddr = ee->asize;
+        ee->cur %= ee->rsize;
     }
 
     ret = ee->mem[ee->cur];
-- 
2.39.2


