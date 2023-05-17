Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E494C706245
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6C-0001wB-FC; Wed, 17 May 2023 04:01:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC61-0001si-2Q; Wed, 17 May 2023 04:01:21 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC5t-0000Yj-MQ; Wed, 17 May 2023 04:01:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4285B6753;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BCDD85E0B;
 Wed, 17 May 2023 11:00:57 +0300 (MSK)
Received: (nullmailer pid 3624108 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v8.0.1 10/36] hw/net/msf2-emac: Don't modify descriptor
 in-place in emac_store_desc()
Date: Wed, 17 May 2023 11:00:30 +0300
Message-Id: <20230517080056.3623993-10-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The msf2-emac ethernet controller has functions emac_load_desc() and
emac_store_desc() which read and write the in-memory descriptor
blocks and handle conversion between guest and host endianness.

As currently written, emac_store_desc() does the endianness
conversion in-place; this means that it effectively consumes the
input EmacDesc struct, because on a big-endian host the fields will
be overwritten with the little-endian versions of their values.
Unfortunately, in all the callsites the code continues to access
fields in the EmacDesc struct after it has called emac_store_desc()
-- specifically, it looks at the d.next field.

The effect of this is that on a big-endian host networking doesn't
work because the address of the next descriptor is corrupted.

We could fix this by making the callsite avoid using the struct; but
it's more robust to have emac_store_desc() leave its input alone.

(emac_load_desc() also does an in-place conversion, but here this is
fine, because the function is supposed to be initializing the
struct.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20230424151919.1333299-1-peter.maydell@linaro.org
(cherry picked from commit d565f58b38424e9a390a7ea33ff7477bab693fda)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/net/msf2-emac.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index 7ccd3e5142..db3a04deb1 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -118,14 +118,18 @@ static void emac_load_desc(MSF2EmacState *s, EmacDesc *d, hwaddr desc)
     d->next = le32_to_cpu(d->next);
 }
 
-static void emac_store_desc(MSF2EmacState *s, EmacDesc *d, hwaddr desc)
+static void emac_store_desc(MSF2EmacState *s, const EmacDesc *d, hwaddr desc)
 {
-    /* Convert from host endianness into LE. */
-    d->pktaddr = cpu_to_le32(d->pktaddr);
-    d->pktsize = cpu_to_le32(d->pktsize);
-    d->next = cpu_to_le32(d->next);
-
-    address_space_write(&s->dma_as, desc, MEMTXATTRS_UNSPECIFIED, d, sizeof *d);
+    EmacDesc outd;
+    /*
+     * Convert from host endianness into LE. We use a local struct because
+     * calling code may still want to look at the fields afterwards.
+     */
+    outd.pktaddr = cpu_to_le32(d->pktaddr);
+    outd.pktsize = cpu_to_le32(d->pktsize);
+    outd.next = cpu_to_le32(d->next);
+
+    address_space_write(&s->dma_as, desc, MEMTXATTRS_UNSPECIFIED, &outd, sizeof outd);
 }
 
 static void msf2_dma_tx(MSF2EmacState *s)
-- 
2.39.2


