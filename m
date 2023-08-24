Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6348787488
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:48:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCYq-0006fP-6O; Thu, 24 Aug 2023 11:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCYm-0006eY-6P
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:47:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZCYj-0006ez-Si
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:47:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31977ace1c8so6091051f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892064; x=1693496864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d7uTEaYhffoTdd19BViGveR+NpC3t/cRU3Ix58EgIAA=;
 b=B+xnLBu/Pkq6Yh4DBb+wiliuv6RIiLQ1z7Vj0wVOdYT3MNOycKkPTkN2rJYspE2Qor
 ln++MwJ9muDTYBnECK7wCuqhtyVjPFE6Q7yci/c8LFx68rApP6jIciCnaM5Ywqil/R8x
 YN3+WJp1xkWCoRTb3kSaIrpNlT/6SL9umTWR8UNnay5PPDSsViXF2KmG0FnHvG630eNP
 JcaK9lLSx60K7CFFmX7E9IiJ/QGUqrgjX/s9rnH/4/xVFssdHODd34J/amRj7Aoo/Cvt
 jj0vzA4ICsN88FCVdB4P3jepTBb+O7qT4jrGLwlwWrM9XKFnRO3oiXCtWS9jlgAvA38o
 zNUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892064; x=1693496864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d7uTEaYhffoTdd19BViGveR+NpC3t/cRU3Ix58EgIAA=;
 b=QEw7qxbcASulefJr3bAS/MrjwmED/7AFubLu15vaLroLQ7jsh7BDIQy76HZ4FYvrt2
 oqAn+bsTbcMvhwfFaWFkH3ahm1q06eqyjJ0lMcCkPhQz2/AqvxuUXyrt9VSgZZMk+eme
 piKlcKqphCT9jxE5+gAmwwPkuJ02P6rkafozACaFjF61Xk6HzViX0N1is79yfLDuS5ht
 DcEhUpjQUvXGAV56vu+o2VYDz2/UtNPLI2ru8+uGrlG/SSVTCB+ztFFz0q956qC54l9D
 WMOyOb/9J2WKTJOnODT/nruh/2XCtnvCLCOkGeYPIH/8fz/QQEltq0cKfzbDLxUI/tJw
 DjkA==
X-Gm-Message-State: AOJu0YzMoST/hBxSpQarmXdhSXxaeTWSxiC3Y4NoxIE876nsOp4Q0CKH
 QEygiWBSZ3EetVTiGYKft3gppg==
X-Google-Smtp-Source: AGHT+IF0qjCq1GKVpImb4+2tvhePm2pYlA38uGoCHl/DludViqFR8jX0B8VHBIWY6symkz76wx6VDQ==
X-Received: by 2002:adf:e50f:0:b0:317:5a99:4549 with SMTP id
 j15-20020adfe50f000000b003175a994549mr12582097wrm.0.1692892064053; 
 Thu, 24 Aug 2023 08:47:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 i9-20020a05600011c900b0031c6581d55esm7661242wrx.91.2023.08.24.08.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:47:43 -0700 (PDT)
Message-ID: <663d4cd3-50d5-d5db-bd43-efc55fe6bbf0@linaro.org>
Date: Thu, 24 Aug 2023 17:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/4] hw/net/fsl_etsec/rings.c: Avoid variable length array
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824153224.2517486-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/8/23 17:32, Peter Maydell wrote:
> In fill_rx_bd() we create a variable length array of size
> etsec->rx_padding. In fact we know that this will never be
> larger than 64 bytes, because rx_padding is set in rx_init_frame()
> in a way that ensures it is only that large. Use a fixed sized
> array and assert that it is big enough.
> 
> Since padd[] is now potentially rather larger than the actual
> padding required, adjust the memset() we do on it to match the
> size that we write with cpu_physical_memory_write(), rather than
> clearing the entire array.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/net/fsl_etsec/rings.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
> index 788463f1b62..2f2f359f7a5 100644
> --- a/hw/net/fsl_etsec/rings.c
> +++ b/hw/net/fsl_etsec/rings.c
> @@ -372,6 +372,12 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
>       etsec->regs[TSTAT].value |= 1 << (31 - ring_nbr);
>   }
>   
> +/*
> + * rx_init_frame() ensures we never do more padding than this
> + * (checksum plus minimum data packet size)
> + */
> +#define MAX_RX_PADDING 64
> +
>   static void fill_rx_bd(eTSEC          *etsec,
>                          eTSEC_rxtx_bd  *bd,
>                          const uint8_t **buf,
> @@ -380,9 +386,11 @@ static void fill_rx_bd(eTSEC          *etsec,
>       uint16_t to_write;
>       hwaddr   bufptr = bd->bufptr +
>           ((hwaddr)(etsec->regs[TBDBPH].value & 0xF) << 32);
> -    uint8_t  padd[etsec->rx_padding];
> +    uint8_t  padd[MAX_RX_PADDING];
>       uint8_t  rem;
>   
> +    assert(etsec->rx_padding <= MAX_RX_PADDING);
> +
>       RING_DEBUG("eTSEC fill Rx buffer @ 0x%016" HWADDR_PRIx
>                  " size:%zu(padding + crc:%u) + fcb:%u\n",
>                  bufptr, *size, etsec->rx_padding, etsec->rx_fcb_size);
> @@ -426,7 +434,7 @@ static void fill_rx_bd(eTSEC          *etsec,
>           rem = MIN(etsec->regs[MRBLR].value - bd->length, etsec->rx_padding);
>   
>           if (rem > 0) {
> -            memset(padd, 0x0, sizeof(padd));
> +            memset(padd, 0x0, rem);
>               etsec->rx_padding -= rem;
>               *size             -= rem;
>               bd->length        += rem;

Maybe we can add this for clarity:

@@ -468,6 +468,6 @@ static void rx_init_frame(eTSEC *etsec, const 
uint8_t *buf, size_t size)
       * minimum MTU size bytes long (64)
       */
-    if (etsec->rx_buffer_len < 60) {
-        etsec->rx_padding += 60 - etsec->rx_buffer_len;
+    if (etsec->rx_padding + etsec->rx_buffer_len < MAX_RX_PADDING) {
+        etsec->rx_padding = MAX_RX_PADDING - etsec->rx_buffer_len;
      }



