Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10478785032
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:55:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgno-0001lE-VH; Wed, 23 Aug 2023 01:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgnl-0001k6-4d
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:53:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYgni-0007Qo-PQ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:53:08 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B5EC01C39B
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 08:52:21 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 60A0A21243;
 Wed, 23 Aug 2023 08:52:03 +0300 (MSK)
Received: (nullmailer pid 1917495 invoked by uid 1000);
 Wed, 23 Aug 2023 05:52:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH 14/24] hw/tpm: spelling fixes
Date: Wed, 23 Aug 2023 08:51:45 +0300
Message-Id: <20230823055155.1917375-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691405748.git.mjt@tls.msk.ru>
References: <cover.1691405748.git.mjt@tls.msk.ru>
MIME-Version: 1.0
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/tpm/tpm_tis.h        | 2 +-
 hw/tpm/tpm_tis_common.c | 2 +-
 hw/tpm/tpm_tis_i2c.c    | 4 ++--
 hw/tpm/tpm_tis_isa.c    | 2 +-
 hw/tpm/tpm_tis_sysbus.c | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 6f29a508dd..6f14896b97 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -20,5 +20,5 @@
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 #ifndef TPM_TPM_TIS_H
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index c07c179dbc..279ce436b5 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -21,5 +21,5 @@
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 #include "qemu/osdep.h"
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index b695fd3a46..4ecea7fa3e 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -14,5 +14,5 @@
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  *
  */
@@ -508,5 +508,5 @@ static void tpm_tis_i2c_realizefn(DeviceState *dev, Error **errp)
 
     /*
-     * Get the backend pointer. It is not initialized propery during
+     * Get the backend pointer. It is not initialized properly during
      * device_class_set_props
      */
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 91e3792248..0367401586 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -20,5 +20,5 @@
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 6724b3d4f6..2fc550f119 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -20,5 +20,5 @@
  *
  * TPM TIS for TPM 2 implementation following TCG PC Client Platform
- * TPM Profile (PTP) Specification, Familiy 2.0, Revision 00.43
+ * TPM Profile (PTP) Specification, Family 2.0, Revision 00.43
  */
 
-- 
2.39.2


