Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8632678EE54
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLV-0008BX-OC; Thu, 31 Aug 2023 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1qbhHX-0005tB-Hu; Thu, 31 Aug 2023 09:00:22 -0400
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>)
 id 1qbhHR-0006TA-7O; Thu, 31 Aug 2023 09:00:18 -0400
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1693486805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GYdOQ0xvtEmo+ZfyGAg1NXhfZlMos6zME9NUPxYncoU=;
 b=LzQnRPi/r8a+CJDOOGWyJLF0W2BiC/IhixUB+7vHa0QQ9FAb+PpwnfxHKifkJEbcGjOZbm
 AonRx7Rqknp/1dMOMZXFugQgQCNPxr2e9ozfpUBrH09rXTdGoMTVQXRBtOiMt8ftl32taQ
 lGufRWQH4sE0hTJkDR+7nYkKU6Gg5NY=
To: qemu-devel@nongnu.org, qemu-block@nongnu.org, fam@euphon.net,
 kwolf@redhat.com, hreitz@redhat.com
Cc: sdl.qemu@linuxtesting.org,
	Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] fix bdrv_open_child return value check
Date: Thu, 31 Aug 2023 15:59:27 +0300
Message-Id: <20230831125926.796205-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

bdrv_open_child() may return NULL.
Usually return value is checked for this function.
Check for return value is more reliable.

Fixes: 24bc15d1f6 ("vmdk: Use BdrvChild instead of BDS for references to extents")

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 block/vmdk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 70066c2b01..58ce290e9c 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1207,7 +1207,7 @@ static int vmdk_parse_extents(const char *desc, BlockDriverState *bs,
                                       bs, &child_of_bds, extent_role, false,
                                       &local_err);
         g_free(extent_path);
-        if (local_err) {
+        if (!extent_file) {
             error_propagate(errp, local_err);
             ret = -EINVAL;
             goto out;
-- 
2.34.1


