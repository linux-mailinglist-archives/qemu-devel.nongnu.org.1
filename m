Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F7A81E653
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 10:25:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI3fg-00019i-3i; Tue, 26 Dec 2023 04:24:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fe-00017E-1G
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rI3fc-0008Fc-Fd
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 04:24:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703582655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mT5jS00lY7mc5PDHiaNs4tRIIbDIIgu7me/ZwVh7LTg=;
 b=grnCm7u8fGEyhxFMxZcIzGBt2qosJLW5st3x7NNURO57D74q7g6J/FLRcIHQDDTRGt1NlM
 ZYcC2Lrgeim0WM3jT13gNnam9Ao4lPJ4Vk3h3lEHbcFtGhFKHctrBHdj97SffP8XY4a7ek
 M2sGjsK6HdC5QP+WN3m8KDp45wCvqVA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-sYukVv2wP-qcj5iiGWAzkQ-1; Tue, 26 Dec 2023 04:24:13 -0500
X-MC-Unique: sYukVv2wP-qcj5iiGWAzkQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3368c707b03so3057422f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 01:24:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703582651; x=1704187451;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mT5jS00lY7mc5PDHiaNs4tRIIbDIIgu7me/ZwVh7LTg=;
 b=Ekdvyl4Nh/clHj0NVTWlRc4XefPZylmgWWIUXh/U9OSduxmgLGhrUU+Sf9TvX9/MaI
 w+wY/DA2EKgPFqnIy5nld9llO9X8SSaU1QAQv/CG5JT7YPfYv8Bvyoe+2dLzmFhskTnh
 gSsozg0ynIaFvN+AlzPGJGoBSU1LnFZSrmcxkoenVCwkgZJJsgMyizRDSs4ulzjOcF9a
 O0Y+i4qdt2FDRs1gso1t3CPhDMnA490edGGm94VzSrrYQY7/S1AeoZ5xMl7RO5uwTKft
 07b4CAIqfQdnMRwGvsAGN87qtiN97FLr3mAOUZWNHT0fLSnCo1AdRp5OwRIRGwGKQioJ
 mzzQ==
X-Gm-Message-State: AOJu0YzRiPB1S3ekf95tgWt1ECA5TcvRszgERLOv9fl0oGrRsj/HyZu+
 OwgCJutvzhCJ7Uguc8ajWCMn7oWhmKocd6z2x0een4D9bdc5Oa3aEmOrCBbzKMkrQMV5LHYI9KE
 cK09X512m1t1AXkas2s2Gb0yvCsvjjoXTlcUXQsx6TuwBYHH7JnhfcV8COsGrIG0buj5eT7MZsu
 yK
X-Received: by 2002:a05:600c:548e:b0:40c:336d:2a24 with SMTP id
 iv14-20020a05600c548e00b0040c336d2a24mr4086277wmb.30.1703582651194; 
 Tue, 26 Dec 2023 01:24:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmfJxVq4qu3NdtgqtRdLErZ/f0RC0FMYa0p7RMNAkweJmyV2gbqk++XTcifhQRohu1Zfjvsw==
X-Received: by 2002:a05:600c:548e:b0:40c:336d:2a24 with SMTP id
 iv14-20020a05600c548e00b0040c336d2a24mr4086265wmb.30.1703582650813; 
 Tue, 26 Dec 2023 01:24:10 -0800 (PST)
Received: from redhat.com ([2.55.177.189]) by smtp.gmail.com with ESMTPSA id
 n9-20020a05600c4f8900b0040d56075463sm6630463wmq.44.2023.12.26.01.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 01:24:08 -0800 (PST)
Date: Tue, 26 Dec 2023 04:24:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 02/21] tests: bios-tables-test: Rename smbios type 4 related
 test functions
Message-ID: <c40db4ba60af354cccaddbbae5c7125b4b97c79c.1703582625.git.mst@redhat.com>
References: <cover.1703582625.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1703582625.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

In fact, type4-count, core-count, core-count2, thread-count and
thread-count2 are tested with KVM not TCG.

Rename these test functions to reflect KVM base instead of TCG.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index fe6a9a8563..21811a1ab5 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1015,7 +1015,7 @@ static void test_acpi_q35_tcg(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_type4_count(void)
+static void test_acpi_q35_kvm_type4_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1031,7 +1031,7 @@ static void test_acpi_q35_tcg_type4_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_core_count(void)
+static void test_acpi_q35_kvm_core_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1048,7 +1048,7 @@ static void test_acpi_q35_tcg_core_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_core_count2(void)
+static void test_acpi_q35_kvm_core_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1065,7 +1065,7 @@ static void test_acpi_q35_tcg_core_count2(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_thread_count(void)
+static void test_acpi_q35_kvm_thread_count(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -1082,7 +1082,7 @@ static void test_acpi_q35_tcg_thread_count(void)
     free_test_data(&data);
 }
 
-static void test_acpi_q35_tcg_thread_count2(void)
+static void test_acpi_q35_kvm_thread_count2(void)
 {
     test_data data = {
         .machine = MACHINE_Q35,
@@ -2262,15 +2262,15 @@ int main(int argc, char *argv[])
                 qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
                 qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
                 qtest_add_func("acpi/q35/type4-count",
-                               test_acpi_q35_tcg_type4_count);
+                               test_acpi_q35_kvm_type4_count);
                 qtest_add_func("acpi/q35/core-count",
-                               test_acpi_q35_tcg_core_count);
+                               test_acpi_q35_kvm_core_count);
                 qtest_add_func("acpi/q35/core-count2",
-                               test_acpi_q35_tcg_core_count2);
+                               test_acpi_q35_kvm_core_count2);
                 qtest_add_func("acpi/q35/thread-count",
-                               test_acpi_q35_tcg_thread_count);
+                               test_acpi_q35_kvm_thread_count);
                 qtest_add_func("acpi/q35/thread-count2",
-                               test_acpi_q35_tcg_thread_count2);
+                               test_acpi_q35_kvm_thread_count2);
             }
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
-- 
MST


