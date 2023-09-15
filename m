Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 827B87A1FD8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8sq-0002ZQ-Mq; Fri, 15 Sep 2023 09:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8sl-0002Z3-67
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8sj-0007tB-Fn
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694784551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Bq+2S1TBjYkEeNo7lBdo+9SJOB7nuAs3XszT9YNhxY=;
 b=fyju3LxnAitlF87PUxOeYOgYAtZv5EY97JAebvW92UHSeMv+mK3Q5BFK4LoYgQRs3+lmBk
 TYOIR/5lqzxOkzW5Id6+UZLPVN15UmrxCKYxpDNglJhJp01eHzRgIJ4iIFGsfTU5a30UT9
 TPpYmC8zWHl7V4a5kcie0NfPuOnK/R8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-gyweKFvmOCyQDvGsdaxkfA-1; Fri, 15 Sep 2023 09:29:10 -0400
X-MC-Unique: gyweKFvmOCyQDvGsdaxkfA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-52f274df255so5104769a12.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694784549; x=1695389349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Bq+2S1TBjYkEeNo7lBdo+9SJOB7nuAs3XszT9YNhxY=;
 b=NOAy8mCsY+ZpVJ3WMUVgP4hcgH3XGI/A26bCJL40MnIWJoykFkPBJBB6bo2tkeXUyW
 6zZbD6iYWke4QxSlnZmsW9FmW9TNpERH6WUrzIpMsiBUuIB5QjoMVjoaL7EfH1BKU/7a
 WWjVcApJaQjK1g8StGcQIAqLRP40uU0AqXaLyKv2tb1Il01ydjYRjHr/vS3gy/q2R9h8
 fR53zpLk4PE0lf6rO6aWMQp5y5pVCSCizYjXRJR38/A2JsJoK5tguDmZUPHBhyOKfIRI
 xm0IwRGJE8Q9jta1pvdbTKGghixEHvB99ddi7/mhJgUtB5zvZCG8d7daEHGTtiEe06RD
 HeLQ==
X-Gm-Message-State: AOJu0Yzju6V7rrL2xJbr0BBQQUT+FqGffdd8RzFFxNCCdFjAvwYzPtzP
 SiFegKBbaT7GQENehEu06cPJn/VR5iLYPk+nZiOxcVl8m6lfxax5xJdeppcEwYYfPiQxiecPPUW
 hJwR9Wjjms8gUEOY=
X-Received: by 2002:a50:ec8c:0:b0:52f:a763:aab4 with SMTP id
 e12-20020a50ec8c000000b0052fa763aab4mr2498191edr.5.1694784549422; 
 Fri, 15 Sep 2023 06:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzdwDSLTwDmQ5DZ1WdwUUnFoBIdUoQO0SNmAzFhdyWY4shM9nYxoNDF2XMTxJR8SEBbYv7uA==
X-Received: by 2002:a50:ec8c:0:b0:52f:a763:aab4 with SMTP id
 e12-20020a50ec8c000000b0052fa763aab4mr2498163edr.5.1694784549121; 
 Fri, 15 Sep 2023 06:29:09 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 v16-20020aa7d9d0000000b0052f3471ccf6sm2304003eds.6.2023.09.15.06.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:29:08 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:29:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 15/16] tests: bios-tables-test: Add test for smbios
 type4 thread count2
Message-ID: <20230915152907.4b6e63bc@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-16-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-16-zhao1.liu@linux.intel.com>
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

On Fri, 25 Aug 2023 11:36:18 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> type4").
> 
> Add this test to cover 2 cases:
> 1. Test thread count2 field with multiple sockets and multiple dies to
>    confirm this field could correctly calculate threads per sockets.
> 
> 2. Confirm that field calculation could correctly recognize the
>    difference between "-smp maxcpus" and "-smp cpus".
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  tests/qtest/bios-tables-test.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 26474d376633..1b0c27e95d26 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -96,6 +96,7 @@ typedef struct {
>      uint8_t smbios_core_count;
>      uint16_t smbios_core_count2;
>      uint8_t smbios_thread_count;
> +    uint16_t smbios_thread_count2;
>      uint8_t *required_struct_types;
>      int required_struct_types_len;
>      int type4_count;
> @@ -644,6 +645,7 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>      uint8_t thread_count, expected_thread_count = data->smbios_thread_count;
>      uint16_t speed, expected_speed[2];
>      uint16_t core_count2, expected_core_count2 = data->smbios_core_count2;
> +    uint16_t thread_count2, expected_thread_count2 = data->smbios_thread_count2;
>      int offset[2];
>      int i;
>  
> @@ -673,6 +675,8 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>      }
>  
>      if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> +        uint64_t thread_count2_addr;
> +
>          core_count2 = qtest_readw(data->qts,
>                            addr + offsetof(struct smbios_type_4, core_count2));
>  
> @@ -680,6 +684,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>          if (expected_core_count == 0xFF && expected_core_count2) {
>              g_assert_cmpuint(core_count2, ==, expected_core_count2);
>          }
> +
> +        thread_count2_addr = addr +
> +                             offsetof(struct smbios_type_4, thread_count2);
> +        thread_count2 = qtest_readw(data->qts, thread_count2_addr);

I'd mimic the same code style as used for core_count2 and avoid introducing an extra variable

> +
> +        /* Thread Count has reached its limit, checking Thread Count 2 */
> +        if (expected_thread_count == 0xFF && expected_thread_count2) {
> +            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
> +        }
>      }
>  }
>  
> @@ -1050,6 +1063,7 @@ static void test_acpi_q35_tcg_thread_count(void)
>          .required_struct_types = base_required_struct_types,
>          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
>          .smbios_thread_count = 27,
> +        .smbios_thread_count2 = 27,
>      };
>  
>      test_acpi_one("-machine smbios-entry-point-type=64 "
> @@ -1058,6 +1072,23 @@ static void test_acpi_q35_tcg_thread_count(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_thread_count2(void)
> +{
> +    test_data data = {
> +        .machine = MACHINE_Q35,
> +        .variant = ".thread-count2",
> +        .required_struct_types = base_required_struct_types,
> +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> +        .smbios_thread_count = 0xFF,
> +        .smbios_thread_count2 = 260,
> +    };
> +
> +    test_acpi_one("-machine smbios-entry-point-type=64 "
> +                  "-smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2",
> +                  &data);

explain in commit message why abive -smp == 
  > +        .smbios_thread_count = 0xFF,
  > +        .smbios_thread_count2 = 260,


> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg_bridge(void)
>  {
>      test_data data = {};
> @@ -2216,6 +2247,8 @@ int main(int argc, char *argv[])
>                                 test_acpi_q35_tcg_core_count2);
>                  qtest_add_func("acpi/q35/thread-count",
>                                 test_acpi_q35_tcg_thread_count);
> +                qtest_add_func("acpi/q35/thread-count2",
> +                               test_acpi_q35_tcg_thread_count2);
>              }
>              qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
>  #ifdef CONFIG_POSIX


