Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385C823B68
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:33:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFPY-0000FB-43; Wed, 03 Jan 2024 23:32:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPW-0000Er-5y
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPU-0006Yh-LX
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABx49MI82+qH2tz8ojbNkQ+kyIm22DuH+mdAmNEU/SQ=;
 b=MnNSU/sXIdJfH+uF/Yaez8XDxpIh36P5lvUnFYrCg76z5YAf0bBHcRB9rJqo3M2xqRrkaN
 zXE2nuoWR0Qhu/GYEyoZBm1OsPJYiZ04SPfjPR+P+vN4vR/freBZiY/LrfkfCxUhRQt1Un
 be9oyuYVvpiCNpbmT+fZETf0lh2Wvog=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-0iNW2o_9PLuY6xNl_VN3pw-1; Wed,
 03 Jan 2024 23:32:44 -0500
X-MC-Unique: 0iNW2o_9PLuY6xNl_VN3pw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EFDE3C025BB;
 Thu,  4 Jan 2024 04:32:44 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 947C7C15968;
 Thu,  4 Jan 2024 04:32:40 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 05/26] cpus: check running not RUN_STATE_RUNNING
Date: Thu,  4 Jan 2024 12:31:50 +0800
Message-ID: <20240104043213.431566-6-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

When a vm transitions from running to suspended, runstate notifiers are
not called, so the notifiers still think the vm is running.  Hence, when
we call vm_start to restore the suspended state, we call vm_state_notify
with running=1.  However, some notifiers check for RUN_STATE_RUNNING.
They must check the running boolean instead.

No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1704312341-66640-4-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 backends/tpm/tpm_emulator.c | 2 +-
 hw/usb/hcd-ehci.c           | 2 +-
 hw/usb/redirect.c           | 2 +-
 hw/xen/xen-hvm-common.c     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f7f1b4ad7a..254fce7764 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -904,7 +904,7 @@ static void tpm_emulator_vm_state_change(void *opaque, bool running,
 
     trace_tpm_emulator_vm_state_change(running, state);
 
-    if (!running || state != RUN_STATE_RUNNING || !tpm_emu->relock_storage) {
+    if (!running || !tpm_emu->relock_storage) {
         return;
     }
 
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 19b4534c20..10c82ce472 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -2451,7 +2451,7 @@ static void usb_ehci_vm_state_change(void *opaque, bool running, RunState state)
      * USB-devices which have async handled packages have a packet in the
      * ep queue to match the completion with.
      */
-    if (state == RUN_STATE_RUNNING) {
+    if (running) {
         ehci_advance_async_state(ehci);
     }
 
diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index c9893df867..3785bb057b 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -1403,7 +1403,7 @@ static void usbredir_vm_state_change(void *priv, bool running, RunState state)
 {
     USBRedirDevice *dev = priv;
 
-    if (state == RUN_STATE_RUNNING && dev->parser != NULL) {
+    if (running && dev->parser != NULL) {
         usbredirparser_do_write(dev->parser); /* Flush any pending writes */
     }
 }
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 565dc39c8f..47e6cb1db3 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -623,7 +623,7 @@ void xen_hvm_change_state_handler(void *opaque, bool running,
 
     xen_set_ioreq_server_state(xen_domid,
                                state->ioservid,
-                               (rstate == RUN_STATE_RUNNING));
+                               running);
 }
 
 void xen_exit_notifier(Notifier *n, void *data)
-- 
2.41.0


