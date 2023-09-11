Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14B79A58C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:08:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbsq-0001Y5-Pk; Mon, 11 Sep 2023 04:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsn-0001WY-TW; Mon, 11 Sep 2023 04:02:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfbsl-0002BL-K8; Mon, 11 Sep 2023 04:02:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9373C20AF8;
 Mon, 11 Sep 2023 11:02:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EB8AA2724D;
 Mon, 11 Sep 2023 11:02:28 +0300 (MSK)
Received: (nullmailer pid 3680152 invoked by uid 1000);
 Mon, 11 Sep 2023 08:02:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.6 11/51] raven: disable reentrancy detection for iomem
Date: Mon, 11 Sep 2023 11:02:02 +0300
Message-Id: <20230911080225.3680068-11-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
References: <qemu-stable-7.2.6-20230911105418@cover.tls.msk.ru>
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

As the code is designed for re-entrant calls from raven_io_ops to
pci-conf, mark raven_io_ops as reentrancy-safe.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Message-Id: <20230427211013.2994127-8-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 6dad5a6810d9c60ca320d01276f6133bbcfa1fc7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 7a105e4a63..42fb02b7e6 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -293,6 +293,13 @@ static void raven_pcihost_initfn(Object *obj)
     memory_region_init(&s->pci_memory, obj, "pci-memory", 0x3f000000);
     address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
 
+    /*
+     * Raven's raven_io_ops use the address-space API to access pci-conf-idx
+     * (which is also owned by the raven device). As such, mark the
+     * pci_io_non_contiguous as re-entrancy safe.
+     */
+    s->pci_io_non_contiguous.disable_reentrancy_guard = true;
+
     /* CPU address space */
     memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
                                 &s->pci_io);
-- 
2.39.2


