Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAA182C080
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:06:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHCc-0003sz-Vg; Fri, 12 Jan 2024 08:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCQ-0003SO-O5
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOHCO-0002mc-OK
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SNVGuDAiOl4Y2cc0LW/69S8I9XTCJhPHlEiJvwmXo8Q=; b=yzyw30PR5l0ip/XRhJvKbuYjwD
 ituxTwJ4Icz60uPyG2mCLBXaNdOhUD5PyYayzxqidJcKqYO2/zKVkPPG4Q/6oDdtY8bOwRVVxbAH7
 SnUiBxp3JMjcitC+YxtPTLJ9oEagauwhaGQnfVGF9g+yBBsd+v5piIu/00CM/0DZwUOnNEwKkwz4S
 cY4BugXIrJwvsYqNVtnaJ5NHt0/3QsAT+JQiRSy7XRJT8UPfOymo+P99mkeUMSmV2JgWXM/o/Io5x
 W+RzvwCLQmea9mfiwF8s/7VY1ZjA46URH8RU7WN5SJT7ideiEto8Mzcbb5Zq3CCmkYioWjLIrI35T
 PFGhGnGYDhVc+NRX4KSQsboUq9JFrZ7qxpIM07+IAFbWLF10s5Qi8SmlNqn7FwyJVz1sW2Aux2zcE
 FSFQg19wzl+9PxUeJzXUkQEiZu2R9B2hrsY6NV0KQyoUOhJpLvFjejDFaugr54Ofv5MOQtilcUJXs
 9At1HVSfi5xUtZyo6BKN1uMVYr1j89h7r+QB0Whi+sWwuY4R0tp+x6g3vmynvb4B9gFJ/WaHn3HNW
 Gxn46mTuaA1/7nKh55UEkeTgRna+jJAlUsmOcL4lXxr44LiCt6i3TKp0CGKa8rVdP00ctOmscM/oO
 JpEWEKJz9U9XGYToewqA9bTbRJYVIZW+u3ICb0uwk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rOH6B-0008jM-M4; Fri, 12 Jan 2024 12:57:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 laurent@vivier.eu, thuth@redhat.com, qemu-devel@nongnu.org
Date: Fri, 12 Jan 2024 12:53:55 +0000
Message-Id: <20240112125420.514425-64-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 63/88] esp.c: remove unneeded ti_cmd field
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

According to the datasheet the previous ESP command remains in the ESP_CMD
register, which caused a problem when consecutive TI commands were issued as
it becomes impossible for the state machine to know when the first TI
command finishes.

This was the original reason for introducing the ti_cmd field which kept
track of the last written command for this purpose. However closer reading
of the datasheet shows that a TI command that terminates due to a change of
SCSI target phase resets the ESP_CMD register to zero which solves this
problem.

Now that this has been fixed in the previous commit, remove the unneeded
ti_cmd field and access the ESP_CMD register directly instead. Bump the
vmstate_esp version to indicate that the ti_cmd field is no longer included.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c         | 19 +++++++++++++------
 include/hw/scsi/esp.h |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ccb8ad4bae..bcebd00831 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -321,7 +321,6 @@ static void do_command_phase(ESPState *s)
     fifo8_reset(&s->cmdfifo);
     s->data_ready = false;
     if (datalen != 0) {
-        s->ti_cmd = 0;
         /*
          * Switch to DATA phase but wait until initial data xfer is
          * complete before raising the command completion interrupt
@@ -908,12 +907,12 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
      * async data transfer is delayed then s->dma is set incorrectly.
      */
 
-    if (s->ti_cmd == (CMD_TI | CMD_DMA)) {
+    if (s->rregs[ESP_CMD] == (CMD_TI | CMD_DMA)) {
         /* When the SCSI layer returns more data, raise deferred INTR_BS */
         esp_dma_ti_check(s);
 
         esp_do_dma(s);
-    } else if (s->ti_cmd == CMD_TI) {
+    } else if (s->rregs[ESP_CMD] == CMD_TI) {
         esp_do_nodma(s);
     }
 }
@@ -927,7 +926,6 @@ static void handle_ti(ESPState *s)
         return;
     }
 
-    s->ti_cmd = s->rregs[ESP_CMD];
     if (s->dma) {
         dmalen = esp_get_tc(s);
         trace_esp_handle_ti(dmalen);
@@ -1200,6 +1198,14 @@ static bool esp_is_version_6(void *opaque, int version_id)
     return version_id >= 6;
 }
 
+static bool esp_is_between_version_5_and_6(void *opaque, int version_id)
+{
+    ESPState *s = ESP(opaque);
+
+    version_id = MIN(version_id, s->mig_version_id);
+    return version_id >= 5 && version_id <= 6;
+}
+
 int esp_pre_save(void *opaque)
 {
     ESPState *s = ESP(object_resolve_path_component(
@@ -1237,7 +1243,7 @@ static int esp_post_load(void *opaque, int version_id)
 
 const VMStateDescription vmstate_esp = {
     .name = "esp",
-    .version_id = 6,
+    .version_id = 7,
     .minimum_version_id = 3,
     .post_load = esp_post_load,
     .fields = (const VMStateField[]) {
@@ -1265,7 +1271,8 @@ const VMStateDescription vmstate_esp = {
         VMSTATE_UINT8_TEST(cmdfifo_cdb_offset, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(fifo, ESPState, esp_is_version_5),
         VMSTATE_FIFO8_TEST(cmdfifo, ESPState, esp_is_version_5),
-        VMSTATE_UINT8_TEST(ti_cmd, ESPState, esp_is_version_5),
+        VMSTATE_UINT8_TEST(mig_ti_cmd, ESPState,
+                           esp_is_between_version_5_and_6),
         VMSTATE_UINT8_TEST(lun, ESPState, esp_is_version_6),
         VMSTATE_END_OF_LIST()
     },
diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
index 1036606943..39b416f538 100644
--- a/include/hw/scsi/esp.h
+++ b/include/hw/scsi/esp.h
@@ -41,7 +41,6 @@ struct ESPState {
     uint32_t do_cmd;
 
     bool data_ready;
-    uint8_t ti_cmd;
     int dma_enabled;
 
     uint32_t async_len;
@@ -62,6 +61,8 @@ struct ESPState {
     uint8_t mig_ti_buf[ESP_FIFO_SZ];
     uint8_t mig_cmdbuf[ESP_CMDFIFO_SZ];
     uint32_t mig_cmdlen;
+
+    uint8_t mig_ti_cmd;
 };
 
 #define TYPE_SYSBUS_ESP "sysbus-esp"
-- 
2.39.2


