Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3989C845DCB
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Feb 2024 17:54:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDD-0005sI-P8; Thu, 01 Feb 2024 11:46:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaB6-0002xf-Ba
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rVaAv-0002Ps-1u
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=4LcthZeMhomcS7qQ4JhYfqujNilKqWbfcJYcyaxs+fc=; b=R5ob6XwqdmMHLIgOQOYJG6+jiH
 d+wasNW0ZwEuwrhOqAoJrMZszyz6Y9IeltL3bpUNquqTYo6L5KTuLZcwFzIUD2eC/LZ6o+Feus6xK
 UkqTsRe0OKUZudM3uJs+Nx9ftG6lKrm+ZuMaQ2Iqgz3m9tdS9e6m0XDE4fEj4A+yDVyZztpoiB39Z
 0mf+/1kEAWtIuiz/dRgdfrna+QHfYnoYMd4l+Tf0MvCmeDvt7akm+AZybB8jvLgEce3pdmm/6HMrb
 eJ69tb7UbdSe02d2PXqc+LmhvZPGLC1tUkfE4iyCTh7iMNmPG1wqA5qBjEQBowWijJtEQGaZ0zZUZ
 Mh595NSg==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAe-0000000GId0-2rFg for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003IMa-2ye1 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/47] hw/mips/fuloong2e: use pci_init_nic_devices()
Date: Thu,  1 Feb 2024 16:43:37 +0000
Message-ID: <20240201164412.785520-13-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+16c2638fe4346fda554c+7466+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

The previous behaviour was: *if* the first NIC specified on the command
line was an RTL8139 (or unspecified model) then it gets assigned to PCI
slot 7, which is where the Fuloong board had an RTL8139. All other
devices (including the first, if it was specified as anything other than
an rtl8319) get dynamically assigned on the bus.

The new behaviour is subtly different: If the first NIC was given a
specific model *other* than rtl8139, and a subsequent NIC was not,
then the rtl8139 (or unspecified) NIC will go to slot 7 and the rest
will be dynamically assigned.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/mips/fuloong2e.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 97b2c8ed8e..a45aac368c 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -201,19 +201,9 @@ static void main_cpu_reset(void *opaque)
 /* Network support */
 static void network_init(PCIBus *pci_bus)
 {
-    int i;
-
-    for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-        const char *default_devaddr = NULL;
-
-        if (i == 0 && (!nd->model || strcmp(nd->model, "rtl8139") == 0)) {
-            /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
-            default_devaddr = "07";
-        }
-
-        pci_nic_init_nofail(nd, pci_bus, "rtl8139", default_devaddr);
-    }
+    /* The Fuloong board has a RTL8139 card using PCI SLOT 7 */
+    pci_init_nic_in_slot(pci_bus, "rtl8139", NULL, "07");
+    pci_init_nic_devices(pci_bus, "rtl8139");
 }
 
 static void mips_fuloong2e_init(MachineState *machine)
-- 
2.43.0


