Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD8F77085A
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 20:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRzwH-0002It-Cl; Fri, 04 Aug 2023 14:54:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwE-0002HV-HW; Fri, 04 Aug 2023 14:54:14 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRzwC-00088T-R1; Fri, 04 Aug 2023 14:54:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2851B1840A;
 Fri,  4 Aug 2023 21:54:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id BDB161B881;
 Fri,  4 Aug 2023 21:53:57 +0300 (MSK)
Received: (nullmailer pid 1874212 invoked by uid 1000);
 Fri, 04 Aug 2023 18:53:56 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>, Brian Wiltse <brian.wiltse@live.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.5 20/36] qga/win32: Use rundll for VSS installation
Date: Fri,  4 Aug 2023 21:53:33 +0300
Message-Id: <20230804185350.1874133-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
References: <qemu-stable-7.2.5-20230804215319@cover.tls.msk.ru>
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

From: Konstantin Kostiuk <kkostiuk@redhat.com>

The custom action uses cmd.exe to run VSS Service installation
and removal which causes an interactive command shell to spawn.
This shell can be used to execute any commands as a SYSTEM user.
Even if call qemu-ga.exe directly the interactive command shell
will be spawned as qemu-ga.exe is a console application and used
by users from the console as well as a service.

As VSS Service runs from DLL which contains the installer and
uninstaller code, it can be run directly by rundll32.exe without
any interactive command shell.

Add specific entry points for rundll which is just a wrapper
for COMRegister/COMUnregister functions with proper arguments.

resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2167423
fixes: CVE-2023-0664 (part 2 of 2)

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Yan Vugenfirer <yvugenfi@redhat.com>
Reported-by: Brian Wiltse <brian.wiltse@live.com>
(cherry picked from commit 07ce178a2b0768eb9e712bb5ad0cf6dc7fcf0158)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/qga/installer/qemu-ga.wxs b/qga/installer/qemu-ga.wxs
index 3442383627..949ba07fd2 100644
--- a/qga/installer/qemu-ga.wxs
+++ b/qga/installer/qemu-ga.wxs
@@ -116,22 +116,22 @@
       </Directory>
     </Directory>
 
-    <Property Id="cmd" Value="cmd.exe"/>
+    <Property Id="rundll" Value="rundll32.exe"/>
     <Property Id="REINSTALLMODE" Value="amus"/>
 
     <?ifdef var.InstallVss?>
     <CustomAction Id="RegisterCom"
-              ExeCommand='/c "[qemu_ga_directory]qemu-ga.exe" -s vss-install'
+              ExeCommand='"[qemu_ga_directory]qga-vss.dll",DLLCOMRegister'
               Execute="deferred"
-              Property="cmd"
+              Property="rundll"
               Impersonate="no"
               Return="check"
               >
     </CustomAction>
     <CustomAction Id="UnRegisterCom"
-              ExeCommand='/c "[qemu_ga_directory]qemu-ga.exe" -s vss-uninstall'
+              ExeCommand='"[qemu_ga_directory]qga-vss.dll",DLLCOMUnregister'
               Execute="deferred"
-              Property="cmd"
+              Property="rundll"
               Impersonate="no"
               Return="check"
               >
diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index b8087e5baa..ff93b08a9e 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -357,6 +357,15 @@ out:
     return hr;
 }
 
+STDAPI_(void) CALLBACK DLLCOMRegister(HWND, HINSTANCE, LPSTR, int)
+{
+    COMRegister();
+}
+
+STDAPI_(void) CALLBACK DLLCOMUnregister(HWND, HINSTANCE, LPSTR, int)
+{
+    COMUnregister();
+}
 
 static BOOL CreateRegistryKey(LPCTSTR key, LPCTSTR value, LPCTSTR data)
 {
diff --git a/qga/vss-win32/qga-vss.def b/qga/vss-win32/qga-vss.def
index 927782c31b..ee97a81427 100644
--- a/qga/vss-win32/qga-vss.def
+++ b/qga/vss-win32/qga-vss.def
@@ -1,6 +1,8 @@
 LIBRARY      "QGA-PROVIDER.DLL"
 
 EXPORTS
+	DLLCOMRegister
+	DLLCOMUnregister
 	COMRegister		PRIVATE
 	COMUnregister		PRIVATE
 	DllCanUnloadNow		PRIVATE
-- 
2.39.2


