Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C640F77C35F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVfvJ-0003Ol-SK; Mon, 14 Aug 2023 18:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfum-0003BQ-Iw
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfuk-0005k9-D5
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692051593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9sRU6XGp/MSmvILBmcGtp0+DyLq8JV+/t6bA0F+AKyo=;
 b=Ajt0q6Oq1DfwZwFN/e50zgi8F28syyIjNI6EU6ba1jxwCTsU4D+hNfGdfeZg0Q1FxJwPZS
 AlmQgzES6GKlNTc6l5MyekwtQvTxgjbfWys1wgof5j58YjmoiV+GPWLMjja2El7cUGpl8S
 X3Mw07RPtT/9RU39asv8EsUPo5bBKKw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-Z98wOUTZOGS7Uae40MEKog-1; Mon, 14 Aug 2023 18:19:52 -0400
X-MC-Unique: Z98wOUTZOGS7Uae40MEKog-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76cc6815f23so119307685a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051592; x=1692656392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sRU6XGp/MSmvILBmcGtp0+DyLq8JV+/t6bA0F+AKyo=;
 b=VCx6bKO+XfhGxeDqpZ9PRd4VUaEY0N4QxDoE2DuOweUGXllta60ljJlUSA5lc+bGIs
 TNhUAOLFXqfqTsoBTOyRiAf5bs02cIRxs+XOHBERMM8+gnyT8DVtB9Le+2hHlz2s8STC
 WKCoM82J3Nnqjg/uWh8SLErKaLIMUQpLm5zjtQtougqZyUsp85xbZGuA271ebi09LacI
 q7qZOIlZlMDhEI/uZjb3hs2CH9oddSAeCP3fsE1Fkm1qzYLHwEn4MPG78t/Lnpq5IaWB
 ohgahPADCTLPpMSDU8PH1bxaz4qlMlsnAa3OIBAn/gsJuSSkjpMdl3tZ8C2tP9aD7WaE
 wuZw==
X-Gm-Message-State: AOJu0YxELrSh5W17G32j5wxwovhBOSbNt7RgXkWtcWtrd6j8HLJjBci8
 JEOc9mgVWQOrfDbU48SmjRLvGafW1//wZ8xthuCv+AAPpsIuxy/a9LMBBlOlGq22zwRyFY+5ZaU
 W4Cgz5RJPsvXT/rjua9xeHUB0K8qXkrZsimZeNhhG2Hqb5UMUBhXfj6YyYBGtQ2art03KDbSC
X-Received: by 2002:a05:620a:468b:b0:76c:a3bb:f8c0 with SMTP id
 bq11-20020a05620a468b00b0076ca3bbf8c0mr14775294qkb.0.1692051591840; 
 Mon, 14 Aug 2023 15:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb+BiLiGnyNcq45xP+OcbVw3yZ2/NCPIqbDiOpvPmvvtdA6uBtXiAmpO+bqLG3X/U6YnSQIA==
X-Received: by 2002:a05:620a:468b:b0:76c:a3bb:f8c0 with SMTP id
 bq11-20020a05620a468b00b0076ca3bbf8c0mr14775273qkb.0.1692051591493; 
 Mon, 14 Aug 2023 15:19:51 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a05620a16b600b0076ca401d8c7sm3324978qkj.111.2023.08.14.15.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:19:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH for-8.2 2/4] tests/migration-test: Add a test for null
 parameter setups
Date: Mon, 14 Aug 2023 18:19:45 -0400
Message-ID: <20230814221947.353093-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814221947.353093-1-peterx@redhat.com>
References: <20230814221947.353093-1-peterx@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..12e72580a6 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1471,6 +1471,29 @@ static void test_postcopy_preempt_all(void)
 
 #endif
 
+/*
+ * We have a few parameters that allows null as input, test them to make
+ * sure they won't crash (where some used to).
+ */
+static void test_null_parameters(void)
+{
+    const char *null_params[] = {
+        "tls-authz", "tls-hostname", "tls-creds"};
+    QTestState *vm = qtest_init("");
+    QDict *response;
+    int i;
+
+    for (i = 0; i < sizeof(null_params) / sizeof(const char *); i++) {
+        response = qtest_qmp(vm, "{ 'execute': 'migrate-set-parameters',"
+                             "'arguments': { %s: null } }",
+                             null_params[i]);
+        /* Succeed or fail; as long as not crashing */
+        qobject_unref(response);
+    }
+
+    qtest_quit(vm);
+}
+
 static void test_baddest(void)
 {
     MigrateStart args = {
@@ -2827,6 +2850,7 @@ int main(int argc, char **argv)
         }
     }
 
+    qtest_add_func("/migration/null_parameters", test_null_parameters);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
-- 
2.41.0


