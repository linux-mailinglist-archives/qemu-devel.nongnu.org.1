Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A077085B
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzxt-0005kY-93; Fri, 04 Aug 2023 14:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzxY-0005Zd-K6; Fri, 04 Aug 2023 14:55:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzxX-0008UV-2L; Fri, 04 Aug 2023 14:55:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD95D18419;
 Fri,  4 Aug 2023 21:54:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5D2D41B890;
 Fri,  4 Aug 2023 21:54:01 +0300 (MSK)
Received: (nullmailer pid 1874257 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 35/36] hw/i386/x86-iommu: Fix endianness issue in
 x86_iommu_irq_to_msi_message()
Date: Fri,  4 Aug 2023 21:53:48 +0300
Message-Id: <20230804185350.1874133-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

The values in "msg" are assembled in host endian byte order (the other
field are also not swapped), so we must not swap the __addr_head here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-6-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 37cf5cecb039a063c0abe3b51ae30f969e73aa84)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 01d11325a6..726e9e1d16 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -63,7 +63,7 @@ void x86_iommu_irq_to_msi_message(X86IOMMUIrq *irq, MSIMessage *msg_out)
     msg.redir_hint = irq->redir_hint;
     msg.dest = irq->dest;
     msg.__addr_hi = irq->dest & 0xffffff00;
-    msg.__addr_head = cpu_to_le32(0xfee);
+    msg.__addr_head = 0xfee;
     /* Keep this from original MSI address bits */
     msg.__not_used = irq->msi_addr_last_bits;
 
-- 
2.39.2


