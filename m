Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3057E6B7A
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:49:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15Nq-0000my-2N; Thu, 09 Nov 2023 08:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Mc-00078z-1i; Thu, 09 Nov 2023 08:46:33 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15MY-0001zc-VD; Thu, 09 Nov 2023 08:46:29 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19EA431B19;
 Thu,  9 Nov 2023 16:43:14 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 288C7344BF;
 Thu,  9 Nov 2023 16:43:06 +0300 (MSK)
Received: (nullmailer pid 1461861 invoked by uid 1000);
 Thu, 09 Nov 2023 13:43:02 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, David Woodhouse <dwmw@amazon.co.uk>,
 Paul Durrant <paul@xen.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.3 33/55] hw/xen: don't clear map_track[] in
 xen_gnttab_reset()
Date: Thu,  9 Nov 2023 16:42:37 +0300
Message-Id: <20231109134300.1461632-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
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

From: David Woodhouse <dwmw@amazon.co.uk>

The refcounts actually correspond to 'active_ref' structures stored in a
GHashTable per "user" on the backend side (mostly, per XenDevice).

If we zero map_track[] on reset, then when the backend drivers get torn
down and release their mapping we hit the assert(s->map_track[ref] != 0)
in gnt_unref().

So leave them in place. Each backend driver will disconnect and reconnect
as the guest comes back up again and reconnects, and it all works out OK
in the end as the old refs get dropped.

Cc: qemu-stable@nongnu.org
Fixes: de26b2619789 ("hw/xen: Implement soft reset for emulated gnttab")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
(cherry picked from commit 3de75ed352411899dbc9222e82fe164890c77e78)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 21c30e3659..839ec920a1 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -541,7 +541,5 @@ int xen_gnttab_reset(void)
     s->entries.v1[GNTTAB_RESERVED_XENSTORE].flags = GTF_permit_access;
     s->entries.v1[GNTTAB_RESERVED_XENSTORE].frame = XEN_SPECIAL_PFN(XENSTORE);
 
-    memset(s->map_track, 0, s->max_frames * ENTRIES_PER_FRAME_V1);
-
     return 0;
 }
-- 
2.39.2


