Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEF4B801DA
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 16:41:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyqlh-0000U7-Kv; Wed, 17 Sep 2025 07:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyql4-0007pe-J3; Wed, 17 Sep 2025 07:55:38 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uyqkw-0004bq-A9; Wed, 17 Sep 2025 07:55:34 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 4BCF44DC0F;
 Wed, 17 Sep 2025 13:55:20 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com
Subject: [PATCH v2 1/5] include/block/block_int-common: document when resize
 callback is used
Date: Wed, 17 Sep 2025 13:54:48 +0200
Message-ID: <20250917115509.401015-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250917115509.401015-1-f.ebner@proxmox.com>
References: <20250917115509.401015-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1758110111461
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The 'resize' callback is only called by bdrv_parent_cb_resize() which
is only called by bdrv_co_write_req_finish() to notify the parent(s)
that the child was resized.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/block_int-common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
index 034c0634c8..8a3d427356 100644
--- a/include/block/block_int-common.h
+++ b/include/block/block_int-common.h
@@ -1020,6 +1020,9 @@ struct BdrvChildClass {
      * the I/O API.
      */
 
+    /*
+     * Notifies the parent that the child was resized.
+     */
     void (*resize)(BdrvChild *child);
 
     /*
-- 
2.47.2



