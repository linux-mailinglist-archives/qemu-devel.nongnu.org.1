Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B57A1F7A
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 15:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh8Ty-0007Xt-4w; Fri, 15 Sep 2023 09:03:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8Tq-0007WE-5g
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qh8Tl-0002iZ-JO
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 09:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694783004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CI31JrmQFxksb36g3xnXkVYMYChreNxQMKc5WYmoZ7o=;
 b=abo7ND1zm08oXL/YuyENC7v8o6N6qxb+BvyyqYClFjeZGdX8cUM4/CkR94wVFcCcLoBqoE
 IILzDYZqfmi4pWRJaSnBYrzJX17YOZjHnw5P5M5DhsRscNn1Hx+epks4O+DmD3AbTZCXQS
 uxBRDeCPwvv/MIdGYRRSmhPTb6gclK0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-HavjA0MwNWCN5LvCD32qmA-1; Fri, 15 Sep 2023 09:03:18 -0400
X-MC-Unique: HavjA0MwNWCN5LvCD32qmA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50076a3fd35so2549636e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 06:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694782991; x=1695387791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CI31JrmQFxksb36g3xnXkVYMYChreNxQMKc5WYmoZ7o=;
 b=fcHyhu9lqr528FOSCF49ghc3IU/1mQfHtwQMZPSpzXj/pIgbsLbrC/ozP4ym+6nxWJ
 01upWe6oLdUw7cibw7oaFK8wftWo/lE5JELen7wrjUGqIpwGOgY47UwQGIzNUKrlx1As
 iT8igHXhW2W0rHGwZSzpgKbMKywWfqQMTHzWf0A8KhZWBU5os8SqokUpfrpkEdm5U3sS
 Uja3dlek4UTIWf2Q/7tHpuwoQI9JujRUs8zEv8SoScO9T1MCN15OkY0JWADFi/J0owYI
 N8LMR8IQ3H6O6r4DsDmJrXQtdewhChe/n3O7m4PhHLh9/hEVdBoMifz7vrvrMfUniImw
 +b2Q==
X-Gm-Message-State: AOJu0YyYMg/C1705FaJNzD0XOi+KQiQYvwsXBbXfjYleZZVuiots4K/s
 QlSIpH1FXrSlQ4exfvOZhIPEC5KCMK94uKJjItqm58jy65RkN1xERnHZsCL9WKSkD+RTtb6dbu9
 HYbu6+rVMPVlIRXw=
X-Received: by 2002:a05:6512:70e:b0:4f9:5426:6622 with SMTP id
 b14-20020a056512070e00b004f954266622mr1337402lfs.69.1694782991346; 
 Fri, 15 Sep 2023 06:03:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzjVoLM6Q+0ObM5XgujrOH45/5zVRmcH5usNs9W0kUe1ydIHS6kcbNi0e9QCfQITutTb7BEw==
X-Received: by 2002:a05:6512:70e:b0:4f9:5426:6622 with SMTP id
 b14-20020a056512070e00b004f954266622mr1337382lfs.69.1694782991034; 
 Fri, 15 Sep 2023 06:03:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 s7-20020a17090699c700b009adcb6c0f0dsm1066574ejn.38.2023.09.15.06.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 06:03:09 -0700 (PDT)
Date: Fri, 15 Sep 2023 15:03:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@linux.intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Zhenyu Wang
 <zhenyu.z.wang@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 06/16] tests: bios-tables-test: Add test for smbios
 type4 core count
Message-ID: <20230915150307.2934b0d4@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230825033619.2075837-7-zhao1.liu@linux.intel.com>
References: <20230825033619.2075837-1-zhao1.liu@linux.intel.com>
 <20230825033619.2075837-7-zhao1.liu@linux.intel.com>
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

On Fri, 25 Aug 2023 11:36:09 +0800
Zhao Liu <zhao1.liu@linux.intel.com> wrote:

> From: Zhao Liu <zhao1.liu@intel.com>
> 
> This tests the commit 196ea60a734c3 ("hw/smbios: Fix core count in
> type4").
> 
> Test the core count field of type4 table for multiple sockets/dies case.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  tests/qtest/bios-tables-test.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 8679255449cf..a35c753a3a00 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -999,6 +999,23 @@ static void test_acpi_q35_tcg_type4_count(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_q35_tcg_core_count(void)
> +{
> +    test_data data = {
> +        .machine = MACHINE_Q35,
> +        .variant = ".core-count",
> +        .required_struct_types = base_required_struct_types,
> +        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types),
> +        .smbios_core_count = 9,
> +        .smbios_core_count2 = 9,
> +    };
> +
> +    test_acpi_one("-machine smbios-entry-point-type=64 "
> +                  "-smp 54,sockets=2,dies=3,cores=3,threads=3",

ditto as for 3/16
It's not obvious why this topology is used and how it correlates to  smbios_core_*
so describe setup in commit message

> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_tcg_core_count2(void)
>  {
>      test_data data = {
> @@ -2166,6 +2183,8 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/q35/kvm/dmar", test_acpi_q35_kvm_dmar);
>                  qtest_add_func("acpi/q35/type4-count",
>                                 test_acpi_q35_tcg_type4_count);
> +                qtest_add_func("acpi/q35/core-count",
> +                               test_acpi_q35_tcg_core_count);
>                  qtest_add_func("acpi/q35/core-count2",
>                                 test_acpi_q35_tcg_core_count2);
>              }


