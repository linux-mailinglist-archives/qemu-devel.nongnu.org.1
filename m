Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774A670DA6A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 12:25:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1P8B-00067e-N6; Tue, 23 May 2023 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P86-0005dk-5k; Tue, 23 May 2023 06:20:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q1P84-000389-2E; Tue, 23 May 2023 06:20:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9BCCF7D3F;
 Tue, 23 May 2023 13:20:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EF46B72A6;
 Tue, 23 May 2023 13:20:15 +0300 (MSK)
Received: (nullmailer pid 86088 invoked by uid 1000);
 Tue, 23 May 2023 10:20:14 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Th=C3=A9o=20Maillart?= <tmaillart@freebox.fr>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 40/45] scsi-generic: fix buffer overflow on block
 limits inquiry
Date: Tue, 23 May 2023 13:17:17 +0300
Message-Id: <20230523102014.85954-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230523131604@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Using linux 6.x guest, at boot time, an inquiry on a scsi-generic
device makes qemu crash.  This is caused by a buffer overflow when
scsi-generic patches the block limits VPD page.

Do the operations on a temporary on-stack buffer that is guaranteed
to be large enough.

Reported-by: Théo Maillart <tmaillart@freebox.fr>
Analyzed-by: Théo Maillart <tmaillart@freebox.fr>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 9bd634b2f5e2f10fe35d7609eb83f30583f2e15a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 92cce20a4d..d513870181 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -190,12 +190,16 @@ static int scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s, int len)
     if ((s->type == TYPE_DISK || s->type == TYPE_ZBC) &&
         (r->req.cmd.buf[1] & 0x01)) {
         page = r->req.cmd.buf[2];
-        if (page == 0xb0) {
+        if (page == 0xb0 && r->buflen >= 8) {
+            uint8_t buf[16] = {};
+            uint8_t buf_used = MIN(r->buflen, 16);
             uint64_t max_transfer = calculate_max_transfer(s);
-            stl_be_p(&r->buf[8], max_transfer);
-            /* Also take care of the opt xfer len. */
-            stl_be_p(&r->buf[12],
-                    MIN_NON_ZERO(max_transfer, ldl_be_p(&r->buf[12])));
+
+            memcpy(buf, r->buf, buf_used);
+            stl_be_p(&buf[8], max_transfer);
+            stl_be_p(&buf[12], MIN_NON_ZERO(max_transfer, ldl_be_p(&buf[12])));
+            memcpy(r->buf + 8, buf + 8, buf_used - 8);
+
         } else if (s->needs_vpd_bl_emulation && page == 0x00 && r->buflen >= 4) {
             /*
              * Now we're capable of supplying the VPD Block Limits
-- 
2.39.2


