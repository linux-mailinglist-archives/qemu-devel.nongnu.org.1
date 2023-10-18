Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5932D7CE1DE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 17:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sa-0001Pk-UX; Wed, 18 Oct 2023 11:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sY-0001AA-79
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sW-0006Tj-Ff
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwMMcG5cEaHfQ2TgGjb60VwjA/LGsrSX8V2jHOn88fg=;
 b=ZehQEyar9JR4VHQY/Tecw8RRBTxSqVVeJDGUz5H1J8WRwtoOOsIiG4TZzWxdZEztPBpxni
 xnn9+xWqmWXa6yFnd1gqnKtc5t2bTIdaBk+fCfNIjQhkbcI59Nc4NIKqwq4O6Bx44k0he9
 lMyQHaGSz/mKUnAR8/YnJ/YJztqoO5o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-u9NN3IqVPo6Ikgacy4vdgw-1; Wed, 18 Oct 2023 11:54:24 -0400
X-MC-Unique: u9NN3IqVPo6Ikgacy4vdgw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso66532031fa.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644462; x=1698249262;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NwMMcG5cEaHfQ2TgGjb60VwjA/LGsrSX8V2jHOn88fg=;
 b=D8DT64sWp8bGrqiJ0QVlUERvW38Qzcgn7/YLTOXdc2xyxIIkcpJ7pqO3S0W7InKV1k
 g+mSaUCHFVTY4bvYWadNxuA1+wSY3aXhbF9+ND8m1CD41gYxIvvNbAY8VK9U0c2pe2/c
 cYwwC5+LJ9g9KrXGp13zqZ5Mlo7VfVzBE+wQ87cVVoEsA3DmV6CCF7MN8UtkZV1rTle1
 qvrFrJ/mXqP/X/h5BoIFc2jTiVN8teM8Nqh7672MLhJimWdd0qtZPg2EcoBYfZxgCnDS
 vpAApgmfDb+1JRa9zKBpBKW6eYlG8UFGZhPGK39bszNdk+gFmbsUYEI0xvXaiBzBy+Hs
 Gm5w==
X-Gm-Message-State: AOJu0Yzw2QewA2uCtQQOv5DmjzVSdvQ1JE5+MgcbF3R8o/3MMGmf2N60
 CYDrQ28IMKY4DDUB3ZKmSrfjNAwQOz3tpnRuDna7kSjQ58FOR4YrDv49upeFoN+6aFMhaiKdSf9
 JjB0kto9F4c0jmYBtMKT7CJlWMVaQYHYLU3HA+OA+0OKaVLVfip0TgK0CygzICbHF7a/6Q5A=
X-Received: by 2002:a2e:a178:0:b0:2c5:1ad3:7798 with SMTP id
 u24-20020a2ea178000000b002c51ad37798mr3914198ljl.52.1697644462354; 
 Wed, 18 Oct 2023 08:54:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+1a/J+T834ACXR4ZE3y99OajdE2j9O+kFSxbreOq+ZL0+apO6nEdsGJBICFMldX/3uZIlsQ==
X-Received: by 2002:a2e:a178:0:b0:2c5:1ad3:7798 with SMTP id
 u24-20020a2ea178000000b002c51ad37798mr3914183ljl.52.1697644461992; 
 Wed, 18 Oct 2023 08:54:21 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adfe5ce000000b003296b488961sm2405552wrn.31.2023.10.18.08.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:21 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 15/83] tests: bios-tables-test: Add test for smbios type4 count
Message-ID: <335c9675408d8b72a31f5fd34ca7cdfc219968fe.1697644299.git.mst@redhat.com>
References: <cover.1697644299.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697644299.git.mst@redhat.com>
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
Message-Id: <20230928125943.1816922-4-zhao1.liu@linux.intel.com>
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


