Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B98E7CE206
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8vG-0005Gf-Bk; Wed, 18 Oct 2023 11:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8t7-0002di-3K
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8t1-0006e7-5t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y2vvrjcXQ7FkGJyS721V81si3KF742NaIRZW7f1WAeE=;
 b=erIfGIfKD7vDweLbbVw+oAXeqImCp2ngDZOYIvRj94DwdEAc8xnlQIt/feXxJkqFpDo1nm
 fKKK16rmqMHxo/yw8V2EMpAMEhgQMttOazIYBOsdo2m4EVVitBiRz44go+ljjWXjMNQB+2
 HbzyTlyYmmG6nAWXnex2W3GvS4kfZ2I=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-xIMNtRSLOGS_xXtfQ3Jn0A-1; Wed, 18 Oct 2023 11:55:04 -0400
X-MC-Unique: xIMNtRSLOGS_xXtfQ3Jn0A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40566c578b7so50241345e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:55:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644502; x=1698249302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2vvrjcXQ7FkGJyS721V81si3KF742NaIRZW7f1WAeE=;
 b=vHS5s6NsX2bf91GuVFV0jNgRNfVpvTXSXhRQm4oc0lJSKYfLidJfra97JHL8vEtBdj
 wVY6NmQdBNC0eRZdHfjw2av+kGqjX9EsDulcDCFF1qQ+QWhCWXbkxFegsqA8q4Cm+3tv
 6kA9IZSO8D/80CnVi+QebkeBXTHuGbQQ1Ngx329TyilW24Uu/dTBs8YpHpuG2Sorvz1n
 ekkgUbuhL3cji8AWv0k6xznH/WSo2DoCuVqJJ88o6njLWWDrI8iaaAvl2ZGd7ci/ekp/
 W/IxM476oBUFo/x3OeGJuUUYlW34zqSiWA3bHqedH+NYyT1ju196VayvMp4PKH/eIvny
 nlkw==
X-Gm-Message-State: AOJu0YyVdP0KRHCAH7yNvRuPPD75ckN7vQg1w8xaogYJm9A+Ig9RBtHk
 fCmV8l4iNMIE0vLhbVO5qBqgtIiWfE8nfNIjnB2WqS8SMtw7k1Wn6n2cRmG4PWFb7hArrJxi7OW
 QxUQFCv5MHP4YldoEF8mdMhysmA1yvdZ3xuCwpFob2BPnPsOa+iHae9XfAWE5eOogBFMT5xI=
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe0 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe0mr542104wms.6.1697644502384; 
 Wed, 18 Oct 2023 08:55:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNCWzMRbk11rPAdYm60cwQQnzeQPVx2mk81W8uMqTBxeRiAXlCwaGoJ8WFyDOoAPQgQKZ83Q==
X-Received: by 2002:a05:600c:1d22:b0:408:41b4:7fe0 with SMTP id
 l34-20020a05600c1d2200b0040841b47fe0mr542088wms.6.1697644502055; 
 Wed, 18 Oct 2023 08:55:02 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b003fe1fe56202sm2044786wmo.33.2023.10.18.08.55.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:55:01 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 24/83] tests: bios-tables-test: Add test for smbios type4
 thread count
Message-ID: <706fa69cfc9f3a4cf7677583cce31d742c0d2712.1697644299.git.mst@redhat.com>
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
threads in the socket is not more than 255, then smbios type4 table
encodes threads per socket into the thread count field.

So for the topology in this case, there're the following considerations:
1. threads per socket should be not more than 255 to ensure we could
   cover the thread count field.
2. The original bug was that threads per socket was miscalculated, so
   now we should configure as many topology levels as possible (mutiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the threads per
   socket encoded in the thread count field is correct.
3. For the more general topology, we should also add "cpus" (presented
   threads for machine) and "maxcpus" (total threads for machine) to
   make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
   does not affect the correctness of threads per socket for thread
   count field.

Based on these considerations, select the topology as the follow:

-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3

The expected thread count = threads per socket = threads (3) * cores (3)
* dies (3) = 27.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20230928125943.1816922-13-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f3af20cf2c..395ed7f9ff 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -95,6 +95,7 @@ typedef struct {
     uint16_t smbios_cpu_curr_speed;
     uint8_t smbios_core_count;
     uint16_t smbios_core_count2;
+    uint8_t smbios_thread_count;
     uint8_t *required_struct_types;
     int required_struct_types_len;
     int type4_count;
@@ -640,6 +641,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
                             SmbiosEntryPointType ep_type)
 {
     uint8_t core_count, expected_core_count = data->smbios_core_count;
+    uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
     uint16_t speed, expected_speed[2];
     uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
     int offset[2];
@@ -663,6 +665,13 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
         g_assert_cmpuint(core_count, ==, expected_core_count);
     }
 
+    thread_count = qtest_readb(data->qts,
+                       addr + offsetof(struct smbios_type_4, thread_count));
+
+    if (expected_thread_count) {
+        g_assert_cmpuint(thread_count, ==, expected_thread_count);
+    }
+
     if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
         core_count2 = qtest_readw(data->qts,
                           addr + offsetof(struct smbios_type_4, core_count2));
@@ -1033,6 +1042,22 @@ static void test_acpi_q35_tcg_core_count2(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_thread_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".thread-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_thread_count = 27,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_bridge(void)
 {
     test_data data = {};
@@ -2201,6 +2226,8 @@ int main(int argc, char *argv[])
                                test_acpi_q35_tcg_core_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
+                qtest_add_func("acpi/q35/thread-count",
+                               test_acpi_q35_tcg_thread_count);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
MST


