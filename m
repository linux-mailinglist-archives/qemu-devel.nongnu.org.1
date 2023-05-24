Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C970FFD1
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vnJ-0007Hk-7i; Wed, 24 May 2023 17:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vnF-00070m-Pm
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:13 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vnC-0002KI-Mb
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W0B8qcuLZ3opG8CQ/3oV6l6s2KGTedCPNPswvMXxdxA=; b=vEPtHr0yzkVJ+xuUR+gWiFHxB4
 5EKkUMTcciSXOb5cxY4JVxWj09dSMARUc3xtra28CB58DAMSZGxhrzLWspreZok5vmSXLeiBHOlF1
 VIWc2/eT4yHE82ZXMVGT7P3P7FBby42+anVa1UZ9s4TqXveKYqBRxb0IoBzVsYDQgI42MJ1HZxqah
 GmKHHfzjZTIDlCyekt85kQEF6NDTJLUvpjf7YktWwxnTMbbZ6RF60yqSeOt/2TI7I8eWPbdJDtqDO
 Y8C1CSi6aj29E18SVs4B2HUSPt6RlCv9Swc0jIY8d21eqZTg8btAQcavf8efXXseSt6j84tSJerVg
 UUrpRzSmPB745uYKQIquN1iAMcHS7r98Dolv+O+qhQqkLPB9dmzRBLdhf3JrAcf9Ih0fglKJKDmwg
 HX2FGMSu8pwBKt0qngh4yn0iV82gDmXeNB4YCZb2g2VWvwyX1SZkfmUZFxu+ed6oxu/rExpIdgFI/
 Y9Barex60g6pHW0Tenj/zKaBbqx3wOW4iMJ9IwNhNSK253lIaJridEpxXod/Opt4IThL73XauIos3
 hKStmx7Pe1yiZfg7U4ipiwWaSYpRTRUQ1Eqt/7/Xh/d98aWnSXMLZc5nkHhPSzZo6Rr/DoxF8dpxM
 mPiLGzzBVUi1jjyzFRlYpyMbc118oG4jyxB6liKxc=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmt-0005XR-Q6; Wed, 24 May 2023 22:12:56 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:11:04 +0100
Message-Id: <20230524211104.686087-31-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 30/30] mac_via: work around QEMU unaligned MMIO access bug
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

During the kernel timer calibration routine A/UX performs an unaligned access
across the T1CL and T1CH registers to read the entire 16-bit value in a
single memory access.

This triggers a bug in the QEMU softtlb implementation whereby the 2 separate
accesses are combined incorrectly losing the high byte of the counter (see
https://gitlab.com/qemu-project/qemu/-/issues/360 for more detail). Since
A/UX requires a minimum difference of 0x500 between 2 subsequent reads to
succeed then this causes the timer calibration routine to get stuck in an
infinite loop.

Add a temporary workaround for the QEMU unaligned MMIO access bug whereby
these special accesses are detected and the 8-byte result copied into both
halves of the 16-bit access which allows the existing softtlb implementation
to return the correct result.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c            |  1 +
 hw/misc/mac_via.c         | 42 +++++++++++++++++++++++++++++++++++++++
 hw/misc/trace-events      |  1 +
 include/hw/misc/mac_via.h |  4 +++-
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index bf4acb5db7..918cc8f695 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -443,6 +443,7 @@ static const MemoryRegionOps macio_alias_ops = {
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
+        .unaligned = true,     /* For VIA1 via1_unaligned_hack_state() */
     },
 };
 
diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 4ec1ee18dd..45c8dee9f4 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1026,12 +1026,47 @@ static void via1_timer_calibration_hack(MOS6522Q800VIA1State *v1s, int addr,
     }
 }
 
+static bool via1_unaligned_hack_state(MOS6522Q800VIA1State *v1s, hwaddr addr,
+                                      int size)
+{
+    /*
+     * Workaround for bug in QEMU whereby load_helper() doesn't correctly
+     * handle combining unaligned memory accesses: see QEMU issue
+     * https://gitlab.com/qemu-project/qemu/-/issues/360 for all the
+     * details.
+     *
+     * Its only known use is during the A/UX timer calibration loop which
+     * runs on kernel startup.
+     */
+    switch (v1s->unaligned_hack_state) {
+    case 0:
+        /* First half of unaligned access */
+        if (addr == 0x11fe && size == 2) {
+            v1s->unaligned_hack_state = 1;
+            trace_via1_unaligned_hack_state(v1s->unaligned_hack_state);
+            return true;
+        }
+        return false;
+    case 1:
+        /* Second half of unaligned access */
+        if (addr == 0x1200 && size == 2) {
+            v1s->unaligned_hack_state = 0;
+            trace_via1_unaligned_hack_state(v1s->unaligned_hack_state);
+            return true;
+        }
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(v1s);
     int64_t now;
     uint64_t ret;
+    hwaddr oldaddr = addr;
 
     addr = (addr >> 9) & 0xf;
     ret = mos6522_read(ms, addr, size);
@@ -1059,6 +1094,12 @@ static uint64_t mos6522_q800_via1_read(void *opaque, hwaddr addr, unsigned size)
         }
         break;
     }
+
+    if (via1_unaligned_hack_state(v1s, oldaddr, size)) {
+        /* Splat return byte into word to fix unaligned access combine */
+        ret |= ret << 8;
+    }
+
     return ret;
 }
 
@@ -1126,6 +1167,7 @@ static const MemoryRegionOps mos6522_q800_via1_ops = {
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
+        .unaligned = true,     /* For VIA1 via1_unaligned_hack_state() */
     },
 };
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 7206bd5d93..8867cef356 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -252,6 +252,7 @@ via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size
 via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
 via1_auxmode(int mode) "setting auxmode to %d"
 via1_timer_hack_state(int state) "setting timer_hack_state to %d"
+via1_unaligned_hack_state(int state) "setting unaligned_hack_state to %d"
 
 # grlib_ahb_apb_pnp.c
 grlib_ahb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "AHB PnP read addr:0x%03"PRIx64" size:%u data:0x%08x"
diff --git a/include/hw/misc/mac_via.h b/include/hw/misc/mac_via.h
index 63cdcf7c69..0a12737552 100644
--- a/include/hw/misc/mac_via.h
+++ b/include/hw/misc/mac_via.h
@@ -77,8 +77,10 @@ struct MOS6522Q800VIA1State {
 
     /* SETUPTIMEK hack */
     int timer_hack_state;
-};
 
+    /* Unaligned access hack */
+    int unaligned_hack_state;
+};
 
 /* VIA 2 */
 #define VIA2_IRQ_SCSI_DATA_BIT  CA2_INT_BIT
-- 
2.30.2


