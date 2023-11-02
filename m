Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D736D7DEE15
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 09:18:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qySsv-0004MR-B7; Thu, 02 Nov 2023 04:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qySss-0004Lf-Kg
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:16:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qySsi-0007MA-93
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:16:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698913005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=jaVjapOY9rl5GKxOKF8u5zLmvAQkMeicDz8SAsNacyM=;
 b=bL5qoWUeGtBgKRM0LdMAOtTlyww4RL+vbHaJOZ9hp/ChNrQ2XTaruG0cN/1yBfhx9OShXh
 Y9uAfe0xiEtdvGPoxmXeYw2Dpr2eZluWfVxQM4mZeCecuvEb1uSCJ6kbABu8rl089hnPQl
 mflnA709bLRsjnyIdiS1Tphvqn1F7fI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-cHH2JHZEOaGBvQjAwvVztw-1; Thu, 02 Nov 2023 04:16:44 -0400
X-MC-Unique: cHH2JHZEOaGBvQjAwvVztw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28035cf4306so1460324a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 01:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913003; x=1699517803;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jaVjapOY9rl5GKxOKF8u5zLmvAQkMeicDz8SAsNacyM=;
 b=v54u4FmwvEzlu9tTyu2GGcCgiMkb9+fZp6yGqgrEXMSwAWgLULLhsbYcjv1ydaF39/
 tb21b78McWV6qu0XY/nfmIp9o7KtJT3JMjWNH8PKWOQR7RvbKTZGhH+qXzDOhUSbB1oy
 GXdRdrypgQrQejdxmsmr7BOjpdj7gc6ayFmqRk0p/QTn60UDoU4CqyuMrCX4J85Rjt89
 CjoHpdB6QfbPapnGv5TKYj5QLVn3slvdNv+6UMjGc+zMSEK67CkLNT9YGbr5omqtElQw
 eo+Eg69Xpf8IRxjky88YZKdOWRhUHEZEfGQkrs5Zx6+S1Ht7xwkFTE6d7rWJMg4cNPtx
 aoHg==
X-Gm-Message-State: AOJu0Yyggnjv0tbDnDOg02ke4rqUFpl/JmcNVJm7zPd41F05u35l2na/
 Mtv0lW15aXaXUM+p/kLdQoShvHZIFKrgHcIwm4qME6PQ6ajwSMK2RHkmtfHzZdXRRScZDtvy9xK
 4DiQOHYQ5sfzjkic=
X-Received: by 2002:a17:90a:df06:b0:280:23e1:e4dd with SMTP id
 gp6-20020a17090adf0600b0028023e1e4ddmr11198099pjb.17.1698913003431; 
 Thu, 02 Nov 2023 01:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa4QQjHC0F2HH1GmRqKcCfm7KZB3qTpRkBb+LvXiOuSDw+E5yUzC/+sJW8lRXzFCSiwrGuSQ==
X-Received: by 2002:a17:90a:df06:b0:280:23e1:e4dd with SMTP id
 gp6-20020a17090adf0600b0028023e1e4ddmr11198084pjb.17.1698913003118; 
 Thu, 02 Nov 2023 01:16:43 -0700 (PDT)
Received: from localhost.localdomain ([115.96.120.135])
 by smtp.googlemail.com with ESMTPSA id
 28-20020a17090a195c00b00263b9e75aecsm2125541pjh.41.2023.11.02.01.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 01:16:42 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH] tests/acpi/bios-tables-test: do not write new blobs unless
 there are changes
Date: Thu,  2 Nov 2023 13:46:24 +0530
Message-ID: <20231102081624.25229-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
test variants are dumped regardless of whether there are any actual changes to
the tables or not. This creates lot of new files for various test variants that
are not part of the git repository. This is because we do not check in all table
blobs for all test variants into the repository. Only those blobs for those
variants that are different from the generic test-variant agnostic blob are
checked in.

This change makes the test smarter by checking if at all there are any changes
in the tables from the checked-in gold master blobs. If there are no changes,
no new files are written for test variants. However, existing files continue
to be overwritten regardless of whether there are changes. Hence, new files
will be generated only when there are actual changes in the tables.
This would make analyzing changes to tables less confusing and there would
be no need to clean useless untracked files when there are no table changes.

CC: peter.maydell@linaro.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 9f4bc15aab..743b509e93 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -109,6 +109,7 @@ static const char *iasl;
 #endif
 
 static int verbosity_level;
+static GArray *load_expected_aml(test_data *data);
 
 static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
 {
@@ -241,21 +242,32 @@ static void test_acpi_fadt_table(test_data *data)
 
 static void dump_aml_files(test_data *data, bool rebuild)
 {
-    AcpiSdtTable *sdt;
+    AcpiSdtTable *sdt, *exp_sdt;
     GError *error = NULL;
     gchar *aml_file = NULL;
+    test_data exp_data = {};
     gint fd;
     ssize_t ret;
     int i;
 
+    exp_data.tables = load_expected_aml(data);
     for (i = 0; i < data->tables->len; ++i) {
         const char *ext = data->variant ? data->variant : "";
         sdt = &g_array_index(data->tables, AcpiSdtTable, i);
+        exp_sdt = &g_array_index(exp_data.tables, AcpiSdtTable, i);
         g_assert(sdt->aml);
+        g_assert(exp_sdt->aml);
 
         if (rebuild) {
             aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
                                        sdt->aml, ext);
+            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
+                sdt->aml_len == exp_sdt->aml_len &&
+                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
+                /* identical tables, no need to write new files */
+                g_free(aml_file);
+                continue;
+            }
             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
             if (fd < 0) {
-- 
2.42.0


