Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 609287B0FE9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 02:21:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlelC-0007p8-6O; Wed, 27 Sep 2023 20:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlelA-0007jq-4B
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:20:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qlel7-0001U7-U9
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 20:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695860398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vti1iKlQh+xqVfVl8OL6V2rWcMCL1f9cRENDpFGOnus=;
 b=L9aOyMxhqZzSXdsaoQil11D6V0OJZafEACHXLxfu0Y+5wDnc1n/Zz5/CnHpy/WVwcOWpHr
 flP458sSuG6yS5c6OfP4v20eEoaynJ+EY5fWpCUdZdY/mGTFHYaMxuz4Gn6+F8sOHPxOW0
 3IdF5frJ2h/sWV2SYldDxnOuDCSe+ds=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-Qt5ZuS8jNPaTu8bbDurWlA-1; Wed, 27 Sep 2023 20:19:57 -0400
X-MC-Unique: Qt5ZuS8jNPaTu8bbDurWlA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1c413438552so146103805ad.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 17:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695860396; x=1696465196;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vti1iKlQh+xqVfVl8OL6V2rWcMCL1f9cRENDpFGOnus=;
 b=OS+pRK69nzq5fOA4pI1nl2tyIDtq2IGuoBjSQfEXhxXMrWTgoHdFGFWUi/ApQpGzFJ
 JuBGqUpo9Vajoqxxa10T3KufgyeYRrY0kBZ5Hqm1mM/ZEOzoBHN8ecGWyduJBHJpELhI
 XtlJloVKWh0gtPPS1NT12+SQDOwiweYIUmUfWMHQHyV0zOntzSfFr7JAn3qLtphhjlpt
 f3kxvpIgr2Peq9MTTlAWkFI0X+Yv2YrgQNf9+P32V47YTmtAiScIF8hnGRDN0R9tQLUa
 1RFKh3BNre2AKIHsriOdftn0KKlYMVMowPbBmi1sF98JHwlJhfT5wdlG7LzKeXemwoVg
 MP7g==
X-Gm-Message-State: AOJu0YzMhb35mGiGYaiwP2qz9Nr6/lEobHttkXra47xHjBkhDcw2drCU
 z/Wr8lo3bphrIWIPjLPtfBLgzQzS0t93oLxqNSU9uLPmp/r6D8Kq5MiAFGsOSsYUVrc/qn9RfN1
 IObcnp2WNGELw/FM=
X-Received: by 2002:a17:902:ced2:b0:1c6:a38:ebcc with SMTP id
 d18-20020a170902ced200b001c60a38ebccmr3760793plg.43.1695860396214; 
 Wed, 27 Sep 2023 17:19:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkkja9CTyEq8MHcmf3AYrhEiK7jsya/iP0tFF1xHRWOLQJDUs0mLY8r8PlQFi85dN3DNUgQg==
X-Received: by 2002:a17:902:ced2:b0:1c6:a38:ebcc with SMTP id
 d18-20020a170902ced200b001c60a38ebccmr3760767plg.43.1695860395892; 
 Wed, 27 Sep 2023 17:19:55 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 ix22-20020a170902f81600b001b05e96d859sm13753816plb.135.2023.09.27.17.19.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 17:19:55 -0700 (PDT)
Message-ID: <a478929d-9b43-4e87-c16a-e33f82aa20da@redhat.com>
Date: Thu, 28 Sep 2023 10:19:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 09/37] hw/acpi: Move CPU ctrl-dev MMIO region len
 macro to common header file
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
 <20230926100436.28284-10-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-10-salil.mehta@huawei.com>
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

On 9/26/23 20:04, Salil Mehta wrote:
> CPU ctrl-dev MMIO region length could be used in ACPI GED (common ACPI code
> across architectures) and various other architecture specific places. To make
> these code places independent of compilation order, ACPI_CPU_HOTPLUG_REG_LEN
> macro should be moved to a header file.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/cpu.c                 | 2 +-
>   include/hw/acpi/cpu_hotplug.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 19c154d78f..45defdc0e2 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -1,12 +1,12 @@
>   #include "qemu/osdep.h"
>   #include "migration/vmstate.h"
>   #include "hw/acpi/cpu.h"
> +#include "hw/acpi/cpu_hotplug.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-events-acpi.h"
>   #include "trace.h"
>   #include "sysemu/numa.h"
>   
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>   #define ACPI_CPU_SELECTOR_OFFSET_WR 0
>   #define ACPI_CPU_FLAGS_OFFSET_RW 4
>   #define ACPI_CPU_CMD_OFFSET_WR 5
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbb..48b291e45e 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -19,6 +19,8 @@
>   #include "hw/hotplug.h"
>   #include "hw/acpi/cpu.h"
>   
> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
> +
>   typedef struct AcpiCpuHotplug {
>       Object *device;
>       MemoryRegion io;


