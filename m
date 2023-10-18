Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EB7CE1F3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:59:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vB-0004TF-Pw; Wed, 18 Oct 2023 11:57:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tR-0002kV-UF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8tO-0006jC-B3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ipRnkY4NnuS9r1wxkgNKOh/7QddOOYjOxyvSDYxSKc=;
 b=EsTi1B/sByINr+KLeHoH5ZzHWAswAl3LYGs9URRW6sZU3Zf/VFRJbZPYx2fO00cfOWm3sV
 +mxgdD3PfWHUReu9ie6P9VlId/GrMh9+4ODbC8aA4yR2rwzSPFAmxuAwW8cHQgEPHj8k9s
 wt+KfIkqjQflUnPW/dVeRYLIhphWeU8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-7VFxPu3LM0i8__FBth6UdQ-1; Wed, 18 Oct 2023 11:55:18 -0400
X-MC-Unique: 7VFxPu3LM0i8__FBth6UdQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083865e0b7so8161225e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644517; x=1698249317;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ipRnkY4NnuS9r1wxkgNKOh/7QddOOYjOxyvSDYxSKc=;
 b=SDDvoewAjITRwEC3V3pldwrxd7YAEWN+Q2C/I6qHfQYamDr0cbmO+lId2eMIp563Bp
 BrtG6nHWSDnWpE3ciI2nz88oKxKnUx8/akbbdC7IJ9sAPiRyrryONDDHw6XbT1TXiQDb
 71Afngn0LPoUzRl5miihyLKk88XMym7Hpae90fQGS3K2paD119Xygq0rdKnVBLpsQyNA
 8xJm5eRc3ngOjOtYMVnBFqnmuk3mzcV7AYfzZyH09sf9LHOpMN2MC/hSys4DGUX3kXbk
 pZYgNcmeHJKoaahlEpMrbR0la9DLHi8n3GEn1OCo3V1iafe3o3D46gOvS+si437Nq2Z0
 9cIg==
X-Gm-Message-State: AOJu0Yx5s8gOBQDF6gWbz4NTd4Rm6l0cVvjPptdToh9nCX0182VxpEsK
 8zWdOcJglTODjo7831SNMegBfKBzE/q4HMZ1q77bftam1nvtC+j3+bQQoyCFYQa5QRW9/gO5dS6
 TqoHtrkNXIIN/s/C2ppKX5FaTfA6t8sSdvsVl74n9B/hO0rxnQcgmOMg166dlzHY6dw2qAaM=
X-Received: by 2002:a05:600c:3c96:b0:406:53f1:d629 with SMTP id
 bg22-20020a05600c3c9600b0040653f1d629mr4184124wmb.5.1697644516796; 
 Wed, 18 Oct 2023 08:55:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYW+5Q3wvgvSHgK60mRVa+C5bOOnsFRs32f109HwRintm+OGb80khRpfG2BYyMP2l4la1tiw==
X-Received: by 2002:a05:600c:3c96:b0:406:53f1:d629 with SMTP id
 bg22-20020a05600c3c9600b0040653f1d629mr4184104wmb.5.1697644516393; 
 Wed, 18 Oct 2023 08:55:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c220600b0040684abb623sm1964428wml.24.2023.10.18.08.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:55:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 27/83] tests: bios-tables-test: Add test for smbios type4
 thread count2
Message-ID: <2b04a1eaf75f0a94b40be865198ab746cfb3034d.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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

From: Zhao Liu <zhao1.liu@intel.com>

This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
type4").

In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
threads in the socket is more than 255, then smbios type4 table encodes
threads per socket into the thread count2 field.

So for the topology in this case, there're the following considerations:
1. threads per socket should be more than 255 to ensure we could cover
   the thread count2 field.
2. The original bug was that threads per socket was miscalculated, so
   now we should configure as many topology levels as possible (mutiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the threads per
   socket encoded in the thread count2 field is correct.
3. For the more general topology, we should also add "cpus" (presented
   threads for machine) and "maxcpus" (total threads for machine) to
   make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
   does not affect the correctness of threads per socket for thread
   count2 field.

Based on these considerations, select the topology as the follow:

-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2

The expected thread count2 = threads per socket = threads (2)
* cores (65) * dies (2) = 260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20230928125943.1816922-16-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 395ed7f9ff..1e61ead539 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -96,6 +96,7 @@ typedef struct {
     uint8_t smbios_core_count;
     uint16_t smbios_core_count2;
     uint8_t smbios_thread_count;
+    uint16_t smbios_thread_count2;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     int type4_count;
@@ -644,6 +645,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
     uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
     uint16_t speed, expected_speed[2];
     uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
+    uint16_t thread_count2, expected_thread_count2 = data->smbios_thread_count2;
     int offset[2];
     int i;
 
@@ -680,6 +682,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
         if (expected_core_count == 0xFF && expected_core_count2) {
             g_assert_cmpuint(core_count2, ==, expected_core_count2);
         }
+
+        thread_count2 = qtest_readw(data->qts,
+                            addr + offsetof(struct smbios_type_4,
+                            thread_count2));
+
+        /* Thread Count has reached its limit, checking Thread Count 2 */
+        if (expected_thread_count == 0xFF && expected_thread_count2) {
+            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
+        }
     }
 }
 
@@ -1050,6 +1061,7 @@ static void test_acpi_q35_tcg_thread_count(void)
         .required_struct_types = base_required_struct_types,
         .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
         .smbios_thread_count = 27,
+        .smbios_thread_count2 = 27,
     };
 
     test_acpi_one("-machine smbios-entry-point-type=64 "
@@ -1058,6 +1070,23 @@ static void test_acpi_q35_tcg_thread_count(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_thread_count2(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".thread-count2",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_thread_count = 0xFF,
+        .smbios_thread_count2 = 260,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_bridge(void)
 {
     test_data data = {};
@@ -2228,6 +2257,8 @@ int main(int argc, char *argv[])
                                test_acpi_q35_tcg_core_count2);
                 qtest_add_func("acpi/q35/thread-count",
                                test_acpi_q35_tcg_thread_count);
+                qtest_add_func("acpi/q35/thread-count2",
+                               test_acpi_q35_tcg_thread_count2);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
MST


