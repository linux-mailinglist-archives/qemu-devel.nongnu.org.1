Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DB4BA2E39
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 10:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Yl-0007PR-Vx; Fri, 26 Sep 2025 04:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23YW-0007Mz-SD; Fri, 26 Sep 2025 04:11:53 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23YT-0000N0-8l; Fri, 26 Sep 2025 04:11:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 79AE7157D52;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D2B7290C36;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 10/60] qga/installer: Remove QGA VSS if QGA
 installation failed
Date: Fri, 26 Sep 2025 11:09:38 +0300
Message-ID: <20250926081031.2214971-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

When QGA Installer failed to install QGA service but install
QGA VSS provider, provider should be removed before installer
exits. Otherwise QGA VSS will has broken infomation and
prevent QGA installation in next run.

Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250825143155.160913-1-kkostiuk@redhat.com
Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
(cherry picked from commit 85ff0e956bf26a93c92e4dca8f6257613269a0cf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index df572adb4a..32b8308728 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -151,6 +151,14 @@
               Return="check"
               >
     </CustomAction>
+    <CustomAction Id="UnRegisterCom_Rollback"
+              ExeCommand='"[qemu_ga_directory]qga-vss.dll",DLLCOMUnregister'
+              Execute="rollback"
+              Property="rundll"
+              Impersonate="no"
+              Return="check"
+              >
+    </CustomAction>
     <?endif?>
 
     <Feature Id="QEMUFeature" Title="QEMU Guest Agent" Level="1">
@@ -174,8 +182,19 @@
 
     <InstallExecuteSequence>
       <?ifdef var.InstallVss?>
-      <Custom Action="UnRegisterCom" After="StopServices">Installed</Custom>
-      <Custom Action="RegisterCom" After="InstallServices">NOT REMOVE</Custom>
+        <!-- Use explicit Sequence number to provide an absolute position in the sequence-->
+        <!-- This is needed to set "UnRegisterCom_Rollback" before "RegisterCom" and after "InstallFiles"-->
+        <!-- but, Wix detect this double condition incorrectly -->
+
+        <!-- UnRegisterCom_Rollback (for install rollback): at 5849, right before RegisterCom (5850)-->
+        <!-- Runs only if the installation fails and rolls back-->
+        <Custom Action="UnRegisterCom_Rollback" Sequence="5849">NOT REMOVE</Custom>
+
+        <!-- RegisterCom (for install): at 5850, right after InstallFiles (5849) (old: After="InstallServices")-->
+        <Custom Action="RegisterCom" Sequence="5850">NOT REMOVE</Custom>
+
+        <!-- UnRegisterCom (for uninstall): at 1901, right after StopServices (1900) (old: After="StopServices")-->
+        <Custom Action="UnRegisterCom" Sequence="1901">Installed</Custom>
       <?endif?>
     </InstallExecuteSequence>
   </Product>
-- 
2.47.3


