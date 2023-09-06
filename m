Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 832567940BB
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdumw-0007CX-Dn; Wed, 06 Sep 2023 11:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdums-0007Ag-8B; Wed, 06 Sep 2023 11:49:50 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1qdump-0002xv-8m; Wed, 06 Sep 2023 11:49:49 -0400
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1qduji-007L3X-1Y;
 Wed, 06 Sep 2023 17:49:33 +0200
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@gmail.com,
 Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Subject: [PULL 04/18] parallels: Check if data_end greater than the file size
Date: Wed,  6 Sep 2023 17:49:37 +0200
Message-Id: <20230906154942.656537-5-den@openvz.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906154942.656537-1-den@openvz.org>
References: <20230906154942.656537-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

Initially data_end is set to the data_off image header field and must not
be greater than the file size.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 block/parallels.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/parallels.c b/block/parallels.c
index 3c0dca3dbf..6a3d41373a 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -874,6 +874,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
          */
         s->header_size = size;
     }
+    if (s->data_end > file_nb_sectors) {
+        error_setg(errp, "Invalid image: incorrect data_off field");
+        ret = -EINVAL;
+        goto fail;
+    }
 
     ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
     if (ret < 0) {
-- 
2.34.1


