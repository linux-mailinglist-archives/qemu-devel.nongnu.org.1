Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9778B7E34B3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 05:51:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0E2f-0004wN-Pg; Mon, 06 Nov 2023 23:50:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0E2c-0004vb-FO
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0E2a-0002hG-IE
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 23:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699332615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2R/kWFT2Q/SwgDCTIIuoRwHVPh5erP/dYvf1fBM0FTM=;
 b=crW2teRGrYQuUigvpD0GkQ/pDviCWL1ZAqYLLNy1ag8Rg4OaxbXoNHxSTYJMCc1iDGSj8B
 oMmgaF88EycySxm2EDycXE7duImD28p3CfqZiQTpBc9jHuxIf2Td579hTwIZhSSiZ04//E
 7pYbvQV7T+lLbZJkaaMv7haswc3apqU=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-mwS-cfqsOymIugTl2KFD0g-1; Mon, 06 Nov 2023 23:50:03 -0500
X-MC-Unique: mwS-cfqsOymIugTl2KFD0g-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7b9d83044c3so1775893241.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 20:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699332603; x=1699937403;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2R/kWFT2Q/SwgDCTIIuoRwHVPh5erP/dYvf1fBM0FTM=;
 b=L94fgmnXynsG3KCphoqxB7EAdC/osN4QiOy5CQOUsdR3xG4iQuVpgpbbBWmD4T49Eu
 U3Nqqsj2kspO3OBJRqRm32lyztySUEM59XDxBTmqtIj/2jWjzS46AeoSOcrvcKMRA1Az
 Z+Wu7C1BsMoBOY0pBcmMrYj99zSD+aMlYZdLJngslM9m98LQiv9Bdw715Pt+KR1VHc4r
 /4eSrgWJWD3XC18XH51KsTOJn+brwTqpYnYl63dy7i0iajJ8CWLDTJmMk+HLlKt2vciZ
 vCtMQpJzcZjUY7sEmgAtCiHO7jy/J8wHy3ZdzHWUTaLHglO4DsqqFaXBgTXVHn7MYubg
 lRew==
X-Gm-Message-State: AOJu0YwuhHOwMkWTlywDglyJ0vAUs3qONx8ZTnqHk6Iharh460xBtbwq
 ZBZJ1cKiEi+O390VpnrFb1q6Vq0JU7yk+8Llf3BaMpUkRBNUxq/MdvhPU4M71miQ+8XDllGft3s
 uKqfqY2RVcbHEfBY=
X-Received: by 2002:a67:c181:0:b0:45d:b9fa:48e9 with SMTP id
 h1-20020a67c181000000b0045db9fa48e9mr7282694vsj.31.1699332603148; 
 Mon, 06 Nov 2023 20:50:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyPWuEGFBH0N66vXrN7wC7VMpT+Z0uQbNlSvG6g4P+Et0K1qPBbDkZLO3chSuqIkO3jRbbeg==
X-Received: by 2002:a67:c181:0:b0:45d:b9fa:48e9 with SMTP id
 h1-20020a67c181000000b0045db9fa48e9mr7282684vsj.31.1699332602774; 
 Mon, 06 Nov 2023 20:50:02 -0800 (PST)
Received: from localhost.localdomain ([115.96.144.207])
 by smtp.googlemail.com with ESMTPSA id
 y11-20020a62f24b000000b006c067f1b254sm6253082pfl.122.2023.11.06.20.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 20:50:02 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] tests/acpi/bios-tables-test: do not write new blobs unless
 there are changes
Date: Tue,  7 Nov 2023 10:19:51 +0530
Message-ID: <20231107044952.5461-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
test variants are dumped regardless of whether there are any actual changes to
the tables or not. This creates lot of new files for various test variants that
are not part of the git repository. This is because we do not check in all table
blobs for all test variants into the repository. Only those blobs for those
variants that are different from the generic test-variant agnostic blob are
checked in.

This change makes the test smarter by checking if at all there are any changes
in the tables from the checked-in gold master blobs and take actions
accordingly.

When there are no changes:
 - No new table blobs would be written.
 - Existing table blobs will be refreshed (git diff will show no changes).
When there are changes:
 - New table blob files will be dumped.
 - Existing table blobs will be refreshed (git diff will show that the files
   changed, asl diff will show the actual changes).
When new tables are introduced:
 - Zero byte empty file blobs for new tables as instructed in the header of
   bios-tables-test.c will be regenerated to actual table blobs.

This would make analyzing changes to tables less confusing and there would
be no need to clean useless untracked files when there are no table changes.

CC: peter.maydell@linaro.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

changelog:
v2: commit description updated to make things a little clearer.
    No actual changes.

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


