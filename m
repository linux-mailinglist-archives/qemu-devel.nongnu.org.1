Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF89E959686
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Aug 2024 10:30:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggiB-0000I2-H0; Wed, 21 Aug 2024 04:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggi6-00006K-Sy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggi3-0004N6-TR
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jOge0tLIU5iHH9K47aSDb2ja1ND++2y6Sfu7ni5xkTQ=;
 b=I/Mtb5/ereBX8pblmJIWAnWufvuBfg+cel3Dq2S4e/tA+MjUIbRw4+ytgcGQrq7t3QCjyr
 728EPa9vNhJklWHy4lkMhkXy0Gze/dn9OELC774cPyZIKBT8AfiNB6w8SnHCISZZIes7c6
 rPKiDAfAMfvSTnQKsJo97jiqzNXPGbs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-EdQSB0CBOVSb1QCCk4ro_Q-1; Wed,
 21 Aug 2024 04:28:47 -0400
X-MC-Unique: EdQSB0CBOVSb1QCCk4ro_Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C80E11955BFE; Wed, 21 Aug 2024 08:28:45 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3B6731955F1B; Wed, 21 Aug 2024 08:28:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 14/35] tests/functional: add a module for handling asset
 download & caching
Date: Wed, 21 Aug 2024 10:27:15 +0200
Message-ID: <20240821082748.65853-15-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

The 'Asset' class is a simple module that declares a downloadable
asset that can be cached locally. Downloads are stored in the user's
home dir at ~/.cache/qemu/download, using a sha256 sum of the URL.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[thuth: Drop sha1 support, use hash on file content for naming instead of URL,
        add the possibility to specify the cache dir via environment variable]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/__init__.py |  1 +
 tests/functional/qemu_test/asset.py    | 97 ++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)
 create mode 100644 tests/functional/qemu_test/asset.py

diff --git a/tests/functional/qemu_test/__init__.py b/tests/functional/qemu_test/__init__.py
index 2f1e0bc70d..db05c8f412 100644
--- a/tests/functional/qemu_test/__init__.py
+++ b/tests/functional/qemu_test/__init__.py
@@ -6,6 +6,7 @@
 # later.  See the COPYING file in the top-level directory.
 
 
+from .asset import Asset
 from .config import BUILD_DIR
 from .cmd import has_cmd, has_cmds, run_cmd, is_readable_executable_file, \
     interrupt_interactive_console_until_pattern, wait_for_console_pattern, \
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
new file mode 100644
index 0000000000..cbeb6278af
--- /dev/null
+++ b/tests/functional/qemu_test/asset.py
@@ -0,0 +1,97 @@
+# Test utilities for fetching & caching assets
+#
+# Copyright 2024 Red Hat, Inc.
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import hashlib
+import logging
+import os
+import subprocess
+import urllib.request
+from pathlib import Path
+from shutil import copyfileobj
+
+
+# Instances of this class must be declared as class level variables
+# starting with a name "ASSET_". This enables the pre-caching logic
+# to easily find all referenced assets and download them prior to
+# execution of the tests.
+class Asset:
+
+    def __init__(self, url, hashsum):
+        self.url = url
+        self.hash = hashsum
+        cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
+        if cache_dir_env:
+            self.cache_dir = Path(cache_dir_env, "download")
+        else:
+            self.cache_dir = Path(Path("~").expanduser(),
+                                  ".cache", "qemu", "download")
+        self.cache_file = Path(self.cache_dir, hashsum)
+        self.log = logging.getLogger('qemu-test')
+
+    def __repr__(self):
+        return "Asset: url=%s hash=%s cache=%s" % (
+            self.url, self.hash, self.cache_file)
+
+    def _check(self, cache_file):
+        if self.hash is None:
+            return True
+        if len(self.hash) == 64:
+            sum_prog = 'sha256sum'
+        elif len(self.hash) == 128:
+            sum_prog = 'sha512sum'
+        else:
+            raise Exception("unknown hash type")
+
+        checksum = subprocess.check_output(
+            [sum_prog, str(cache_file)]).split()[0]
+        return self.hash == checksum.decode("utf-8")
+
+    def valid(self):
+        return self.cache_file.exists() and self._check(self.cache_file)
+
+    def fetch(self):
+        if not self.cache_dir.exists():
+            self.cache_dir.mkdir(parents=True, exist_ok=True)
+
+        if self.valid():
+            self.log.debug("Using cached asset %s for %s",
+                           self.cache_file, self.url)
+            return str(self.cache_file)
+
+        self.log.info("Downloading %s to %s...", self.url, self.cache_file)
+        tmp_cache_file = self.cache_file.with_suffix(".download")
+
+        try:
+            resp = urllib.request.urlopen(self.url)
+        except Exception as e:
+            self.log.error("Unable to download %s: %s", self.url, e)
+            raise
+
+        try:
+            with tmp_cache_file.open("wb+") as dst:
+                copyfileobj(resp, dst)
+        except:
+            tmp_cache_file.unlink()
+            raise
+        try:
+            # Set these just for informational purposes
+            os.setxattr(str(tmp_cache_file), "user.qemu-asset-url",
+                        self.url.encode('utf8'))
+            os.setxattr(str(tmp_cache_file), "user.qemu-asset-hash",
+                        self.hash.encode('utf8'))
+        except Exception as e:
+            self.log.info("Unable to set xattr on %s: %s", tmp_cache_file, e)
+            pass
+
+        if not self._check(tmp_cache_file):
+            tmp_cache_file.unlink()
+            raise Exception("Hash of %s does not match %s" %
+                            (self.url, self.hash))
+        tmp_cache_file.replace(self.cache_file)
+
+        self.log.info("Cached %s at %s" % (self.url, self.cache_file))
+        return str(self.cache_file)
-- 
2.46.0


