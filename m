Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24250825B1B
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 20:33:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLpuU-0000Ly-2n; Fri, 05 Jan 2024 14:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpuG-0000HL-AW; Fri, 05 Jan 2024 14:31:01 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rLpuB-000300-Ks; Fri, 05 Jan 2024 14:30:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 83D4840D2D;
 Fri,  5 Jan 2024 22:30:42 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 262175B1ED;
 Fri,  5 Jan 2024 22:30:39 +0300 (MSK)
Received: (nullmailer pid 116610 invoked by uid 1000);
 Fri, 05 Jan 2024 19:30:38 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Subject: [PULL 2/6] chardev/char.c: fix "abstract device type" error message
Date: Fri,  5 Jan 2024 22:30:34 +0300
Message-Id: <20240105193038.116576-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240105193038.116576-1-mjt@tls.msk.ru>
References: <20240105193038.116576-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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

Current error message:

 qemu-system-x86_64: -chardev spice,id=foo: Parameter 'driver' expects an abstract device type

while in fact the meaning is in reverse, -chardev expects
a non-abstract device type.

Fixes: 777357d758d9 ("chardev: qom-ify" 2016-12-07)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 chardev/char.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index 996a024c7a..119b548784 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -518,7 +518,7 @@ static const ChardevClass *char_get_class(const char *driver, Error **errp)
 
     if (object_class_is_abstract(oc)) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
-                   "an abstract device type");
+                   "a non-abstract device type");
         return NULL;
     }
 
-- 
2.39.2


