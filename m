Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DEE7B7985
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:05:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnws4-0007xl-Bk; Wed, 04 Oct 2023 04:04:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqh-0004iR-2y; Wed, 04 Oct 2023 04:03:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qnwqf-0008A8-8e; Wed, 04 Oct 2023 04:03:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0566A27596;
 Wed,  4 Oct 2023 11:02:25 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 504332CBD2;
 Wed,  4 Oct 2023 11:02:24 +0300 (MSK)
Received: (nullmailer pid 2702786 invoked by uid 1000);
 Wed, 04 Oct 2023 08:02:21 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Dmitry Frolov <frolov@swemel.ru>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [Stable-8.1.2 12/45] hw/cxl: Fix out of bound array access
Date: Wed,  4 Oct 2023 11:01:33 +0300
Message-Id: <20231004080221.2702636-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
References: <qemu-stable-8.1.2-20231003193203@cover.tls.msk.ru>
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

From: Dmitry Frolov <frolov@swemel.ru>

According to cxl_interleave_ways_enc(), fw->num_targets is allowed to be up
to 16. This also corresponds to CXL r3.0 spec. So, the fw->target_hbs[]
array is iterated from 0 to 15. But it is statically declared of length 8.
Thus, out of bound array access may occur.

Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit from TYPE_PXB_DEV")
Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Link: https://lore.kernel.org/r/20230913101055.754709-1-frolov@swemel.ru
Cc: qemu-stable@nongnu.org
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit de5bbfc602ef1b9b79c494a914c6083a1a23cca2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 56c9e7676e..4944725849 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -29,7 +29,7 @@ typedef struct PXBCXLDev PXBCXLDev;
 typedef struct CXLFixedWindow {
     uint64_t size;
     char **targets;
-    PXBCXLDev *target_hbs[8];
+    PXBCXLDev *target_hbs[16];
     uint8_t num_targets;
     uint8_t enc_int_ways;
     uint8_t enc_int_gran;
-- 
2.39.2


