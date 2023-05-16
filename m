Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2D6704B97
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 13:03:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysP8-0001Mw-FC; Tue, 16 May 2023 06:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysP6-0001J1-7Z
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pysOk-000850-8M
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684234756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2+/0aWl7kv70Kfb+NErxQICxOB1Kfvv2D0lP9wBFC8I=;
 b=SdwUTTlaJb3n55gTURALW6SXr/PUiJP94YEf+JgHzZJmuuS3OanlqOAQOOwk9ApYzf9emu
 8iRYHLU97XrN4jd19FpbMR24vg5QboWtZ/L9uxQeqThSBdf8MHiIxG9ERTLkU0/xO7yaCZ
 YqG2ASivDoaIPcd8KrIksOP1LresToo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624--xo8Lx6hNQCOjeCbVUMB3w-1; Tue, 16 May 2023 06:59:15 -0400
X-MC-Unique: -xo8Lx6hNQCOjeCbVUMB3w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AED8587DC01;
 Tue, 16 May 2023 10:59:14 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C64B3492B01;
 Tue, 16 May 2023 10:59:13 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	philmd@linaro.org,
	berrange@redhat.com
Subject: [PATCH v2 04/27] mkvenv: add better error message for broken or
 missing ensurepip
Date: Tue, 16 May 2023 12:58:45 +0200
Message-Id: <20230516105908.527838-4-pbonzini@redhat.com>
In-Reply-To: <20230516105908.527838-1-pbonzini@redhat.com>
References: <20230516105908.527838-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: John Snow <jsnow@redhat.com>

Debian debundles ensurepip for python; NetBSD debundles pyexpat but
ensurepip needs pyexpat. Try our best to offer a helpful error message
instead of just failing catastrophically.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-5-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/mkvenv.py | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a4534e41b52b..09a6f300d541 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -34,6 +34,7 @@
 # later. See the COPYING file in the top-level directory.
 
 import argparse
+from importlib.util import find_spec
 import logging
 import os
 from pathlib import Path
@@ -76,6 +77,10 @@ class QemuEnvBuilder(venv.EnvBuilder):
 
     def __init__(self, *args: Any, **kwargs: Any) -> None:
         logger.debug("QemuEnvBuilder.__init__(...)")
+
+        if kwargs["with_pip"]:
+            check_ensurepip()
+
         super().__init__(*args, **kwargs)
 
         # Make the context available post-creation:
@@ -98,6 +103,38 @@ def get_value(self, field: str) -> str:
         return ret
 
 
+def check_ensurepip() -> None:
+    """
+    Check that we have ensurepip.
+
+    Raise a fatal exception with a helpful hint if it isn't available.
+    """
+    if not find_spec("ensurepip"):
+        msg = (
+            "Python's ensurepip module is not found.\n"
+            "It's normally part of the Python standard library, "
+            "maybe your distribution packages it separately?\n"
+            "Either install ensurepip, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n"
+            "(Hint: Debian puts ensurepip in its python3-venv package.)"
+        )
+        raise Ouch(msg)
+
+    # ensurepip uses pyexpat, which can also go missing on us:
+    if not find_spec("pyexpat"):
+        msg = (
+            "Python's pyexpat module is not found.\n"
+            "It's normally part of the Python standard library, "
+            "maybe your distribution packages it separately?\n"
+            "Either install pyexpat, or alleviate the need for it in the "
+            "first place by installing pip and setuptools for "
+            f"'{sys.executable}'.\n\n"
+            "(Hint: NetBSD's pkgsrc debundles this to e.g. 'py310-expat'.)"
+        )
+        raise Ouch(msg)
+
+
 def make_venv(  # pylint: disable=too-many-arguments
     env_dir: Union[str, Path],
     system_site_packages: bool = False,
-- 
2.40.1



