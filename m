Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE08798AD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Mar 2024 17:13:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4iq-00068E-Cl; Tue, 12 Mar 2024 12:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iY-0005y5-0L
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rk4iT-0007A2-6O
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6tmmkz0v1gAREBV/ns3ox69HHc78tIUnrLE1mw14Ye8=;
 b=Eg+iDVEZ1kfhXJ2CjxqqxMWGzUKTK9qWWzPnXz++1VDLiJAa8xcjk08N0d3X5Bntq01tA9
 kauWp2FtMuv9kZ04/YIFV+vmd9DV0in5rTcNJDxKUm9HLjmbiFxJuVW2Rq2oTs4NOAVbdI
 Gw1i7nghRI+rq8jaNle82Vu2xnCVlqI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-PLPqCaKnOm-hAVHhAmhEvQ-1; Tue, 12 Mar 2024 12:10:55 -0400
X-MC-Unique: PLPqCaKnOm-hAVHhAmhEvQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B1118007AB;
 Tue, 12 Mar 2024 16:10:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE4E3C21;
 Tue, 12 Mar 2024 16:10:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, Ani Sinha <anisinha@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>
Subject: [PATCH v3 02/20] tests: smbios: add test for -smbios type=11 option
Date: Tue, 12 Mar 2024 17:10:32 +0100
Message-Id: <20240312161050.2248814-3-imammedo@redhat.com>
In-Reply-To: <20240312161050.2248814-1-imammedo@redhat.com>
References: <20240312161050.2248814-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/data/smbios/type11_blob  | Bin 0 -> 11 bytes
 tests/qtest/bios-tables-test.c |  17 +++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/smbios/type11_blob

diff --git a/tests/data/smbios/type11_blob b/tests/data/smbios/type11_blob
new file mode 100644
index 0000000000000000000000000000000000000000..1d8fea4b0c6f040a13ba99c3fad762538b795614
GIT binary patch
literal 11
Scmd;PW!S(N;u;*nzyJUX)&c?m

literal 0
HcmV?d00001

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index b2992bafa8..a116f88e1d 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2091,6 +2091,21 @@ static void test_acpi_pc_smbios_options(void)
     free_test_data(&data);
 }
 
+static void test_acpi_pc_smbios_blob(void)
+{
+    uint8_t req_type11[] = { 11 };
+    test_data data = {
+        .machine = MACHINE_PC,
+        .variant = ".pc_smbios_blob",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-machine smbios-entry-point-type=32 "
+                "-smbios file=tests/data/smbios/type11_blob", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2244,6 +2259,8 @@ int main(int argc, char *argv[])
 #endif
             qtest_add_func("acpi/piix4/smbios-options",
                            test_acpi_pc_smbios_options);
+            qtest_add_func("acpi/piix4/smbios-blob",
+                           test_acpi_pc_smbios_blob);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
-- 
2.39.3


