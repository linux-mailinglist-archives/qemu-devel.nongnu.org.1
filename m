Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4827B28DE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 01:36:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm0YD-00021R-Dn; Thu, 28 Sep 2023 19:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0YB-00020z-B3
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1qm0Y8-0002kq-ON
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 19:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695944163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NhHiTPhIHts6fXGHDavroBfU4qdkNdxMJ5VMdhZNFE=;
 b=PujATFBLUlIXI4tHqljnZYsn/UuDgF7NfObjGEYbx18a+fqBRathLgLWO1xayz+u2t4wmD
 6ILlEAF3gcMPiD5dGHdy+CfT2SXz7dhHc95d66zDHhbOZzGx89f2XjLkpZvnQ6XFF8ZTI5
 xbdBMazMY20ghUC+ZH7xBdX8AsMYl84=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-4Av6W1fJOmilGPox_5h3JA-1; Thu, 28 Sep 2023 19:36:01 -0400
X-MC-Unique: 4Av6W1fJOmilGPox_5h3JA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-690a0eedb24so15364158b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 16:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695944160; x=1696548960;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/NhHiTPhIHts6fXGHDavroBfU4qdkNdxMJ5VMdhZNFE=;
 b=TEBmvlBVXjPO4HjVaQc5SPSJWvvpxMU1LFyZe3/I2UO1BjREd0Gx7cBwasTiSjBPlq
 Ee8vv8JAqBp4eyHwrON1SHEcuPH1z1nfwACTrdiv4opTMgdt35dR72E42O1I7qY4cna7
 odHcw2Yj2RqzHKSaCOkjJmBRxdnMTOFK4dv8Nj+O0xH5NMSHJVerlXFvte18CXc7cJwl
 4VBdtMGypVPcx2x/8dNkNaBM36JlzOUi+Mjo0OEDroz1pDHs96CNX951OT7DlQANSlRG
 wTbJVjf6U9vSAhMEgV6gjoFPTVRhhpjQiVNXqH2mjMAgIg0n7hxbRVpM6D56GPV5/8jt
 Az4g==
X-Gm-Message-State: AOJu0YzV8/qR0/f318l+R2PN9iE3TdA5i5s4JlPp/jH7JuvjDuEvW27W
 X+iq7jIYRGWXsS8D2dj9yWgH2Jo7EBpR0fUAtUR4a6R8slpyAuRHSYhEfdFl9yl65qndg5HiFaW
 qISx5KMmyj18YBz8=
X-Received: by 2002:a05:6a20:4292:b0:157:b453:dbb9 with SMTP id
 o18-20020a056a20429200b00157b453dbb9mr2907369pzj.6.1695944160285; 
 Thu, 28 Sep 2023 16:36:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOUkAECKdqd4RB7feXe6A0k8vKyek8G/6oW8ObWg/8hTCF05E7Lttw4VeP9hEXyymokf7jqw==
X-Received: by 2002:a05:6a20:4292:b0:157:b453:dbb9 with SMTP id
 o18-20020a056a20429200b00157b453dbb9mr2907335pzj.6.1695944159967; 
 Thu, 28 Sep 2023 16:35:59 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5?
 ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
 by smtp.gmail.com with ESMTPSA id
 k9-20020a170902c40900b001c56157f062sm15541080plk.227.2023.09.28.16.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 16:35:59 -0700 (PDT)
Message-ID: <14b334c1-0b5f-7f56-6f35-809925085dcf@redhat.com>
Date: Fri, 29 Sep 2023 09:35:46 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH RFC V2 20/37] hw/acpi: Update GED _EVT method AML with cpu
 scan
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
 <20230926100436.28284-21-salil.mehta@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20230926100436.28284-21-salil.mehta@huawei.com>
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

On 9/26/23 20:04, Salil Mehta wrote:
> OSPM evaluates _EVT method to map the event. The cpu hotplug event eventually
> results in start of the cpu scan. Scan figures out the cpu and the kind of
> event(plug/unplug) and notifies it back to the guest.
> 
> The change in this patch updates the GED AML _EVT method with the call to
> \\_SB.CPUS.CSCN which will do above.
> 
> Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> ---
>   hw/acpi/generic_event_device.c | 4 ++++
>   include/hw/acpi/cpu_hotplug.h  | 2 ++
>   2 files changed, 6 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index b84602b238..ad252e6a91 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -108,6 +108,10 @@ void build_ged_aml(Aml *table, const char *name, HotplugHandler *hotplug_dev,
>                   aml_append(if_ctx, aml_call0(MEMORY_DEVICES_CONTAINER "."
>                                                MEMORY_SLOT_SCAN_METHOD));
>                   break;
> +            case ACPI_GED_CPU_HOTPLUG_EVT:
> +                aml_append(if_ctx, aml_call0(ACPI_CPU_CONTAINER "."
> +                                             ACPI_CPU_SCAN_METHOD));
> +                break;
>               case ACPI_GED_PWR_DOWN_EVT:
>                   aml_append(if_ctx,
>                              aml_notify(aml_name(ACPI_POWER_BUTTON_DEVICE),
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 48b291e45e..ef631750b4 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -20,6 +20,8 @@
>   #include "hw/acpi/cpu.h"
>   
>   #define ACPI_CPU_HOTPLUG_REG_LEN 12
> +#define ACPI_CPU_SCAN_METHOD "CSCN"
> +#define ACPI_CPU_CONTAINER "\\_SB.CPUS"
>   
>   typedef struct AcpiCpuHotplug {
>       Object *device;


