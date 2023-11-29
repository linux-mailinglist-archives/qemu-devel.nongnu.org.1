Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BBE7FD3A0
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 11:11:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8HVS-0000An-TB; Wed, 29 Nov 2023 05:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8HVR-0000Af-42
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 05:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r8HVL-00043d-NY
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 05:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701252554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZkKWpTtBdKIXYZquT5PGOdUzD9eB0G5s9HEBm/gqFo=;
 b=hCuuidiDQxsFomY5Kmj/kNq+r4tQvCl70Hv8/HMtKlKG8PE1R/sfvv5ubv3FpSH13czNRX
 mn2LGFLQCBsJE0rOwlrZuQ9CUZ7qG8cFIknk5lWRNjpDFOD1AQ7dinqhP9EAXPxdqZG11z
 Ad+1IynR2OVW3EN88Y8JZ4b1Q+32zWs=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-KJyoIVeOOXi1uwpQruxE-g-1; Wed, 29 Nov 2023 05:09:13 -0500
X-MC-Unique: KJyoIVeOOXi1uwpQruxE-g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a114f099bebso221003766b.2
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 02:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701252552; x=1701857352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZkKWpTtBdKIXYZquT5PGOdUzD9eB0G5s9HEBm/gqFo=;
 b=o12E0O8lnBXM5wCJWH18Vs46mJgP5yWuumvHRSis5sm8Q2iNHCsn0OQaQDMOTrS9YI
 aaBg5AaJyKa3mVFuITChpxmyjzGENB/J7RK66UmzyGG6YJNRtfwqT+G+9X+nnkhN+0qo
 WZXpUTjXul6CpIHCfTybgzypsWwFg7JrIKAd6nud9Xesf3Yt4H8tUwLJK9AE6RHiZWbK
 g7M5aocX2ZbDgLkYse42HzuKBxMGPkRtKG7fT/Zf7/L6rbuga15p3HGr9U81Miptiz75
 repOF71czx9v6051o39/Np1DFJWYPsGu4sEG00p7nb9bZHzwEzfSNQwEiz52KHNvxzYv
 nDnQ==
X-Gm-Message-State: AOJu0Ywiqs/ARm3rZyYPXBm49pNDuOcjJt/wyf7g02QDLVOZNY+n7JYJ
 8i4bEc4lh17AVC6UQ1qgnOEOf1H9hSXt+b406zN12aZWWvP89jmkZG4R0UVW3DebS9m7iwPWmhB
 sC8Ic8Ihu2r71DkI=
X-Received: by 2002:a17:906:eb53:b0:a02:3f1e:59e6 with SMTP id
 mc19-20020a170906eb5300b00a023f1e59e6mr12396378ejb.71.1701252552102; 
 Wed, 29 Nov 2023 02:09:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1jCjM/Pp6FRxEukxdH3H9DK9qrTBt9O9Tv0bsOULGF6IoZ5VjKcTBqqAoiTMhLw3UldvmLw==
X-Received: by 2002:a17:906:eb53:b0:a02:3f1e:59e6 with SMTP id
 mc19-20020a170906eb5300b00a023f1e59e6mr12396361ejb.71.1701252551795; 
 Wed, 29 Nov 2023 02:09:11 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 3-20020a170906018300b00a0a8b2b74ddsm5704796ejb.154.2023.11.29.02.09.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 02:09:11 -0800 (PST)
Date: Wed, 29 Nov 2023 11:09:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] tests: bios-tables-test: Rename smbios type 4 related
 test functions
Message-ID: <20231129110910.34df85a2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
References: <20231127160202.1037290-1-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

On Tue, 28 Nov 2023 00:02:02 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> In fact, type4-count, core-count, core-count2, thread-count and
> thread-count2 are tested with KVM not TCG.
> 
> Rename these test functions to reflect KVM base instead of TCG.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 71af5cf69fc5..9a7e459e8ffb 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1003,7 +1003,7 @@ static void test_acpi_q35_tcg(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_q35_tcg_type4_count(void)
> +static void test_acpi_q35_kvm_type4_count(void)
>  {
>      test_data data = {
>          .machine = MACHINE_Q35,
> @@ -1019,7 +1019,7 @@ static void test_acpi_q35_tcg_type4_count(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_q35_tcg_core_count(void)
> +static void test_acpi_q35_kvm_core_count(void)
>  {
>      test_data data = {
>          .machine = MACHINE_Q35,
> @@ -1036,7 +1036,7 @@ static void test_acpi_q35_tcg_core_count(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_q35_tcg_core_count2(void)
> +static void test_acpi_q35_kvm_core_count2(void)
>  {
>      test_data data = {
>          .machine = MACHINE_Q35,
> @@ -1053,7 +1053,7 @@ static void test_acpi_q35_tcg_core_count2(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_q35_tcg_thread_count(void)
> +static void test_acpi_q35_kvm_thread_count(void)
>  {
>      test_data data = {
>          .machine = MACHINE_Q35,
> @@ -1070,7 +1070,7 @@ static void test_acpi_q35_tcg_thread_count(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_q35_tcg_thread_count2(void)
> +static void test_acpi_q35_kvm_thread_count2(void)
>  {
>      test_data data = {
>          .machine = MACHINE_Q35,
> @@ -2250,15 +2250,15 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
>                  qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
>                  qtest_add_func("acpi/q35/type4-count",
> -                               test_acpi_q35_tcg_type4_count);
> +                               test_acpi_q35_kvm_type4_count);
>                  qtest_add_func("acpi/q35/core-count",
> -                               test_acpi_q35_tcg_core_count);
> +                               test_acpi_q35_kvm_core_count);
>                  qtest_add_func("acpi/q35/core-count2",
> -                               test_acpi_q35_tcg_core_count2);
> +                               test_acpi_q35_kvm_core_count2);
>                  qtest_add_func("acpi/q35/thread-count",
> -                               test_acpi_q35_tcg_thread_count);
> +                               test_acpi_q35_kvm_thread_count);
>                  qtest_add_func("acpi/q35/thread-count2",
> -                               test_acpi_q35_tcg_thread_count2);
> +                               test_acpi_q35_kvm_thread_count2);
>              }
>              if (qtest_has_device("virtio-iommu-pci")) {
>                  qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);


