Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 126DF7D014F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 20:23:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtXfP-0006SX-Ox; Thu, 19 Oct 2023 14:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXeb-0005hC-W1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qtXea-0000g8-1u
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 14:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697739711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e8B8UMg5FgaD2nE0alqJMY1VMfzRw0D7N1lubTBicmU=;
 b=bBoZ+6ocXQ/24rtZ6SXMU6zhMtzmVNIgEBmjlZuLYdYpKpXFq0ysurO/alwcwxtt+v40oo
 Ya2qQ+IPzSJIsYTtl4uDU023tzGKKsO7M+OZqcVgs0Yd5658roZKgwIWzQSykf2bDb0Qzo
 sZWAjHQP8+J1vCa9vhjUGUVLeC4TYKI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-WAnfMVnTOMiiIfrAsueEUw-1; Thu, 19 Oct 2023 14:21:49 -0400
X-MC-Unique: WAnfMVnTOMiiIfrAsueEUw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4077ee09a4eso34070585e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 11:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697739708; x=1698344508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e8B8UMg5FgaD2nE0alqJMY1VMfzRw0D7N1lubTBicmU=;
 b=v9efjiukb25QxoPqXDNGB2z8VbKg7eWElE9DHOVIi2qR9zPiaGDN/9D7FQGisLSnB9
 B/LxaFlX61vRUTdXuHOIh2gI9tY3+cSIH/8JqsoCKpd8dE+7DmDN6IMLcP3x+1Tr2piL
 WQsGem9OHnbFT/SuTo0hrZlTTMscOAoRCjSrFKx+drHaCpF0CWoBxr4nBxfhQyGyMkke
 vG4t6RaFFVdbBT6EoITgir/icgR3f6+fa2jgEbkb4TlNPA6YeRzqeq8HEVVfhQSuanhv
 vVCOKqsHBSNiFACkP0ihux24Z0SdoIKqYbL1Iqqo7FtgxusXKXE18C9rr6moNZaWpsqI
 ST3w==
X-Gm-Message-State: AOJu0Ywm0m1j5JBbz+S+gQBbRVXlqp/CrWVEYTvQoeNY++e8/EE36bQ1
 wT3V2KD9nFFB0yYMTQXLnURzYyoJC2V5DCmqXakIAq68UoBpEWjZwXUUBbtl6zOOHofb+hC98us
 wECy/4KT8Q9Rg4p4Notb4CALJc6frCKsZp8Iad4Ei6rfQ/3R4grzzEsRkpQAhdxJD2R0P
X-Received: by 2002:a05:600c:46d2:b0:408:4120:bab7 with SMTP id
 q18-20020a05600c46d200b004084120bab7mr2495140wmo.15.1697739708022; 
 Thu, 19 Oct 2023 11:21:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8+xq8MSJ5nTlZ99kuLXNNi2+8gXvHlmMD/AdthpX3/D6ndaMNUl84n5vEl4o/dKi14pvwyg==
X-Received: by 2002:a05:600c:46d2:b0:408:4120:bab7 with SMTP id
 q18-20020a05600c46d200b004084120bab7mr2495124wmo.15.1697739707700; 
 Thu, 19 Oct 2023 11:21:47 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 g38-20020a05600c4ca600b004078d71be9csm4931879wmp.13.2023.10.19.11.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 11:21:47 -0700 (PDT)
Date: Thu, 19 Oct 2023 14:21:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 13/78] tests: bios-tables-test: Add test for smbios type4
 core count
Message-ID: <216cee8e19d7df4b98146affba41e9a8cd2420b8.1697739629.git.mst@redhat.com>
References: <cover.1697739629.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697739629.git.mst@redhat.com>
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


