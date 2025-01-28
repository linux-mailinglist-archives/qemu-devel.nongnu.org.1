Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0502A2062C
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 09:27:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgSR-0000c6-7f; Tue, 28 Jan 2025 02:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgRd-0007gN-CI; Tue, 28 Jan 2025 02:55:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgRb-00009P-Ay; Tue, 28 Jan 2025 02:55:37 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 18FCDE1AD7;
 Tue, 28 Jan 2025 10:53:00 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 87E6F1A62C6;
 Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id 3F6A552023; Tue, 28 Jan 2025 10:53:25 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.16 30/31] pci: acpi: Windows 'PCI Label Id' bug workaround
Date: Tue, 28 Jan 2025 00:41:22 +0300
Message-Id: <20250127214124.3730126-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
References: <qemu-stable-7.2.16-20250128004119@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Current versions of Windows call _DSM(func=7) regardless
of whether it is supported or not. It leads to NICs having bogus
'PCI Label Id = 0', where none should be set at all.

Also presence of 'PCI Label Id' triggers another Windows bug
on localized versions that leads to hangs. The later bug is fixed
in latest updates for 'Windows Server' but not in consumer
versions of Windows (and there is no plans to fix it
as far as I'm aware).

Given it's easy, implement Microsoft suggested workaround
(return invalid Package) so that affected Windows versions
could boot on QEMU.
This would effectvely remove bogus 'PCI Label Id's on NICs,
but MS teem confirmed that flipping 'PCI Label Id' should not
change 'Network Connection' ennumeration, so it should be safe
for QEMU to change _DSM without any compat code.

Smoke tested with WinXP and WS2022
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/774
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20250115125342.3883374-3-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 0b053391985abcc40b16ac8fc4a7f6588d1d95c1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f9cdacadb1..79b68f2218 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -541,6 +541,7 @@ static Aml *aml_pci_pdsm(void)
     Aml *acpi_index = aml_local(2);
     Aml *zero = aml_int(0);
     Aml *one = aml_int(1);
+    Aml *not_supp = aml_int(0xFFFFFFFF);
     Aml *func = aml_arg(2);
     Aml *rev = aml_arg(1);
     Aml *params = aml_arg(4);
@@ -586,7 +587,7 @@ static Aml *aml_pci_pdsm(void)
          */
         ifctx1 = aml_if(aml_lnot(
                      aml_or(aml_equal(acpi_index, zero),
-                            aml_equal(acpi_index, aml_int(0xFFFFFFFF)), NULL)
+                            aml_equal(acpi_index, not_supp), NULL)
                  ));
         {
             /* have supported functions */
@@ -612,18 +613,30 @@ static Aml *aml_pci_pdsm(void)
     {
        Aml *pkg = aml_package(2);
 
-       aml_append(pkg, zero);
-       /*
-        * optional, if not impl. should return null string
-        */
-       aml_append(pkg, aml_string("%s", ""));
-       aml_append(ifctx, aml_store(pkg, ret));
-
        aml_append(ifctx, aml_store(aml_call2("AIDX", bnum, sunum), acpi_index));
+       aml_append(ifctx, aml_store(pkg, ret));
        /*
-        * update acpi-index to actual value
+        * Windows calls func=7 without checking if it's available,
+        * as workaround Microsoft has suggested to return invalid for func7
+        * Package, so return 2 elements package but only initialize elements
+        * when acpi_index is supported and leave them uninitialized, which
+        * leads elements to being Uninitialized ObjectType and should trip
+        * Windows into discarding result as an unexpected and prevent setting
+        * bogus 'PCI Label' on the device.
         */
-       aml_append(ifctx, aml_store(acpi_index, aml_index(ret, zero)));
+       ifctx1 = aml_if(aml_lnot(aml_lor(
+                    aml_equal(acpi_index, zero), aml_equal(acpi_index, not_supp)
+                )));
+       {
+           aml_append(ifctx1, aml_store(acpi_index, aml_index(ret, zero)));
+           /*
+            * optional, if not impl. should return null string
+            */
+           aml_append(ifctx1, aml_store(aml_string("%s", ""),
+                                        aml_index(ret, one)));
+       }
+       aml_append(ifctx, ifctx1);
+
        aml_append(ifctx, aml_return(ret));
     }
 
-- 
2.39.5


