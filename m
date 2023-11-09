Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4F97E6BE6
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:01:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15bF-0007yz-JF; Thu, 09 Nov 2023 09:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zt-0005bw-09; Thu, 09 Nov 2023 09:00:17 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r15Zk-0005V7-0k; Thu, 09 Nov 2023 09:00:11 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D81E531BC0;
 Thu,  9 Nov 2023 16:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id DF997344F9;
 Thu,  9 Nov 2023 16:59:33 +0300 (MSK)
Received: (nullmailer pid 1462785 invoked by uid 1000);
 Thu, 09 Nov 2023 13:59:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Zhijian <lizhijian@cn.fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.7 10/62] hw/cxl: Fix CFMW config memory leak
Date: Thu,  9 Nov 2023 16:58:38 +0300
Message-Id: <20231109135933.1462615-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
References: <qemu-stable-7.2.7-20231109164316@cover.tls.msk.ru>
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

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Allocate targets and targets[n] resources when all sanity checks are
passed to avoid memory leaks.

Cc: qemu-stable@nongnu.org
Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(cherry picked from commit 7b165fa164022b756c2b001d0a1525f98199d3ac)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 1adf61231a..0fc3e57138 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -39,12 +39,6 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         return;
     }
 
-    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
-    for (i = 0, target = object->targets; target; i++, target = target->next) {
-        /* This link cannot be resolved yet, so stash the name for now */
-        fw->targets[i] = g_strdup(target->value);
-    }
-
     if (object->size % (256 * MiB)) {
         error_setg(errp,
                    "Size of a CXL fixed memory window must my a multiple of 256MiB");
@@ -64,6 +58,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->enc_int_gran = 0;
     }
 
+    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
+    for (i = 0, target = object->targets; target; i++, target = target->next) {
+        /* This link cannot be resolved yet, so stash the name for now */
+        fw->targets[i] = g_strdup(target->value);
+    }
+
     cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
                                              g_steal_pointer(&fw));
 
-- 
2.39.2


