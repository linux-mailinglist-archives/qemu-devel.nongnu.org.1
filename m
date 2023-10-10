Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D43807BF463
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:35:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7GU-0006Ar-6l; Tue, 10 Oct 2023 03:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7GR-0006AA-Ag
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1qq7GO-0000aY-Pg
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 03:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696923283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VoOVTQEYghYJfkMhPVf3yW590Z5y0rGh3KvHCnyd/dY=;
 b=aeHRK6S1+N8TDoFPdjkK4MvnyRuO2AioZTmgr1HBfm6KvtMvMFapzUHNIyHYqk8P0m5Jj+
 xomtJFcER54+Ud+1sR2sQaTuLOmNtgmFj0DsAw/qAnDMzjklBkdG6LNJtwtcNryIqtQBr4
 TUr2KIcWyoYFVt50JmR0cWLyKsn4cK4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-A4cc6-RyMkya1mKd6a94Xw-1; Tue, 10 Oct 2023 03:34:32 -0400
X-MC-Unique: A4cc6-RyMkya1mKd6a94Xw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-690be60b13bso1095398b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 00:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696923271; x=1697528071;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VoOVTQEYghYJfkMhPVf3yW590Z5y0rGh3KvHCnyd/dY=;
 b=fqmxeWQLveKAktchaTy/K4XpD5ttzDC7euA26Dsz1MFZ+v2x0mxF3o4h/PyxAGHdCw
 SR6YOGDKL3GvUm2GgTRnJfIxjR06e/EzYwliFZIufEoj5nQUWpVpQK6ZZIp5TdG5uRI+
 fkBHvVvQ48sY9Eu2mcoFqZRh++vXSmRAzNCJqvbJAj1SAX8NKk2m1pLvJ0exYQMpsa8d
 tUFF4y7lWLkYdn4dcF7g1uaRw8NTn5WfvALY7QQu9T5fZcSY6pU1hX0gEkgLIRsIWBNU
 HTw0SSrHWEPv/Wk/IdFJw6hIjGeSN3Jd4GEq2Gq8MucvzxmNdIUlsegvA1j7NILKoB2L
 ecTA==
X-Gm-Message-State: AOJu0Yz1aEGVTahefbuKF4evlrgUMzQQqWwZGFiKsvVclHXRa1EV4rwI
 1FofogSvSNKrkpnp+B+TlnYUuGtyzX9+p0fG2xnfur5F5Sf7spjw7ugTg+9hq3ZSAE67jOa+mky
 pXYevczY2HH55dVI=
X-Received: by 2002:a05:6a20:9393:b0:16c:b95c:6d38 with SMTP id
 x19-20020a056a20939300b0016cb95c6d38mr10342546pzh.2.1696923271378; 
 Tue, 10 Oct 2023 00:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9zizqVF2nF1Oqoc15qqNVPENCMWahfC4HoEVgOhEAmh+CJGIf8l0Iokz6Em3BWtapqnFAvw==
X-Received: by 2002:a05:6a20:9393:b0:16c:b95c:6d38 with SMTP id
 x19-20020a056a20939300b0016cb95c6d38mr10342507pzh.2.1696923271097; 
 Tue, 10 Oct 2023 00:34:31 -0700 (PDT)
Received: from [10.66.61.39] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a639f02000000b00588e8421fa8sm9572129pge.84.2023.10.10.00.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 00:34:30 -0700 (PDT)
Message-ID: <e2141d6a-7627-d092-3930-76ba91a77e7f@redhat.com>
Date: Tue, 10 Oct 2023 15:34:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V4 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 oliver.upton@linux.dev, pbonzini@redhat.com, mst@redhat.com,
 will@kernel.org, gshan@redhat.com, rafael@kernel.org,
 alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009203601.17584-1-salil.mehta@huawei.com>
 <20231009203601.17584-3-salil.mehta@huawei.com>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20231009203601.17584-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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



On 10/10/23 04:35, Salil Mehta via wrote:
> CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   hw/acpi/cpu.c                 | 2 +-
>   include/hw/acpi/cpu_hotplug.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
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

-- 
Shaoqin


