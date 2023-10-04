Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E9F7B7A5B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxOr-0003ij-C8; Wed, 04 Oct 2023 04:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOo-0003gz-Tk
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOn-0007Ui-E4
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Yq4FVlsatCpO1BqFxeAfy1d7RPiheuwvpjbMMHlmwno=; b=Sps4aHHFcO8UUmRsNXHjf6YVtK
 lFdjnnu1mwxX9RzTvKvG/g/Iw9Y7ZDZZPqXVkUNaFy+rWtuIXMV6YRYyDE3tasYgR7l21ByCGohex
 8/CHc0CJ/v2/MhPUafQnYAwDnMLTCyK2Bl5D7GpLQIxQSsPfbKXgXPGbN19gg+ZLru+aoNVj4Rg9b
 ivS3UE6cGbUPN3c+48rMKrC3+TQpnxF8tqSQT0qDQglyVAJTb+gxeSkIwR5lUPd4nVBc/UXediIGs
 5nDDyVl+RdUZgXDUV50TU/K/W3HiqD0ivauZttC+eNdp1iOJj6Kk3FBOBitsj7cfqRZKE+7XBJqob
 JE4vlhJjLRy5jAZJRj+5OLSKHD4F/jMFn12OzAHjhl3tIAQUay4WuOe2MsnWGEpdjlYpD8rLyTd1V
 bmj7nTHidaX1C62sbxIg/JeDZIR+BtbPvR/fjHzbtxdZnTB1xZAoHooE6+C3oHztw/nZKmVdPeHnT
 dDG9lRpQxXzE+ZRtbuSoiM6ulJqxap5/GR+8N8RbpfuoWN1s/gzsG8VWOLz1+bvq8rstbYZcC0pQV
 VsP/GgdEHRR5GSClUQAfnE3JiZYKgBFXQ+2qfA0HGuLb9vRP7HKtgxRF83QIJzCY8bdtLJ0lkSJhF
 t1girxQPmIjAk0w/7/xtIU8tmGdrjq4eoGmbT9TOg=;
Received: from host86-159-123-68.range86-159.btcentralplus.com
 ([86.159.123.68] helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qnxOb-0006za-0U; Wed, 04 Oct 2023 09:38:18 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed,  4 Oct 2023 09:37:50 +0100
Message-Id: <20231004083806.757242-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
References: <20231004083806.757242-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.159.123.68
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 04/20] q800: implement additional machine id bits on VIA1
 port A
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

Co-developed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/mac_via.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index f84cc68849..e87a1b82d8 100644
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
@@ -872,9 +875,18 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
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
2.39.2


