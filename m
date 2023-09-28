Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D8B7B1068
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:38:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfxA-00050v-Vd; Wed, 27 Sep 2023 21:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfx8-00050g-FK
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfx7-0003Gl-2t
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695864987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yd6hFstXCvS7L9LdWl4WKlufmHJf10wiKwAN4rDTzdw=;
 b=LVa5+o+62khIx4niqVVzIlnhhu87BKB488rFenDf70WVi129Sp1DZi/P1h8VwC57mbyCzX
 3vCSgWOh1YX7vhw5/hagtrBLrH1SXYnxtFeet9LlqriaaKHKsK0Nmy6qq4OkUSoz6kbRuV
 M16KJlt9tWh1UGT+YrglHOEHQr4nQN0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-57c332rcNbCEl7z6uolvGQ-1; Wed, 27 Sep 2023 21:36:26 -0400
X-MC-Unique: 57c332rcNbCEl7z6uolvGQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b107812f0so128362146d6.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 18:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695864985; x=1696469785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yd6hFstXCvS7L9LdWl4WKlufmHJf10wiKwAN4rDTzdw=;
 b=lUGuWkRlnWpJC3lUtcEZf3h5edUIgs/n52a8T9IAVfRXojMOE6bFV+KE9W2R5u3eT1
 hsbea9hvqgG6ivfOzOIvk+UC/VmuYbchLtxyIocNpuIuWJvYezQi6sMWgm/YeO++hiMy
 5FuABMoTG5Vi+Zq6y01/p9P+XWP8HTs3bZupYyspWxPs4YYq/Va4DNxmdeMx/LzwdgAO
 5Jv3RgMls85+Pb/ZMucHGrlxMXFl1JqKlUAmQo1D2cU0zhdSXtjGT8owIaEV7HdHW0FA
 EWzVO1oMu4peV8oTk4A5SbiPWxmYXqoMEjODPWKC9u+pQ+8Jg1BZ9+FsWIzHk/ybLwY4
 CxVQ==
X-Gm-Message-State: AOJu0YyUKMDf2svXQ0ld+86XPzu4qHC2QuOEUgQoKcFCskyahPqrFAMe
 BnF16EM4SzKSdlgDYXVTFotoRJWpLcvSPPYJN/Wo2wDD31G9CpnU2zbPyC4vN7ntbBp28pJ0y5Z
 YJSbik47ubeZMOqM=
X-Received: by 2002:a0c:9c8f:0:b0:656:5535:ef27 with SMTP id
 i15-20020a0c9c8f000000b006565535ef27mr3616490qvf.48.1695864985508; 
 Wed, 27 Sep 2023 18:36:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbbkVhonZAKlnsttYX1r+HqXHtuGnq0NSVq0mseeeHvGTNW4uDVgDOpMrNTUPtA+gmQ5U+sg==
X-Received: by 2002:a0c:9c8f:0:b0:656:5535:ef27 with SMTP id
 i15-20020a0c9c8f000000b006565535ef27mr3616470qvf.48.1695864985241; 
 Wed, 27 Sep 2023 18:36:25 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 fk14-20020a056a003a8e00b00686b649cdd0sm1743984pfb.86.2023.09.27.18.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 18:36:24 -0700 (PDT)
Message-ID: <832342cb-74bc-58dd-c5d7-6f995baeb0f2@redhat.com>
Date: Thu, 28 Sep 2023 11:36:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 17/37] arm/virt/acpi: Build CPUs AML with CPU
 Hotplug support
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, rafael@kernel.org, borntraeger@linux.ibm.com,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-18-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-18-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Salil,

On 9/26/23 20:04, Salil Mehta wrote:
> Support of vCPU Hotplug requires sequence of ACPI handshakes between Qemu and
> Guest kernel when a vCPU is plugged or unplugged. Most of the AML code to
> support these handshakes already exists. This AML need to be build during VM
> init for ARM architecture as well if the GED support exists.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt-acpi-build.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 6b674231c2..d27df5030e 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -858,7 +858,18 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>        * the RTC ACPI device at all when using UEFI.
>        */
>       scope = aml_scope("\\_SB");
> -    acpi_dsdt_add_cpus(scope, vms);
> +    /* if GED is enabled then cpus AML shall be added as part build_cpus_aml */
> +    if (vms->acpi_dev) {
> +        CPUHotplugFeatures opts = {
> +             .acpi_1_compatible = false,
> +             .has_legacy_cphp = false
> +        };
> +
> +        build_cpus_aml(scope, ms, opts, memmap[VIRT_CPUHP_ACPI].base,
> +                       "\\_SB", NULL, AML_SYSTEM_MEMORY);
> +    } else {
> +        acpi_dsdt_add_cpus(scope, vms);
> +    }
>       acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
>                          (irqmap[VIRT_UART] + ARM_SPI_BASE));
>       if (vmc->acpi_expose_flash) {

I don't think it's enough to check vms->acpi_dev. vCPU hotplug needn't to be
supported even vms->acpi_dev exists. For example when vGICv2 instead of
vGICv3 is enabled, and so on.

Thanks,
Gavin


