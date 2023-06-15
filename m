Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D606731B1C
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 16:16:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9nkQ-0000tl-JU; Thu, 15 Jun 2023 10:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1q9nkF-0000tB-6L
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 10:14:39 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1q9nkB-0006HW-Tf
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 10:14:38 -0400
Date: Thu, 15 Jun 2023 14:14:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1686838466; x=1687097666;
 bh=OnH08nwM5RhEArqTt9jtnTass0gLngC5Spfe+xJrNfc=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=B7izKVhxBt/Mks9biKeqx/5GonGlfZ8P8e9rMGZ/zJK0HgbC5ID/p+odVhXblSenl
 UIG2pRI+t9B5rbcjh7Z/NLB+iDslfXiXQSPdymWcYQT0eevlhMsvxzLdfrR5wbHUEG
 8TMPKtcDEzGHIiT0EBipxYP38qHGlp2F4V9lFAvE+TdKfttfM13EEaZ+7NblNqNW5E
 xfjEYhqqwa9/NUn+ro6t2JvCLsZJY67Qe0gfKKjolfLnpAdHySBaIt1ifMdQSpSHlu
 frrdtHx9HL7EUih7zW3CVa6v7K08tc55DxzwK5NtzoNN+xROBDZghFrAJAtIhMH1W2
 n8V97DO4ji15A==
To: qemu-devel@nongnu.org
From: Anton Kochkov <anton.kochkov@proton.me>
Cc: Anton Kochkov <anton.kochkov@proton.me>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH] contrib/plugins: add meson build file
Message-ID: <20230615141315.961315-1-anton.kochkov@proton.me>
Feedback-ID: 53490844:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.22;
 envelope-from=anton.kochkov@proton.me; helo=mail-4322.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add crossplatform Meson file to build TCG plugins since
the Makefile makes wrong assumptions about it being used only
on Linux. Tested on Linux and macOS.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1710
Signed-off-by: Anton Kochkov <anton.kochkov@proton.me>
---
 contrib/plugins/meson.build       | 31 +++++++++++++++++++++++++++++++
 contrib/plugins/meson_options.txt |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 contrib/plugins/meson.build
 create mode 100644 contrib/plugins/meson_options.txt

diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
new file mode 100644
index 0000000000..72c4167461
--- /dev/null
+++ b/contrib/plugins/meson.build
@@ -0,0 +1,31 @@
+project('qemu-plugins', 'c', meson_version: '>=3D0.50.0')
+
+qemu_src =3D get_option('qemu_path')
+if qemu_src =3D=3D ''
+  qemu_src =3D '../..'
+endif
+
+qemu_include =3D qemu_src + '/include/qemu'
+incdir =3D include_directories(qemu_include)
+
+plugins =3D [
+  'execlog',
+  'hotblocks',
+  'hotpages',
+  'howvec',
+  'lockstep',
+  'hwprofile',
+  'cache',
+  'drcov',
+]
+
+th =3D dependency('threads', required: true)
+glib =3D dependency('glib-2.0', required: true)
+
+foreach p: plugins
+  library(p, p + '.c',
+    include_directories: incdir,
+    dependencies: [th, glib],
+    override_options: ['b_lundef=3Dfalse']
+  )
+endforeach
diff --git a/contrib/plugins/meson_options.txt b/contrib/plugins/meson_opti=
ons.txt
new file mode 100644
index 0000000000..2d76cda496
--- /dev/null
+++ b/contrib/plugins/meson_options.txt
@@ -0,0 +1 @@
+option('qemu_path', type : 'string', value : '', description : 'Full path =
to the QEMU sources to build plugins for')
--
2.40.1



