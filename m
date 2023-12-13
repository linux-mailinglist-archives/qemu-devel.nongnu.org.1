Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C09C81127C
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:06:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOup-0004io-1t; Wed, 13 Dec 2023 08:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsp-0000g9-4f; Wed, 13 Dec 2023 08:02:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOsk-0007Es-Ru; Wed, 13 Dec 2023 08:02:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2B7913B44B;
 Wed, 13 Dec 2023 16:01:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C00193C8DC;
 Wed, 13 Dec 2023 16:00:46 +0300 (MSK)
Received: (nullmailer pid 1024787 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Patrick Venture <venture@google.com>,
 Chris Rauer <crauer@google.com>, Peter Foley <pefoley@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 24/24] system/memory: use ldn_he_p/stn_he_p
Date: Wed, 13 Dec 2023 16:00:33 +0300
Message-Id: <20231213130041.1024630-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
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

From: Patrick Venture <venture@google.com>

Using direct pointer dereferencing can allow for unaligned accesses,
which was seen during execution with sanitizers enabled.

Cc: qemu-stable@nongnu.org
Reviewed-by: Chris Rauer <crauer@google.com>
Reviewed-by: Peter Foley <pefoley@google.com>
Signed-off-by: Patrick Venture <venture@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20231116163633.276671-1-venture@google.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 2b8fe81b3c2e76d241510a9a85496d544e42f5ec)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 61569f8306..2b03596bc7 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1326,22 +1326,7 @@ static uint64_t memory_region_ram_device_read(void *opaque,
                                               hwaddr addr, unsigned size)
 {
     MemoryRegion *mr = opaque;
-    uint64_t data = (uint64_t)~0;
-
-    switch (size) {
-    case 1:
-        data = *(uint8_t *)(mr->ram_block->host + addr);
-        break;
-    case 2:
-        data = *(uint16_t *)(mr->ram_block->host + addr);
-        break;
-    case 4:
-        data = *(uint32_t *)(mr->ram_block->host + addr);
-        break;
-    case 8:
-        data = *(uint64_t *)(mr->ram_block->host + addr);
-        break;
-    }
+    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
 
     trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
 
@@ -1355,20 +1340,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 
     trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
 
-    switch (size) {
-    case 1:
-        *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
-        break;
-    case 2:
-        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
-        break;
-    case 4:
-        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
-        break;
-    case 8:
-        *(uint64_t *)(mr->ram_block->host + addr) = data;
-        break;
-    }
+    stn_he_p(mr->ram_block->host + addr, size, data);
 }
 
 static const MemoryRegionOps ram_device_mem_ops = {
-- 
2.39.2


