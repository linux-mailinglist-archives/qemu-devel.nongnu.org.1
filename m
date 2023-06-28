Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A78A740FEB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:17:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETAF-0007BU-Ph; Wed, 28 Jun 2023 07:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETA8-00075f-5K
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:16:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qETA6-00017R-KP
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:16:39 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-313f18f5295so3658798f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687950997; x=1690542997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MtGurHEeYBwGEy635q3RYNveqNhidMZBB2vN3AYV2ik=;
 b=ygcGZ8G1gTV8jacsvTo5zgsPTLggntorSw6OrgtIkJzeOH3T/gAhWs8DbHUV+Y+FPk
 hGYMvNxBX8wx96TiFdiz6ZexU1fjBdJkURkGAv/sFf9Ixs2lz8C4IqSQWF1FXfQ7vtju
 ixsl9hHsVMQnNFCgtRGPJwQzzcqmVZGzcGkhNuYClQGR5rwofWJaSdCmSTYQuHJd/ekk
 dSgGHXpkJEDeBEGxAJ5QKRnQRsLVBAgRehnoi6tX91wPMYNQ1Npx4tOqv40Midw8YpcK
 0VXWfS/pSYPpsRIlA7TqYu6dkYad+PJQtt3ClQnq9t0+ry2t4J4tSYgi08c6y/jkhbHE
 Bc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687950997; x=1690542997;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MtGurHEeYBwGEy635q3RYNveqNhidMZBB2vN3AYV2ik=;
 b=OVhZ83jn0ev9Kc3QyZ7rhhCV4bfGJFknYSzSbiA8GiN5H2bLgN7P/DbPCZIJTs4LaA
 87l9sFuXJNWrL5CNYjO0zAEGp6Qxnma4mxjdoSZWrSc2XRoqwA4miv1dyPCLH1Pccr6R
 fEfrpViuS1v9MePVssEquRpm3nb8wI6urBYLeNoIujxWXXcMiV78jE4ovlkeI6ZuHwK4
 kJ34JE3xq0yKVDYKjD/vs1XE9bSfjBrhaDKwIb4utrj826WVBEGpwtTT2Zt4hk4YKqYJ
 acCTeqe6C50hPz1d0EL/gZMflmawzg/WvymxopcCZ5rP327WmkcYN5CVONBoDWMgKrfN
 UyvQ==
X-Gm-Message-State: AC+VfDwL4jhLVUvb54YKgm4nZyCzUUxDztY0qB6jiMzbJgWeI4P3jTx/
 c7lRwBRu63fwKfDic3dFxtr3Aw==
X-Google-Smtp-Source: ACHHUZ59GKKe/sc6gmcXDx7k6bRbhcq0fYcz5G+zVFdQX4U3qUFmSWgEdGkRihCra7OakuuxYZ501Q==
X-Received: by 2002:adf:ed88:0:b0:313:ebb0:ca5d with SMTP id
 c8-20020adfed88000000b00313ebb0ca5dmr10102410wro.44.1687950996786; 
 Wed, 28 Jun 2023 04:16:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm6423383wrx.59.2023.06.28.04.16.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 04:16:36 -0700 (PDT)
Message-ID: <8e8a4714-84d7-8be7-c9ca-f6ed2a70db68@linaro.org>
Date: Wed, 28 Jun 2023 13:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] hw: arm: allwinner-sramc: Set class_size
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>
References: <20230628110905.38125-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628110905.38125-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 13:09, Akihiko Odaki wrote:
> AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
> advertised accordingly.
> 
> Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/misc/allwinner-sramc.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



