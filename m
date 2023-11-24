Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9764D7F7640
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 15:22:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6X3A-0002Ef-LD; Fri, 24 Nov 2023 09:20:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6X39-0002EG-4I
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6X37-0001c3-2i
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 09:20:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700835652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vegpZ4SEXUpYZ9JFohP3hK+vi7e/r3dObUb4fKl4quY=;
 b=VjNdqsaM0H0Y/xc6CB4Q0v37N1I1jQ0NpAnlroLM08vZuMOcK4OplGAQawR9PvpLXaelnp
 r58aUzbtgCgroIK2DjxIP8TCqhEBmT6CCg/UPNgttHx0NKFvi9hAT6un9u/LPf/1EcHzyo
 1lm6/rGPSHSlGtnNqKxQyYKYAeK0T8Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-XUI9oU1IN7ilyhG_ourqyQ-1; Fri, 24 Nov 2023 09:20:51 -0500
X-MC-Unique: XUI9oU1IN7ilyhG_ourqyQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-54acdd65e8cso699310a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 06:20:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700835650; x=1701440450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vegpZ4SEXUpYZ9JFohP3hK+vi7e/r3dObUb4fKl4quY=;
 b=smlwKq+KfFcZGYRm4ogdQd+0A8IZOP/f7eH2ZP6NbNExSgiVlvEFtYeDaolk9oqtUL
 LoUmBG4tpQOdhIwVh69fmTeQHZtBQdkyFWJu3HWy8e0R6J+pOE69zXFWYWFB0A6ORRct
 t8Ce0gfVICArM3xReRNbZb7iQoI0PlnKXsGtZpJld7KRdDQuXGgyLXFZdHia4oxin70F
 lIuaj/CUOrBlqZwk4aBDouO5iV1vtX41FfokVjAFiOInoCzVRsbAI4adYWAf5AKzymcK
 4ZjxP3z+JjAOvw1HRPPDwxJTH6FkOuc5nzQ11LXawkmH5AzaJkRPzuNW0DI/Pal/LwV1
 UNTw==
X-Gm-Message-State: AOJu0Yx6qK/63qB7lQIWSe3pYKdHztC+L4sBsVlUFfhEwiSMv2rS4aqP
 Z5b2Jcgm0Z5Hj1027aBFK9AXYfRrsNS/7kyDzdKF4onkSuUv6k6r//Y+AElFmiaC4n6A8daUoRt
 7xcSxpo02c+H4ScA=
X-Received: by 2002:a50:d55e:0:b0:53d:b839:2045 with SMTP id
 f30-20020a50d55e000000b0053db8392045mr2358102edj.25.1700835650011; 
 Fri, 24 Nov 2023 06:20:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBdg+rntWIl/bOReCSPB2yc8SvVSa73bJJ1RAq/RKoKIP6bxifVD6/pcAX+sA4i3SRdW9+qw==
X-Received: by 2002:a50:d55e:0:b0:53d:b839:2045 with SMTP id
 f30-20020a50d55e000000b0053db8392045mr2358072edj.25.1700835649658; 
 Fri, 24 Nov 2023 06:20:49 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 u11-20020aa7db8b000000b00543525d9fddsm1798204edt.21.2023.11.24.06.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 06:20:49 -0800 (PST)
Date: Fri, 24 Nov 2023 15:20:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V7 2/8] hw/acpi: Move CPU ctrl-dev MMIO region len macro
 to common header file
Message-ID: <20231124152047.1160a5af@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-3-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
 <20231113201236.30668-3-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 13 Nov 2023 20:12:30 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> CPU ctrl-dev MMIO region length could be used in ACPI GED and various oth=
er
> architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
> appropriate common header file.
>=20
> Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
> Tested-by: Xianglai Li <lixianglai@loongson.cn>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  hw/acpi/cpu.c                 | 2 +-
>  include/hw/acpi/cpu_hotplug.h | 2 ++

the header holds legacy stuff (mostly) and I'd say is destined for removal.

include/hw/acpi/cpu.h  would be a better place for it.


>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
> index 011d2c6c2d..4b24a25003 100644
> --- a/hw/acpi/cpu.c
> +++ b/hw/acpi/cpu.c
> @@ -1,13 +1,13 @@
>  #include "qemu/osdep.h"
>  #include "migration/vmstate.h"
>  #include "hw/acpi/cpu.h"
> +#include "hw/acpi/cpu_hotplug.h"
>  #include "hw/core/cpu.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-acpi.h"
>  #include "trace.h"
>  #include "sysemu/numa.h"
> =20
> -#define ACPI_CPU_HOTPLUG_REG_LEN 12
>  #define ACPI_CPU_SELECTOR_OFFSET_WR 0
>  #define ACPI_CPU_FLAGS_OFFSET_RW 4
>  #define ACPI_CPU_CMD_OFFSET_WR 5
> diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
> index 3b932abbbb..48b291e45e 100644
> --- a/include/hw/acpi/cpu_hotplug.h
> +++ b/include/hw/acpi/cpu_hotplug.h
> @@ -19,6 +19,8 @@
>  #include "hw/hotplug.h"
>  #include "hw/acpi/cpu.h"
> =20
> +#define ACPI_CPU_HOTPLUG_REG_LEN 12
> +
>  typedef struct AcpiCpuHotplug {
>      Object *device;
>      MemoryRegion io;


