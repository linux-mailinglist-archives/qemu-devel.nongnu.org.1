Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 814ED70679A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:09:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzFxA-0007Rx-Q9; Wed, 17 May 2023 08:08:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzFx3-0007O2-1U
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1pzFx1-0003sL-00
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684325294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=20rLuDb+RqGbgc9BdxJ1X/ks5hDUjRdW4kxSLOVdGYA=;
 b=iUSrj4acOifjIvvcvWqGJJevFa0aqRzM4iz2CY1fGZLa7nCJHso4IAM8MIafJDVLld1Uni
 QWAqSZ/1tpJDgQywXZy1I9xwjrvZG+r05/+h1DlzYG3Vd1GpMGp8mbh5E/ZTeRMO5tqK/n
 gh1Smts2T0SWXt+lkeCkRuKKLcAVH88=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-F5oLuqC-OHeKE9Enzjm9rg-1; Wed, 17 May 2023 08:08:13 -0400
X-MC-Unique: F5oLuqC-OHeKE9Enzjm9rg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6439df91d81so462457b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 05:08:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684325292; x=1686917292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=20rLuDb+RqGbgc9BdxJ1X/ks5hDUjRdW4kxSLOVdGYA=;
 b=kqXAI5bFRUIIc6KXOPRb7mGIlA1VXwzj3S3D1iVOnQfe9h1nnIRrAUUkPgsd/5YtDO
 BAZ3GxtmRPdDklXHnas2nCAKZdOvB4N1vjTv089iZ7CjKBgohWeh4Fenk7Y05m0J22FY
 clS03GTsc/3+kydyTuf1+o6PJibCbayiaT3os3xhZ+vXGMXqCY8jcluXRTtyCLeddGGV
 cLdxCoz/VSvI1dSjmIFFg9sa9OU4UR63fjNnq27SIg1H2HUNIPXnRa9XA06sdQAMfdyF
 TuRRm++ArmxoV2ycv1LnkVhKHYdhKXVr5XGNRyOFS5/NXS95GfUxUxwO8WDvFnacPZOz
 wedw==
X-Gm-Message-State: AC+VfDwV0PwaxLo5q6WZGh43ZHXhHz3bKrMZAAxo+Ax7z3jIssAH3jzQ
 Rnib7kbkozQaA9flnTIKB2c34TBtHSUVHfIZiKU75sPjaz35BEWLEnkYV9QYoBJH1dLYhIDR/ur
 nSdBLaTfQYsFcUCY=
X-Received: by 2002:a05:6a00:810:b0:64c:c836:662d with SMTP id
 m16-20020a056a00081000b0064cc836662dmr647999pfk.20.1684325291911; 
 Wed, 17 May 2023 05:08:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6v411CJDbFcb0Amen4XrHzrBm35kHbVfXrIpeIuBZwbqK3c4aoqbfEgoSWdxRsq8rw4w2T8w==
X-Received: by 2002:a05:6a00:810:b0:64c:c836:662d with SMTP id
 m16-20020a056a00081000b0064cc836662dmr647962pfk.20.1684325291497; 
 Wed, 17 May 2023 05:08:11 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.155])
 by smtp.googlemail.com with ESMTPSA id
 y10-20020aa7804a000000b006328ee1e56csm15153070pfm.2.2023.05.17.05.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 05:08:10 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] acpi/tests/bios-tables-test: add an environment variable for
 iasl location
Date: Wed, 17 May 2023 17:37:51 +0530
Message-Id: <20230517120751.14679-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently the meson based QEMU build process locates the iasl binary from the
current PATH and other locations [1] and uses that to set CONFIG_IASL which is
then used by the test.

This has two disadvantages:
 - If iasl was not previously installed in the PATH, one has to install iasl
   and rebuild QEMU in order to pick up the iasl location. One cannot simply
   use the existing bios-tables-test binary because CONFIG_IASL is only set
   during the QEMU build time by meson and then bios-tables-test has to be
   rebuilt with CONFIG_IASL set in order to use iasl.
 - Sometimes, the stock iasl that comes with distributions is simply not good
   enough because it does not support the latest ACPI changes - newly
   introduced tables or new table attributes etc. In order to test ACPI code
   in QEMU, one has to clone the latest acpica upstream repository and
   rebuild iasl in order to get support for it. In those cases, one may want
   the test to use the iasl binary from a non-standard location.

In order to overcome the above two disadvantages, we introduce a new
environment variable IASL_PATH that can be set by the tester pointing to an
possibly non-standard iasl binary location. Bios-tables-test then uses this
environment variable to set its iasl location, possibly also overriding the
location that was pointed to by CONFIG_IASL that was set by meson. This way
developers can not only use this new environment variable to set iasl
location to quickly run bios-tables-test but also can point the test to a
custom iasl if required.

[1] https://mesonbuild.com/Reference-manual_functions.html#find_program

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

sample runs:

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 V=2 ./tests/qtest/bios-tables-test
...
acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-DLHA51], Expected [aml:tests/data/acpi/pc/APIC].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
Using iasl: /usr/bin/iasl
acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-L9GA51.dsl, aml:/tmp/aml-DLHA51], Expected [asl:/tmp/asl-10EA51.dsl, aml:tests/data/acpi/pc/APIC].

$ QTEST_QEMU_BINARY=./qemu-system-x86_64 V=2 IASL_PATH=/home/anisinha/workspace/acpica/generate/unix/bin/iasl ./tests/qtest/bios-tables-test
...
acpi-test: Warning! APIC binary file mismatch. Actual [aml:/tmp/aml-5CQ341], Expected [aml:tests/data/acpi/pc/APIC].
See source file tests/qtest/bios-tables-test.c for instructions on how to update expected files.
User has provided an iasl path, using that: /home/anisinha/workspace/acpica/generate/unix/bin/iasl
acpi-test: Warning! APIC mismatch. Actual [asl:/tmp/asl-2GQ341.dsl, aml:/tmp/aml-5CQ341], Expected [asl:/tmp/asl-IBR341.dsl, aml:tests/data/acpi/pc/APIC].

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 7fd88b0e9c..37e8e484cb 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -440,7 +440,12 @@ static void test_acpi_asl(test_data *data)
     AcpiSdtTable *sdt, *exp_sdt;
     test_data exp_data = {};
     gboolean exp_err, err, all_tables_match = true;
+    const char *user_iasl_path = getenv("IASL_PATH");
 
+    /* if user has provided a path to iasl, use that */
+    if (user_iasl_path) {
+        iasl = user_iasl_path;
+    }
     exp_data.tables = load_expected_aml(data);
     dump_aml_files(data, false);
     for (i = 0; i < data->tables->len; ++i) {
@@ -473,6 +478,15 @@ static void test_acpi_asl(test_data *data)
             continue;
         }
 
+        if (verbosity_level >= 2) {
+            if (user_iasl_path) {
+                fprintf(stderr, "User has provided an iasl path," \
+                        "using that: %s\n", user_iasl_path);
+            } else {
+                fprintf(stderr, "Using iasl: %s\n", iasl);
+            }
+        }
+
         err = load_asl(data->tables, sdt);
         asl = normalize_asl(sdt->asl);
 
-- 
2.39.1


