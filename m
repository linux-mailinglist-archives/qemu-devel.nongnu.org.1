Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC97E38C5
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J3Y-0005uj-ID; Tue, 07 Nov 2023 05:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3X-0005uR-Fx
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3V-0002ZU-5M
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CRVMMBpST4bseQtoU4pWaih3l68nE594eAbjKTnyT28=;
 b=F/Z55H1LZlWkJw8e3AYFoa2oKJd7ahDRxXzEMzw1AIBvzCiflce4MhHqE1ocSyU2qsezBJ
 xg2Q5Q1BWTEZymrEvZ1TXezXKbKwzGXd4bI5SbY71IoZD2RsCx5dAnVBpt5fvv0jqYV1ZN
 PPZRZbhSf4vGhpFQ4aSknJu7wtl0LQE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-FiIzqPeEMz-3ZVZ03_Ff5A-1; Tue, 07 Nov 2023 05:11:30 -0500
X-MC-Unique: FiIzqPeEMz-3ZVZ03_Ff5A-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e26bbbc63so4058441a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351888; x=1699956688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRVMMBpST4bseQtoU4pWaih3l68nE594eAbjKTnyT28=;
 b=a41fr6JOZiN+7pbDKAB55u0VmG/MiCgi1Syg73gRuQGftep07pIhgckg6duVCurI1J
 a0IqIjANmuoO8TqUG1BdOpmVkTRK2UL+3HBRZ3gKG5cNee+9J1kaoSrP5fhLPSy2SooR
 7P4Gfv+oidV81picZ6l5/1wsWcjSGRqg7+XkamUTmv1O9NRd7lraa4wcu/AI5FNZWjlD
 FNnZX4IYfSt8Lufjy0HG1XfaU8k5XT9EQchkrbLrGAO3ecFUazJM4pxhnZEC8GNGAFaj
 WrjLOdyQ9VwwtaliqysVWh7uQSLvKOidbbUtebHmA+dnAgQhECh5i0CsXxN/qbieBGrW
 +sWg==
X-Gm-Message-State: AOJu0YxlhPij0/p2eHo9+du/C5wxU3LN82wPT9VT+pjwT6NCu1oqrDte
 5aMnvF1hGwugsVedaDKWOWyKgD9/lF1S0/hVEFjBefyCKtluRUGw7pKngCC586xeQx7JbyCGcEp
 u0qhfTdLN0d24PHr5Dw9Nx4RZvMEzLNishsUcdHWcv06bPftlNQBP3OaB8QGZPdtdaBC3
X-Received: by 2002:a17:906:db01:b0:9b2:a96c:9290 with SMTP id
 xj1-20020a170906db0100b009b2a96c9290mr13620548ejb.33.1699351888118; 
 Tue, 07 Nov 2023 02:11:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvjHJCLuFVxx+/iMtwTma9hBIDlqqCIkO3OUcajw7LY+3vjakpl5vz5MLpJg+SkZGaTYapBA==
X-Received: by 2002:a17:906:db01:b0:9b2:a96c:9290 with SMTP id
 xj1-20020a170906db0100b009b2a96c9290mr13620533ejb.33.1699351887813; 
 Tue, 07 Nov 2023 02:11:27 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05600c0a4c00b0040775501256sm15419124wmq.16.2023.11.07.02.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:27 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 26/63] tests: bios-tables-test: Add test for smbios type4 count
Message-ID: <df210963a10e5ca884908addeb07aa081c5b7ad2.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Zhao Liu <zhao1.liu@intel.com>

This tests the commit d79a284a44bb7 ("hw/smbios: Fix smbios_smp_sockets
calculation").

In smbios_get_tables() (hw/smbios/smbios.c), smbios type4 table is built
for each socket, so the count of type4 tables should be equal to the
number of sockets.

Thus for the topology in this case, there're the following considerations:
1. The topology should include multiple sockets to ensure smbios could
   create type4 tables for each socket.
2. In addition to sockets, for the more general topology, we should also
   configure as many topology levels as possible (multiple dies, no
   module since x86 hasn't supported it), to ensure that smbios is able
   to exclude the effect of other topology levels to create the type4
   tables only for sockets.
3. The original miscalculation bug also misused "smp.cpus", so it's
   necessary to configure "cpus" (presented threads for machine) and
   "maxcpus" (total threads for machine) as well to make sure that
   configuring unpluged CPUs in smp (cpus < maxcpus) does not affect
   the correctness of the count of type4 tables.

Based on these considerations, select the topology as the follow:

-smp cpus=100,maxcpus=120,sockets=5,dies=2,cores=4,threads=3

The expected count of type4 tables = sockets (5).

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-4-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 9f4bc15aab..cdbfb51559 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -97,6 +97,7 @@ typedef struct {
     uint16_t smbios_core_count2;
     uint8_t *required_struct_types;
     int required_struct_types_len;
+    int type4_count;
     QTestState *qts;
 } test_data;
 
@@ -673,12 +674,21 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
     }
 }
 
+static void smbios_type4_count_test(test_data *data, int type4_count)
+{
+    int expected_type4_count = data->type4_count;
+
+    if (expected_type4_count) {
+        g_assert_cmpuint(type4_count, ==, expected_type4_count);
+    }
+}
+
 static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
 {
     DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
 
     SmbiosEntryPoint *ep_table = &data->smbios_ep_table;
-    int i = 0, len, max_len = 0;
+    int i = 0, len, max_len = 0, type4_count = 0;
     uint8_t type, prv, crt;
     uint64_t addr;
 
@@ -704,6 +714,7 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
 
         if (type == 4) {
             smbios_cpu_test(data, addr, ep_type);
+            type4_count++;
         }
 
         /* seek to end of unformatted string area of this struct ("\0\0") */
@@ -747,6 +758,8 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
     for (i = 0; i < data->required_struct_types_len; i++) {
         g_assert(test_bit(data->required_struct_types[i], struct_bitmap));
     }
+
+    smbios_type4_count_test(data, type4_count);
 }
 
 static void test_acpi_load_tables(test_data *data)
@@ -970,6 +983,22 @@ static void test_acpi_q35_tcg(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_type4_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".type4-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .type4_count = 5,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=100,maxcpus=120,sockets=5,"
+                  "dies=2,cores=4,threads=3", &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_core_count2(void)
 {
     test_data data = {
@@ -2147,6 +2176,8 @@ int main(int argc, char *argv[])
             if (has_kvm) {
                 qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
+                qtest_add_func("acpi/q35/type4-count",
+                               test_acpi_q35_tcg_type4_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
             }
-- 
MST


