Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD75E74704A
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGejA-0000R2-Aa; Tue, 04 Jul 2023 08:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=/sNo=CW=redhat.com=clg@ozlabs.org>)
 id 1qGej7-0000PQ-MJ; Tue, 04 Jul 2023 08:01:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=/sNo=CW=redhat.com=clg@ozlabs.org>)
 id 1qGej5-0002Qv-Ji; Tue, 04 Jul 2023 08:01:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwLxL3TFyz4wqZ;
 Tue,  4 Jul 2023 22:01:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwLxJ24zPz4wZw;
 Tue,  4 Jul 2023 22:01:40 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2] kconfig: Add PCIe devices to s390x machines
Date: Tue,  4 Jul 2023 14:01:37 +0200
Message-ID: <20230704120137.2604646-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=/sNo=CW=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

It is useful to extend the number of available PCI devices to KVM guests
for passthrough scenarios and also to expose these models to a different
(big endian) architecture. Include models for Intel Ethernet adapters
and one USB controller, which all support MSI-X. Devices only supporting
INTx won't work on s390x.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---

 Tested under KVM as a machine device, under KVM nested as a passthrough
 device

 hw/s390x/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 5e7d8a2bae8b..7a82c58cdf6e 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
+    imply PCI_EXPRESS
+    imply E1000E_PCI_EXPRESS
+    imply IGB_PCI_EXPRESS
+    imply USB_XHCI_PCI
-- 
2.41.0


