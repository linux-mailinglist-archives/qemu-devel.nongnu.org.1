Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1A47A1F49
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:55:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8LM-0001h5-F3; Fri, 15 Sep 2023 08:54:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8LJ-0001gp-Mb
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8LG-0000Dl-3C
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694782476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4bF/uF8NsmIwjAsrL4ZkBoM7Z0nvO7gveXnYFzGT+mA=;
 b=dJU3EFMugp9QWfxV8I083zXyhaavNz2dfXQhthYL7zASXMenvByzV7VrhGRP/AzRN8oLa2
 i149SNjBJtxDE92GLAAx732UAoQw0AV6FAz1W8Nd2dYlRKN2Ip1VGRRzbCJlP1wx96Q+7s
 /J12iyweMmeymyKplUs7c2DRcYypSoQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yCuats6APi-ptGTJ12lZ5A-1; Fri, 15 Sep 2023 08:54:35 -0400
X-MC-Unique: yCuats6APi-ptGTJ12lZ5A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31aef28315eso1430539f8f.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782474; x=1695387274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bF/uF8NsmIwjAsrL4ZkBoM7Z0nvO7gveXnYFzGT+mA=;
 b=GMfr1zziiIGmKOe+lnMCunXRkSHjPWHEIBArhAlgcK4TTNq9K8Dxa97mfkqXdz2e4X
 UKbfFPjG8UkLNsXi/VtyCyNQjP1fdrXS5EEtuDMz5+lWWNTX6jCOqlL29F0rdREat+df
 LZyoazXZOF/Av77N29E8H+crupINGBgtXBmPGB0k0cFBqGxLFvt++lf2qCy/nJBeMnCg
 27bplpmVi9hHBfabBDWlcT+8djPBTqv7zw93QtQDq3ns+M9XS9kBsPgfZhNY8zo4FIl2
 zFZc8JqEuCpoPZYt2Pd/zfka4t/mf2W1RiU/+pQ3Ur6ziZ7Onq/XHztqBx2Wv43aBhOq
 Rs4w==
X-Gm-Message-State: AOJu0YzfQbuGVCDvF1uCu8tej6D02j7LD7ZfAo0aKNEkWKgYUMCseJYu
 C4NDtkCvGK93Dk9N3degzifMqB1lxcJ01JXzU6IZrHklhd+Zkec2XvaIynwU339j5VndP2FMmOL
 xuY8G8+n59piQmzA=
X-Received: by 2002:adf:e24d:0:b0:31f:a682:d27f with SMTP id
 bl13-20020adfe24d000000b0031fa682d27fmr1259983wrb.67.1694782473986; 
 Fri, 15 Sep 2023 05:54:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgtzPHUttTokU8xqQEaLa9kGzX2Q1AYD4pWVprQo3p6gE0lwc3bQxDGCgPa3cjNXBp3tT3LQ==
X-Received: by 2002:adf:e24d:0:b0:31f:a682:d27f with SMTP id
 bl13-20020adfe24d000000b0031fa682d27fmr1259966wrb.67.1694782473553; 
 Fri, 15 Sep 2023 05:54:33 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f23-20020a056402151700b0052fa02d8efdsm2253744edw.39.2023.09.15.05.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 05:54:33 -0700 (PDT)
Date: Fri, 15 Sep 2023 14:54:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 03/16] tests: bios-tables-test: Add test for smbios
 type4 count
Message-ID: <20230915145432.79d27d83@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-4-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-4-zhao1.liu@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 25 Aug 2023 11:36:06 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> This tests the commit d79a284a44bb7 ("hw/smbios: Fix smbios_smp_sockets
> calculation").
> 
> Test the count of type4 tables for multiple sockets case.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  tests/qtest/bios-tables-test.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 47ba20b9579b..8679255449cf 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -97,6 +97,7 @@ typedef struct {
>      uint16_t smbios_core_count2;
>      uint8_t *required_struct_types;
>      int required_struct_types_len;
> +    int type4_count;
>      QTestState *qts;
>  } test_data;
>  
> @@ -673,12 +674,21 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>      }
>  }
>  
> +static void smbios_type4_count_test(test_data *data, int type4_count)
> +{
> +    int expected_type4_count = data->type4_count;
> +
> +    if (expected_type4_count) {
> +        g_assert_cmpuint(type4_count, ==, expected_type4_count);
> +    }
> +}
> +
>  static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
>  {
>      DECLARE_BITMAP(struct_bitmap, SMBIOS_MAX_TYPE+1) = { 0 };
>  
>      SmbiosEntryPoint *ep_table = &data->smbios_ep_table;
> -    int i = 0, len, max_len = 0;
> +    int i = 0, len, max_len = 0, type4_count = 0;
>      uint8_t type, prv, crt;
>      uint64_t addr;
>  
> @@ -704,6 +714,7 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
>  
>          if (type == 4) {
>              smbios_cpu_test(data, addr, ep_type);
> +            type4_count++;
>          }
>  
>          /* seek to end of unformatted string area of this struct ("\0\0") */
> @@ -747,6 +758,8 @@ static void test_smbios_structs(test_data *data, SmbiosEntryPointType ep_type)
>      for (i = 0; i < data->required_struct_types_len; i++) {
>          g_assert(test_bit(data->required_struct_types[i], struct_bitmap));
>      }
> +
> +    smbios_type4_count_test(data, type4_count);
>  }
>  
>  static void test_acpi_load_tables(test_data *data)
> @@ -970,6 +983,22 @@ static void test_acpi_q35_tcg(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_type4_count(void)
> +{
> +    test_data data = {
> +        .machine = MACHINE_Q35,
> +        .variant = ".type4-count",
> +        .required_struct_types = base_required_struct_types,
> +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> +        .type4_count = 5,
> +    };
> +
> +    test_acpi_one("-machine smbios-entry-point-type=64 "
> +                  "-smp cpus=100,maxcpus=120,sockets=5,"
> +                  "dies=2,cores=4,threads=3", &data);

I'd add to commit message an explanation why above topology was picked up

> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg_core_count2(void)
>  {
>      test_data data = {
> @@ -2135,6 +2164,8 @@ int main(int argc, char *argv[])
>              if (has_kvm) {
>                  qtest_add_func("acpi/q35/kvm/xapic", test_acpi_q35_kvm_xapic);
>                  qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
> +                qtest_add_func("acpi/q35/type4-count",
> +                               test_acpi_q35_tcg_type4_count);
>                  qtest_add_func("acpi/q35/core-count2",
>                                 test_acpi_q35_tcg_core_count2);
>              }


