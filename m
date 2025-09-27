Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E8BA5C04
	for <lists+qemu-devel@lfdr.de>; Sat, 27 Sep 2025 11:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2QrJ-0004EQ-EC; Sat, 27 Sep 2025 05:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QrD-0004Be-Al; Sat, 27 Sep 2025 05:04:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qr1-0006vB-HB; Sat, 27 Sep 2025 05:04:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE9BF15855D;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8DC1E29157A;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 08/16] hw/usb/network: Remove hardcoded 0x40 prefix in
 STRING_ETHADDR response
Date: Sat, 27 Sep 2025 12:02:52 +0300
Message-ID: <20250927090304.2901324-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stéphane Graber <stgraber@stgraber.org>

USB NICs have a "40:" prefix hardcoded for all MAC addresses when we
return the guest the MAC address if it queries the STRING_ETHADDR USB
string property.  This doesn't match what we use for the
OID_802_3_PERMANENT_ADDRESS or OID_802_3_CURRENT_ADDRESS OIDs for
NDIS, or the MAC address we actually use in the QEMU networking code
to send/receive packets for this device, or the NIC info string we
print for users.  In all those other places we directly use
s->conf.macaddr.a, which is the full thing the user asks for.

This overrides user-provided configuration and leads to an inconsistent
experience.

I couldn't find any documented reason (comment or git commits) for
this behavior.  It seems like everyone is just expecting the MAC
address to be fully passed through to the guest, but it isn't.

This may have been a debugging hack that accidentally made it through
to the accepted patch: it has been in the code since it was originally
added back in 2008.

This is also particularly problematic as the "40:" prefix isn't a
reserved prefix for MAC addresses (IEEE OUI).  There are a number of
valid allocations out there which use this prefix, meaning that QEMU
may be causing MAC address conflicts.

Cc: qemu-stable@nongnu.org
Fixes: 6c9f886ceae5b ("Add CDC-Ethernet usb NIC (original patch from Thomas Sailer)"
Signed-off-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2951
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[PMM: beef up commit message based on mailing list discussion]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit aaf042299acf83919862c7d7dd5fc36acf4e0671)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 2c33e36cad..1b6004c902 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1391,7 +1391,7 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
-             0x40,
+             s->conf.macaddr.a[0],
              s->conf.macaddr.a[1],
              s->conf.macaddr.a[2],
              s->conf.macaddr.a[3],
-- 
2.47.3


