Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D44809975
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:44:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQqV-00012j-DX; Thu, 07 Dec 2023 21:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.a.young@durham.ac.uk>)
 id 1rBNYT-0003YY-Tn
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 18:13:17 -0500
Received: from smtphost3.dur.ac.uk ([129.234.7.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.a.young@durham.ac.uk>)
 id 1rBNYR-0005Dn-Gd
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 18:13:17 -0500
Received: from austen5.home (unknown [10.0.152.18])
 by smtphost3.dur.ac.uk (Postfix) with ESMTPSA id C46B51957222;
 Thu,  7 Dec 2023 23:13:07 +0000 (GMT)
From: Michael Young <m.a.young@durham.ac.uk>
To: qemu-devel@nongnu.org
Cc: Michael Young <m.a.young@durham.ac.uk>
Subject: [PATCH] fix qemu build with xen-4.18.0
Date: Thu,  7 Dec 2023 23:12:48 +0000
Message-ID: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=129.234.7.145;
 envelope-from=m.a.young@durham.ac.uk; helo=smtphost3.dur.ac.uk
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Dec 2023 21:44:04 -0500
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

Builds of qemu-8.2.0rc2 with xen-4.18.0 are currently failing
with errors like
../hw/arm/xen_arm.c:74:5: error: ‘GUEST_VIRTIO_MMIO_SPI_LAST’ undeclared (first use in this function)
   74 |    (GUEST_VIRTIO_MMIO_SPI_LAST - GUEST_VIRTIO_MMIO_SPI_FIRST)
      |     ^~~~~~~~~~~~~~~~~~~~~~~~~~

as there is an incorrect comparision in include/hw/xen/xen_native.h
which means that settings like GUEST_VIRTIO_MMIO_SPI_LAST
aren't being defined for xen-4.18.0

Signed-off-by: Michael Young <m.a.young@durham.ac.uk>
---
 include/hw/xen/xen_native.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index 6f09c48823..04b1ef4d34 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -532,7 +532,7 @@ static inline int xendevicemodel_set_irq_level(xendevicemodel_handle *dmod,
 }
 #endif
 
-#if CONFIG_XEN_CTRL_INTERFACE_VERSION <= 41700
+#if CONFIG_XEN_CTRL_INTERFACE_VERSION >= 41700
 #define GUEST_VIRTIO_MMIO_BASE   xen_mk_ullong(0x02000000)
 #define GUEST_VIRTIO_MMIO_SIZE   xen_mk_ullong(0x00100000)
 #define GUEST_VIRTIO_MMIO_SPI_FIRST   33
-- 
2.43.0


