Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9E70FFB5
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vmG-0002db-4L; Wed, 24 May 2023 17:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmE-0002WM-DV
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vm3-00025p-TM
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=v0u3ughJnnH4tmiVQkkBhXmwI2doRXhHtAxcgsOwuGI=; b=km6hQQfIJVaAy+MxMVgea16LT7
 oR6NnHwL/xPMz14FEEG1l2hnkwEtYkjfj8ucC8/9Ziu0LBO5FZ6TfpjmJ6NatrtZ3L3ABTyD8G9T5
 yhAgp0LiyaOfFRMcbkgNxUpTNt81Tg0pM9wDtNLjgGmU+OAFnkoZGeCGrG+9JaDQq9UBwdvg+phxF
 EN/jQGHeRf1FvGkpkXELsDPOiwCyVnrh5oensvsT1t2xA/dNDtA7YpfiwDKeEFVo4/Moq4agb2pg2
 CamhcjlWXsQkVSeDHOxLxcccf2o9R6o122jfKBS4D+fXYL2CkqkTuVkT1PbpILeElIFaUJ6iG17pv
 wjYiwCJ5dARsI5UP01dtulfkmuhhJ5N/nV+I+KUFAvXWPVjLwUEReFKf3POfRNqCas38+2UrJmW0o
 5GencNhl5ExwcrO4kpEygm1yk2u0zEsDgJwD5STSJdVOuGwL32BLYhpJOFKULlaMhNbB9Xzd+Lrkz
 AzkbkiRoRFt/h26vpFKn+Meoisz+4QehIqSLPdKmyIir2cBsR+fekaFb9Rh0pJ7JG2neSJi7aKdy0
 BUlNV7XYYSwLZdATWGGrpVWmUbAgkpNX0CBxEP2yIhT2fwrRUcrZtDsDAv2VdpfMdmO7Bk69H+OYA
 ZiO/0VXDv5eRcPMcfsOp8/Ut7ljb8DdTliYq7Ntxc=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vlw-0005XR-Hr; Wed, 24 May 2023 22:11:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:45 +0100
Message-Id: <20230524211104.686087-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 11/30] q800: implement additional machine id bits on VIA1 port
 A
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

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 076d18e5fd..f90a22a067 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -114,6 +114,9 @@
 #define VIA1A_CPUID1    0x04    /* CPU id bit 0 on RBV, others */
 #define VIA1A_CPUID2    0x10    /* CPU id bit 0 on RBV, others */
 #define VIA1A_CPUID3    0x40    /* CPU id bit 0 on RBV, others */
+#define VIA1A_CPUID_MASK (VIA1A_CPUID0 | VIA1A_CPUID1 | \
+                          VIA1A_CPUID2 | VIA1A_CPUID3)
+#define VIA1A_CPUID_Q800 (VIA1A_CPUID0 | VIA1A_CPUID2)
 
 /*
  * Info on VIA1B is from Macintosh Family Hardware & MkLinux.
@@ -871,9 +874,18 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(s);
+    uint64_t ret;
 
     addr = (addr >> 9) & 0xf;
-    return mos6522_read(ms, addr, size);
+    ret = mos6522_read(ms, addr, size);
+    switch (addr) {
+    case VIA_REG_A:
+    case VIA_REG_ANH:
+        /* Quadra 800 Id */
+        ret = (ret & ~VIA1A_CPUID_MASK) | VIA1A_CPUID_Q800;
+        break;
+    }
+    return ret;
 }
 
 static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
-- 
2.30.2


