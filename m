Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F399970FFC3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vn2-0004fW-Ea; Wed, 24 May 2023 17:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmw-0003vv-9c
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:54 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmu-0002Ef-3d
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1H9aTnPvfzwWG0TePJOatxdz3yLOREQRSdwo9qmO90o=; b=maoT5hujIY3+Bt+KM0mQuNiKDP
 HgOuCBzu/jsYzPupClT+Zz7ZEeMPgDVHz1czIA1sqiBBKk5apUVKm37stc/DQF2pgfi0eSO4QLI1X
 mQbNSGFVWBjopWYx4x021rdufTIM2UGqcbgvVMU2FyZAhFwhiBC5csU1d6VSVnGx5QOd3ibcT5Dlp
 n6CXiEBf+ORA3BM8rg9GkLmP/5rG2NVweX7u364rppXCequM43LWQqmxpr1Q1HTLsgack4tRDJAF1
 fZnE695lhFH45kBhOjpf/vTDL39MiU2HYlRdFCaqa0R4RQ1SYJsJspzNM8LrW3RYOZEAGAM7/bFiE
 JAFOJUZo0BAPoaizHeyQVIoCoCZYp6WQYgB5NmcOn2FGFpdOb4KeR8dWX0UQbW71/Y3HEqaF5iZRf
 qbHArWPhFP+LecGVgds9lCsk8YfsfjlL04jNJQIIz74zA+pWxoE1DtjWlkjZ6Vo+NIPzz5WrwUtZO
 DiDQn6NZjggT22JEka9GU/UOn0BCVZS4xNeVSEHj0w5j4r9xefSJ3qD9DFSr7qXI6Wyo3WAcHbUFr
 5sP35lTwM2TWvQ1Uqznf7oPo5B0UNxULBYJspBnrv/1CS31htSLSoZUq67ab4R8Ew0j1JKeYXj7+P
 qjzUv0OevG2KIzqLJfq8ov7Lmb+Sta/lg4JvtAXTE=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q1vmc-0005XR-L9; Wed, 24 May 2023 22:12:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 24 May 2023 22:10:58 +0100
Message-Id: <20230524211104.686087-25-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 24/30] mac_via: workaround NetBSD ADB bus enumeration issue
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

NetBSD assumes it can send its first ADB command after sending the ADB_BUSRESET
command in ADB_STATE_NEW without changing the state back to ADB_STATE_IDLE
first as detailed in the ADB protocol.

Add a workaround to detect this condition at the start of ADB enumeration
and send the next command written to SR after a ADB_BUSRESET onto the bus
regardless, even if we don't detect a state transition to ADB_STATE_NEW.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/misc/mac_via.c    | 34 ++++++++++++++++++++++++++++++++++
 hw/misc/trace-events |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/misc/mac_via.c b/hw/misc/mac_via.c
index 5d5334b0f6..564db8337e 100644
--- a/hw/misc/mac_via.c
+++ b/hw/misc/mac_via.c
@@ -1001,6 +1001,8 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
 {
     MOS6522Q800VIA1State *v1s = MOS6522_Q800_VIA1(opaque);
     MOS6522State *ms = MOS6522(v1s);
+    int oldstate, state;
+    int oldsr = ms->sr;
 
     addr = (addr >> 9) & 0xf;
 
@@ -1016,6 +1018,38 @@ static void mos6522_q800_via1_write(void *opaque, hwaddr addr, uint64_t val,
 
         v1s->last_b = ms->b;
         break;
+
+    case VIA_REG_SR:
+        {
+            /*
+             * NetBSD assumes it can send its first ADB command after sending
+             * the ADB_BUSRESET command in ADB_STATE_NEW without changing the
+             * state back to ADB_STATE_IDLE first as detailed in the ADB
+             * protocol.
+             *
+             * Add a workaround to detect this condition at the start of ADB
+             * enumeration and send the next command written to SR after a
+             * ADB_BUSRESET onto the bus regardless, even if we don't detect a
+             * state transition to ADB_STATE_NEW.
+             *
+             * Note that in my tests the NetBSD state machine takes one ADB
+             * operation to recover which means the probe for an ADB device at
+             * address 1 always fails. However since the first device is at
+             * address 2 then this will work fine, without having to come up
+             * with a more complicated and invasive solution.
+             */
+            oldstate = (v1s->last_b & VIA1B_vADB_StateMask) >>
+                       VIA1B_vADB_StateShift;
+            state = (ms->b & VIA1B_vADB_StateMask) >> VIA1B_vADB_StateShift;
+
+            if (oldstate == ADB_STATE_NEW && state == ADB_STATE_NEW &&
+                    (ms->acr & VIA1ACR_vShiftOut) &&
+                    oldsr == 0 /* ADB_BUSRESET */) {
+                trace_via1_adb_netbsd_enum_hack();
+                adb_via_send(v1s, state, ms->sr);
+            }
+        }
+        break;
     }
 }
 
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index d3a9295d2f..7206bd5d93 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -249,6 +249,7 @@ via1_rtc_cmd_pram_sect_write(int sector, int offset, int addr, int value) "secto
 via1_adb_send(const char *state, uint8_t data, const char *vadbint) "state %s data=0x%02x vADBInt=%s"
 via1_adb_receive(const char *state, uint8_t data, const char *vadbint, int status, int index, int size) "state %s data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
 via1_adb_poll(uint8_t data, const char *vadbint, int status, int index, int size) "data=0x%02x vADBInt=%s status=0x%x index=%d size=%d"
+via1_adb_netbsd_enum_hack(void) "using NetBSD enum hack"
 via1_auxmode(int mode) "setting auxmode to %d"
 via1_timer_hack_state(int state) "setting timer_hack_state to %d"
 
-- 
2.30.2


