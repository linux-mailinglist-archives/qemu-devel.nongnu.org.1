Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3316F931D0D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 00:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTws-0005sV-Ch; Mon, 15 Jul 2024 18:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwX-00052e-Tg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:14 -0400
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwW-0006Jy-Aj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:13 -0400
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6b5dfa44f24so26610686d6.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721081591; x=1721686391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n/pLSkEkVMQ2EG9E68S2CQhpC5K2Hr/bhI+bVnZfMKI=;
 b=JjhbKBOjMfjhYCuIeZ/z0jtMtKAGhhhpIUauA22g3NqENkY9TzT0sjHn2sCe6dBC5z
 dpOuwpEtqjQ7RM21H69GggX2ZIVN5oezYCAWI2F8IZu9Nsdt2NJyiI/3I2HF/DNl8HFr
 LRmRSIqpyI92Noh/SoTcx+78SGsUn0GpJenwqBgnu0O7TEweA+7GEekSGdpJAkFFjAA9
 mIa77CEYR3Hj1XhGfrvywvqXjj4Pe39ggWXi9F7xu7lIzseQytEeQCIZoN94277UpqmY
 8gO5x6LS66cKFEOHM4k92D/VeuIX3q9RkoQRzBNC4M4+tHThBnm1vVEqTS3EEiq8T3kn
 x+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721081591; x=1721686391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n/pLSkEkVMQ2EG9E68S2CQhpC5K2Hr/bhI+bVnZfMKI=;
 b=X0nQxvZEuGNT/ckG+M+5KBuzStjC5bniOw9b67faHpXwaOpMJJ1sKSMZ1WTTWYJquH
 02F9zMDl1K3HzhLtkvSGjMiaXb0GWfl61pnYSSxdW7NkvwyzKGTAhLLZoY+2ck3Kt0LR
 d24VkUAS+oNIc+fdee/6P7gqoPa2Ox8E55u9uQActVxTualOTmw2VcZdkT5to3ynlPht
 /8s27UyGhrR0QytFkqrxePNtVoY7hDB4b57vvGhfQH18eFt75TyA6203QRA+4B//zCAX
 vvtgEVTpd1U4FO4A17fxK3p/95uhlcd+cYLwd/ihtzslNSZbO1UMS115Zp6uGy2LTR/Y
 gItQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDCA9ieWgVv+tN/IVkbGo8hf5BK90LwA04PsNI+gQa4YkyLxnyDy/AZ328LZuDHGkMEy0jhiuNDKB/pSsuqTbvh18vjq4=
X-Gm-Message-State: AOJu0YyeCVtXflLHCA0bBoXzYW7VD1frZnlN1NNpHkeCASiR+Na4nNKy
 zS38+L12bbugg1VnA0JOQvOrCUobebeyDWAxcaaqm9OrEcRGNSQ9ipI4ga3Cv0E=
X-Google-Smtp-Source: AGHT+IEcAQJV4HFi+QnPk5O8ti203cBdLdrgyoq50Cf7vB2f0qQpx0859LP8Qhk4r5W6mQtlcl+E8w==
X-Received: by 2002:ad4:5cab:0:b0:6b5:6c27:642e with SMTP id
 6a1803df08f44-6b77f4dbcfbmr7858916d6.14.1721081591273; 
 Mon, 15 Jul 2024 15:13:11 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b76198aca3sm25398326d6.51.2024.07.15.15.13.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jul 2024 15:13:11 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH v6 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Date: Mon, 15 Jul 2024 15:12:45 -0700
Message-Id: <20240715221245.12435-6-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715221245.12435-1-yichen.wang@bytedance.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2d;
 envelope-from=yichen.wang@bytedance.com; helo=mail-qv1-xf2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Bryan Zhang <bryan.zhang@bytedance.com>

Adds an integration test for 'qatzip'.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b888..98f60d58a7 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -32,6 +32,10 @@
 # endif /* CONFIG_TASN1 */
 #endif /* CONFIG_GNUTLS */
 
+#ifdef CONFIG_QATZIP
+#include <qatzip.h>
+#endif /* CONFIG_QATZIP */
+
 /* For dirty ring test; so far only x86_64 is supported */
 #if defined(__linux__) && defined(HOST_X86_64)
 #include "linux/kvm.h"
@@ -2992,6 +2996,18 @@ test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
 }
 #endif /* CONFIG_ZSTD */
 
+#ifdef CONFIG_QATZIP
+static void *
+test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
+                                              QTestState *to)
+{
+    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
+    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
+
+    return test_migrate_precopy_tcp_multifd_start_common(from, to, "qatzip");
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void *
 test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
@@ -3089,6 +3105,17 @@ static void test_multifd_tcp_zstd(void)
 }
 #endif
 
+#ifdef CONFIG_QATZIP
+static void test_multifd_tcp_qatzip(void)
+{
+    MigrateCommon args = {
+        .listen_uri = "defer",
+        .start_hook = test_migrate_precopy_tcp_multifd_qatzip_start,
+    };
+    test_precopy_common(&args);
+}
+#endif
+
 #ifdef CONFIG_QPL
 static void test_multifd_tcp_qpl(void)
 {
@@ -3992,6 +4019,10 @@ int main(int argc, char **argv)
     migration_test_add("/migration/multifd/tcp/plain/zstd",
                        test_multifd_tcp_zstd);
 #endif
+#ifdef CONFIG_QATZIP
+    migration_test_add("/migration/multifd/tcp/plain/qatzip",
+                test_multifd_tcp_qatzip);
+#endif
 #ifdef CONFIG_QPL
     migration_test_add("/migration/multifd/tcp/plain/qpl",
                        test_multifd_tcp_qpl);
-- 
Yichen Wang


