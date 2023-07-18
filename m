Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 599DD757818
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 11:32:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLh2o-00042c-Tg; Tue, 18 Jul 2023 05:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2m-00041m-MK
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qLh2l-0004F4-By
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 05:30:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689672654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zHSH2f6sNdUL3OXSLvMYszb1rthfkO1fWtFRariBUVA=;
 b=LecodnJgV7BL/Nsr+Xqf6v9x0wH/K4hTW77FiHfv7HcPPBNdTMmP74F+ZSg5I3WTrGjKqB
 x85y7tHvKYML4Hw4yrHdBb8H64Ons/ocLArr145TY98Xdq0ttDDMMF50+l/UxGZxC2G8IC
 8LO2HPDHAOjSOR/Ar2goTvTXsWP5Ie0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-479-1NP3Kue-NDSFO3gg-_bjBg-1; Tue, 18 Jul 2023 05:30:51 -0400
X-MC-Unique: 1NP3Kue-NDSFO3gg-_bjBg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C94202A59542;
 Tue, 18 Jul 2023 09:30:50 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D424D2166B25;
 Tue, 18 Jul 2023 09:30:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/8] tests/vm: Introduce get_qemu_packages_from_lcitool_json()
 helper
Date: Tue, 18 Jul 2023 11:30:38 +0200
Message-Id: <20230718093040.172145-7-thuth@redhat.com>
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

Add the get_qemu_packages_from_lcitool_json() helper which return
such package list from a lcitool env var file in JSON format.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230711144922.67491-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/vm/basevm.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 23229e23d1..a97e23b0ce 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -27,6 +27,7 @@
 import multiprocessing
 import traceback
 import shlex
+import json
 
 from qemu.machine import QEMUMachine
 from qemu.utils import get_info_usernet_hostfwd_port, kvm_available
@@ -501,6 +502,16 @@ def gen_cloud_init_iso(self):
                               stderr=self._stdout)
         return os.path.join(cidir, "cloud-init.iso")
 
+    def get_qemu_packages_from_lcitool_json(self, json_path=None):
+        """Parse a lcitool variables json file and return the PKGS list."""
+        if json_path is None:
+            json_path = os.path.join(
+                os.path.dirname(__file__), "generated", self.name + ".json"
+            )
+        with open(json_path, "r") as fh:
+            return json.load(fh)["pkgs"]
+
+
 def get_qemu_path(arch, build_path=None):
     """Fetch the path to the qemu binary."""
     # If QEMU environment variable set, it takes precedence
-- 
2.39.3


