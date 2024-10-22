Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 370299A9ECE
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Oct 2024 11:43:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3BOj-0002s4-8d; Tue, 22 Oct 2024 05:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOT-0002ok-Ue; Tue, 22 Oct 2024 05:41:38 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t3BOR-00015E-RL; Tue, 22 Oct 2024 05:41:36 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 22 Oct
 2024 17:41:12 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 22 Oct 2024 17:41:12 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?=
 <clg@redhat.com>
Subject: [PATCH v2 03/18] hw/block:m25p80: Support write status register 2
 command (0x31) for w25q01jvq
Date: Tue, 22 Oct 2024 17:40:55 +0800
Message-ID: <20241022094110.1574011-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
References: <20241022094110.1574011-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

According to the w25q01jv datasheet at page 16, it is required to set QE bit
in "Status Register 2" to enable quad mode.

Currently, m25p80 support users utilize "Write Status Register 1(0x01)" command
to set QE bit in "Status Register 2" and utilize "Read Status Register 2(0x35)"
command to get the QE bit status.

However, some firmware directly utilize "Status Register 2(0x31)" command to
set QE bit. To fully support quad mode for w25q01jvq, adds WRSR2 command.

Update collecting data needed 1 byte for WRSR2 command in decode_new_cmd
function and verify QE bit at the first byte of collecting data bit 2 in
complete_collecting_data.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/block/m25p80.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index 3f55b8f385..411d810d3b 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -430,6 +430,11 @@ typedef enum {
     RDCR_EQIO = 0x35,
     RSTQIO = 0xf5,
 
+    /*
+     * Winbond: 0x31 - write status register 2
+     */
+    WRSR2 = 0x31,
+
     RNVCR = 0xB5,
     WNVCR = 0xB1,
 
@@ -821,6 +826,15 @@ static void complete_collecting_data(Flash *s)
             s->write_enable = false;
         }
         break;
+    case WRSR2:
+        switch (get_man(s)) {
+        case MAN_WINBOND:
+            s->quad_enable = !!(s->data[0] & 0x02);
+            break;
+        default:
+            break;
+        }
+        break;
     case BRWR:
     case EXTEND_ADDR_WRITE:
         s->ear = s->data[0];
@@ -1280,7 +1294,31 @@ static void decode_new_cmd(Flash *s, uint32_t value)
         }
         s->pos = 0;
         break;
+    case WRSR2:
+        /*
+         * If WP# is low and status_register_write_disabled is high,
+         * status register writes are disabled.
+         * This is also called "hardware protected mode" (HPM). All other
+         * combinations of the two states are called "software protected mode"
+         * (SPM), and status register writes are permitted.
+         */
+        if ((s->wp_level == 0 && s->status_register_write_disabled)
+            || !s->write_enable) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "M25P80: Status register 2 write is disabled!\n");
+            break;
+        }
 
+        switch (get_man(s)) {
+        case MAN_WINBOND:
+            s->needed_bytes = 1;
+            s->state = STATE_COLLECTING_DATA;
+            s->pos = 0;
+            break;
+        default:
+            break;
+        }
+        break;
     case WRDI:
         s->write_enable = false;
         if (get_man(s) == MAN_SST) {
-- 
2.34.1


