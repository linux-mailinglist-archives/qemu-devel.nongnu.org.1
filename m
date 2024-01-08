Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A44827B54
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 00:15:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMypL-0003fU-8K; Mon, 08 Jan 2024 18:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMypI-0003ba-LG
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:14:36 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMypG-0000aM-R3
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 18:14:36 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3374c693f92so1986838f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 15:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704755673; x=1705360473; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cU9XPHoclqEeRy1KkF1HJKic3tB/ViVBZim3kjYaLVc=;
 b=KUZiQQg3o/Bco2Qw7AYjSbgO0T9X6INAFli9w4Ay1TBvECRvKIpoSGahwZark9KjR/
 XrN9YbrljW8eqXl73rRoDlFrNv7w7M4Hlx2+ChpWXsgGFcmXnEZXQQjwH7bIrS28fVO8
 hAFBZnHRLP7LmiDlF2hAYgtT/bS7fS81+f8nbthq5RhxHeApMRUq0TP94Wgu32J42R0E
 vcpYQ+Kf6azKQf6PV3LpcBFtb2DlTJneiKedP3aHZ8SvQ2cLVS4rSE6X9ArbF0n3LJRj
 rbf/IwVfNTtD3yYT9kF+dVzXGdCI4aV8BJGqe60yi2tqEPyI15ERTrpjpsl/fA2ndZxl
 H71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704755673; x=1705360473;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cU9XPHoclqEeRy1KkF1HJKic3tB/ViVBZim3kjYaLVc=;
 b=Ayr4Po1bm3YHmvVMaceUvOmB8eY/nK1UCE+f4ZyUsOaTII8645wunwzXB48jzOMGdd
 OzvYu/gkHevb7+WW32IchqPCuvfsJ49hXP9zeblx7dR7ufXXhLAFCEz4yFF372Z8De5W
 a3rDvUg3ODSf+2rnXK1+5j6P+6A7HCvohCBtB0rc6ARdDfCloJIZG//FMTkJsvw2EAyK
 mAP19nS/eoGUgNk7CaNNI/M7D6wR72+61yTVYM9S0jUDOz9PX7ZEvMpAnLRuJ0uxPc2K
 gFE2raEIAYknx41OqclxB8Qo6teJsHEZo6ybnM2wIbCkKorg0lSXcMx247bhhLsfSTrW
 JLdA==
X-Gm-Message-State: AOJu0Yw1MljbZgxpsBQhtKw3bRGvgH0cKKU66xm104IyHvO82zEjp1Qv
 mMJjF9QxGVgxOO4+yoQDKw9ZYUEgOalOG1cVniM2dNUMRSs=
X-Google-Smtp-Source: AGHT+IHA6A9cg/eCkTL470fBhbkWbBnARjoQUuupH3k8sGz5vabnhyXxWrSxHSu0HS8hlvMHI96ORQ==
X-Received: by 2002:a5d:4046:0:b0:333:2fd2:815b with SMTP id
 w6-20020a5d4046000000b003332fd2815bmr90488wrp.120.1704755673236; 
 Mon, 08 Jan 2024 15:14:33 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.16])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a056000128300b003376dbc75e9sm788091wrx.14.2024.01.08.15.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 15:14:31 -0800 (PST)
Message-ID: <58a28201-7f26-4637-b311-4c291dd7aa7a@linaro.org>
Date: Tue, 9 Jan 2024 00:14:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/10] hw/net: GMAC Rx Implementation
Content-Language: en-US
To: Nabih Estefan <nabihestefan@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com,
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com,
 kwliu@nuvoton.com, tomer.maimon@nuvoton.com, Hila.Miranda-Kuzi@nuvoton.com
References: <20240108222747.2453106-1-nabihestefan@google.com>
 <20240108222747.2453106-9-nabihestefan@google.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108222747.2453106-9-nabihestefan@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 8/1/24 23:27, Nabih Estefan wrote:
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
> When RX descriptor list is full, it returns a DMA_STATUS for
> software to handle it. But there's no way to indicate the software has
> handled all RX descriptors and the whole pipeline stalls.
> 
> We do something similar to NPCM7XX EMC to handle this case.
> 
> 1. Return packet size when RX descriptor is full, effectively dropping
> these packets in such a case.
> 2. When software clears RX descriptor full bit, continue receiving
> further packets by flushing QEMU packet queue.
> 
> Added relevant trace-events
> 
> Change-Id: I132aa254a94cda1a586aba2ea33bbfc74ecdb831
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> ---
>   hw/net/npcm_gmac.c  | 324 +++++++++++++++++++++++++++++++++++++++++++-
>   hw/net/trace-events |   5 +
>   2 files changed, 327 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
> index 44c4ffaff4..54c8af3b41 100644
> --- a/hw/net/npcm_gmac.c
> +++ b/hw/net/npcm_gmac.c
> @@ -23,7 +23,11 @@
>   #include "hw/registerfields.h"
>   #include "hw/net/mii.h"
>   #include "hw/net/npcm_gmac.h"
> +#include "linux/if_ether.h"

Still doesn't build on macOS:

[1215/1649] Compiling C object libcommon.fa.p/hw_net_npcm_gmac.c.o
../../hw/net/npcm_gmac.c:26:10: fatal error: 'linux/if_ether.h' file not 
found
#include "linux/if_ether.h"
          ^~~~~~~~~~~~~~~~~~
1 error generated.
FAILED: libcommon.fa.p/hw_net_npcm_gmac.c.o

