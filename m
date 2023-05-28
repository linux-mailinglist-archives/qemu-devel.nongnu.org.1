Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4273A71382D
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:00:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3AOT-0004aE-3w; Sun, 28 May 2023 03:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANe-0004Kf-EG; Sun, 28 May 2023 02:59:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANb-0001r6-UB; Sun, 28 May 2023 02:59:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DC2328E22;
 Sun, 28 May 2023 09:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 51FD97E2C;
 Sun, 28 May 2023 09:59:41 +0300 (MSK)
Received: (nullmailer pid 42631 invoked by uid 1000);
 Sun, 28 May 2023 06:59:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Ryan Wendland <wendland@live.com.au>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 51/53] usb/ohci: Set pad to 0 after frame update
Date: Sun, 28 May 2023 09:59:24 +0300
Message-Id: <20230528065940.42582-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
MIME-Version: 1.0
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

When the OHCI controller's framenumber is incremented, HccaPad1 register
should be set to zero (Ref OHCI Spec 4.4)

ReactOS uses hccaPad1 to determine if the OHCI hardware is running,
consequently it fails this check in current qemu master.

Signed-off-by: Ryan Wendland <wendland@live.com.au>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1048
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 6301460ce9f59885e8feb65185bcfb6b128c8eff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 9d68036d23..c3ab762f54 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -1210,6 +1210,8 @@ static void ohci_frame_boundary(void *opaque)
     /* Increment frame number and take care of endianness. */
     ohci->frame_number = (ohci->frame_number + 1) & 0xffff;
     hcca.frame = cpu_to_le16(ohci->frame_number);
+    /* When the HC updates frame number, set pad to 0. Ref OHCI Spec 4.4.1*/
+    hcca.pad = 0;
 
     if (ohci->done_count == 0 && !(ohci->intr_status & OHCI_INTR_WD)) {
         if (!ohci->done)
-- 
2.39.2


