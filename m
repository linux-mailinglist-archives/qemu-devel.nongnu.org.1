Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62360733309
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:02:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAA0P-0006LH-LE; Fri, 16 Jun 2023 10:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA07-0006I7-Bg
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:00:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qAA03-0004ee-E2
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:00:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f8d2bfed53so6239595e9.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 07:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686924024; x=1689516024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iy5ZxnR3pIZc5lAQUDvBKzsQwzHhU4/RE3u4YPG9eEA=;
 b=STZPd56DE5nWzSN1EOCHlvEAjkXD0Cu03dHOqZ3+ZKeBeXBEJqgsfYf9JPdz6jvbc9
 0bX/hihP9eqgv6G3G0Xi1es5B87HKbttaRN767KyTS3Av0eCsrVebBziZusUDkzbhwj1
 uskz9rdxOpQ7rm1Lf+YItHoKKbD5pxbO5jMuhy3R2vK7Lhsbc4G/VEeIHVF4KNAVtv/7
 8q2+AsNpDqruNhwgznHTZqmJ/FLalSmr6kyJNPGPtH+7ZGW4do8ZA5QxOQcUUwnuuWTd
 O/t5WhNDeTEr7P9FdTZfNmz4daIVOhUEw1Nm/peOcX1jcKmW942W/+9g+kCOeMTi+Vyq
 rRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686924024; x=1689516024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iy5ZxnR3pIZc5lAQUDvBKzsQwzHhU4/RE3u4YPG9eEA=;
 b=ZjzTAPdM7/yU0kzhZTkX3hrq+sx9ITV+tLfrCXGPdfGu35pRemgbZMMmlH4ZTyOfTM
 KxpwpHpHKzzvQQzIPinoX9MZC+vKWHW5nd81wOcn47CWzf7V9XkozA8VWN0FmiaEOlhw
 kJ7vpqLDz+oXNhKDww+pWEEcemNpEhFQxR2l8vQdFPFIizKz2UDRVkSEpR14CuHcuZld
 9RQgQkCY1Vew70EmHztej6W33QtRLqmrvhRE0euXiQJvUQ99yNeWm7J30yIWLUYKC7q1
 /mrGl8UxnVVDjOjJM5OsN4nJKyyNcV/DvBIfioRvupXyH+SDmmY9ZrLY0i7ephal7eBm
 PtzA==
X-Gm-Message-State: AC+VfDynePOTK3by6wcCBSbYnrl5gUZw6b6Js/bA+Kwont/UjmB7N/g6
 81GNUbSqMfwboN78HoDRtUiPSQ==
X-Google-Smtp-Source: ACHHUZ6kPj+FMGGuTj0YDhgwONdGHoS+BS3HeKvdgsfdFnlVK34YImvQtzNGSKgPexIHdJ7LqnklUw==
X-Received: by 2002:a05:600c:378b:b0:3f7:2b61:4c98 with SMTP id
 o11-20020a05600c378b00b003f72b614c98mr1784777wmr.13.1686924024383; 
 Fri, 16 Jun 2023 07:00:24 -0700 (PDT)
Received: from [192.168.164.175] (146.red-88-29-160.dynamicip.rima-tde.net.
 [88.29.160.146]) by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003f7eafe9d76sm2274260wmi.37.2023.06.16.07.00.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jun 2023 07:00:23 -0700 (PDT)
Message-ID: <96ec686c-e384-ac79-8027-2c439a090cbb@linaro.org>
Date: Fri, 16 Jun 2023 12:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 02/12] hw/misc/pvpanic: Add MMIO interface
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230614224038.86148-1-graf@amazon.com>
 <20230614224038.86148-3-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230614224038.86148-3-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 15/6/23 00:40, Alexander Graf wrote:
> In addition to the ISA and PCI variants of pvpanic, let's add an MMIO
> platform device that we can use in embedded arm environments.
> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/misc/Kconfig           |  4 +++
>   hw/misc/meson.build       |  1 +
>   hw/misc/pvpanic-mmio.c    | 66 +++++++++++++++++++++++++++++++++++++++
>   include/hw/misc/pvpanic.h |  1 +
>   4 files changed, 72 insertions(+)
>   create mode 100644 hw/misc/pvpanic-mmio.c


> diff --git a/hw/misc/pvpanic-mmio.c b/hw/misc/pvpanic-mmio.c
> new file mode 100644
> index 0000000000..aebe7227e6
> --- /dev/null
> +++ b/hw/misc/pvpanic-mmio.c
> @@ -0,0 +1,66 @@
> +/*
> + * QEMU simulated pvpanic device (MMIO frontend)
> + *
> + * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.

Preferably SPDX tag.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/module.h"

Unused header.

> +#include "sysemu/runstate.h"
> +
> +#include "hw/nvram/fw_cfg.h"

Ditto.

> +#include "hw/qdev-properties.h"
> +#include "hw/misc/pvpanic.h"
> +#include "qom/object.h"

Ditto.

> +#include "hw/isa/isa.h"

Ditto.

> +#include "standard-headers/linux/pvpanic.h"
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(PVPanicMMIOState, PVPANIC_MMIO_DEVICE)
> +
> +#define PVPANIC_MMIO_SIZE 0x2
> +
> +struct PVPanicMMIOState {
> +    SysBusDevice parent_obj;

Mising "sysbus.h"

> +
> +    PVPanicState pvpanic;
> +};

This worked for me:

-- >8 --
--- a/hw/misc/pvpanic-mmio.c
+++ b/hw/misc/pvpanic-mmio.c
@@ -3,19 +3,13 @@
   *
   * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights 
Reserved.
   *
- * This work is licensed under the terms of the GNU GPL, version 2 or 
later.
- * See the COPYING file in the top-level directory.
+ * SPDX-License-Identifier: GPL-2.0-or-later
   */

  #include "qemu/osdep.h"
-#include "qemu/module.h"
-#include "sysemu/runstate.h"
-
-#include "hw/nvram/fw_cfg.h"
  #include "hw/qdev-properties.h"
  #include "hw/misc/pvpanic.h"
-#include "qom/object.h"
-#include "hw/isa/isa.h"
+#include "hw/sysbus.h"
  #include "standard-headers/linux/pvpanic.h"
---

Fixing the includes:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

