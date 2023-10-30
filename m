Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7017DB23A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:18:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxImr-0005RF-N7; Sun, 29 Oct 2023 23:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxImk-0005Qo-UU
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:17:53 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxImi-00067v-5q
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:17:50 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c5056059e0so58022461fa.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698635864; x=1699240664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EZDWAj1ykkJn4R5/rp3f1Fz3f3ygHodsmieKmcp466M=;
 b=zmIiWTzD8gWWWFWNxjeQ/ZypjDUCDodRCTDY8nKLHBiSWJ1erJncw8LUPkVR3eijC/
 2JnjdorEqTUoaP3KZEK/DkrA8h5MomO87YBUs8DhzN4Nq9Xw3mmUDMbcaRUMQTM+dMsg
 1gGiRtCPSHhmentt/AcOPUR+IFmYXspmYI0wFT5rSbeyJHJbdYq9ixl9nQ3fnsz58KT7
 q08HsCYHfMHo1A7EGhWIO3yPJrPxU/nvC9NOxFzCVDF28m2oyvv0NSVbiFlPMzNR6e9n
 +xRDVbCKr96beN0EIJdNxP4A+27Zs5D4eaLKOQkSLbREu8YuV2VX6FccwCpJcwfghV1l
 Bgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698635864; x=1699240664;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZDWAj1ykkJn4R5/rp3f1Fz3f3ygHodsmieKmcp466M=;
 b=V2RzhSFs9FtYowCIXZB9AJ36CFqD+sXl/NRQeOeybPhmYiKLwJlRelaL0TNFmFCAdx
 DTn4d/TckjG6UTDyBZP28wk8wrmxGudDXXMwa8SdenLNTsZzKpMhaOTPL9lu6duLLsvn
 eT/pjPwY9DijiOQ2xE0BKIuRjq3/pSRt5xMugdqy7Q+SlUaMRlH5O25BNy5G/KQFzXxj
 O63b3/m8h0QB/Uwoan/6ecDqvmQcxuh0uBSKucTEYZ3/VeSXUVIiLB0dzU6IuU0ZuOSg
 jqODWygOU/LsCx2PVNonHh/xwZK5G7QIE0F1hXgjP1SGCsnAbZpB08i+wrNPPZZJzaBD
 JwOw==
X-Gm-Message-State: AOJu0YyHNv/hpS3QJj4aFVjd6icAetPG4Z6A0ZiwosFQGjZwOhl2IZo8
 TfzYOj8rXI8N4feOaSAiF7SILg==
X-Google-Smtp-Source: AGHT+IEOpLAOzm7qSabmM28Vo5aaKS60C5sH2RgBNpS1Fm6uCguOrTMCS610koiYqVQ1a2x08Rzogw==
X-Received: by 2002:a2e:bc83:0:b0:2c3:3c0b:d747 with SMTP id
 h3-20020a2ebc83000000b002c33c0bd747mr7670151ljf.17.1698635864024; 
 Sun, 29 Oct 2023 20:17:44 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a1c770a000000b00405bbfd5d16sm8002419wmi.7.2023.10.29.20.17.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:17:43 -0700 (PDT)
Message-ID: <2fe346f1-c76f-7b37-32cf-b9118037b235@linaro.org>
Date: Mon, 30 Oct 2023 04:17:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] hw/watchdog/wdt_imx2: Trace MMIO access
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-2-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028122415.14869-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28/10/23 14:24, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/watchdog/wdt_imx2.c   | 24 ++++++++++++++++++------
>   hw/watchdog/trace-events |  4 ++++
>   2 files changed, 22 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


