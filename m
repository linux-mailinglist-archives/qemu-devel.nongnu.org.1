Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A779983D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:01:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexaK-0006TU-Ej; Sat, 09 Sep 2023 09:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZy-0006RL-4L; Sat, 09 Sep 2023 09:00:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qexZv-0002CA-Rv; Sat, 09 Sep 2023 09:00:49 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3775320596;
 Sat,  9 Sep 2023 16:01:15 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 0DEA826DFD;
 Sat,  9 Sep 2023 16:00:24 +0300 (MSK)
Received: (nullmailer pid 353081 invoked by uid 1000);
 Sat, 09 Sep 2023 13:00:22 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ankit Kumar <ankit.kumar@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 09/43] hw/nvme: fix CRC64 for guard tag
Date: Sat,  9 Sep 2023 15:59:35 +0300
Message-Id: <20230909130020.352951-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230909155813@cover.tls.msk.ru>
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

From: Ankit Kumar <ankit.kumar@samsung.com>

The nvme CRC64 generator expects the caller to pass inverted seed value.
Pass inverted crc value for metadata buffer.

Cc: qemu-stable@nongnu.org
Fixes: 44219b6029fc ("hw/nvme: 64-bit pi support")
Signed-off-by: Ankit Kumar <ankit.kumar@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit dbdb13f931d7cf2d3c3ca662e751bb1551e9eab6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/dif.c b/hw/nvme/dif.c
index 63c44c86ab..01b19c3373 100644
--- a/hw/nvme/dif.c
+++ b/hw/nvme/dif.c
@@ -115,7 +115,7 @@ static void nvme_dif_pract_generate_dif_crc64(NvmeNamespace *ns, uint8_t *buf,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         dif->g64.guard = cpu_to_be64(crc);
@@ -246,7 +246,7 @@ static uint16_t nvme_dif_prchk_crc64(NvmeNamespace *ns, NvmeDifTuple *dif,
         uint64_t crc = crc64_nvme(~0ULL, buf, ns->lbasz);
 
         if (pil) {
-            crc = crc64_nvme(crc, mbuf, pil);
+            crc = crc64_nvme(~crc, mbuf, pil);
         }
 
         trace_pci_nvme_dif_prchk_guard_crc64(be64_to_cpu(dif->g64.guard), crc);
-- 
2.39.2


