Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C365A706240
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:09:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzC6h-0002h3-Sg; Wed, 17 May 2023 04:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6S-00025C-K0; Wed, 17 May 2023 04:01:46 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pzC6L-0000ar-BE; Wed, 17 May 2023 04:01:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 344176759;
 Wed, 17 May 2023 11:00:59 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9D9A15E11;
 Wed, 17 May 2023 11:00:58 +0300 (MSK)
Received: (nullmailer pid 3624126 invoked by uid 1000);
 Wed, 17 May 2023 08:00:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8.0.1 16/36] hw/sd/allwinner-sdhost: Correctly byteswap
 descriptor fields
Date: Wed, 17 May 2023 11:00:36 +0300
Message-Id: <20230517080056.3623993-16-mjt@msgid.tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <<20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In allwinner_sdhost_process_desc() we just read directly from
guest memory into a host TransferDescriptor struct and back.
This only works on little-endian hosts. Abstract the reading
and writing of descriptors into functions that handle the
byte-swapping so that TransferDescriptor structs as seen by
the rest of the code are always in host-order.

This fixes a failure of one of the avocado tests on s390.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230424165053.1428857-2-peter.maydell@linaro.org
(cherry picked from commit 3e20d90824c262de6887aa1bc52af94db69e4310)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/sd/allwinner-sdhost.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 51e5e90830..92a0f42708 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -302,6 +302,30 @@ static void allwinner_sdhost_auto_stop(AwSdHostState *s)
     }
 }
 
+static void read_descriptor(AwSdHostState *s, hwaddr desc_addr,
+                            TransferDescriptor *desc)
+{
+    uint32_t desc_words[4];
+    dma_memory_read(&s->dma_as, desc_addr, &desc_words, sizeof(desc_words),
+                    MEMTXATTRS_UNSPECIFIED);
+    desc->status = le32_to_cpu(desc_words[0]);
+    desc->size = le32_to_cpu(desc_words[1]);
+    desc->addr = le32_to_cpu(desc_words[2]);
+    desc->next = le32_to_cpu(desc_words[3]);
+}
+
+static void write_descriptor(AwSdHostState *s, hwaddr desc_addr,
+                             const TransferDescriptor *desc)
+{
+    uint32_t desc_words[4];
+    desc_words[0] = cpu_to_le32(desc->status);
+    desc_words[1] = cpu_to_le32(desc->size);
+    desc_words[2] = cpu_to_le32(desc->addr);
+    desc_words[3] = cpu_to_le32(desc->next);
+    dma_memory_write(&s->dma_as, desc_addr, &desc_words, sizeof(desc_words),
+                     MEMTXATTRS_UNSPECIFIED);
+}
+
 static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
                                               hwaddr desc_addr,
                                               TransferDescriptor *desc,
@@ -312,9 +336,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
     uint32_t num_bytes = max_bytes;
     uint8_t buf[1024];
 
-    /* Read descriptor */
-    dma_memory_read(&s->dma_as, desc_addr, desc, sizeof(*desc),
-                    MEMTXATTRS_UNSPECIFIED);
+    read_descriptor(s, desc_addr, desc);
     if (desc->size == 0) {
         desc->size = klass->max_desc_size;
     } else if (desc->size > klass->max_desc_size) {
@@ -356,8 +378,7 @@ static uint32_t allwinner_sdhost_process_desc(AwSdHostState *s,
 
     /* Clear hold flag and flush descriptor */
     desc->status &= ~DESC_STATUS_HOLD;
-    dma_memory_write(&s->dma_as, desc_addr, desc, sizeof(*desc),
-                     MEMTXATTRS_UNSPECIFIED);
+    write_descriptor(s, desc_addr, desc);
 
     return num_done;
 }
-- 
2.39.2


