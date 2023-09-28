Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535F47B1038
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 03:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlfW1-0004s5-PX; Wed, 27 Sep 2023 21:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfVz-0004rs-V7
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlfVy-0001vo-DF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 21:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695863305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e63qvRPH057Klm0EneSQ47/qz7x6enkUS5KEkV9Db78=;
 b=GVhcdDgR4J0up6O0zReO+9HWfNCa75N8OAqS4VHf1ikpEE9FAtls1t1vVAbISB3KrvVFL5
 eB+sOLQNYgnFr3CYus+ZOIFPPCa9QlJKzf7yZnno53Nkp7xLbX0n/7V52x4b0ToIzoSWu8
 D7BiOuJ11+dBSJJMy0c1vVgjriOqwOk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-HHXatET0Mq2fv4afr7PrGw-1; Wed, 27 Sep 2023 21:08:24 -0400
X-MC-Unique: HHXatET0Mq2fv4afr7PrGw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1c6181dacf6so110723585ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 18:08:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695863303; x=1696468103;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e63qvRPH057Klm0EneSQ47/qz7x6enkUS5KEkV9Db78=;
 b=Oj1yyy++RvgZOsLCeW8kmJZuPi5cmKR+pLtU+qZ7aSe54slO6BSLmbOmeNbTnoO/Lv
 VPHPsNqh9V/YbRkVNRMBg3IXWDiyRj0svzw7zfzO2LiD9QVpjLsq9DEsyePrbVFsTDVe
 j7aTl5mD9ETjp+66lcEPb1g4DQlH2aUc+FGpw8PQ07f034TPgq9C2ioIZ3e0ENXxixxS
 yIPiQ+tJL3Jp2U6+1bpqrQjZWFUSfwJHEc8te3ax8gwYi9bo4skYfjkMJkLxxpfqcsce
 tVxqFxT2L1L3rQcWREMKpAPA7PH3/ZXRKuue0KavQDYN3HxPtEIVqyCDlJDmvLkbioX0
 rMcA==
X-Gm-Message-State: AOJu0YyGPASYp0yI7szgxqL1lVtFUrc8+5G5ySFgBirtVMS74a1zT3Yo
 KysBTsIFo8fSbVifS3fqOVeK5wWlgvo/iEpmlMc1mF9Byd1xxdC2cGFEo2gxmzp5RWbLbShoSFh
 RZUrzynEgVFnP0A0=
X-Received: by 2002:a17:903:25d5:b0:1c6:1928:59b9 with SMTP id
 jc21-20020a17090325d500b001c6192859b9mr3563114plb.10.1695863303243; 
 Wed, 27 Sep 2023 18:08:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELxUNlnpAux6slAeBwAdbl4nAPfUWKXKwFU0DWqvu2/VMaxGCY8jAKI72OjbwySlNmlJOl2Q==
X-Received: by 2002:a17:903:25d5:b0:1c6:1928:59b9 with SMTP id
 jc21-20020a17090325d500b001c6192859b9mr3563093plb.10.1695863302945; 
 Wed, 27 Sep 2023 18:08:22 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a170902708c00b001c407fac227sm7427746plk.41.2023.09.27.18.08.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 18:08:22 -0700 (PDT)
Message-ID: <37064f7b-1ad5-b636-3cdb-97208d995c95@redhat.com>
Date: Thu, 28 Sep 2023 11:08:08 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 15/37] arm/virt: Create GED dev before *disabled*
 CPU Objs are destroyed
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
 <20230926100436.28284-16-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-16-salil.mehta@huawei.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> ACPI CPU hotplug state (is_present=_STA.PRESENT, is_enabled=_STA.ENABLED) for
> all the possible vCPUs MUST be initialized during machine init. This is done
> during the creation of the GED device. VMM/Qemu MUST expose/fake the ACPI state
> of the disabled vCPUs to the Guest kernel as 'present' (_STA.PRESENT) always
> i.e. ACPI persistent. if the 'disabled' vCPU objectes are destroyed before the
> GED device has been created then their ACPI hotplug state might not get
> initialized correctly as acpi_persistent flag is part of the CPUState. This will
> expose wrong status of the unplugged vCPUs to the Guest kernel.
> 
> Hence, moving the GED device creation before disabled vCPU objects get destroyed
> as part of the post CPU init routine.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/arm/virt.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 5c8a0672dc..cbb6199ec6 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2376,6 +2376,12 @@ static void machvirt_init(MachineState *machine)
>   
>       create_gic(vms, sysmem);
>   
> +    has_ged = has_ged && aarch64 && firmware_loaded &&
> +              virt_is_acpi_enabled(vms);
> +    if (has_ged) {
> +        vms->acpi_dev = create_acpi_ged(vms);
> +    }
> +

I prefer the old style. Squeezing all conditions to @has_ged changes what's
to be meant by @has_ged itself.

        if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
            :
        }

>       virt_cpu_post_init(vms, sysmem);
>   
>       fdt_add_pmu_nodes(vms);
> @@ -2398,9 +2404,7 @@ static void machvirt_init(MachineState *machine)
>   
>       create_pcie(vms);
>   
> -    if (has_ged && aarch64 && firmware_loaded && virt_is_acpi_enabled(vms)) {
> -        vms->acpi_dev = create_acpi_ged(vms);
> -    } else {
> +    if (!has_ged) {
>           create_gpio_devices(vms, VIRT_GPIO, sysmem);
>       }
>   

Thanks,
Gavin


