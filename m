Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4094076AEB8
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 11:41:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQlsJ-0003Fi-1g; Tue, 01 Aug 2023 05:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQlsC-0003B6-8Z
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:41:01 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=570bccec8=anthony.perard@citrix.com>)
 id 1qQlsA-0005Bq-KJ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 05:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1690882858;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OC1WEjAz+/iKZdGM0POuUnljqucVKYlkFVCZyFyI6m4=;
 b=UBa8vvQWMyIKl3i/N3IVrQj9ov5bRz27RlyWXcITvn+dui56Zb76tLsT
 RO0Iqe9lKPLy9aAn8TWVt+zSM8asIRf9TokmA8DfgJGTcj1K3McYAk9RU
 P+4/orkjnYmE+oY28Uc/wIStRkl+snlkVHl2hxym2/b2P85mL8kaKB53G 8=;
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 117971006
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:n8UrkayPNjVTTjzZi4V6t+dlxirEfRIJ4+MujC+fZmUNrF6WrkUDn
 TMaCjuEPq6IN2HzeItwOo/j/E4GvJXdn9ZlGwc9qCAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EoHUMja4mtC5QRhPqkT5zcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KXBV+
 L8cCAwiUhysvb2IyajibbZinf12eaEHPKtH0p1h5TTQDPJgSpHfWaTao9Rf2V/chOgXQ6yYP
 ZBAL2MyMlKZOUYn1lQ/UfrSmM+hgGX/dDtJ7kqYv6Mt70DYzRBr0airO93QEjCPbZwMwRfH/
 zqeoQwVBDkBZNi6yjCG806luf/VgCigR8FLSaaRo6sCbFq7mTVIVUx+uUGAieC0j1P7V99BJ
 kg8/C0ooq4vskuxQbHAswaQ+SDe+ERGApwJTrN8sVvWokbJ3+qHLnkfQ31FSOAJiMMZf2MU3
 0XQuIznHgU65dV5VkmhGqeoQSKaYHZEdT9dOnVdFWPp8PG4/tht00unosJLVffs04arQWyYL
 yWi9nBWulkFsSIcO0xXF3jjiinkmJXGRxVdCu7/DjP8tVMRiGJIiuWVBbnnARVodtzxoqGp5
 iRspiRnxLlm4WuxvCKMWv4RO7qi+uyINjbR6XY2Qch5p279pyH/IdoPiN2bGKuOGp9VEQIFn
 WeJ4V8BjHOtFCXCgVBLj3KZVJ1xkPmI+SXNXfHIdNteCqWdhyfelByCkXW4hji3+GB1yPFXB
 HtuWZr0ZZrsIfg9nWXeqiZ0+eND+x3SMkuJFcyilUn2juDHDJNXIJ9cWGazgikCxPvsiG3oH
 xx3Z6NmFz03vDXCXxTq
IronPort-HdrOrdr: A9a23:CRgy86gYnkTdtreHz2VbRkUhJHBQXrkji2hC6mlwRA09TyX4ra
 CTdZEgviMc5wx9ZJhNo7q90cq7IE80i6Qb3WB5B97LYOCMggeVxe9Zg7ff/w==
X-Talos-CUID: =?us-ascii?q?9a23=3AQhiHAmr23gbGqmEQ+aKrb7fmUdE+fz7Z7Ev/H0O?=
 =?us-ascii?q?XMzlXQafMbgCe45oxxg=3D=3D?=
X-Talos-MUID: 9a23:QVQ7uAg6adRKalx6CR8UKcMpL5dsxqekC0ExmKoWodSPbjMzYmqGpWHi
X-IronPort-AV: E=Sophos;i="6.01,246,1684814400"; d="scan'208";a="117971006"
To: <qemu-devel@nongnu.org>
CC: Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 2/5] xen-block: Avoid leaks on new error path
Date: Tue, 1 Aug 2023 10:40:35 +0100
Message-ID: <20230801094038.11026-3-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230801094038.11026-1-anthony.perard@citrix.com>
References: <20230801094038.11026-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.145.153;
 envelope-from=prvs=570bccec8=anthony.perard@citrix.com;
 helo=esa2.hc3370-68.iphmx.com
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
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20230704171819.42564-1-anthony.perard@citrix.com>
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


