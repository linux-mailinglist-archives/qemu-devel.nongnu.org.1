Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 545568272D8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:20:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrQ8-0005s4-Oz; Mon, 08 Jan 2024 10:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrPv-0005qw-IE
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:19:56 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMrPo-0004wr-P2
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:19:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336990fb8fbso1864368f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704727178; x=1705331978; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K+osPsFOJQ0Mo4THPwnyg9SyaD9dN1OwJU4TLjAUKa0=;
 b=Inl02+or0gSuJ/nqbg4pDalEUKBaIIG/esgk53qdEqL8XEynycINQn+6l/cZI9FnxK
 CmGf7DqfbjnztIM2KqmKQAtdPXe8jRnO5x3Y0H7NrQcfgsPaOU8tcQ+5XXknHHLka3fb
 hFHZ9Wp7rLqxcGwIR2Uy/9vMP0DE/3cQGN+qZ5KEskIVPZrYvz/OUcNKwMN6m7SE1ajE
 lMXAon/Q1yFPnt37NzbuHOdsgBlVu2y9la9KH1s/VD7Y3D9zEc8Od9uGr89SRFHtRREu
 cYEtC9x4SH2D9LhiYeuXfeH6DchEsPPQCfEacIV0wmAuydopC8FdeCqwXFX2Piw1U7Hl
 Hucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704727178; x=1705331978;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K+osPsFOJQ0Mo4THPwnyg9SyaD9dN1OwJU4TLjAUKa0=;
 b=ZpOGW2LllT1SQ7n9pYHhVi/Hp1younevEVjSxgjqjw2thwDDREYrT9O9A4u6M3gDVD
 Q9aLBHGJki41p4W/nPAyr68x+QRVt3jq8wQkOh4DjSL6XMXiNexv9JIV+0AMOtgtbwr/
 l/+gOLSs3bsVthBnuO2PFO6EakcIl8sKXoRN/R7RNlitPIzOlGv+tI1nnVEVN1cavOPm
 5k0F/freX7ZrsA2W90EBE6HTtmumhjY1yao8YFMq2sYpB08EoWsZZHDg2739Waf9KoWn
 g/zGz95p65J63Iw00OraFavJEx0qTyyQpYdkxfobHXaPSDHZc4zTUSXmWXhuGB5KcCx+
 V/KA==
X-Gm-Message-State: AOJu0YzadOH6ya64CH2K/WU/e5lRqU6UKhmZAKWyEd0G1qBCtmS6ZC0N
 SK9LZWNJwwOtSxAYxmk7eXScWuJ36A2RPxs5pEOWoZ536bc=
X-Google-Smtp-Source: AGHT+IF/DPPljqoPLszV59aAo7I2+MpZ+dT1qxjyA6kedgXHVj7IJ378A2xn086QaxmXzaG3dOZENg==
X-Received: by 2002:adf:fe8c:0:b0:337:689e:6616 with SMTP id
 l12-20020adffe8c000000b00337689e6616mr1229999wrr.10.1704727178327; 
 Mon, 08 Jan 2024 07:19:38 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a5d4f90000000b003366e974cacsm8075538wru.73.2024.01.08.07.19.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 07:19:37 -0800 (PST)
Message-ID: <68443785-d97d-412b-8c65-36865dd38803@linaro.org>
Date: Mon, 8 Jan 2024 16:19:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/10] hw/net: GMAC Rx Implementation
Content-Language: en-US
To: Nabih Estefan <nabihestefan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com,
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com,
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
References: <20231219213255.604535-1-nabihestefan@google.com>
 <20231219213255.604535-9-nabihestefan@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231219213255.604535-9-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Nabih,

On 19/12/23 22:32, Nabih Estefan wrote:
> From: Nabih Estefan Diaz <nabihestefan@google.com>
> 
> - Implementation of Receive function for packets
> - Implementation for reading and writing from and to descriptors in
>    memory for Rx
> 
> When RX starts, we need to flush the queued packets so that they
> can be received by the GMAC device. Without this it won't work
> with TAP NIC device.
> 
> When RX descriptor list is full, it returns a DMA_STATUS for software to handle it. But there's no way to indicate the software ha handled all RX descriptors and the whole pipeline stalls.
> 
> We do something similar to NPCM7XX EMC to handle this case.
> 
> 1. Return packet size when RX descriptor is full, effectively dropping these packets in such a case.
> 2. When software clears RX descriptor full bit, continue receiving further packets by flushing QEMU packet queue.
> 
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>   hw/net/npcm_gmac.c | 330 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 328 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 44c4ffaff4..fe7b0421ef 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -23,7 +23,11 @@
>   #include "hw/registerfields.h"
>   #include "hw/net/mii.h"
>   #include "hw/net/npcm_gmac.h"
> +#include "linux/if_ether.h"

This doesn't build on macOS:

[1116/1645] Compiling C object libcommon.fa.p/hw_net_npcm_gmac.c.o
../../hw/net/npcm_gmac.c:26:10: fatal error: 'linux/if_ether.h' file not 
found
#include "linux/if_ether.h"
          ^~~~~~~~~~~~~~~~~~
1 error generated.
FAILED: libcommon.fa.p/hw_net_npcm_gmac.c.o
ninja: build stopped: subcommand failed.

$ uname -o
Darwin

>   #include "migration/vmstate.h"
> +#include "net/checksum.h"
> +#include "net/net.h"
> +#include "qemu/cutils.h"
>   #include "qemu/log.h"
>   #include "qemu/units.h"
>   #include "sysemu/dma.h"


