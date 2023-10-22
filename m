Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3967D220B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUb2-0005uc-6R; Sun, 22 Oct 2023 05:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUb0-0005uQ-HC
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1quUar-0007ta-Jq
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697966275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z8lxIkuablBdzZ/CaufIGL1l59UM/GiHJJkiaViTTPA=;
 b=D4Mv2Bo3+dx1gRaI/B1NoI8rZpRmgqwCRRCCh2YK31hBx5umtyxBTGHo1NItHMYPzWIqID
 1jvKCo1lYHdWosqnkfFrKgJzqUleGXkcHr6d32yiYz4JvUjror7eoMB6Aecy06j0S7PRQ5
 7NSDWblXHYUrAxyMxhXmuQB/f7iJv2M=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-s55e1usDOMC21ISCskZJRg-1; Sun, 22 Oct 2023 05:17:37 -0400
X-MC-Unique: s55e1usDOMC21ISCskZJRg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c53ea92642so19255401fa.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697966256; x=1698571056;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8lxIkuablBdzZ/CaufIGL1l59UM/GiHJJkiaViTTPA=;
 b=aLktJQ0tL1n1IUsiPSNcPEwlVnlzeBJgOat351ZYfgdfsl7JUZ5qA+fMdtHYHsqVi+
 mvVqu4aU4E6XwUicYIp5R39bbrNgno9yaCM2jv0O9UIKzPnx5OcDd62zrCR6d9Sulfpg
 1D+1vePxfKFgWTqVqOHWmIvJURPST768ryp2mooPWwAwejOtH4GQI84gBhlPhvEHrCTC
 6/AeelI/R4Jtr5M1WKbJO/P/Jc3riiH9C9tH88lkzsGF2x6cLnx8BSZDBsD4Q9l5Y7JD
 XqGMf6TmCy7YdS1dI7msb+HILG0lYy7dJKK1LHRyWTCt2GRvqkwKUAtFbVXkiKiUlOr3
 U8qQ==
X-Gm-Message-State: AOJu0Yz2P3pqoGoIxz+tVgGocPo2M+XHwbFw17XT7YNsZxRizui9dki5
 aRR/OkligGI3p2qWhor3x6kvGMSdhjqLYUlHGYtlDxKG45p/Il4UfjTe7oKxEPwX22LfdyAaSDj
 BGKOq1XSXiPNPCjU=
X-Received: by 2002:ac2:5183:0:b0:507:ce49:81ba with SMTP id
 u3-20020ac25183000000b00507ce4981bamr3573104lfi.67.1697966256439; 
 Sun, 22 Oct 2023 02:17:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCgVOE7KKK0oTsopYeVXUoFmack3dvNm/EpaoNiy9UawCwV5odhKQmWpf/+ejFuSomRmtXaQ==
X-Received: by 2002:ac2:5183:0:b0:507:ce49:81ba with SMTP id
 u3-20020ac25183000000b00507ce4981bamr3573083lfi.67.1697966255601; 
 Sun, 22 Oct 2023 02:17:35 -0700 (PDT)
Received: from redhat.com ([2.52.1.53]) by smtp.gmail.com with ESMTPSA id
 f5-20020a056000128500b0032179c4a46dsm5233414wrx.100.2023.10.22.02.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:17:34 -0700 (PDT)
Date: Sun, 22 Oct 2023 05:17:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v2 15/16] tests: bios-tables-test: Add test for smbios
 type4 thread count2
Message-ID: <20231022051520-mutt-send-email-mst@kernel.org>
References: <20230928125943.1816922-1-zhao1.liu@linux.intel.com>
 <20230928125943.1816922-16-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928125943.1816922-16-zhao1.liu@linux.intel.com>
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

On Thu, Sep 28, 2023 at 08:59:42PM +0800, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> This tests the commit 7298fd7de5551 ("hw/smbios: Fix thread count in
> type4").
> 
> In smbios_build_type_4_table() (hw/smbios/smbios.c), if the number of
> threads in the socket is more than 255, then smbios type4 table encodes
> threads per socket into the thread count2 field.
> 
> So for the topology in this case, there're the following considerations:
> 1. threads per socket should be more than 255 to ensure we could cover
>    the thread count2 field.
> 2. The original bug was that threads per socket was miscalculated, so
>    now we should configure as many topology levels as possible (mutiple
>    sockets & dies, no module since x86 hasn't supported it) to cover
>    more general topology scenarios, to ensure that the threads per
>    socket encoded in the thread count2 field is correct.
> 3. For the more general topology, we should also add "cpus" (presented
>    threads for machine) and "maxcpus" (total threads for machine) to
>    make sure that configuring unpluged CPUs in smp (cpus < maxcpus)
>    does not affect the correctness of threads per socket for thread
>    count2 field.
> 
> Based on these considerations, select the topology as the follow:
> 
> -smp cpus=210,maxcpus=520,sockets=2,dies=2,cores=65,threads=2
> 
> The expected thread count2 = threads per socket = threads (2)
> * cores (65) * dies (2) = 260.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

There's a problem here: not all hosts support such high
number of vCPUs.
Number of hotpluggable cpus requested (520) exceeds the maximum cpus
supported by KVM (288)
socket_accept failed: Resource temporarily unavailable
**

Dropped for now pls come up with a solution.


> ---
> Changes since v1:
>  * Dropped the extra variable: uint64_t thread_count2_addr. (Igor)
>  * Added description of the consideration for topology selection of this
>    case in commit message. (Igor)
> ---
>  tests/qtest/bios-tables-test.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index f8e3e349e09f..58119d8979c6 100644
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
> @@ -680,6 +682,15 @@ static void smbios_cpu_test(test_data *data, uint32_t addr,
>          if (expected_core_count == 0xFF && expected_core_count2) {
>              g_assert_cmpuint(core_count2, ==, expected_core_count2);
>          }
> +
> +        thread_count2 = qtest_readw(data->qts,
> +                            addr + offsetof(struct smbios_type_4,
> +                            thread_count2));
> +
> +        /* Thread Count has reached its limit, checking Thread Count 2 */
> +        if (expected_thread_count == 0xFF && expected_thread_count2) {
> +            g_assert_cmpuint(thread_count2, ==, expected_thread_count2);
> +        }
>      }
>  }
>  
> @@ -1050,6 +1061,7 @@ static void test_acpi_q35_tcg_thread_count(void)
>          .required_struct_types = base_required_struct_types,
>          .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
>          .smbios_thread_count = 27,
> +        .smbios_thread_count2 = 27,
>      };
>  
>      test_acpi_one("-machine smbios-entry-point-type=64 "
> @@ -1058,6 +1070,23 @@ static void test_acpi_q35_tcg_thread_count(void)
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
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg_bridge(void)
>  {
>      test_data data = {};
> @@ -2216,6 +2245,8 @@ int main(int argc, char *argv[])
>                                 test_acpi_q35_tcg_core_count2);
>                  qtest_add_func("acpi/q35/thread-count",
>                                 test_acpi_q35_tcg_thread_count);
> +                qtest_add_func("acpi/q35/thread-count2",
> +                               test_acpi_q35_tcg_thread_count2);
>              }
>              if (qtest_has_device("virtio-iommu-pci")) {
>                  qtest_add_func("acpi/q35/viot", test_acpi_q35_viot);
> -- 
> 2.34.1


