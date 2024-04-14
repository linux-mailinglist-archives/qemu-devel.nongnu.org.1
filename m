Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458ED89EBD2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Apr 2024 09:24:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSJ1-0007yl-6c; Wed, 10 Apr 2024 03:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIv-0007mm-Ik; Wed, 10 Apr 2024 03:23:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSIq-0003vI-RR; Wed, 10 Apr 2024 03:23:33 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 12BDE5D679;
 Wed, 10 Apr 2024 10:25:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AA8FAB02BA;
 Wed, 10 Apr 2024 10:23:04 +0300 (MSK)
Received: (nullmailer pid 4191674 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sven Schnelle <svens@stackframe.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 10/87] hw/scsi/lsi53c895a: stop script on phase mismatch
Date: Wed, 10 Apr 2024 10:21:43 +0300
Message-Id: <20240410072303.4191455-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sven Schnelle <svens@stackframe.org>

Netbsd isn't happy with qemu lsi53c895a emulation:

cd0(esiop0:0:2:0): command with tag id 0 reset
esiop0: autoconfiguration error: phase mismatch without command
esiop0: autoconfiguration error: unhandled scsi interrupt, sist=0x80 sstat1=0x0 DSA=0x23a64b1 DSP=0x50

This is because lsi_bad_phase() triggers a phase mismatch, which
stops SCRIPT processing. However, after returning to
lsi_command_complete(), SCRIPT is restarted with lsi_resume_script().
Fix this by adding a return value to lsi_bad_phase(), and only resume
script processing when lsi_bad_phase() didn't trigger a host interrupt.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Tested-by: Helge Deller <deller@gmx.de>
Message-ID: <20240302214453.2071388-1-svens@stackframe.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit a9198b3132d81a6bfc9fdbf6f3d3a514c2864674)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index afbea0fefa..46c17b320e 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -570,8 +570,9 @@ static inline void lsi_set_phase(LSIState *s, int phase)
     s->sstat1 = (s->sstat1 & ~PHASE_MASK) | phase;
 }
 
-static void lsi_bad_phase(LSIState *s, int out, int new_phase)
+static int lsi_bad_phase(LSIState *s, int out, int new_phase)
 {
+    int ret = 0;
     /* Trigger a phase mismatch.  */
     if (s->ccntl0 & LSI_CCNTL0_ENPMJ) {
         if ((s->ccntl0 & LSI_CCNTL0_PMJCTL)) {
@@ -584,8 +585,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
         trace_lsi_bad_phase_interrupt();
         lsi_script_scsi_interrupt(s, LSI_SIST0_MA, 0);
         lsi_stop_script(s);
+        ret = 1;
     }
     lsi_set_phase(s, new_phase);
+    return ret;
 }
 
 
@@ -789,7 +792,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
 static void lsi_command_complete(SCSIRequest *req, size_t resid)
 {
     LSIState *s = LSI53C895A(req->bus->qbus.parent);
-    int out;
+    int out, stop = 0;
 
     out = (s->sstat1 & PHASE_MASK) == PHASE_DO;
     trace_lsi_command_complete(req->status);
@@ -797,7 +800,10 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
     s->command_complete = 2;
     if (s->waiting && s->dbc != 0) {
         /* Raise phase mismatch for short transfers.  */
-        lsi_bad_phase(s, out, PHASE_ST);
+        stop = lsi_bad_phase(s, out, PHASE_ST);
+        if (stop) {
+            s->waiting = 0;
+        }
     } else {
         lsi_set_phase(s, PHASE_ST);
     }
@@ -807,7 +813,9 @@ static void lsi_command_complete(SCSIRequest *req, size_t resid)
         lsi_request_free(s, s->current);
         scsi_req_unref(req);
     }
-    lsi_resume_script(s);
+    if (!stop) {
+        lsi_resume_script(s);
+    }
 }
 
  /* Callback to indicate that the SCSI layer has completed a transfer.  */
-- 
2.39.2


