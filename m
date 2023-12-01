Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2308010EF
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:16:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r977H-0002up-J6; Fri, 01 Dec 2023 12:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976x-0002r0-Sp
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r976v-0007eM-2t
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:15:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701450923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P0D6AFFuP7amG1vNr2743fXDdJGbhTGQIzdx7FMuVTU=;
 b=ZKXpGWDUmXfBuHSW66a9eip2fzUNDpB3ieS4gRtkTXilgONLWlsA4kAAW27HpES3ektYfc
 KNYOsEpWpIQwoPDwbt4EqZRy5ZxQ8Uaunar3zVbF6YoTpJEuXtObd++hT3l9dFaXLU9g5O
 djxB6LBjSh3ljWAycKDztoGP8aKVv+g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-QDKe5n1uMsyzG-E1O7eZCA-1; Fri, 01 Dec 2023 12:15:20 -0500
X-MC-Unique: QDKe5n1uMsyzG-E1O7eZCA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-333030e0708so1908071f8f.3
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:15:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701450919; x=1702055719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P0D6AFFuP7amG1vNr2743fXDdJGbhTGQIzdx7FMuVTU=;
 b=RPxi6YkCxZZhLA75WfA+l0NqF/th18yNShIrR5xAYruhDduwu2UTBN0byXLSqlxDLt
 tvwQuyUqfF82u0sXPkQKDss9AtMYUJjN0UFzd1NTV25kVq38I3+lwiEuOKpD7cwucaEK
 bx2EdPGOqNF5d9iAJrAHVBCFXzLCYU0C4Bsw3SIxAdaUx/oJlZRV1Md7sM9kfw21feNu
 I6O+L9S/z5/MiLvpuGHLAYCcHyy/fC88kt4/U0Bc9VBYY7OmndxSMPuEes19B05ckOIp
 ndScbyvdgIQxzig5e1Dz5f1j96gbVgYywj2kvXJ8nxlRapGiN1OKeYVNByHx/slvX2ND
 e3Pg==
X-Gm-Message-State: AOJu0Yzei/bPdWiFHP5semjcc49eIhZhYJAkkAgt4Fuf8JSDmiSxOx8o
 HtaCvVNPXE66dx6XtIikBx8qFN3yMroXoqumA+xYVs7h0Eyo+s2JcnU2DIkCFZW/EBwyppycFbt
 2cT2y9IEpKbNyYUvyFJ9FHzXzB1ClnVxerrt4aZzbfdnWH3js7RJwD0iSALYjIIeM+SxG
X-Received: by 2002:adf:f2c4:0:b0:331:6d19:6899 with SMTP id
 d4-20020adff2c4000000b003316d196899mr1228255wrp.70.1701450918793; 
 Fri, 01 Dec 2023 09:15:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWXQ2aG54TIWe56Px5p5KeLOtcLwLe+x+ImBBIQuEUiSaFsaW7WHQKi1lficXLxvu9XjuzWw==
X-Received: by 2002:adf:f2c4:0:b0:331:6d19:6899 with SMTP id
 d4-20020adff2c4000000b003316d196899mr1228242wrp.70.1701450918340; 
 Fri, 01 Dec 2023 09:15:18 -0800 (PST)
Received: from redhat.com ([2a06:c701:73e1:6f00:c7ce:b553:4096:d504])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a056000104c00b00333339e5f42sm1402612wrx.32.2023.12.01.09.15.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:15:17 -0800 (PST)
Date: Fri, 1 Dec 2023 12:15:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 03/15] tests/acpi/bios-tables-test: do not write new blobs
 unless there are changes
Message-ID: <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701450838.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Ani Sinha <anisinha@redhat.com>

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
Message-Id: <20231107044952.5461-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 71af5cf69f..fe6a9a8563 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -112,6 +112,7 @@ static const char *iasl;
 #endif
 
 static int verbosity_level;
+static GArray *load_expected_aml(test_data *data);
 
 static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
 {
@@ -244,21 +245,32 @@ static void test_acpi_fadt_table(test_data *data)
 
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
MST


