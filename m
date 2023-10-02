Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4267B5DB2
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:26:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnSI8-0004yA-Hp; Mon, 02 Oct 2023 19:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSI6-0004xu-UW
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qnSI1-0000TS-IQ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 19:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696289124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09sAV7Zg1QggcLvG8Ic2iWuh1IUbW2ZGEDw+h086a0Q=;
 b=QDakutgzKoDtupxVTZnuPGEvc6+7QoHpgsq7sHVcBDd3XKFgSgnIhFjOXSs9DfEAQsktRU
 AtB14q1Z5Yw/q+ijU15+rTY3oUWu2b1aoccH9RTVhScIIo9DAutKfwCJaX4IK676Oh1jlV
 UThk4S2B7C86kQmz0gAge5msOapqoA0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-f51j2Op8OY2mmKutbMkRgA-1; Mon, 02 Oct 2023 19:25:23 -0400
X-MC-Unique: f51j2Op8OY2mmKutbMkRgA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-692161c3948so222385b3a.0
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 16:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696289122; x=1696893922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=09sAV7Zg1QggcLvG8Ic2iWuh1IUbW2ZGEDw+h086a0Q=;
 b=M6yM/Iqtwd9iYb4lHZ3N/ltr2W2ytQUHDWvDwOdVRp6Z8rK9pEF+xoyquDAVzoofvF
 H3e+OlhVUmZ9zYAeroh41a+XG66OA18bLiU08++xQVLa6UI/ILBc1GQNxW/qNSXbtLds
 H/io09RrBY4lqFXMTjbTfSHkCoriKovjP6BR7fLbZICG5XPjCKYvQMrINEf0mltt1G/L
 XxfxnL+PeI2APgz7JG6NYYLqVE4w3/oaUMrg6aZhv6Evgtst0ip2SKVQdILUDIMBpDoX
 MkFkS439GbW+NTU+YWhrrA3Xg24NKLBRIop+CYLYc/eSAKtxSX4+ctQ21hEEG6NtGSg4
 UspQ==
X-Gm-Message-State: AOJu0YyeVixRxHYwSddfj8NuED8+lmOMJv6sQHIFrlUAikhE9BHAryv8
 hyZt0gTaWprDpVCvPRoVZ6ZwaGMHTl9V7z0azbWB2ylB9UC8BJDFO8Zk/WOi6Ka/bu/5LhCzYHy
 P4DMPgqtsFGyOFYE=
X-Received: by 2002:a05:6a00:3a23:b0:68f:c2f7:cef0 with SMTP id
 fj35-20020a056a003a2300b0068fc2f7cef0mr1634187pfb.4.1696289122074; 
 Mon, 02 Oct 2023 16:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDNt03dCvEfeWpfJgXCPzT848dG3DujhJtHpZYanKuo665O5v+qnKnu8gGKd0i1LWLyuTO3Q==
X-Received: by 2002:a05:6a00:3a23:b0:68f:c2f7:cef0 with SMTP id
 fj35-20020a056a003a2300b0068fc2f7cef0mr1634160pfb.4.1696289121751; 
 Mon, 02 Oct 2023 16:25:21 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 f20-20020aa782d4000000b0069343e474bcsm33981pfn.104.2023.10.02.16.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 16:25:21 -0700 (PDT)
Message-ID: <1269fcdc-0b14-2449-2623-9de2948f81fa@redhat.com>
Date: Tue, 3 Oct 2023 09:25:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V2 03/10] hw/acpi: Add ACPI CPU hotplug init stub
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, rafael@kernel.org, alex.bennee@linaro.org,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 karl.heubaum@oracle.com, miguel.luis@oracle.com, salil.mehta@opnsrc.net,
 zhukeqian1@huawei.com, wangxiongfeng2@huawei.com, wangyanan55@huawei.com,
 jiakernel2@gmail.com, maobibo@loongson.cn, lixianglai@loongson.cn,
 linuxarm@huawei.com
References: <20230930001933.2660-1-salil.mehta@huawei.com>
 <20230930001933.2660-4-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230930001933.2660-4-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-2.321, RCVD_IN_MSPIKE_H4=0.001,
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


On 9/30/23 10:19, Salil Mehta wrote:
> ACPI CPU hotplug related initialization should only happen if ACPI_CPU_HOTPLUG
> support has been enabled for particular architecture. Add cpu_hotplug_hw_init()
> stub to avoid compilation break.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/acpi-cpu-hotplug-stub.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
> index 3fc4b14c26..c6c61bb9cd 100644
> --- a/hw/acpi/acpi-cpu-hotplug-stub.c
> +++ b/hw/acpi/acpi-cpu-hotplug-stub.c
> @@ -19,6 +19,12 @@ void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
>       return;
>   }
>   
> +void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
> +                         CPUHotplugState *state, hwaddr base_addr)
> +{
> +    return;
        ^^^^^^
> +}
> +

I guess the return is the outcome by following the pattern of other functions ;-)

>   void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
>   {
>       return;

Thanks,
Gavin


