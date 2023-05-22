Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E561570B4D2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 08:06:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0ygB-00084Y-OT; Mon, 22 May 2023 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0yg9-00082k-Ae
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:05:57 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0yg6-00026p-NL
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:05:57 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so35023625e9.3
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684735553; x=1687327553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NXgJy8c5g6MPyHjNu9RSgx4PXQ+UTK626UsedlhezkQ=;
 b=jKfXul5YJIBY7lm67QP+IDB5SV3dQiRW7Z3ntEsymQq5a/JS+qYKriS9XRoBthO/vS
 P+85gAkwjvUtsEIbs594kCDPq6ByZNvMoZ35ASHmj6+D7Up78nUuVpp35Ba4ns9uvwii
 /arQZr3KUqZw94Hnxa2UgkNPXM3/GulVvluSZeiskUeaUZ0V5aiLR0S7l8ywZZy8pcXs
 88WoxkwuB/5hWLTQKT//2Bc70y84pyPoXjD4sdlQ+S7as4yRgXMsVrHWagJWefX0t4ED
 PdceyTWNVKLamICZ51O95RtAoLAOCrfJACHgTBkNKKbQQTGbwU6vBIz2PnFlXUYHl3j3
 2A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684735553; x=1687327553;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NXgJy8c5g6MPyHjNu9RSgx4PXQ+UTK626UsedlhezkQ=;
 b=i7G5m60trSNJSc+aXjXUAFbLxrKcyD1Kur/rrM4mQONNdEugKN9d5fDMy3C9iC5AY4
 TaWMTDuFEhrhFIwsHKFiM3raIaXfcS8lcTe68s55rkMVKvMRPHs8NjGCydxXjpQQv2uA
 OgmNmKW2DZqw6GHfwS4FkHbKD2cZOzPww7NPKVPnRwIQlmlPfDYB6IRZEza3Lvql4DBg
 NQ3KasFiEESftlWQU/Rwx/Ht7djlDHYtwQ2D0gL65o2XV0rpKU1oPbP0c4pp7Vh+4goT
 P6UIULVAzdlxJ1U0O9sSOKom8f6e77cP584m9dYzpm2RQgn5DAd9QCb5Vov5uNqt9SdP
 UddQ==
X-Gm-Message-State: AC+VfDw5J0LSM7CXmhmGJeGWp13RqLerDOLETtQF5VkYaHn7iSfRQ7Ah
 Wb562D/gOgefnJit6ShD/4LQjg==
X-Google-Smtp-Source: ACHHUZ7M+d+vYV1pwynGt8mkSD7oGvpUVsBNnDfTCh73z9kcWS2ILdE4jDMqW9N9gRGQrHk9jeAHXg==
X-Received: by 2002:a7b:cbc1:0:b0:3f5:aa2:288b with SMTP id
 n1-20020a7bcbc1000000b003f50aa2288bmr6190355wmi.0.1684735553036; 
 Sun, 21 May 2023 23:05:53 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a05600c378500b003f42314832fsm7098482wmr.18.2023.05.21.23.05.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 23:05:52 -0700 (PDT)
Message-ID: <e55f3652-0d22-9845-f9c8-0ae4c6e3387e@linaro.org>
Date: Mon, 22 May 2023 08:05:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/6] hw/char/parallel: Export ParallelState
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230521123049.312349-1-shentey@gmail.com>
 <20230521123049.312349-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521123049.312349-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 21/5/23 14:30, Bernhard Beschow wrote:
> Exporting ParallelState is a precondition for exporing TYPE_ISA_PARALLEL.
> 
> Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Missing your S-o-b.

> ---
>   include/hw/char/parallel.h | 44 ++++++++++++++++++++++++++++++++++++++
>   hw/char/parallel.c         | 42 ------------------------------------
>   2 files changed, 44 insertions(+), 42 deletions(-)
> 
> diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
> index 0a23c0f57e..2d4907c1fe 100644
> --- a/include/hw/char/parallel.h
> +++ b/include/hw/char/parallel.h
> @@ -1,9 +1,53 @@
>   #ifndef HW_PARALLEL_H
>   #define HW_PARALLEL_H
>   
> +#include "exec/ioport.h"
> +#include "exec/memory.h"
>   #include "hw/isa/isa.h"
> +#include "hw/irq.h"
> +#include "chardev/char-fe.h"
>   #include "chardev/char.h"
>   
> +/*
> + * These are the definitions for the Printer Status Register
> + */
> +#define PARA_STS_BUSY   0x80    /* Busy complement */
> +#define PARA_STS_ACK    0x40    /* Acknowledge */
> +#define PARA_STS_PAPER  0x20    /* Out of paper */
> +#define PARA_STS_ONLINE 0x10    /* Online */
> +#define PARA_STS_ERROR  0x08    /* Error complement */
> +#define PARA_STS_TMOUT  0x01    /* EPP timeout */
> +
> +/*
> + * These are the definitions for the Printer Control Register
> + */
> +#define PARA_CTR_DIR    0x20    /* Direction (1=read, 0=write) */
> +#define PARA_CTR_INTEN  0x10    /* IRQ Enable */
> +#define PARA_CTR_SELECT 0x08    /* Select In complement */
> +#define PARA_CTR_INIT   0x04    /* Initialize Printer complement */
> +#define PARA_CTR_AUTOLF 0x02    /* Auto linefeed complement */
> +#define PARA_CTR_STROBE 0x01    /* Strobe complement */
> +
> +#define PARA_CTR_SIGNAL (PARA_CTR_SELECT | PARA_CTR_INIT | PARA_CTR_AUTOLF \
> +                         | PARA_CTR_STROBE)

Can't we keep these register definitions local to the implementation?

