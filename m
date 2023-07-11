Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0F074F26D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJESK-0005ym-58; Tue, 11 Jul 2023 10:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=TvwJ=C5=redhat.com=clg@ozlabs.org>)
 id 1qJESC-0005wj-AI; Tue, 11 Jul 2023 10:35:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=TvwJ=C5=redhat.com=clg@ozlabs.org>)
 id 1qJERw-0007zt-49; Tue, 11 Jul 2023 10:34:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4R0k0T4cy1z4wy4;
 Wed, 12 Jul 2023 00:34:33 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4R0k0R69Lyz4wy9;
 Wed, 12 Jul 2023 00:34:31 +1000 (AEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] s390x: Fix QEMU abort by selecting S390_FLIC_KVM
Date: Tue, 11 Jul 2023 16:34:26 +0200
Message-ID: <20230711143426.708978-1-clg@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=TvwJ=C5=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

If QEMU is built with --without-default-devices, the s390-flic-kvm
device is missing and QEMU aborts when started with the KVM accelerator.
Make sure it's available by selecting S390_FLIC_KVM in Kconfig.

Consequently, this also fixes an abort in tests/qtest/migration-test.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/Kconfig  | 1 -
 hw/s390x/Kconfig | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 21441d0a0c43..97d550b06b77 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -49,7 +49,6 @@ config S390_FLIC
 
 config S390_FLIC_KVM
     bool
-    default y
     depends on S390_FLIC && KVM
 
 config OMPIC
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 5e7d8a2bae8b..0dad184e06d2 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -7,6 +7,7 @@ config S390_CCW_VIRTIO
     imply WDT_DIAG288
     select PCI
     select S390_FLIC
+    select S390_FLIC_KVM
     select SCLPCONSOLE
     select VIRTIO_CCW
     select MSI_NONBROKEN
-- 
2.41.0


