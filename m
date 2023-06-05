Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F867225F3
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 14:34:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q69Og-00045u-4k; Mon, 05 Jun 2023 08:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Od-00045I-Hp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:33:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q69Ob-00037Z-VO
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 08:33:15 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso39717175e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 05:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685968392; x=1688560392;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=49FmC4ipE3UHjBkubeAG5gkW8thDbEKWPzod3HwtL3M=;
 b=eL701mnC8jkagRPYLOjTy0abu24nXm6oeyWR2Zr3Fb0oasHpFeSpG8F7jaJRTHDOme
 0ZsFKB3b7xum5P3J0aNAfHhsagUE9TKO+/cZyxoBvY7tYWZNOsBD2Sf1pwamdRYzUujK
 JGtZipSomutGLCag39BClv1qeLKWgB1CqGaEuXxSbzmH/vXXF9ayeNyelsfLEZtn3Lc3
 jhy/lMV7VCLQXm/CGuJQuZgKbp8ZowVUJJSGvqSjFC8IrPikUstm96mnfnhq1NhBBeQr
 hEbZPfiTSbQPMXvjehpWpYyKpqy3UznRG+hkJPGsbyEDMe7B/6Z86d9A6VVxWuM1tQPn
 NiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685968392; x=1688560392;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49FmC4ipE3UHjBkubeAG5gkW8thDbEKWPzod3HwtL3M=;
 b=GPI1cmg1wmI1lgb6P5/rtJo6aPPXufEOhwXUnDZXTmMzFih0lYHA6F5qDgdBAUgm3w
 /ZCfnH4NU6ZpP0JhdQqvMELAOhmRI/4k36hVImkbFFll62y5snQx4/ViSgCo4+5FwJ8x
 xUF/QwjTTKK4n5UYIKpPL1F5hSRxyvR5p3jwi9garucTwOz274LyFlVWnbdx5nbVWSec
 GI12SyG0C817lYdz1zxlSZGBgG5AJsu5xgEoTAqm1Qbg7SRihZW9xKIl1HDy3+4FesL3
 dMlX6yEJgDnRsltUrEtXur3w98MVkPcGbNO9KdFCB618TtSYuhIu+IpsGDys8KA8fqLe
 AUMQ==
X-Gm-Message-State: AC+VfDyMI84vvUQD8AGT7ultMJyrBv7pDJBDSzuInoUyvZOhzh8C9zhd
 234ET/bfB3lmHqrOcBMs23gmRg==
X-Google-Smtp-Source: ACHHUZ73EcnBADSo2UGKkMdi+zVrOTC/osAmg+5sjj/sZRO6zIOw8+B7HOrHp/AvtVse57ncBp9cpw==
X-Received: by 2002:a05:600c:2288:b0:3f7:3991:e128 with SMTP id
 8-20020a05600c228800b003f73991e128mr2049047wmf.2.1685968392244; 
 Mon, 05 Jun 2023 05:33:12 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a5d5386000000b00307c46f4f08sm9679448wrv.79.2023.06.05.05.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 05:33:11 -0700 (PDT)
Message-ID: <941f0d32-8d90-b956-e76c-fd6e86c0f7b5@linaro.org>
Date: Mon, 5 Jun 2023 14:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 05/23] q800: move CPU object into Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
 <20230604131450.428797-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230604131450.428797-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
> Also change the instantiation of the CPU to use object_initialize_child()
> followed by a separate realisation.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 18 +++++++++++++-----
>   include/hw/m68k/q800.h |  3 +++
>   2 files changed, 16 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


