Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FD85D26C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Feb 2024 09:21:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rchr6-0001Ek-HB; Wed, 21 Feb 2024 03:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqw-00015U-6P; Wed, 21 Feb 2024 03:21:18 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchqu-0002Au-I2; Wed, 21 Feb 2024 03:21:17 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 657C04F3C6;
 Wed, 21 Feb 2024 11:21:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2ED37860A5;
 Wed, 21 Feb 2024 11:20:59 +0300 (MSK)
Received: (nullmailer pid 2142010 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Bohdan Kostiv <bohdan.kostiv@tii.ae>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 08/60] system/vl.c: Fix handling of '-serial none
 -serial something'
Date: Wed, 21 Feb 2024 11:19:56 +0300
Message-Id: <20240221082058.2141850-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently if the user passes multiple -serial options on the command
line, we mostly treat those as applying to the different serial
devices in order, so that for example
 -serial stdio -serial file:filename
will connect the first serial port to stdio and the second to the
named file.

The exception to this is the '-serial none' serial device type.  This
means "don't allocate this serial device", but a bug means that
following -serial options are not correctly handled, so that
 -serial none -serial stdio
has the unexpected effect that stdio is connected to the first serial
port, not the second.

This is a very long-standing bug that dates back at least as far as
commit 998bbd74b9d81 from 2009.

Make the 'none' serial type move forward in the indexing of serial
devices like all the other serial types, so that any subsequent
-serial options are correctly handled.

Note that if your commandline mistakenly had a '-serial none' that
was being overridden by a following '-serial something' option, you
should delete the unnecessary '-serial none'.  This will give you the
same behaviour as before, on QEMU versions both with and without this
bug fix.

Cc: qemu-stable@nongnu.org
Reported-by: Bohdan Kostiv <bohdan.kostiv@tii.ae>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240122163607.459769-2-peter.maydell@linaro.org
Fixes: 998bbd74b9d81 ("default devices: core code & serial lines")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit d2019a9d0c34a4fdcb5b5df550d73040dc0637d9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/vl.c b/system/vl.c
index 6b87bfa32c..938b7b5acc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -1440,18 +1440,22 @@ static void qemu_create_default_devices(void)
 static int serial_parse(const char *devname)
 {
     int index = num_serial_hds;
-    char label[32];
 
-    if (strcmp(devname, "none") == 0)
-        return 0;
-    snprintf(label, sizeof(label), "serial%d", index);
     serial_hds = g_renew(Chardev *, serial_hds, index + 1);
 
-    serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
-    if (!serial_hds[index]) {
-        error_report("could not connect serial device"
-                     " to character backend '%s'", devname);
-        return -1;
+    if (strcmp(devname, "none") == 0) {
+        /* Don't allocate a serial device for this index */
+        serial_hds[index] = NULL;
+    } else {
+        char label[32];
+        snprintf(label, sizeof(label), "serial%d", index);
+
+        serial_hds[index] = qemu_chr_new_mux_mon(label, devname, NULL);
+        if (!serial_hds[index]) {
+            error_report("could not connect serial device"
+                         " to character backend '%s'", devname);
+            return -1;
+        }
     }
     num_serial_hds++;
     return 0;
-- 
2.39.2


