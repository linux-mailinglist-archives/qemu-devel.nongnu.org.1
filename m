Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7F07E38CE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:19:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J4j-0002ni-9E; Tue, 07 Nov 2023 05:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4g-0002me-PU
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J4Z-0002lB-TP
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0Ocf1GvnCZPw3fKHL0EDtSVhrXG0RlJR7LYrQ1QKH94=;
 b=FSBApN2t2ictxXqwDzC0flUe3zf5WTMrFWzQKpMKvdDYlxsaA8wxyullLbZAxb35cg8/cA
 lAhl1RVamtC11EfvhWqA/qjm4IjGiC9PwqQyEMs7gsH3qoxZ9zJIFVBJ2cAHsVzl0H4Dl/
 fd3SNcgk6q8nKsNMV9oLTvP35+xW3fU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-Nk9XfQ_xNtSzO8s74Z5ufw-1; Tue, 07 Nov 2023 05:12:22 -0500
X-MC-Unique: Nk9XfQ_xNtSzO8s74Z5ufw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9e27cc6dbf0so29805966b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351941; x=1699956741;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Ocf1GvnCZPw3fKHL0EDtSVhrXG0RlJR7LYrQ1QKH94=;
 b=uMREKm7LrPcYXSoJZ2EaYRQdl/or5aRCC0Q1mksgemgO60fy6L8uhqPUgyB9/BT1+B
 fu9U2TXX+l9YzyE/jcT/39fQIbiRbBIbFqCSZ+BvB6YmiI7DPFcX3+kGBc3LWbuQoOq+
 SFg/WpVSnmNRi8mNAEwnBRNoA8xax1GS+Sm8cg1/6i5BtxCqt2yORpRF585GkJ/zc1T7
 Q8c3ey1Na3VyfJ0RUEXMpnI77144mPj5aXAm3kO2kpxMWk4surxI5AFtGw9yCPfgMonO
 XOc5O1caWpq+DFraKEJGGcv37VysIxH7f8V710XNTyg8kSuy6u2MhnfohT0GSL4+h4ZF
 l82A==
X-Gm-Message-State: AOJu0YyqthK4rxBux3YA+Yha/oh/hT6T/nV0Vd8Vb8F+Fr8cp/6BE1bM
 OSZybmegwP7bhZOrJQMFWCjPOEo/7vf9XDLYPUKqMDoy2203J599a968xtHPPfIDBLcd4tRFOM8
 mvaRnprozDI7NMj1m5GBHsU/MixEn5siOh/EXPnolWg1D0D37TW87YA+38C/drLEAvlyd
X-Received: by 2002:a17:906:6686:b0:9ca:e7ce:8e60 with SMTP id
 z6-20020a170906668600b009cae7ce8e60mr12376809ejo.41.1699351941101; 
 Tue, 07 Nov 2023 02:12:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAilrcRitFIbk95f2YYUrWZ6P82D6l2ARhIjIIyas3dyHbHZe+7CXcl7y+MRdZCXVGWNGxHw==
X-Received: by 2002:a17:906:6686:b0:9ca:e7ce:8e60 with SMTP id
 z6-20020a170906668600b009cae7ce8e60mr12376791ejo.41.1699351940781; 
 Tue, 07 Nov 2023 02:12:20 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 q8-20020a05600c46c800b0040776008abdsm15110187wmo.40.2023.11.07.02.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:12:20 -0800 (PST)
Date: Tue, 7 Nov 2023 05:12:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 38/63] tests: bios-tables-test: Add test for smbios type4
 thread count2
Message-ID: <198eee0cc17d74f17ecd54ddf72681f421f7bc43.1699351720.git.mst@redhat.com>
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

This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
type4").

In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
threads in the socket is more than 255, then smbios type4 table encodes
threads per socket into the thread count2 field.

So for the topology in this case, there're the following considerations:
1. threads per socket should be more than 255 to ensure we could cover
   the thread count2 field.
2. The original bug was that threads per socket was miscalculated, so
   now we should configure as many topology levels as possible (multiple
   dies, no module since x86 hasn't supported it) to cover more general
   topology scenarios, to ensure that the threads per socket encoded in
   the thread count2 field is correct.
3. For the more general topology, we should also add "cpus" (presented
   threads for machine) and "maxcpus" (total threads for machine) to
   make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
   does not affect the correctness of threads per socket for thread
   count2 field.

Note we don't consider the topology with multiple sockets since this
topology would create too many vCPUs (more than 255 threads per socket
with at least 2 sockets, which may cause the failure "Number of
hotpluggable cpus requested (*) exceeds the maximum cpus supported by
KVM (*) socket_accept failed: Resource temporarily unavailable"), and
the calculation of threads per socket has already been covered by
"thread count" test case.

Based on these considerations, select the topology as the follow:

-smp cpus=210,maxcpus=260,dies=2,cores=65,threads=2

The expected thread count2 = threads per socket = threads (2)
* cores (65) * dies (2) = 260.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231023094635.1588282-16-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 395ed7f9ff..71af5cf69f 100644
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
+                  "-smp cpus=210,maxcpus=260,dies=2,cores=65,threads=2",
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


