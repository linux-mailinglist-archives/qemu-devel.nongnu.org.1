Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFE74F2AD
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 16:50:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJEga-0001H6-Ii; Tue, 11 Jul 2023 10:49:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgY-0001Gc-Co
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:50 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJEgT-0002oB-D0
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 10:49:50 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-98e39784a85so1388299666b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689086983; x=1691678983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQpa/hfpAq5E6avQ+sBqrAEF6fPdfI9vuVD97imT8vE=;
 b=elItkfJU2ESHqMFI5dBdmImo6shfsO3P2JzUdo1pO4tFYCYLuNJ7G9WMB3n1HpAVp4
 wi4nawp07DPujTSJ/qZlGTRDdLW/M3Fc6izltzFeZbph9GjtV9r7xTj9m4PHv4CWR3oi
 KRtOeMie0yaYiuL4hqsYrOoxlSYsNFEJ86TPygAD5B19etrwQG/U/mhEK5JCoHkzkgJh
 RyTXsUyBo5xRwW/6+oKvzrQYIm8o7mqYTWRTlawE6azAczBDH7EgwI+8/f/DNH9uydfu
 QYUdHmV5c5GQi2zpd2OcZN7KodR1ouWDEoVtX2CgAN+ZLK1HTYtpCQjF4lGhZm2SVfBI
 gbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689086983; x=1691678983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQpa/hfpAq5E6avQ+sBqrAEF6fPdfI9vuVD97imT8vE=;
 b=UnEEEMkLTnHPk1DL6P+FHJwHU7I+/nHdCm3SQPMWdewtrfBKUIIpRSDscEv33XuGVK
 Lrnd6Krs4l8HlK3K+qV6pAL2wslSFb8WSEpgHMcGOnKbrc/mtUxxeXixWByjR8NQB6M6
 zI1IuMx3TUSii3h2oUynT3gItOgTEd5h9mztOw+tJLgT5db3kmrfgwjuEcaaHQrnWs3W
 uBJf6W+URNfpA+mbB+HAvKfJx4RtaH3JyYvTgVpAGgbFOkiHif7R8sVd1Q++631w8/Fz
 onlCHmL1ci5pq9nf8aMHkmmT3uX3d6XeY4EvSAM8it/JOq4wQ957tamljnNVmwQQxfEd
 U/yg==
X-Gm-Message-State: ABy/qLaqloQNvxlqhnx6A8iLRftPaiFhnxXGh7zvQHrQGjMV7v0TknSC
 Oa9DI/tbjhtDg9abcHw597Oxx0lLauNkPBTe31Y=
X-Google-Smtp-Source: APBJJlFi/9Cm5viQQdK+fZxEC1CYuVnq/SIh4JJ3HRpbM1PgV0MVv1Pb6Fufb6Ci5rvR6qZb7BmKyQ==
X-Received: by 2002:a17:906:648d:b0:993:e695:b585 with SMTP id
 e13-20020a170906648d00b00993e695b585mr15875875ejm.9.1689086983713; 
 Tue, 11 Jul 2023 07:49:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a170906284700b0098e48ad11f2sm1268031ejc.93.2023.07.11.07.49.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 07:49:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Erik Skultety <eskultet@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PATCH v3 3/4] tests/vm: Introduce
 get_qemu_packages_from_lcitool_json() helper
Date: Tue, 11 Jul 2023 16:49:21 +0200
Message-Id: <20230711144922.67491-4-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230711144922.67491-1-philmd@linaro.org>
References: <20230711144922.67491-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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
2.38.1


