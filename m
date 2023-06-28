Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CD741650
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 18:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEXzq-0002uh-It; Wed, 28 Jun 2023 12:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEXzn-0002u8-6K
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:19 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anton.kochkov@proton.me>)
 id 1qEXzk-0005Ke-HX
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 12:26:18 -0400
Date: Wed, 28 Jun 2023 16:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1687969573; x=1688228773;
 bh=qe5CWlh53+pTfFMU9cEeYsbWXbyj2Km1XOBR/UFeY/4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=fCDbGdrlbmX2sfH6BNiOSuMcuYh/mnFIBV2O69dq1gmeoc1UYX2VNvY0i7gMZ2SRu
 FC+BAPYSp4OCsT0IlOGjolqUY5P31tjazvk7H0wRQCrWTaPC3natxUZPNtOUTqlHfm
 tBOQ7Lf0r/UEpxGlI5HR6IIM3a4Q6H4wzhUrKnfDqXbFaBGSRQ8gUKJXRrjlqULamX
 Y3mAwL6ktUt/nLPz6wlUNasiuZFq5HCkRKJyuVuf9aEr5lhaCWoZe2rjfBn2JYzr1L
 R6KSZ2PVyLNpYO5qtAoYUYCHMB3Po7PYxqHLuCr6rS5FI74y9mqvUDZsI01D4dvPEb
 xbau92Rj+lZrw==
To: qemu-devel@nongnu.org
From: Anton Kochkov <anton.kochkov@proton.me>
Cc: Anton Kochkov <anton.kochkov@proton.me>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 1/2] contrib/plugins: add meson build file
Message-ID: <20230628162451.147419-2-anton.kochkov@proton.me>
In-Reply-To: <20230628162451.147419-1-anton.kochkov@proton.me>
References: <20230628162451.147419-1-anton.kochkov@proton.me>
Feedback-ID: 53490844:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.131;
 envelope-from=anton.kochkov@proton.me; helo=mail-40131.protonmail.ch
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
2.41.0



