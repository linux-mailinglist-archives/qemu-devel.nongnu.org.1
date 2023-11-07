Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 227B37E38F0
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:22:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J45-0007Z5-Cp; Tue, 07 Nov 2023 05:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3q-0007IT-7y
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J3h-0002bH-O6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f1qL4Gjf5dDJMPYrCrv2bEV2a6+bVH8Xfdo7bHqZQA0=;
 b=PpyBIa5LE3pBjETDLB91js5bKirhGvKpHo9sN5NpW7KJVa4NiO+hpGpL2Wtp2WEnjs6c7+
 fsbupYitZZ5nyRFSPuhgbSJiOwHtTPRdtLXUOGjJYGm0FuphUVv22D+AMgpfq9N6vtRxd7
 LjE7ysO3H6FTUQTY50bVxBdj3Tuc6Ec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-PYcy4sBWNQCFvUBEGgC2AA-1; Tue, 07 Nov 2023 05:11:43 -0500
X-MC-Unique: PYcy4sBWNQCFvUBEGgC2AA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32fa25668acso2831208f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:11:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351902; x=1699956702;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1qL4Gjf5dDJMPYrCrv2bEV2a6+bVH8Xfdo7bHqZQA0=;
 b=iIVs7sTgnS2/tNYJQMuoKgCDLggg/u4QxI3qWCQLvauBOAfjLTcieuwi335rRGcPmd
 KoZqsIcIh3pDr55tXMb53ZNd9M83A21ISYBIw+02jn5nbDT8Cbr/X1Agd/v75txzGuC+
 ft5Uihvww9daaLrj6ZhxIhwZX98bySqmcxI5+x7/hVs0XHPvJzuQj1j11JlXWNZYBaBW
 LM0tVsUZ9tuQLQoIpSFlazjykux4FU7BvjSeopr9MDkuZrabahsiD24annL2+w53juWi
 vy3GtDprgQ4CMaCwdyPz9otZvg0pPxGAcC+QILWjj/s0QclfAfc5pZnhzAyxkPmVlzWg
 eMzg==
X-Gm-Message-State: AOJu0YwvThQCxHYPDFqzVxuQlSal3LQHoZbmS82A+bWCkf8fKFNEDVnt
 SQjEvkvnXnvBh7vEnZHyEhPuIxwvWo0tebTkloi3sGsuq2CZvlNUpvYaS2De8TJ7HibnvwZKmmf
 LU5gTHppuxRWZOdNJtp1LXBD806DG+xglAiUQcCD8GQgDVXmI3l6WoBEXUBHR3xJR09nY
X-Received: by 2002:adf:f08f:0:b0:32d:8872:aac8 with SMTP id
 n15-20020adff08f000000b0032d8872aac8mr23765246wro.31.1699351901803; 
 Tue, 07 Nov 2023 02:11:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgQRMWJi47Ehcf2w6FB+4kaMFVkia6IbaQRChxS6ngxFEjSRlS3F2+L2hirXSXoy24VCrHRQ==
X-Received: by 2002:adf:f08f:0:b0:32d:8872:aac8 with SMTP id
 n15-20020adff08f000000b0032d8872aac8mr23765228wro.31.1699351901390; 
 Tue, 07 Nov 2023 02:11:41 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 a4-20020a5d53c4000000b0032f7d7ec4adsm1927005wrw.92.2023.11.07.02.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:11:40 -0800 (PST)
Date: Tue, 7 Nov 2023 05:11:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 29/63] tests: bios-tables-test: Add test for smbios type4 core
 count
Message-ID: <148a8a1d5fdbdb0ba2a9883c6182e3135cb417b2.1699351720.git.mst@redhat.com>
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
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
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

From: Zhao Liu <zhao1.liu@intel.com>

This tests the commit 196ea60a734c3 ("hw/smbios: Fix core count in
type4").

In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
cores in the socket is not more than 255, then smbios type4 table
encodes cores per socket into the core count field.

So for the topology in this case, there're the following considerations:
1. cores per socket should be not more than 255 to ensure we could cover
   the core count field.
2. The original bug was that cores per socket was miscalculated, so now
   we should include as many topology levels as possible (mutiple
   sockets & dies, no module since x86 hasn't supported it) to cover
   more general topology scenarios, to ensure that the cores per socket
   encoded in the core count field is correct.

Based on these considerations, select the topology with multiple sockets
and dies:

-smp 54,sockets=2,dies=3,cores=3,threads=3

The expected core count = cores per socket = cores (3) * dies (3) = 9.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20231023094635.1588282-7-zhao1.liu@linux.intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index cdbfb51559..c20f6f73d0 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -999,6 +999,23 @@ static void test_acpi_q35_tcg_type4_count(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_core_count(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".core-count",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
+        .smbios_core_count = 9,
+        .smbios_core_count2 = 9,
+    };
+
+    test_acpi_one("-machine smbios-entry-point-type=64 "
+                  "-smp 54,sockets=2,dies=3,cores=3,threads=3",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_q35_tcg_core_count2(void)
 {
     test_data data = {
@@ -2178,6 +2195,8 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
                 qtest_add_func("acpi/q35/type4-count",
                                test_acpi_q35_tcg_type4_count);
+                qtest_add_func("acpi/q35/core-count",
+                               test_acpi_q35_tcg_core_count);
                 qtest_add_func("acpi/q35/core-count2",
                                test_acpi_q35_tcg_core_count2);
             }
-- 
MST


