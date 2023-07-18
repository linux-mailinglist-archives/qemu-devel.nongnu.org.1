Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A9A757812
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:31:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2q-00044l-0b; Tue, 18 Jul 2023 05:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2l-000412-8R
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2j-0004EX-S9
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9hlZtbmHrNPWro4lit4wkX521HorupWbjPTdtpUrEk=;
 b=EWtujGCOIzrtHdggkhjsifVigfFl25AivStNf1b2y0PP2bFtIvPuHH5mdwnKeGLIBS956j
 wHsZvbgHkyQTbJy5c6wLnEwl5un5FqxlnHExMX7eUp2ciHj6yLxbmh2GMiDZP3WR9hfG9f
 b8Bdd22ZSHBgU61CotwDAFPw1VVKUO0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-Xf4-ufvGP3-UVSSZfMg6Fw-1; Tue, 18 Jul 2023 05:30:49 -0400
X-MC-Unique: Xf4-ufvGP3-UVSSZfMg6Fw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88E383C13927;
 Tue, 18 Jul 2023 09:30:49 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 922112166B25;
 Tue, 18 Jul 2023 09:30:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/8] tests/lcitool: Refresh generated files
Date: Tue, 18 Jul 2023 11:30:37 +0200
Message-Id: <20230718093040.172145-6-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Refresh the generated files by running:

  $ make lcitool-refresh

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230711144922.67491-3-philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
[thuth: Drop changes to libpmem-dev and libxen-dev]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/generated/freebsd.json | 77 +++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 tests/vm/generated/freebsd.json

diff --git a/tests/vm/generated/freebsd.json b/tests/vm/generated/freebsd.json
new file mode 100644
index 0000000000..7c435cf23e
--- /dev/null
+++ b/tests/vm/generated/freebsd.json
@@ -0,0 +1,77 @@
+{
+  "ccache": "/usr/local/bin/ccache",
+  "cpan_pkgs": [],
+  "cross_pkgs": [],
+  "make": "/usr/local/bin/gmake",
+  "ninja": "/usr/local/bin/ninja",
+  "packaging_command": "pkg",
+  "pip3": "/usr/local/bin/pip-3.8",
+  "pkgs": [
+    "alsa-lib",
+    "bash",
+    "bison",
+    "bzip2",
+    "ca_root_nss",
+    "capstone4",
+    "ccache",
+    "cmocka",
+    "ctags",
+    "curl",
+    "cyrus-sasl",
+    "dbus",
+    "diffutils",
+    "dtc",
+    "flex",
+    "fusefs-libs3",
+    "gettext",
+    "git",
+    "glib",
+    "gmake",
+    "gnutls",
+    "gsed",
+    "gtk3",
+    "json-c",
+    "libepoxy",
+    "libffi",
+    "libgcrypt",
+    "libjpeg-turbo",
+    "libnfs",
+    "libslirp",
+    "libspice-server",
+    "libssh",
+    "libtasn1",
+    "llvm",
+    "lzo2",
+    "meson",
+    "mtools",
+    "ncurses",
+    "nettle",
+    "ninja",
+    "opencv",
+    "pixman",
+    "pkgconf",
+    "png",
+    "py39-numpy",
+    "py39-pillow",
+    "py39-pip",
+    "py39-sphinx",
+    "py39-sphinx_rtd_theme",
+    "py39-yaml",
+    "python3",
+    "rpm2cpio",
+    "sdl2",
+    "sdl2_image",
+    "snappy",
+    "sndio",
+    "socat",
+    "spice-protocol",
+    "tesseract",
+    "usbredir",
+    "virglrenderer",
+    "vte3",
+    "xorriso",
+    "zstd"
+  ],
+  "pypi_pkgs": [],
+  "python": "/usr/local/bin/python3"
+}
-- 
2.39.3


