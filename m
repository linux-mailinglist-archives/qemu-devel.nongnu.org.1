Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E8F7DB244
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:24:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIsm-0000LA-C2; Sun, 29 Oct 2023 23:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIsk-0000Kc-V1
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:24:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxIsh-0006wO-V0
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:24:02 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9adca291f99so593351566b.2
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 20:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698636238; x=1699241038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUZOix7+S8UCeIxe9GrXyoIQmjmVxlOACYTBe+fKbC8=;
 b=dwTDjxbBSpvszEPAjqoCzlNC0dYJQP/hxe8owDLhjouYX5/jlffT9MgHEQGQKV9kLz
 Hae01k4Rua7lfBYDvaLp8T1zEWs4Ixfa7C8UGWYudE//LM2Z4681E9VWqym1GqvD/puh
 bm11kHrJrAi3hrW0Ahxw73VykrICmrHErlbFzhi29mpwVfcdu8nlM9q61VtZkOrnXHay
 NK+eVdHemBBLHU1jKg3F1U8Czr8OuLtb505L3dcpuni89Ugn2vCSK6Am/NAQti3m0m2q
 uVlIoalBwPqUQrnbG1zzWUZrHvPx009kVvkyGRgbVKsYpcwcp3p3LgewHXFyDZWMk6h+
 DjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698636238; x=1699241038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUZOix7+S8UCeIxe9GrXyoIQmjmVxlOACYTBe+fKbC8=;
 b=FnEtw15dw7ttdQLNYNV+eACwLZ2W2CTeF3dqxS5XHEOVkQH1AsGDLkzJLD8pSV6KmW
 tNhmdfarz+hZDMIt6H7w9PrIDRUn9CKUF2NCzZ3Pb0O2NBLHzjSB1/ZUZM9C2BRenaQZ
 bQgSdG8xK0uNjX0b4985/TiPzAEb0feFEO5BsCAZy4YITa6Hxu+bijvTf5lGy+zDiQjp
 SFaC9e9JXLwrQvTalh7dxaVPtD752MYat6CaQezMnZLBGn8/NXxtiX8KEFRfqL8BiDf9
 RGpaBRWp6b5QX0iKQGT4on9P7tTma3Yd/khDT396YWBJrfDlCQXy1FR/vi2TtG66nT28
 J1GA==
X-Gm-Message-State: AOJu0YwcC6qQ2J+qNchO0qYiQadTf8ztJwN8vRwFL7nBm5KEqSezCppf
 PZuO3/DeEemep/8LSC7USC1P6g==
X-Google-Smtp-Source: AGHT+IF8oDqO0yfFFVdns9uvWb9dJT45/e7BRbmxIluTDCdBqc1FFZjC+LLSz0Q07ac7HzVtZd+nrw==
X-Received: by 2002:a17:907:2cc3:b0:9bd:bb63:49db with SMTP id
 hg3-20020a1709072cc300b009bdbb6349dbmr8459604ejc.7.1698636238037; 
 Sun, 29 Oct 2023 20:23:58 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a170906541000b009adc5802d08sm5286362ejo.190.2023.10.29.20.23.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 20:23:57 -0700 (PDT)
Message-ID: <7e52e29c-46c8-483c-cf5a-b6e6ca18c655@linaro.org>
Date: Mon, 30 Oct 2023 04:23:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 4/6] hw/misc/imx6_ccm: Convert DPRINTF to trace events
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>
References: <20231028122415.14869-1-shentey@gmail.com>
 <20231028122415.14869-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028122415.14869-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Hi Bernhard,

On 28/10/23 14:24, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/misc/imx6_ccm.c   | 41 ++++++++++++++---------------------------
>   hw/misc/trace-events | 15 +++++++++++++++
>   2 files changed, 29 insertions(+), 27 deletions(-)


> +# imx6_ccm.c
> +imx6_analog_get_periph_clk(uint32_t freq) "freq = %u"

Preferably explicit the unit, as "freq = %u Hz".

> +imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u"
> +imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq = %u"
> +imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq = %u"

> +imx6_ccm_get_ahb_clk(uint32_t freq) "freq = %u"
> +imx6_ccm_get_ipg_clk(uint32_t freq) "freq = %u"
> +imx6_ccm_get_per_clk(uint32_t freq) "freq = %u"
> +imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock = %d) = %u"

'freq' is uint64_t, but I suppose 32-bit is enough, so I'm
not against the implicit cast.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


