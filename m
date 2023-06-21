Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F000737F1F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:47:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuQO-0006lm-8o; Wed, 21 Jun 2023 05:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuQM-0006lT-3L
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:46:50 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qBuQK-0002X1-4z
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:46:49 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51bdf6336d2so225897a12.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687340806; x=1689932806;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wC7HbOc7aDuirvYpYu+juqtN6YdFA9pAjWz3EsMRdiM=;
 b=XMEvzKOCkBiecJUTf8UjZzwXy02NLyKxrHajGM5rqzf4njdvooTaW1EXBiWL8Vs7rJ
 6RB7pXCoHURCpUZEwD8/cR2mXUCxBieWO3LEVbFXcq1Z2X8bPf5l+NvSwaX9FQ4G1VW3
 +TozN15L/fQP2VsAV2OL3a2uF1R8Jclf/AZvtdmpgJMoAZ25jhRhYp6+IhVZPNOsOkZd
 dS69max7ar78/WD5ShbVdDvSMexjuDl3BAyUD5jAyYUHnRu98XRqxCGXTCx043gJXLeJ
 VHdScRYPlyOjOIqOdO1yQSy6/nN1fROwA7QefNMDShUlcACGGtujeF1e8VwI9xvO6YV4
 rL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687340806; x=1689932806;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wC7HbOc7aDuirvYpYu+juqtN6YdFA9pAjWz3EsMRdiM=;
 b=FOfQ+LBcMLqmTnsuYJyUAnhKJNiqb/O7q+Q4C56LbPzFJBLAlktER5Jdef4TnibX90
 UEzT07Lp5nKvFzkws4IzrxOKqz9Y9NWfx7OtkAspY8q1obT8oRBXQELwA3n5RP4EeaIB
 ct0FuwkhEWUGYbeAknHqlTatiY+jcHSdQbewaSEnTRC/E6tCISN/Z+M7Tmv31J1pNmgw
 LDeE/j19m13x0IxqPFjy4gxGVdIgzcEGII/5nyHsChXNQWDdRRlK8zCuBLsIl/Wk3TI0
 k5si2wB5WCCAFJ8HjXD4HvPeQIhCK4SzCvtqtEF9TPEIXDYe/8CfcQ1TkHogOE0A4viu
 hr+A==
X-Gm-Message-State: AC+VfDwFalglM+U8ABK3ZojCBaA0SlSJ0NFDWRYjt8xX1flrqnldE9Vx
 rnN6ddp7FSThGXrD7R0KeDZ5qg==
X-Google-Smtp-Source: ACHHUZ7fZVffhAYOyNbJ3jAQn/HllDB8nP939U2B0f3//kp2ppokOnwvgMi27gfHWaKvkf2ZbCGCQQ==
X-Received: by 2002:aa7:cf86:0:b0:51a:2769:9d1a with SMTP id
 z6-20020aa7cf86000000b0051a27699d1amr10102503edx.28.1687340806498; 
 Wed, 21 Jun 2023 02:46:46 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0051495ce23absm2343007edp.10.2023.06.21.02.46.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:46:46 -0700 (PDT)
Message-ID: <b15a4923-dfab-f8f8-c6f7-45ffda82d9d0@linaro.org>
Date: Wed, 21 Jun 2023 11:46:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 07/24] q800: move GLUE device into separate q800-glue.c
 file
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
 <20230621085353.113233-8-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621085353.113233-8-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

On 21/6/23 10:53, Mark Cave-Ayland wrote:
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
> index 0000000000..e81f9438f1
> --- /dev/null
> +++ b/hw/m68k/q800-glue.c
> @@ -0,0 +1,252 @@
> +/*
> + * QEMU q800 logic GLUE (General Logic Unit)
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
> + */
> +
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "hw/m68k/q800-glue.h"
> +#include "hw/boards.h"

"hw/boards.h" shouldn't be necessary here.

> +#include "hw/irq.h"
> +#include "hw/nmi.h"
> +#include "hw/qdev-properties.h"
> +#include "migration/vmstate.h"


> diff --git a/include/hw/m68k/q800-glue.h b/include/hw/m68k/q800-glue.h
> new file mode 100644
> index 0000000000..c1817b01a5
> --- /dev/null
> +++ b/include/hw/m68k/q800-glue.h
> @@ -0,0 +1,50 @@
> +/*
> + * QEMU q800 logic glue

"QEMU q800 logic GLUE (General Logic Unit)" similar to .c?
(could be changed when applying, no need to respin)

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

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
> + */



