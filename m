Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96879974D
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 12:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qevDG-0000xG-1p; Sat, 09 Sep 2023 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevDD-0000vt-Ks; Sat, 09 Sep 2023 06:29:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qevDB-0004ZG-7L; Sat, 09 Sep 2023 06:29:11 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A7D1204A5;
 Sat,  9 Sep 2023 13:29:09 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 6055026D03;
 Sat,  9 Sep 2023 13:28:18 +0300 (MSK)
Received: (nullmailer pid 346693 invoked by uid 1000);
 Sat, 09 Sep 2023 10:28:17 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.1 18/34] ppc/vof: Fix missed fields in VOF cleanup
Date: Sat,  9 Sep 2023 13:27:11 +0300
Message-Id: <20230909102747.346522-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
References: <qemu-stable-8.1.1-20230909131531@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Nicholas Piggin <npiggin@gmail.com>

Failing to reset the of_instance_last makes ihandle allocation continue
to increase, which causes record-replay replay fail to match the
recorded trace.

Not resetting claimed_base makes VOF eventually run out of memory after
some resets.

Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Fixes: fc8c745d501 ("spapr: Implement Open Firmware client interface")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
(cherry picked from commit 7b8589d7ce7e23f26ff53338d575a5cbd7818e28)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ppc/vof.c b/hw/ppc/vof.c
index 18c3f92317..e3b430a81f 100644
--- a/hw/ppc/vof.c
+++ b/hw/ppc/vof.c
@@ -1024,6 +1024,8 @@ void vof_cleanup(Vof *vof)
     }
     vof->claimed = NULL;
     vof->of_instances = NULL;
+    vof->of_instance_last = 0;
+    vof->claimed_base = 0;
 }
 
 void vof_build_dt(void *fdt, Vof *vof)
-- 
2.39.2


