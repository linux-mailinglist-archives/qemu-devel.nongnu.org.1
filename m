Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76966A20626
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:26:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgYA-00052o-D4; Tue, 28 Jan 2025 03:02:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXx-0004L9-82; Tue, 28 Jan 2025 03:02:09 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgXu-0001x8-N2; Tue, 28 Jan 2025 03:02:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AC705E1B53;
 Tue, 28 Jan 2025 10:57:08 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2821A1A6306;
 Tue, 28 Jan 2025 10:57:34 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id F10085209D; Tue, 28 Jan 2025 10:57:33 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fiona Ebner <f.ebner@proxmox.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.3 12/58] scsi: megasas: Internal cdbs have 16-byte length
Date: Mon, 27 Jan 2025 23:24:58 +0300
Message-Id: <20250127202547.3723716-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
References: <qemu-stable-9.1.3-20250127232536@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Host drivers do not necessarily set cdb_len in megasas io commands.
With commits 6d1511cea0 ("scsi: Reject commands if the CDB length
exceeds buf_len") and fe9d8927e2 ("scsi: Add buf_len parameter to
scsi_req_new()"), this results in failures to boot Linux from affected
SCSI drives because cdb_len is set to 0 by the host driver.
Set the cdb length to its actual size to solve the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Link: https://lore.kernel.org/r/20230228171129.4094709-1-linux@roeck-us.net
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 3abb67323aeecf06a27191076ab50424ec21f334)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 2d0c607177..97e51733af 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -1781,7 +1781,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
     uint8_t cdb[16];
     int len;
     struct SCSIDevice *sdev = NULL;
-    int target_id, lun_id, cdb_len;
+    int target_id, lun_id;
 
     lba_count = le32_to_cpu(cmd->frame->io.header.data_len);
     lba_start_lo = le32_to_cpu(cmd->frame->io.lba_lo);
@@ -1790,7 +1790,6 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     target_id = cmd->frame->header.target_id;
     lun_id = cmd->frame->header.lun_id;
-    cdb_len = cmd->frame->header.cdb_len;
 
     if (target_id < MFI_MAX_LD && lun_id == 0) {
         sdev = scsi_device_find(&s->bus, 0, target_id, lun_id);
@@ -1805,15 +1804,6 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
         return MFI_STAT_DEVICE_NOT_FOUND;
     }
 
-    if (cdb_len > 16) {
-        trace_megasas_scsi_invalid_cdb_len(
-            mfi_frame_desc(frame_cmd), 1, target_id, lun_id, cdb_len);
-        megasas_write_sense(cmd, SENSE_CODE(INVALID_OPCODE));
-        cmd->frame->header.scsi_status = CHECK_CONDITION;
-        s->event_count++;
-        return MFI_STAT_SCSI_DONE_WITH_ERROR;
-    }
-
     cmd->iov_size = lba_count * sdev->blocksize;
     if (megasas_map_sgl(s, cmd, &cmd->frame->io.sgl)) {
         megasas_write_sense(cmd, SENSE_CODE(TARGET_FAILURE));
@@ -1824,7 +1814,7 @@ static int megasas_handle_io(MegasasState *s, MegasasCmd *cmd, int frame_cmd)
 
     megasas_encode_lba(cdb, lba_start, lba_count, is_write);
     cmd->req = scsi_req_new(sdev, cmd->index,
-                            lun_id, cdb, cdb_len, cmd);
+                            lun_id, cdb, sizeof(cdb), cmd);
     if (!cmd->req) {
         trace_megasas_scsi_req_alloc_failed(
             mfi_frame_desc(frame_cmd), target_id, lun_id);
-- 
2.39.5


