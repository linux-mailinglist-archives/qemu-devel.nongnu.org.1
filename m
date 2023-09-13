Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A211D79E908
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:19:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPlK-0007N3-A2; Wed, 13 Sep 2023 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlG-0007MK-QA; Wed, 13 Sep 2023 09:18:30 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlD-00038t-DR; Wed, 13 Sep 2023 09:18:30 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A99D521764;
 Wed, 13 Sep 2023 16:18:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 984F827C87;
 Wed, 13 Sep 2023 16:18:02 +0300 (MSK)
Received: (nullmailer pid 4073295 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>, Thomas Huth <thuth@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 10/66] apic: disable reentrancy detection for apic-msi
Date: Wed, 13 Sep 2023 16:17:34 +0300
Message-Id: <20230913131757.4073200-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexander Bulekov <alxndr@bu.edu>

As the code is designed for re-entrant calls to apic-msi, mark apic-msi
as reentrancy-safe.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Message-Id: <20230427211013.2994127-9-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 50795ee051a342c681a9b45671c552fbd6274db8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 20b5a94073..ac3d47d231 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -885,6 +885,13 @@ static void apic_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->io_memory, OBJECT(s), &apic_io_ops, s, "apic-msi",
                           APIC_SPACE_SIZE);
 
+    /*
+     * apic-msi's apic_mem_write can call into ioapic_eoi_broadcast, which can
+     * write back to apic-msi. As such mark the apic-msi region re-entrancy
+     * safe.
+     */
+    s->io_memory.disable_reentrancy_guard = true;
+
     s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, apic_timer, s);
     local_apics[s->id] = s;
 
-- 
2.39.2


