Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428307E6E23
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:03:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17U7-0005xf-0N; Thu, 09 Nov 2023 11:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r17U4-0005ug-KK
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:02:21 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1r17U2-0000si-RO
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:02:20 -0500
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1r17Tz-000351-0e; Thu, 09 Nov 2023 17:02:15 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH] hv-balloon: avoid alloca() usage
Date: Thu,  9 Nov 2023 17:02:08 +0100
Message-ID: <3b2253d199165648b958570d6c4db86d6ced139d.1699545634.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.42.0
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

alloca() is frowned upon, replace it with g_malloc0() + g_autofree.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 hw/hyperv/hv-balloon.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/hyperv/hv-balloon.c b/hw/hyperv/hv-balloon.c
index 66f297c1d7e3..a4b4bde0a1e9 100644
--- a/hw/hyperv/hv-balloon.c
+++ b/hw/hyperv/hv-balloon.c
@@ -365,7 +365,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     PageRangeTree dtree;
     uint64_t *dctr;
     bool our_range;
-    struct dm_unballoon_request *ur;
+    g_autofree struct dm_unballoon_request *ur = NULL;
     size_t ur_size = sizeof(*ur) + sizeof(ur->range_array[0]);
     PageRange range;
     bool bret;
@@ -387,8 +387,7 @@ static void hv_balloon_unballoon_posting(HvBalloon *balloon, StateDesc *stdesc)
     assert(dtree.t);
     assert(dctr);
 
-    ur = alloca(ur_size);
-    memset(ur, 0, ur_size);
+    ur = g_malloc0(ur_size);
     ur->hdr.type = DM_UNBALLOON_REQUEST;
     ur->hdr.size = ur_size;
     ur->hdr.trans_id = balloon->trans_id;
@@ -530,7 +529,7 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
     PageRange *hot_add_range = &balloon->hot_add_range;
     uint64_t *current_count = &balloon->ha_current_count;
     VMBusChannel *chan = hv_balloon_get_channel(balloon);
-    struct dm_hot_add *ha;
+    g_autofree struct dm_hot_add *ha = NULL;
     size_t ha_size = sizeof(*ha) + sizeof(ha->range);
     union dm_mem_page_range *ha_region;
     uint64_t align, chunk_max_size;
@@ -559,9 +558,8 @@ static void hv_balloon_hot_add_posting(HvBalloon *balloon, StateDesc *stdesc)
      */
     *current_count = MIN(hot_add_range->count, chunk_max_size);
 
-    ha = alloca(ha_size);
+    ha = g_malloc0(ha_size);
     ha_region = &(&ha->range)[1];
-    memset(ha, 0, ha_size);
     ha->hdr.type = DM_MEM_HOT_ADD_REQUEST;
     ha->hdr.size = ha_size;
     ha->hdr.trans_id = balloon->trans_id;

