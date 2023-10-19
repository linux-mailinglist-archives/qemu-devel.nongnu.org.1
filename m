Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D4A7D0182
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXgg-0007rj-6F; Thu, 19 Oct 2023 14:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXfB-0006OS-3Z
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXf7-0000kz-F9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+ipRnkY4NnuS9r1wxkgNKOh/7QddOOYjOxyvSDYxSKc=;
 b=Run7CH7RUddiV8njPH6cXIyS9WyT/AcBSTLi8h8ErxLj2PIixsO5J2vhaJ4Ac7NF3jbNwo
 vD6R0hMOCIjejQGbNtGLUd2JNtcN/X9J3xf5tdhLPOBpE7bGgvIpbKGNx8vf+Q54+YOvzO
 UacpQuF9eKAMTAnAXQBg0uVRpB5Gfmg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-dEEW77MGOOSHOXGIOpoG7g-1; Thu, 19 Oct 2023 14:22:13 -0400
X-MC-Unique: dEEW77MGOOSHOXGIOpoG7g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db6a28e24so6246f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:22:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739731; x=1698344531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ipRnkY4NnuS9r1wxkgNKOh/7QddOOYjOxyvSDYxSKc=;
 b=MPuTaJUuc3rrstuqGsX/2OXRGbkTyL7k1HJqFb/ocq+dw05kUmLoWlOX3n5QPnstnv
 OSICVPLvp678+EHiDuQ94P8LNd8zF9/jnOR2+ljG6AlGY8RomLEEqRVqDiw1i4ryee9k
 vJz65/6bDLl7EWog+xiP1L5x63B9zw3rGOFp99dTTqpTsLmdAKFS73HW4hv8vsTgL+75
 /t4/BHW2ccAIaUHJvrJplX84HRclDCbyTkw4JmnXxzKVr4FmyifWpaGe8/atM2YhrgUK
 H1Ga0v5AZdnFp7ow9kOnEZk5bLYKfIrEqZYWRgE+BIoC/i4TPDr945o/CdjQWSEZ40XC
 sIOQ==
X-Gm-Message-State: AOJu0YwNNRplfGTaTemgDKGKd511RbMGlRWUR1ZFYrmjqaWWAgx8s5Zb
 txUfH5AjueDvN2aNIUYvmjAN1/2mpjLzMGj4IB5eMXSRGFoQ0Bz9oDU+hDqJ9LKrtaMzJSv+Het
 n2p8LmZP53E8YfZwdwRSXV6/fW9fGKDXv0YcwGjnZYWzsvovRePyBo4XeD3009VEDhvT3
X-Received: by 2002:adf:fccb:0:b0:329:6bdc:5a60 with SMTP id
 f11-20020adffccb000000b003296bdc5a60mr1855325wrs.12.1697739731208; 
 Thu, 19 Oct 2023 11:22:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdVM3f28Qfpo+vZMjV9kTk/VGnryJePcBZRyKOuEqYFFV+CY6EuFSX7+efpKtQ0I7FeNCjBg==
X-Received: by 2002:adf:fccb:0:b0:329:6bdc:5a60 with SMTP id
 f11-20020adffccb000000b003296bdc5a60mr1855311wrs.12.1697739730895; 
 Thu, 19 Oct 2023 11:22:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 q15-20020a5d574f000000b0031980783d78sm5022136wrw.54.2023.10.19.11.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:22:10 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:22:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 22/78] tests: bios-tables-test: Add test for smbios type4
 thread count2
Message-ID: <449d7c8441db2faa8596e393bba84130219d4551.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


