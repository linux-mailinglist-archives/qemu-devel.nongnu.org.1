Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B447D98D1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwMCS-00075g-W1; Fri, 27 Oct 2023 08:44:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhujun2@cmss.chinamobile.com>)
 id 1qwDEH-0006si-QT
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:09:45 -0400
Received: from cmccmta8.chinamobile.com ([111.22.67.151]
 helo=cmccmta2.chinamobile.com)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhujun2@cmss.chinamobile.com>) id 1qwDEE-0005wj-7F
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 23:09:45 -0400
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from spf.mail.chinamobile.com (unknown[10.188.0.87])
 by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6653b29ebaac-4e335;
 Fri, 27 Oct 2023 11:09:33 +0800 (CST)
X-RM-TRANSID: 2ee6653b29ebaac-4e335
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from ubuntu.localdomain (unknown[10.54.5.255])
 by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9653b29eaed7-654ed;
 Fri, 27 Oct 2023 11:09:32 +0800 (CST)
X-RM-TRANSID: 2ee9653b29eaed7-654ed
From: zhujun2 <zhujun2@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, zhujun2 <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tests: Fix printf format string in acpi-utils.c
Date: Thu, 26 Oct 2023 20:09:30 -0700
Message-Id: <20231027030930.7739-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=111.22.67.151;
 envelope-from=zhujun2@cmss.chinamobile.com; helo=cmccmta2.chinamobile.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Oct 2023 08:44:23 -0400
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

Inside of acpi_fetch_table() arguments are
printed via fprintf but '%d' is used to print @flags (of type
uint). Use '%u' instead.

Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
---
 tests/qtest/acpi-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/acpi-utils.c b/tests/qtest/acpi-utils.c
index 673fc97586..6389f1f418 100644
--- a/tests/qtest/acpi-utils.c
+++ b/tests/qtest/acpi-utils.c
@@ -102,7 +102,7 @@ void acpi_fetch_table(QTestState *qts, uint8_t **aml, uint32_t *aml_len,
             char *fname = NULL;
             GError *error = NULL;
 
-            fprintf(stderr, "Invalid '%.4s'(%d)\n", *aml, *aml_len);
+            fprintf(stderr, "Invalid '%.4s'(%u)\n", *aml, *aml_len);
             fd = g_file_open_tmp("malformed-XXXXXX.dat", &fname, &error);
             g_assert_no_error(error);
             fprintf(stderr, "Dumping invalid table into '%s'\n", fname);
-- 
2.17.1




