Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F975781E
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2m-00041C-CO; Tue, 18 Jul 2023 05:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2k-00040J-1F
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2i-0004Dy-DB
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oJ2ry9OM+YSeiT0vw1kCfc9VhjQsurGiFSlEOnlyqKw=;
 b=FVASe3rawMHMcqA4qxuxv4ojTxmNOXcBz7KHRNGe+oXzJejOujfFMnN9A+l2+GpkOvYnhV
 9KKyJrvnjfvRw2JTYQg6iePyC/xRZmop0t9PqYLMhFZjoDTkmO15k6hSG62Gsb9YOTqv9c
 NJjJrraQt4OKb9CVsqpX/KAgPYhzV6U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-hELKaYECMu2gTCiFKc3MiQ-1; Tue, 18 Jul 2023 05:30:48 -0400
X-MC-Unique: hELKaYECMu2gTCiFKc3MiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4277989F701;
 Tue, 18 Jul 2023 09:30:48 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D45B02166B25;
 Tue, 18 Jul 2023 09:30:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Erik Skultety <eskultet@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Warner Losh <imp@bsdimp.com>
Subject: [PULL 4/8] tests/lcitool: Generate distribution packages list in JSON
 format
Date: Tue, 18 Jul 2023 11:30:36 +0200
Message-Id: <20230718093040.172145-5-thuth@redhat.com>
In-Reply-To: <20230718093040.172145-1-thuth@redhat.com>
References: <20230718093040.172145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

Add the generate_pkglist() helper to generate a list of packages
required by a distribution to build QEMU.

Since we can not add a "THIS FILE WAS AUTO-GENERATED" comment in
JSON, create the files under tests/vm/generated/ sub-directory;
add a README mentioning the files are generated.

Suggested-by: Erik Skultety <eskultet@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230711144922.67491-2-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/refresh     | 11 +++++++++++
 tests/vm/generated/README |  5 +++++
 2 files changed, 16 insertions(+)
 create mode 100644 tests/vm/generated/README

diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index b54566edcc..4584870ea1 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -84,6 +84,12 @@ def generate_cirrus(target, trailer=None):
     generate(filename, cmd, trailer)
 
 
+def generate_pkglist(vm, target):
+    filename = Path(src_dir, "tests", "vm", "generated", vm + ".json")
+    cmd = lcitool_cmd + ["variables", "--format", "json", target, "qemu"]
+    generate(filename, cmd, None)
+
+
 # Netmap still needs to be manually built as it is yet to be packaged
 # into a distro. We also add cscope and gtags which are used in the CI
 # test
@@ -191,6 +197,11 @@ try:
     generate_cirrus("freebsd-13")
     generate_cirrus("macos-12")
 
+    #
+    # VM packages lists
+    #
+    generate_pkglist("freebsd", "freebsd-13")
+
     sys.exit(0)
 except Exception as ex:
     print(str(ex), file=sys.stderr)
diff --git a/tests/vm/generated/README b/tests/vm/generated/README
new file mode 100644
index 0000000000..7ccc6ffd3d
--- /dev/null
+++ b/tests/vm/generated/README
@@ -0,0 +1,5 @@
+# FILES IN THIS FOLDER WERE AUTO-GENERATED
+#
+#  $ make lcitool-refresh
+#
+# https://gitlab.com/libvirt/libvirt-ci
-- 
2.39.3


