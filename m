Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1112706FEB
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:49:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEm-0000xs-Hf; Wed, 17 May 2023 13:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLED-0008I1-Js
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEC-0004IV-3K
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4rCHC/nblK5C3SukFSnNAPlnH8JVV43s/yQSX1o5NM=;
 b=SCnMHYZ2FGsB+WPXstluTFnrfUtPnryUbrcr+sZ4bL0jml0HuBHFqd5cJO+1Vz8S6t0SiT
 yB4NozxQ9nEWPvcFWVyBxI/XstHi8oYoxC5H/PJ/ExMiEygHZc43wOA0OKyo8B9rkO8mxn
 zOQez+3Mrh5TZ2OhUUk/Gg3DID3vJic=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-H7TLKsZpMamCXy7VPPTcrw-1; Wed, 17 May 2023 13:46:18 -0400
X-MC-Unique: H7TLKsZpMamCXy7VPPTcrw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f42867b47dso6596095e9.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345576; x=1686937576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s4rCHC/nblK5C3SukFSnNAPlnH8JVV43s/yQSX1o5NM=;
 b=VrIHn6KtmwvDG1wQRhNRTPcTpmqi5AbpaxcFRTmGLEIZawNbYiGhiCGSgC2ADdD77C
 GnhCTBW9wCu3Bs5QSwlX0dSTC4R/fjPMkSOuWSVBlAvp0HkN2AzjGT+QERw/oex4f+hd
 qXuZrm4Fc6TGsXxCKRqUKZJwek20VArW6acpOU31XhoFCXcvaYKT5gLEgs/AfsFlFzoH
 h2e50JhnlWpnNuSg28kH0H/nBf5rIGVTj9cXKVCaC3jE7+d7KNNT3UQvqh9p4CcYWztt
 Ch5hQLt55FR8VNeu857Me70C0m50/Df0z/rIBf3Z4xsAAj3JIzAUucuc3z5XrvyZCv83
 9KWQ==
X-Gm-Message-State: AC+VfDxlbHqaPm4/y+XZ1X5KLgj7jZE/woDg2IUWoUzhA7BqdhQfCKVf
 jL/OeeKmr4IFbL2mK1QTE8qevFzybILVhKVjHOBbPheQW1s3CpEubhuf3U8hMr49XH4QUUUxrKk
 F8FBDtDq5gu3vVMvmS0gJuNxlsC/HYI07HMYEDkVs2MLkCPwCmidYiEaEo0uL48ZdQJznLV1Cpo
 E=
X-Received: by 2002:a05:600c:20f:b0:3f4:2267:10c0 with SMTP id
 15-20020a05600c020f00b003f4226710c0mr25905713wmi.28.1684345576508; 
 Wed, 17 May 2023 10:46:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ADDSZo0VOxhXhWuPDe5aNHzYXmi3IOHrHVyT2XwOTfB5JrZuwHYUmGuBRjxHdwzONUjrVSg==
X-Received: by 2002:a05:600c:20f:b0:3f4:2267:10c0 with SMTP id
 15-20020a05600c020f00b003f4226710c0mr25905694wmi.28.1684345576079; 
 Wed, 17 May 2023 10:46:16 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a7bc4c6000000b003f195d2f1a9sm2902425wmk.15.2023.05.17.10.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 32/68] python: add vendor.py utility
Date: Wed, 17 May 2023 19:44:44 +0200
Message-Id: <20230517174520.887405-33-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

From: John Snow <jsnow@redhat.com>

This is a teeny-tiny script that just downloads any packages we want to
vendor from PyPI and stores them in qemu.git/python/wheels/. If I'm hit
by a meteor, it'll be easy to replicate what I have done in order to
udpate the vendored source.

We don't really care which python runs it; it exists as a meta-utility
with no external dependencies and we won't package or install it. It
will be monitored by the linters/type checkers, though; so it's
guaranteed safe on python 3.6+.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-15-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/scripts/vendor.py | 74 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)
 create mode 100755 python/scripts/vendor.py

diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
new file mode 100755
index 000000000000..23708430ea68
--- /dev/null
+++ b/python/scripts/vendor.py
@@ -0,0 +1,74 @@
+#!/usr/bin/env python3
+"""
+vendor - QEMU python vendoring utility
+
+usage: vendor [-h]
+
+QEMU python vendoring utility
+
+options:
+  -h, --help  show this help message and exit
+"""
+
+# Copyright (C) 2023 Red Hat, Inc.
+#
+# Authors:
+#  John Snow <jsnow@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import argparse
+import os
+from pathlib import Path
+import subprocess
+import sys
+import tempfile
+
+
+def main() -> int:
+    """Run the vendoring utility. See module-level docstring."""
+    loud = False
+    if os.environ.get("DEBUG") or os.environ.get("V"):
+        loud = True
+
+    # No options or anything for now, but I guess
+    # you'll figure that out when you run --help.
+    parser = argparse.ArgumentParser(
+        prog="vendor",
+        description="QEMU python vendoring utility",
+    )
+    parser.parse_args()
+
+    packages = {
+        "meson==0.61.5":
+        "58c2ddb5f885da0e929f15d89f38d8a7d97f981f56815bcba008414f8511f59a",
+    }
+
+    vendor_dir = Path(__file__, "..", "..", "wheels").resolve()
+
+    with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8") as file:
+        for dep_spec, checksum in packages.items():
+            file.write(f"{dep_spec} --hash=sha256:{checksum}")
+        file.flush()
+
+        cli_args = [
+            "pip",
+            "download",
+            "--dest",
+            str(vendor_dir),
+            "--require-hashes",
+            "-r",
+            file.name,
+        ]
+        if loud:
+            cli_args.append("-v")
+
+        print(" ".join(cli_args))
+        subprocess.run(cli_args, check=True)
+
+    return 0
+
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
2.40.1


