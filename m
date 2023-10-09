Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 695097BDB9D
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 14:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qppGc-0003NV-E4; Mon, 09 Oct 2023 08:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppGa-0003MV-GT
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:21:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qppGZ-0002KJ-0J
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 08:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696854102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bZXzUGcxBYinFudKQFkuxnigBSI9gHMfNXLyVDqtV8=;
 b=Uewjd1kgt+Rpx0BA3MRTBTtTcFTB9uV1bi6niNafnzDdW5xmI1qlWRG9+GXDhhJ56ZbFhL
 mg1W3qa43Bi49b1D13rJ8RQDUzJVVoiMAk0pA0qptl1fvh2vXASQYydqHwYNKnL+pX3yqY
 TICLUcyhUvZvgug5zfOzQ+ThFJUjm5s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-kJK9bGJaP7ugJxglFbmbAg-1; Mon, 09 Oct 2023 08:21:36 -0400
X-MC-Unique: kJK9bGJaP7ugJxglFbmbAg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso33828425e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696854095; x=1697458895;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2bZXzUGcxBYinFudKQFkuxnigBSI9gHMfNXLyVDqtV8=;
 b=jsprNWKBHDuTuFHkwGdegdTkZobO/CxOXsaoq7WZ4iBXDSyvpe6fakR8BD0ag8ja6/
 969gditsx3rc4W94vRWpN/ZPz5LwqNL6TdA7WZZ0QpyLNw8KYNOFHwkZ2nyRCikthvCS
 KI3T4paGksBDB0BvIY37HZN7zQDHl1eHLRR1RBmQFVQbsafHFKUpk4jBDM5+6r0bXmyp
 0pfXct6vVlmvv/L1wo+iIlqkNLClzjfmtz0TWZW+HhD3lVtpYhJRihzGEcfUqvNutZVs
 HniuEOn9uzusF1yrvMBhr+cju36UiDSkSWUWcLwl8XTLDyvWfjiGo7IcYXS/A1LHx42D
 UNBw==
X-Gm-Message-State: AOJu0YxKRE/rEdeH5T/9SBUkPDo63imzW1AC0AS9+GIp4nq+vTDexX49
 PzSuOFweFWHwX21YAFv2R6DzHLer2cmovPrYWUGNZ8nrwfY0KzViQMRRQaoycqDnVvsKwk0Wc1/
 QkJ3h2bVwTtsIh7w=
X-Received: by 2002:adf:f08f:0:b0:325:cafe:a687 with SMTP id
 n15-20020adff08f000000b00325cafea687mr15113769wro.51.1696854094720; 
 Mon, 09 Oct 2023 05:21:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjrZ7VRrGIMf2Rg/AsCekX/ybtgrNDOF770M67iVHstIR07sTVG5FV5281eBAUqxyf8jfIfg==
X-Received: by 2002:adf:f08f:0:b0:325:cafe:a687 with SMTP id
 n15-20020adff08f000000b00325cafea687mr15113741wro.51.1696854094301; 
 Mon, 09 Oct 2023 05:21:34 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:6400:ae10:4bb7:9712:8548?
 (p200300cbc7336400ae104bb797128548.dip0.t-ipconnect.de.
 [2003:cb:c733:6400:ae10:4bb7:9712:8548])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a5d4903000000b0031fa870d4b3sm9431127wrq.60.2023.10.09.05.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 05:21:33 -0700 (PDT)
Message-ID: <3380adbe-fbbe-797f-19c2-76aa2e4cfe30@redhat.com>
Date: Mon, 9 Oct 2023 14:21:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V3 02/10] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 philmd@linaro.org, eric.auger@redhat.com, oliver.upton@linux.dev,
 pbonzini@redhat.com, mst@redhat.com, will@kernel.org, gshan@redhat.com,
 rafael@kernel.org, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, linuxarm@huawei.com
References: <20231009112812.10612-1-salil.mehta@huawei.com>
 <20231009112812.10612-3-salil.mehta@huawei.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20231009112812.10612-3-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 09.10.23 13:28, Salil Mehta wrote:
> CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
> 
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
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

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


