Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E25A73782C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 02:23:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBlbY-000425-U8; Tue, 20 Jun 2023 20:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbW-00040Q-Et
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qBlbS-0000AO-DE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 20:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687306901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PlwB+WM1b7QfqPY4EB+HTeRP+apwkJM6BwxEO67ro5k=;
 b=FkioT9ll0CXwHSpOh5EgrG4VH4BBQRWw8GZSMWcrxbbEXSiYm25GFsugK++gHIqvO2h0vz
 ONvP/7HdWwvIdLwS1Wile8Fpn2xFOANwtZwFtTTaD+VNDQv9z61zoYNLpi6c85Ho5q/ONh
 DGdGhVQ0+U2UfjPMYvn9fs2h0ixx1a4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-vK6XCe1hNO6uY2GqojsTdw-1; Tue, 20 Jun 2023 20:21:37 -0400
X-MC-Unique: vK6XCe1hNO6uY2GqojsTdw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3250A381079C;
 Wed, 21 Jun 2023 00:21:37 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.32.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D01AA112132C;
 Wed, 21 Jun 2023 00:21:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH RFC 5/6] iotests: use pyvenv/bin/python3 to launch child test
 processes
Date: Tue, 20 Jun 2023 20:21:20 -0400
Message-Id: <20230621002121.1609612-6-jsnow@redhat.com>
In-Reply-To: <20230621002121.1609612-1-jsnow@redhat.com>
References: <20230621002121.1609612-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Now that there's a fancy venv set up for us by configure, we should take
care to use it even when check is invoked directly.

./check will now use the pyvenv environment when launching python tests,
which allows those tests to find and access the 'qemu.*' packages
without PYTHONPATH modifications.

RFC: This patch now means that ./check may launch test subprocesses
using a different Python than the one used to launch it. If that isn't
acceptable, we might need a launcher shim whose job it is to sit above
"check" and just chooses the correct Python.

...Or maybe it's fine the way it is.

Comments welcome, sorry for my indecision.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index e67ebd254b..1b095d70f2 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -138,7 +138,20 @@ def init_binaries(self) -> None:
              PYTHON (for bash tests)
              QEMU_PROG, QEMU_IMG_PROG, QEMU_IO_PROG, QEMU_NBD_PROG, QSD_PROG
         """
-        self.python = sys.executable
+        # The python we want to use to launch tests.
+        self.python: str = str(
+            Path(self.build_root).joinpath('pyvenv', 'bin', 'python3')
+        )
+        # RFC: Do I need to amend '.exe' for windows, or nah?
+
+        if self.python != sys.executable:
+            print(
+                "Note: "
+                f"check was launched with a Python ({sys.executable}) "
+                f"that doesn't match QEMU's configured Python ({self.python})."
+                " QEMU's Python will be used for individual test processes.",
+                file=sys.stderr
+            )
 
         def root(*names: str) -> str:
             return os.path.join(self.build_root, *names)
-- 
2.40.1


