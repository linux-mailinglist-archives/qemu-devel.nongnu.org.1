Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 287257708E1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 21:19:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS0Kg-0000wO-50; Fri, 04 Aug 2023 15:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Kd-0000kZ-66; Fri, 04 Aug 2023 15:19:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qS0Kb-0007JH-Gi; Fri, 04 Aug 2023 15:19:26 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D768318471;
 Fri,  4 Aug 2023 22:17:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6ED381B8B4;
 Fri,  4 Aug 2023 22:16:56 +0300 (MSK)
Received: (nullmailer pid 1875781 invoked by uid 1000);
 Fri, 04 Aug 2023 19:16:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.4 63/63] include/hw/i386/x86-iommu: Fix struct
 X86IOMMU_MSIMessage for big endian hosts
Date: Fri,  4 Aug 2023 22:16:46 +0300
Message-Id: <20230804191647.1875608-32-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
References: <qemu-stable-8.0.4-20230804221634@cover.tls.msk.ru>
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

From: Thomas Huth <thuth@redhat.com>

The first bitfield here is supposed to be used as a 64-bit equivalent
to the "uint64_t msi_addr" in the union. To make this work correctly
on big endian hosts, too, the __addr_hi field has to be part of the
bitfield, and the the bitfield members must be declared with "uint64_t"
instead of "uint32_t" - otherwise the values are placed in the wrong
bytes on big endian hosts.

Same applies to the 32-bit "msi_data" field: __resved1 must be part
of the bitfield, and the members must be declared with "uint32_t"
instead of "uint16_t".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230802135723.178083-7-thuth@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit e1e56c07d1fa24aa37a7e89e6633768fc8ea8705)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/hw/i386/x86-iommu.h b/include/hw/i386/x86-iommu.h
index 8d8d53b18b..bfd21649d0 100644
--- a/include/hw/i386/x86-iommu.h
+++ b/include/hw/i386/x86-iommu.h
@@ -87,40 +87,42 @@ struct X86IOMMU_MSIMessage {
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint32_t __addr_head:12; /* 0xfee */
-            uint32_t dest:8;
-            uint32_t __reserved:8;
-            uint32_t redir_hint:1;
-            uint32_t dest_mode:1;
-            uint32_t __not_used:2;
+            uint64_t __addr_hi:32;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t dest:8;
+            uint64_t __reserved:8;
+            uint64_t redir_hint:1;
+            uint64_t dest_mode:1;
+            uint64_t __not_used:2;
 #else
-            uint32_t __not_used:2;
-            uint32_t dest_mode:1;
-            uint32_t redir_hint:1;
-            uint32_t __reserved:8;
-            uint32_t dest:8;
-            uint32_t __addr_head:12; /* 0xfee */
+            uint64_t __not_used:2;
+            uint64_t dest_mode:1;
+            uint64_t redir_hint:1;
+            uint64_t __reserved:8;
+            uint64_t dest:8;
+            uint64_t __addr_head:12; /* 0xfee */
+            uint64_t __addr_hi:32;
 #endif
-            uint32_t __addr_hi;
         } QEMU_PACKED;
         uint64_t msi_addr;
     };
     union {
         struct {
 #if HOST_BIG_ENDIAN
-            uint16_t trigger_mode:1;
-            uint16_t level:1;
-            uint16_t __resved:3;
-            uint16_t delivery_mode:3;
-            uint16_t vector:8;
+            uint32_t __resved1:16;
+            uint32_t trigger_mode:1;
+            uint32_t level:1;
+            uint32_t __resved:3;
+            uint32_t delivery_mode:3;
+            uint32_t vector:8;
 #else
-            uint16_t vector:8;
-            uint16_t delivery_mode:3;
-            uint16_t __resved:3;
-            uint16_t level:1;
-            uint16_t trigger_mode:1;
+            uint32_t vector:8;
+            uint32_t delivery_mode:3;
+            uint32_t __resved:3;
+            uint32_t level:1;
+            uint32_t trigger_mode:1;
+            uint32_t __resved1:16;
 #endif
-            uint16_t __resved1;
         } QEMU_PACKED;
         uint32_t msi_data;
     };
-- 
2.39.2


