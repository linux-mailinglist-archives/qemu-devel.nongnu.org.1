Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CED8FA13F47
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Jan 2025 17:25:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSfn-0003iN-V5; Thu, 16 Jan 2025 11:24:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu_peterdavehello_org@proton.me>)
 id 1tYSIh-0002cX-AX
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:00:58 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hsu_peterdavehello_org@proton.me>)
 id 1tYSIc-0000bs-Ug
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1737043242; x=1737302442;
 bh=riHOL1WC9/Uzkv3oorp19GPyNkyqN7V668Q1DBk4B0s=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=HdFCDLiktS1bnY1+qacMzf1HQyTxEU69dd/Rv108od5+23Z7/4ws9lLAdOZr1v81I
 mvUuUqgwn5MhHX7Nql7VlNr+BuTuk2dgOjdEi2zVIHdJa7q/hLZ3dwQZIXgLFDgtub
 wpDQOI3PAxfkRwKwgB5g4cwM6+4AcL4ejdi12nj2c0SD/D0RuimktW4RVSkOT3q5TW
 IeVFuc1pXaVdIp6mfOCodVXdILH7U3UGd41HY4XKp/eVg4aoexoZ4fjO71mUUolwzT
 ou4r5h1conCDuYaWwXmZWjOhAPcEcO7z3l/I/K9uU7jDpG6LVaDVRrNt0/+I33bXNV
 1k1k5XXgQaA5A==
Date: Thu, 16 Jan 2025 16:00:39 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH v2] Add a simple zh_TW Traditional Chinese translation
Message-ID: <jqHNRyfNSXtm_GkuEg4PfIhc5r7bXTHczkQEsanTuQ3kCijpQp4j_5j-phKGiazGYpCYBgpNiW3Yqj1ENbWENF4f1GlzNKi9F5yM-M8VD7s=@proton.me>
Feedback-ID: 91804451:user:proton
X-Pm-Message-ID: ed5d0e76bbabb19def65f834ab9e61f66a11be3c
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=188.165.51.139;
 envelope-from=hsu_peterdavehello_org@proton.me; helo=mail-0301.mail-europe.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Jan 2025 11:24:43 -0500
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
Reply-to:  Peter Dave Hello <hsu_peterdavehello_org@proton.me>
From:  Peter Dave Hello via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From 600ed9784dd5c2b209a3f5e1a5c97fc9cf4fa24e Mon Sep 17 00:00:00 2001
From: Peter Dave Hello <hsu@peterdavehello.org>
Date: Tue, 16 Apr 2024 00:43:29 +0800
Subject: [PATCH v2] Add a simple zh_TW Traditional Chinese translation

This patch adds a basic zh_TW translation file for Taiwan Traditional
Chinese users.

Signed-off-by: Peter Dave Hello <hsu@peterdavehello.org>
---
 po/LINGUAS  |  1 +
 po/zh_TW.po | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)
 create mode 100644 po/zh_TW.po

diff --git a/po/LINGUAS b/po/LINGUAS
index 9b33a365..08163e8d 100644
--- a/po/LINGUAS
+++ b/po/LINGUAS
@@ -7,3 +7,4 @@ sv
 tr
 uk
 zh_CN
+zh_TW
diff --git a/po/zh_TW.po b/po/zh_TW.po
new file mode 100644
index 00000000..e6d2c07c
--- /dev/null
+++ b/po/zh_TW.po
@@ -0,0 +1,74 @@
+# Chinese translations for QEMU package.
+# Copyright (C) 2024 THE QEMU'S COPYRIGHT HOLDER
+# This file is distributed under the same license as the QEMU package.
+# Peter Dave Hello <hsu@peterdavehello.org>, 2024.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: QEMU 9.1\n"
+"Report-Msgid-Bugs-To: qemu-devel@nongnu.org\n"
+"POT-Creation-Date: 2024-04-16 17:52+0800\n"
+"PO-Revision-Date: 2024-04-16 17:52+0800\n"
+"Last-Translator: Peter Dave Hello <hsu@peterdavehello.org>\n"
+"Language-Team: Chinese (traditional)\n"
+"Language: zh_TW\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+
+msgid " - Press Ctrl+Alt+G to release grab"
+msgstr " - =E6=8C=89=E4=B8=8B Ctrl+Alt+G =E4=BB=A5=E9=87=8B=E6=94=BE=
=E9=8E=96=E5=AE=9A"
+
+msgid " [Paused]"
+msgstr " [=E5=B7=B2=E6=9A=AB=E5=81=9C]"
+
+msgid "_Pause"
+msgstr "=E6=9A=AB=E5=81=9C(_P)"
+
+msgid "_Reset"
+msgstr "=E9=87=8D=E8=A8=AD(_R)"
+
+msgid "Power _Down"
+msgstr "=E9=97=9C=E6=A9=9F(_D)"
+
+msgid "_Quit"
+msgstr "=E7=B5=90=E6=9D=9F(_Q)"
+
+msgid "_Fullscreen"
+msgstr "=E5=85=A8=E8=9E=A2=E5=B9=95(_F)"
+
+msgid "_Copy"
+msgstr "=E8=A4=87=E8=A3=BD(_C)"
+
+msgid "Zoom _In"
+msgstr "=E6=94=BE=E5=A4=A7(_I)"
+
+msgid "Zoom _Out"
+msgstr "=E7=B8=AE=E5=B0=8F(_O)"
+
+msgid "Best _Fit"
+msgstr "=E6=9C=80=E4=BD=B3=E5=B0=BA=E5=AF=B8(_F)"
+
+msgid "Zoom To _Fit"
+msgstr "=E8=AA=BF=E6=95=B4=E8=87=B3=E6=9C=80=E4=BD=B3=E5=A4=A7=E5=B0=8F(_F=
)"
+
+msgid "Grab On _Hover"
+msgstr "=E6=BB=91=E9=81=8E=E6=99=82=E9=8E=96=E5=AE=9A(_H)"
+
+msgid "_Grab Input"
+msgstr "=E9=8E=96=E5=AE=9A=E8=BC=B8=E5=85=A5(_G)"
+
+msgid "Show _Tabs"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=88=86=E9=A0=81(_T)"
+
+msgid "Detach Tab"
+msgstr "=E5=88=86=E9=9B=A2=E5=88=86=E9=A0=81"
+
+msgid "Show Menubar"
+msgstr "=E9=A1=AF=E7=A4=BA=E5=8A=9F=E8=83=BD=E8=A1=A8=E5=88=97(_M)"
+
+msgid "_Machine"
+msgstr "=E6=A9=9F=E5=99=A8(_M)"
+
+msgid "_View"
+msgstr "=E6=AA=A2=E8=A6=96(_V)"
--=20
2.25.1



