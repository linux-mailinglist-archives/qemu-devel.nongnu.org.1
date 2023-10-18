Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F1D7CE22B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt8sb-0001VF-QO; Wed, 18 Oct 2023 11:54:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sa-0001O6-7Y
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qt8sY-0006U2-Is
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 11:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697644478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8B8UMg5FgaD2nE0alqJMY1VMfzRw0D7N1lubTBicmU=;
 b=jJeZ+7PnZ6jHDFOKAKm/5dDJsKAm1c2zVZDQc1f+TgwIMVlQ3fb45U40L39mzdAs3TDyRr
 +oS/dNVbhsFEe87MsQ8xxRdgIthf/BdyWrzzxSif4oqoOVNQcyKa/4Q8T8pRu91SD9VgIw
 8NWFwn/1IOBmKSVGNNwqVornJOUQQak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376--USTYwS0P2WwNp2i2xZ_3w-1; Wed, 18 Oct 2023 11:54:36 -0400
X-MC-Unique: -USTYwS0P2WwNp2i2xZ_3w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40839252e81so7339985e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 08:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697644475; x=1698249275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8B8UMg5FgaD2nE0alqJMY1VMfzRw0D7N1lubTBicmU=;
 b=uSzN6ctJCAEt1AfPXmlKNZVIl2VIQYrGIjaJbRBg+PwNHchGbRzBsPwDXjmIjNVa5/
 JOrEY6WQdUt9+1WUuiKpMoAt0zVsk1wMWpAYesGo68dO0i2xmN7mLpqVGctQ6a9oSl1u
 Ie582ICOJpB7RWqk2me2QMJR8AwFo0gYRyaSiwUNCmwu4AMLAjTgsKkkAx1UDh3Bm1Sy
 6RBf0iWpeTnW5G1cpuRZonfe3sRGJuQoHGR0W4W7+n3GmrSV/f4Sm7fikB0DcvmoipnO
 tArzknaxO4ISs384T4XfFhW9D0iYgzS5eXpfYNuQUXet85ry5NWx3eCArkoK75o2Ru5v
 l0fQ==
X-Gm-Message-State: AOJu0Ywrqyl7aYOsvR4qE2VRQtmKSnZ5OBDgZMq/eVZhuXpXSwWOVN6s
 odaWATYeNXADAAfaVLY7fIZ+r452cXu0gggjMp+qgo3HMvDDXOCs0pj/nG9twtzfYI4R6ny5scr
 c7KibOPwzUayKQVkiIZQ20BiRROHJufp9+FUSILIHxODCH2guKl9dsD3gHXZVnBk4U3ySrmo=
X-Received: by 2002:a05:600c:190e:b0:401:c52c:5ed9 with SMTP id
 j14-20020a05600c190e00b00401c52c5ed9mr4618788wmq.32.1697644475185; 
 Wed, 18 Oct 2023 08:54:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU5H/TvLi3LaLGdItcMFH0JQa6H2+cKVh17m5tlMNI2Nu/v2t2i/w0XUMdOH+iD7ryMrpehw==
X-Received: by 2002:a05:600c:190e:b0:401:c52c:5ed9 with SMTP id
 j14-20020a05600c190e00b00401c52c5ed9mr4618776wmq.32.1697644474927; 
 Wed, 18 Oct 2023 08:54:34 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a05600c459000b00405391f485fsm2017076wmo.41.2023.10.18.08.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:54:34 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:54:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 18/83] tests: bios-tables-test: Add test for smbios type4 core
 count
Message-ID: <91320097ee799a31facb8c6d16efacd4ddc41a3f.1697644299.git.mst@redhat.com>
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
Message-Id: <20230928125943.1816922-7-zhao1.liu@linux.intel.com>
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


