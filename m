Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DACD7A1FB1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:20:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8j4-0006mw-Rd; Fri, 15 Sep 2023 09:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8j2-0006ml-J6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8iz-0006Fs-1E
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694783947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6gQHPk57StmXBjGLfvBAUoJ00fzR4wFyHOsQBHTfvs=;
 b=ftMF0z0WafiZOP86pmtRIB2y182hZ15NzCXUfX8/QB3o9HiNHlOP5rlz6Gi0pL6o4SgXOQ
 C/fn3cl4kObAjRwxLtHW/8bRNKrlF2Aet4g2S40wMwjxnS+nUpiESs6qUc7JEhKFSxjVSo
 p5AP3LLvOCmZ5JosegY2JIst3hjct2s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-J_VL_MijMJSFPNRNHzWs0Q-1; Fri, 15 Sep 2023 09:19:06 -0400
X-MC-Unique: J_VL_MijMJSFPNRNHzWs0Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4011fa32e99so16179105e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694783945; x=1695388745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6gQHPk57StmXBjGLfvBAUoJ00fzR4wFyHOsQBHTfvs=;
 b=C4FP9MWh7L1NTPL/TKAjRRoDX7CVTjrdspwctrm153jFgvJrJ3nWWi8+4KstFt03uR
 v9ajfyTFykkR4tfZI7O+A7N5DvJGEkWbVisn/G9CaAeU/nwMiHfbvlNBjTItzB6zLO5p
 WWoqjJoTTEk8wvSMo934rlF/i4D4GOOj5OQBN6nlm9ZOazTOC/gYJ2jT5b/ibFdRxH80
 A3l9DSz2axzdhZgKvUiCRVqtNLQvsSDnZ/haPMV9sFcSS+xGS+L+J7l1gN7MhTjoSWKI
 hwf8ux0El9VppRV9xug8gbqUbuyH+wjWU+bYOnrtaUK6zD7PI1ZFHB10kGEsFwufgWLl
 7Qvw==
X-Gm-Message-State: AOJu0Yz0XXQURw8JXNpRFQrULrDSka1pJ6vmZIW57ffLqZxHe5pvq5VS
 H5GEMo5vRVoCXjMBfhlIecfw1Ot3KXofE1acvMuOEfyjiyh04tFqtLrmDb3lWdpge5SqD25U5tR
 40GwdrCPPInPxYaM=
X-Received: by 2002:adf:eccc:0:b0:316:efb9:ffa with SMTP id
 s12-20020adfeccc000000b00316efb90ffamr1402886wro.35.1694783944878; 
 Fri, 15 Sep 2023 06:19:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5BK4RN2S3vX5Zjwfy7elWo+MEZfi1BNmt5O9n+Z+2RZAEyE2JcIJu5mhh+7o2XT1Q+KW7HA==
X-Received: by 2002:adf:eccc:0:b0:316:efb9:ffa with SMTP id
 s12-20020adfeccc000000b00316efb90ffamr1402873wro.35.1694783944512; 
 Fri, 15 Sep 2023 06:19:04 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 e9-20020aa7d7c9000000b0050488d1d376sm2281606eds.0.2023.09.15.06.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:19:03 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:19:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 12/16] tests: bios-tables-test: Add test for smbios
 type4 thread count
Message-ID: <20230915151902.12e4cf1b@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-13-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-13-zhao1.liu@linux.intel.com>
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

On Fri, 25 Aug 2023 11:36:15 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> type4").
> 
> Add this test to cover 2 cases:
> 1. Test thread count field with multiple sockets and multiple dies to
>    confirm this field could correctly calculate threads per sockets.
> 
> 2. Confirm that field calculation could correctly recognize the
>    difference between "-smp maxcpus" and "-smp cpus".
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

PS:
add to commit message an explanation how -smp maps into
smbios_thread_count

> ---
>  tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 8cba1d8126f2..26474d376633 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -95,6 +95,7 @@ typedef struct {
>      uint16_t smbios_cpu_curr_speed;
>      uint8_t smbios_core_count;
>      uint16_t smbios_core_count2;
> +    uint8_t smbios_thread_count;
>      uint8_t *required_struct_types;
>      int required_struct_types_len;
>      int type4_count;
> @@ -640,6 +641,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>                              SmbiosEntryPointType ep_type)
>  {
>      uint8_t core_count, expected_core_count = data->smbios_core_count;
> +    uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
>      uint16_t speed, expected_speed[2];
>      uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
>      int offset[2];
> @@ -663,6 +665,13 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>          g_assert_cmpuint(core_count, ==, expected_core_count);
>      }
>  
> +    thread_count = qtest_readb(data->qts,
> +                       addr + offsetof(struct smbios_type_4, thread_count));
> +
> +    if (expected_thread_count) {
> +        g_assert_cmpuint(thread_count, ==, expected_thread_count);
> +    }
> +
>      if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          core_count2 = qtest_readw(data->qts,
>                            addr + offsetof(struct smbios_type_4, core_count2));
> @@ -1033,6 +1042,22 @@ static void test_acpi_q35_tcg_core_count2(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_thread_count(void)
> +{
> +    test_data data = {
> +        .machine = MACHINE_Q35,
> +        .variant = ".thread-count",
> +        .required_struct_types = base_required_struct_types,
> +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> +        .smbios_thread_count = 27,
> +    };
> +
> +    test_acpi_one("-machine smbios-entry-point-type=64 "
> +                  "-smp cpus=15,maxcpus=54,sockets=2,dies=3,cores=3,threads=3",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg_bridge(void)
>  {
>      test_data data = {};
> @@ -2189,6 +2214,8 @@ int main(int argc, char *argv[])
>                                 test_acpi_q35_tcg_core_count);
>                  qtest_add_func("acpi/q35/core-count2",
>                                 test_acpi_q35_tcg_core_count2);
> +                qtest_add_func("acpi/q35/thread-count",
> +                               test_acpi_q35_tcg_thread_count);
>              }
>              qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
>  #ifdef CONFIG_POSIX


