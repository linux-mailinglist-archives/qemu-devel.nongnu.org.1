Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D328A7E1330
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 12:49:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzbcM-0002zI-Q4; Sun, 05 Nov 2023 06:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcH-0002yg-3B
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:48:33 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcF-0002GC-HP
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 06:48:32 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qzbcC-0003Xf-BM; Sun, 05 Nov 2023 12:48:28 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [PULL 2/9] memory-device: Drop size alignment check
Date: Sun,  5 Nov 2023 12:47:50 +0100
Message-ID: <de225d7dd84535692d87bab9cf6cb2e819823b82.1699184105.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1699184105.git.maciej.szmigiero@oracle.com>
References: <cover.1699184105.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Hildenbrand <david@redhat.com>

There is no strong requirement that the size has to be multiples of the
requested alignment, let's drop it. This is a preparation for hv-baloon.

Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/mem/memory-device.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index db702ccad554..e0704b8dc37a 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -236,12 +236,6 @@ static uint64_t memory_device_get_free_addr(MachineState *ms,
         return 0;
     }
 
-    if (!QEMU_IS_ALIGNED(size, align)) {
-        error_setg(errp, "backend memory size must be multiple of 0x%"
-                   PRIx64, align);
-        return 0;
-    }
-
     if (hint) {
         if (range_init(&new, *hint, size) || !range_contains_range(&as, &new)) {
             error_setg(errp, "can't add memory device [0x%" PRIx64 ":0x%" PRIx64

