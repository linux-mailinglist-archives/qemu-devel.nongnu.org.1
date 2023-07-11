Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3974F104
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJDwR-00033f-Ry; Tue, 11 Jul 2023 10:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwO-00033E-Nu
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:08 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJDwG-00083B-L7
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:02:08 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-991f956fb5aso664514066b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689084119; x=1691676119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6XJhuOMcFFfDpDirnHeiG77aGS9ai0iI4+kwtvURXQ=;
 b=TXCtY3rWF5Lb+NBKB5eUj7K/dpSFaV3GPM/BVt/7B0Nnljv6r7d88b3lyRC3FDMX6Y
 i6V4zupPVY0MSWC+QLQvk+fCwlCR9K0w1UjES0B7VPG3vfpham7HVWbPKfevP4rwl+HK
 yBp6DIDjh6qJCg6bspgAYLa0fw+J4SLautLTvGzZ6CYoSRTyEYZcHrp76jqEtkZHY46U
 qmoVO/M9OY25Kn4qpC833yV5MhCEdUXPzPDCKGOZtkAu/9SPdz3K4jFxLNsjuU3HOmHv
 TXGXuCH7hohYwuvlOxfOVOaMh00EjAYkM1R5E+QE7WC4FGQO3uN+n2OZWd6L8/VDWHtv
 48Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689084119; x=1691676119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6XJhuOMcFFfDpDirnHeiG77aGS9ai0iI4+kwtvURXQ=;
 b=JLeccSm1MX1DvHA6hJ5Yvo1G7gSAvX8dkPYOiZjQZ+Hw7ck+ttG+bFvqGKKIBkyH18
 7nqCiJAtiQbgwfaLyepnGWgvH78xobX+BzyG+l8ungeV0JnvfelQa/tXSP7T4upatWMG
 5n9XSqkYtq713JwEfeQH4gLu1Gq+hYLUoEed1TSeCb39Kr9nay4XQzPF4ku3zXhcY7CU
 HFS4hTcBljclRtYcex1ZrjtoMvCdo0LEniKteFHX4Fp+hJQKFg3hNzdW0CFRh6QqqNxm
 aQ553iRvpIyU+RPHW994KRlZYQ/LKmrfx3citl7vEZJVMG2nZyrwyVBc8UNpzi613zQa
 zBfg==
X-Gm-Message-State: ABy/qLZ83flIoIhEubUjJE+fneMSzJh7r9Qm7bpx66gnx68o3q51Beyy
 EYKovaiYY2AZsf41nPZ6tJYe4Z9yrZqB5/kSFLc=
X-Google-Smtp-Source: APBJJlFCZmblqeUUfSnvb9aMNFiUkxDHa+uWVqofJ7JUdwEZOiqoZLQT8zYg6Rf1Jdi1LxKkzWcQQA==
X-Received: by 2002:a17:906:253:b0:993:f349:c98c with SMTP id
 19-20020a170906025300b00993f349c98cmr10315655ejl.4.1689084118784; 
 Tue, 11 Jul 2023 07:01:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a1709062c1100b009930308425csm1214889ejh.31.2023.07.11.07.01.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:01:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Erik Skultety <eskultet@redhat.com>
Subject: [PATCH v2 2/3] tests/vm: Introduce
 get_qemu_packages_from_lcitool_json() helper
Date: Tue, 11 Jul 2023 16:01:42 +0200
Message-Id: <20230711140143.65818-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711140143.65818-1-philmd@linaro.org>
References: <20230711140143.65818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add the get_qemu_packages_from_lcitool_json() helper which return
such package list from a lcitool env var file in JSON format.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/vm/Makefile.include | 4 ++++
 tests/vm/basevm.py        | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
index c2a8ca1c17..b021b344b5 100644
--- a/tests/vm/Makefile.include
+++ b/tests/vm/Makefile.include
@@ -106,6 +106,10 @@ $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
 		--build-image $@, \
 		"  VM-IMAGE $*")
 
+$(SRC_PATH)/tests/vm/%.json:
+	$(call quiet-command, \
+		make lcitool-refresh)
+
 # Build in VM $(IMAGE)
 vm-build-%: $(IMAGES_DIR)/%.img $(VM_VENV)
 	$(call quiet-command, \
diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 23229e23d1..cc4cc0a973 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -27,6 +27,7 @@
 import multiprocessing
 import traceback
 import shlex
+import json
 
 from qemu.machine import QEMUMachine
 from qemu.utils import get_info_usernet_hostfwd_port, kvm_available
@@ -501,6 +502,14 @@ def gen_cloud_init_iso(self):
                               stderr=self._stdout)
         return os.path.join(cidir, "cloud-init.iso")
 
+    def get_qemu_packages_from_lcitool_json(self, json_path=None):
+        """Parse a lcitool variables json file and return the PKGS list."""
+        if json_path is None:
+            json_path = os.path.join(os.path.dirname(__file__), self.name + ".json")
+        with open(json_path, "r") as fh:
+            return json.load(fh)["pkgs"]
+
+
 def get_qemu_path(arch, build_path=None):
     """Fetch the path to the qemu binary."""
     # If QEMU environment variable set, it takes precedence
-- 
2.38.1


