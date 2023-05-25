Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0F471071A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:15:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q267V-0003p3-2E; Thu, 25 May 2023 04:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q267R-0003oo-2n
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:14:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q267P-0002cv-6s
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:14:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6cbdf16d2so2051495e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685002480; x=1687594480;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNdecoAq2Rjqipza+KMc32wG3VY5/+2OGEbpVA0JfL8=;
 b=i0A3fnb89fjuWnJsRYcRUcFf+qxQ4ayVRiHw8H2jChmldBatMK8doJClUssenVMrE/
 yKo6AJ6LnHaB5kEwEJ/vbtgGG8kRlzwvbapRZwbLojvpt2OWlNbC2Pg9JAsBL1W13tjq
 1h27qrPdh5PceUsDxhpXDFVxx9iYdBYitT9XjPeIP9A9oP+MEfV4AGry4lQff3SLD7nb
 8SktIkCo78iSKKrqHI0eWDfPpEMJkkvSvoR66nWvu5TO16P0WIDYpnoutN4c7kq0SUGt
 mj/7adzwC3PdWG3QnXhBfD+SRciez8RnYGLFSuNKEG6Th2tKCjsuygxqkyQW6Wv3lXD5
 wzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002480; x=1687594480;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNdecoAq2Rjqipza+KMc32wG3VY5/+2OGEbpVA0JfL8=;
 b=hxNd0SkyoxgkD0me/FOs6EbxDNriCSUKmKGsbCOSyDzCYi9OO5s2UaHp5nl9OSzT1G
 1qc1LFFTSouh7l0eeVQoB4d/ZownbQdnn2S/hO1PBhuSCVpNGkby/MPApCJht+iIQs1J
 MaqBbv/Z8p8eeAr5hXKZNsU0brCx1+/oVhjt7/NDOT0AuDoiL3k0n241ZdYjKetVdh4m
 aLRlyJCO3XyL9zchPuys3aTWYAzWh0708qbxBHVXFtZTGurjXRTV3nUfz3lrAqIvhCK4
 Y6A6QQ8gglkdpYx03QlAcUTdEPcftdRuw8MGONREo1ShI+1R5GzxG6yPvuv0k5L+SZhW
 FeXQ==
X-Gm-Message-State: AC+VfDy7UVbScOWJvP9tOwLg2HEr+cTqf1WiHIWyLExcyW6UsofMcCTX
 Z0fHjGQC4C2Yp48hgzIecwEHnw==
X-Google-Smtp-Source: ACHHUZ6zWMcEgbLVf6IKLehp1fNWIZAq9XnHEQUsFBcQRZmzuPrNLEC4S/pzhms5LeHfVQ++UvSkyw==
X-Received: by 2002:a1c:7304:0:b0:3f1:9b85:e305 with SMTP id
 d4-20020a1c7304000000b003f19b85e305mr1824459wmb.34.1685002480026; 
 Thu, 25 May 2023 01:14:40 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 c3-20020a05600c0ac300b003f50e88ffc1sm4929199wmr.0.2023.05.25.01.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 01:14:39 -0700 (PDT)
Message-ID: <d1487606-f8db-6ada-1f08-fed5b4ae9d33@linaro.org>
Date: Thu, 25 May 2023 10:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 10/30] q800: add machine id register
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-11-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-11-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> MacOS reads this address to identify the hardware.
> 
> This is a basic implementation returning the ID of Quadra 800.
> 
> Details:
> 
>    http://mess.redump.net/mess/driver_info/mac_technical_notes
> 
> "There are 3 ID schemes [...]
>   The third and most scalable is a machine ID register at 0x5ffffffc.
>   The top word must be 0xa55a to be valid. Then bits 15-11 are 0 for
>   consumer Macs, 1 for portables, 2 for high-end 68k, and 3 for high-end
>   PowerPC. Bit 10 is 1 if additional ID bits appear elsewhere (e.g. in VIA1).
>   The rest of the bits are a per-model identifier.
> 
>   Model                          Lower 16 bits of ID
> ...
>   Quadra/Centris 610/650/800     0x2BAD"
> 
> Co-developed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 29 +++++++++++++++++++++++++++++
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 30 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


