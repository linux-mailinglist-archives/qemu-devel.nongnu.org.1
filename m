Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F07722628
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:43:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69Wy-0006NU-Bf; Mon, 05 Jun 2023 08:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Wq-0006N8-De
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:41:45 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Wo-0004c6-P1
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:41:44 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f736e0c9a8so11754025e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685968900; x=1688560900;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LW1OfWw/JkDDky2R4F8hHWKQDYV4J4ZRUpeI9Rfj7cQ=;
 b=stWDehPZBVmccnUCoeM3/mxoxIgPKFCj9kOgrxy2rcWTuVF5BPpMtf8G1ys3VuDgks
 8UcGhobhj4Uj3DCOLbX1MVh2JABYnkOOXN5dtExFLDTsT/gpmBLYH5+Jwl7CpaWuGnTI
 zAhPQz2G4iuenlkXoBoYwdWuNti9X9SMt/eyT7pOhiB91jwKJne7vmW10ZFQxzuOfSan
 xGV0C2kehxlG0mhSIyG9GdGNUATr1xjgbCMH5F/w93A2TY+eLDsnD9INkuGc7J5QzXa3
 hhnX9tFJKbRP5HGbArxGUGi1ymztSkSP5Q9/0L4RYAcO6N2uoEZqVQdEIcZNthTorqNG
 8OLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685968900; x=1688560900;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LW1OfWw/JkDDky2R4F8hHWKQDYV4J4ZRUpeI9Rfj7cQ=;
 b=iJBAYsqTi8Fr/5ZT6PZ7sOd0nVJjHnGzyxbzfIwKWFw2pBIwT9IiEjLz2dc4c8OXDu
 HYfB6U2HiSeut1jogV7WSaURZFpF7w5/HGmAg0J8vf5kAZ2CNqNmf5eVBYm8y1dYlXnT
 OPh8vIBgsLTuIiCxF6vKo3T85e0Q1nsVK/vRWQk03Nteu6cTTmIaHcge1GWkz3LpucNU
 TJoCGfEpfCfY8ZWKR4jd6a4Vbrzt30bw95VIZvWoCW/CdRDzHlHg0ULACOlmcHZfX1Pd
 ExJ5VbHpSNAEMxhgNzuPKSvbgW4uOCXA8JoQJ7ftR6zfoJGrGO/6AIIhcn9YlTwZfGcb
 c3GQ==
X-Gm-Message-State: AC+VfDy3yyodTZOObw+/S/HvXEiNpREUNi+ssyHp5x3iFAcpCHuM7QdB
 Ikv4odCphrG1uDdYg6Z+4YieJsfUxj+t44fkFe4=
X-Google-Smtp-Source: ACHHUZ61C5cwGLxPZHdprd4lS05IwZspBpf4XyIQ0jeqvR7nMI5+Ke7134Gr4f6mTFz4TkUH94XbPA==
X-Received: by 2002:a5d:6790:0:b0:309:3a1e:fc54 with SMTP id
 v16-20020a5d6790000000b003093a1efc54mr4961565wru.7.1685968900185; 
 Mon, 05 Jun 2023 05:41:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a5d650f000000b002fb60c7995esm9735400wru.8.2023.06.05.05.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:41:39 -0700 (PDT)
Message-ID: <d6b7f5ff-d51d-f821-5c2a-20ae7c2d0cc4@linaro.org>
Date: Mon, 5 Jun 2023 14:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 07/23] q800: move GLUE device into separate q800-glue.c
 file
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-8-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 4/6/23 15:14, Mark Cave-Ayland wrote:
> This will allow the q800-glue.h header to be included separately so that the
> GLUE device can be referenced externally.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   MAINTAINERS                 |   2 +
>   hw/m68k/meson.build         |   2 +-
>   hw/m68k/q800-glue.c         | 252 ++++++++++++++++++++++++++++++++++++
>   hw/m68k/q800.c              | 238 +---------------------------------
>   include/hw/m68k/q800-glue.h |  50 +++++++
>   5 files changed, 306 insertions(+), 238 deletions(-)
>   create mode 100644 hw/m68k/q800-glue.c
>   create mode 100644 include/hw/m68k/q800-glue.h


> diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
> new file mode 100644
> index 0000000000..793bdb110c
> --- /dev/null
> +++ b/hw/m68k/q800-glue.c
> @@ -0,0 +1,252 @@
> +/*
> + * QEMU q800 logic glue

Although mentioned later, could we describe as "GLUE (General
Logic Unit)" here?

> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.

Or simpler:

   * SPDX-License-Identifier: MIT

> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/m68k/q800-glue.h"
> +#include "hw/boards.h"
> +#include "hw/irq.h"
> +#include "hw/nmi.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"
> +
> +/*
> + * The GLUE (General Logic Unit) is an Apple custom integrated circuit chip
> + * that performs a variety of functions (RAM management, clock generation, ...).
> + * The GLUE chip receives interrupt requests from various devices,
> + * assign priority to each, and asserts one or more interrupt line to the
> + * CPU.
> + */


> +static const TypeInfo glue_info = {
> +    .name = TYPE_GLUE,
> +    .parent = TYPE_SYS_BUS_DEVICE,
> +    .instance_size = sizeof(GLUEState),
> +    .instance_init = glue_init,
> +    .instance_finalize = glue_finalize,
> +    .class_init = glue_class_init,
> +    .interfaces = (InterfaceInfo[]) {
> +         { TYPE_NMI },
> +         { }
> +    },
> +};
> +
> +static void glue_register_types(void)
> +{
> +    type_register_static(&glue_info);
> +}
 > +
 > +type_init(glue_register_types)

Soon DEFINE_TYPES() will be recommended over type_init().

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


