Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5D37925D4
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYqD-00058V-HV; Tue, 05 Sep 2023 12:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYqB-000588-5M
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYq8-00065z-WA
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693931024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6lR+hCOuaFaVDCurD30WyUh0YxgEa01KD4gK5yHl/+c=;
 b=KOtfbBBWfaQf8V2cUMerCIPWZKl9Z8Bbpno5Ux/aEVZPdM5IGTK7qSHhabHnycL8Z2dPY7
 mO06T8mDGroZZJ1HDhq2qOjXeXbgAd9M5RzER0jFCP32kbcRxhYI9I1T0inY4TuL8QrCZb
 NG+N7imVndKktgO1PqHfW50dpbDSkak=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-xiyYTeBtMWCAl9Rh5FMJ2A-1; Tue, 05 Sep 2023 12:23:40 -0400
X-MC-Unique: xiyYTeBtMWCAl9Rh5FMJ2A-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-44eb5726e2eso79344137.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693931019; x=1694535819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lR+hCOuaFaVDCurD30WyUh0YxgEa01KD4gK5yHl/+c=;
 b=GJRfnHA/LSik2xn+SqsrHt1qvMJtXsFuXwoWJfe/KhLdNPS2/7sUhR37HAwLvA//qy
 wr3BaVhadYFkQ//BHkFFJ97G4bgA2VnbZY2P7WtHrKLglxpby53COOg237+hKF8ChrAT
 ImSWCX77bvr1+CH42q7NDJTbJR2N9HKyD7E8PRzTh7tBZfVL3pRUKx/jlaMde2ji62gl
 n/1f3JfzxVG6RCUTXs1aWFBEWgxwpOdb21qXoWrLgMap0Xx8uv3zFrivI9qgmzVAsZQ+
 QMIaT4367wutogdeLObkgn+7OCjMoGpiVMONtQBlAW9Iv/aR9O7KbThKWWwQcaoFxxek
 8uFw==
X-Gm-Message-State: AOJu0YxT5LXwINOP1PXDf8pTu3zQsLowpxDSuzB4/I57cT7YnYGY0a+u
 YApHIDTGzjx8SbcO9Kt9kwsx2MaKfMrpkZEA+fOc0eFVstExfVShtYo+B2VsKz7jrFse3Rx40px
 lmBchfaedEPuLZtwkxu4URR8SFYhXHQLPiPkrXe8pH/LFTiCnvSaTvMno2RorK3MvMlZ7SaRF
X-Received: by 2002:a67:fb4c:0:b0:44d:37a4:8991 with SMTP id
 e12-20020a67fb4c000000b0044d37a48991mr9005818vsr.1.1693931019425; 
 Tue, 05 Sep 2023 09:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElqV7PxhkcnWo1QrDgH5omkO/qAeEuOgI7c3+ZI8Mx+NpZx4qyhgaxwHvSGNiJLMd0AdpkhQ==
X-Received: by 2002:a67:fb4c:0:b0:44d:37a4:8991 with SMTP id
 e12-20020a67fb4c000000b0044d37a48991mr9005793vsr.1.1693931019016; 
 Tue, 05 Sep 2023 09:23:39 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b0063d281e22f1sm4581675qvl.17.2023.09.05.09.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:23:38 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 2/4] tests/migration-test: Add a test for null parameter
 setups
Date: Tue,  5 Sep 2023 12:23:33 -0400
Message-ID: <20230905162335.235619-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905162335.235619-1-peterx@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a test for StrOrNull parameters (tls-*).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..ff86838ec3 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1471,6 +1471,27 @@ static void test_postcopy_preempt_all(void)
 
 #endif
 
+/*
+ * We have a few parameters that allows null as input, test them to make
+ * sure they won't crash (where some used to).
+ */
+static void test_null_parameters(void)
+{
+    static const char *allow_null_params[] = {
+        "tls-authz", "tls-hostname", "tls-creds"
+    };
+    QTestState *vm = qtest_init("");
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(allow_null_params); i++) {
+        qtest_qmp_assert_success(vm, "{ 'execute': 'migrate-set-parameters',"
+                                 "'arguments': { %s: null } }",
+                                 allow_null_params[i]);
+    }
+
+    qtest_quit(vm);
+}
+
 static void test_baddest(void)
 {
     MigrateStart args = {
@@ -2827,6 +2848,7 @@ int main(int argc, char **argv)
         }
     }
 
+    qtest_add_func("/migration/null_parameters", test_null_parameters);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
-- 
2.41.0


