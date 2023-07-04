Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA577477A7
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 19:20:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGjgU-0000fL-4A; Tue, 04 Jul 2023 13:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5427c2329=anthony.perard@citrix.com>)
 id 1qGjgS-0000ej-IH; Tue, 04 Jul 2023 13:19:24 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5427c2329=anthony.perard@citrix.com>)
 id 1qGjgP-0002qM-G8; Tue, 04 Jul 2023 13:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1688491161;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Eql3MawCi2ZfqehegLJ8cUT771NNec9LMnumXVGF1qE=;
 b=Dfv0x/7U+00nebaodsjzRTiqcxr7Ur54mrL/PP8NGD8Re4SJ5ncBQoVb
 EmvAULfuydqI82zMlpr2DyE36ur/HSdJ4CkfMzmbveyWDqlDlnX7xER6N
 3FZRQrBH7RqNdsAYkOe53uZq2UAsVUwS8mt2Vh6ERYaBTeAM4nB5fdAVa k=;
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 115157045
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:g/iXMqsm1UGONY66HkDFEjp+hOfnVKBeMUV32f8akzHdYApBsoF/q
 tZmKWGFMq7eZzT9Ko8kOoS/8kkF7ZOGzoA2SFNlqCswFysV+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Vv0gnRkPaoQ5ACGyyFOZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwGDkEXyG7tf2P0aulZsROmPwfc5nlI9ZK0p1g5Wmx4fcORJnCR+PB5MNC3Sd2jcdLdRrcT
 5NHM3w1Nk2GOkARfA5NU/rSn8/x7pX7WzRetFKSo7tx+2XJxRZ9+LPsLMDUapqBQsA9ckOw/
 zubpjmmWk1HXDCZ4RW6ymumj+3ooWDUVMFKEvq72q9M33TGkwT/DzVJDADm8JFVkHWWQt9aN
 gkY9zQjqYA080qkSMS7WAe3yFacswIRQZxVGvw25QWJ4q7V5Q+DAS4DVDEpQMc9qMY8SDgu1
 1mIt9DkHzpitPuSU3313q+dsDeaKSUTa2gYakcsThQC59fLuow/jhvTCN1kFcadjsf4GC3i6
 yqHoCg3m/MYistj/7W2+xXLjiyhorDNTxUp/UPHU2S99AR7aYW5IYuy5jDz9PtFMcOTSl6Kv
 1ACnM6R6v1ICouC/BFhW81UQuvvvazcdmSB3xg2RcJJGymRF2CLTYlZ0QBGFlhQI98aVRLLf
 nfv5lNf+8oGVJe1VpObc75dGuxzk/iwSYq8C6GEBjZdSsMvLVHapUmCcWbVhjmwyxZ0zMnTL
 L/BKa6R4WAm5bOLJdZcb8MUyvcVyy833gs/rrirnk38gdJyiJN4IIrp0WdijchjtstoWC2Pr
 75i2zKikn2zqtHWbCjN6pI0JlsXN3U9Dp2eg5UJJr7fels8QT99V665LVYdl2tNxvU9qws11
 ivlBh8wJKTX2BUr1jlmmlg8MeiyDP6TXFowPDA2PEbA5pTQSd/H0UvrTLNuJeNP3LU6nZZJo
 wwtJ53o7gJnFm6WpFzwrPDV8ORfSfhcrVjfZnL4MGVmIsYIqs6g0oaMQzYDPRImVkKf3fbSa
 ZX5vu8HafLvnzhfMfs=
IronPort-HdrOrdr: A9a23:7HCrbqgBgYreQaAKaZfSTzWLknBQXtQji2hC6mlwRA09TyX4ra
 yTdZEgviMc5wx/ZJhNo7690cu7IU80hKQV3WB5B97LNmTbUQCTXeJfBOXZsljdMhy72ulB1b
 pxN4hSYeeAaWSSVPyKgjWFLw==
X-Talos-CUID: 9a23:HNyfVG4AIKYvsWnX5dssxEcdK/EdQGLk3W7OD2KaF15VF+2bVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3AjOhlcA2EuH6aM7kVfYJV62N7vjUjzJuWEUoEk7I?=
 =?us-ascii?q?6+OaIdnR2fDSx3RLoa9py?=
X-IronPort-AV: E=Sophos;i="6.01,181,1684814400"; d="scan'208";a="115157045"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>, Peter Maydell
 <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>,
 "Paul Durrant" <paul@xen.org>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, <xen-devel@lists.xenproject.org>,
 <qemu-block@nongnu.org>
Subject: [PATCH] xen-block: Avoid leaks on new error path
Date: Tue, 4 Jul 2023 18:18:19 +0100
Message-ID: <20230704171819.42564-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.155;
 envelope-from=prvs=5427c2329=anthony.perard@citrix.com;
 helo=esa3.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Anthony PERARD <anthony.perard@citrix.com>

Commit 189829399070 ("xen-block: Use specific blockdev driver")
introduced a new error path, without taking care of allocated
resources.

So only allocate the qdicts after the error check, and free both
`filename` and `driver` when we are about to return and thus taking
care of both success and error path.

Coverity only spotted the leak of qdicts (*_layer variables).

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Fixes: Coverity CID 1508722, 1398649
Fixes: 189829399070 ("xen-block: Use specific blockdev driver")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/block/xen-block.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index f099914831..3906b9058b 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -781,14 +781,15 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     drive = g_new0(XenBlockDrive, 1);
     drive->id = g_strdup(id);
 
-    file_layer = qdict_new();
-    driver_layer = qdict_new();
-
     rc = stat(filename, &st);
     if (rc) {
         error_setg_errno(errp, errno, "Could not stat file '%s'", filename);
         goto done;
     }
+
+    file_layer = qdict_new();
+    driver_layer = qdict_new();
+
     if (S_ISBLK(st.st_mode)) {
         qdict_put_str(file_layer, "driver", "host_device");
     } else {
@@ -796,7 +797,6 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     }
 
     qdict_put_str(file_layer, "filename", filename);
-    g_free(filename);
 
     if (mode && *mode != 'w') {
         qdict_put_bool(file_layer, "read-only", true);
@@ -831,7 +831,6 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     qdict_put_str(file_layer, "locking", "off");
 
     qdict_put_str(driver_layer, "driver", driver);
-    g_free(driver);
 
     qdict_put(driver_layer, "file", file_layer);
 
@@ -842,6 +841,8 @@ static XenBlockDrive *xen_block_drive_create(const char *id,
     qobject_unref(driver_layer);
 
 done:
+    g_free(filename);
+    g_free(driver);
     if (*errp) {
         xen_block_drive_destroy(drive, NULL);
         return NULL;
-- 
Anthony PERARD


