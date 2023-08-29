Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 844DD78C324
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:15:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawfL-0006Sy-TR; Tue, 29 Aug 2023 07:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawfF-0006Sb-Ka
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:13:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawfD-0006ZI-GH
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:13:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fea0640d7aso40117935e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 04:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693307617; x=1693912417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KQUtbACy54l1VkQtejYEY+kC5qfbTPK4jnYfR0Rj3tI=;
 b=eNC0Qk3ND/FmADd43MwaJL+kvpGJeWjhapOIYhvZQNEQqUgCO75zhtXt8r/8OvAn/s
 Lc9HdeLrkzIob+ruJ/rX0T+d+yrLWeHlm9iyeZ/bFRma7eKXJryTChdCdaiNo8v0pnyn
 yU19RgXByCh744IBgbdiw8Tg2J21AOUFk6GU4QeFjV3a7tMfKuhI6AjP9UiXrlI3kGcq
 AY4iCi2Uz8wMofPy3PY9A0a4otnyMiFRJiBKBevUt0DnhiJ8KTtonXCtrRJ+Ok7G9SWV
 4oZJV4g57LRop90TVIXN6f0ROg38IPzUmG9d1PPkvg340otnoaHAnsg+9mX30BDIp2rb
 geww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693307617; x=1693912417;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KQUtbACy54l1VkQtejYEY+kC5qfbTPK4jnYfR0Rj3tI=;
 b=DqzA2BQfIMdwKhOGL2cOO/hQNYkstFrP6cFNyFwevaLRaB+Y7B3VrTlNDh2R600JYs
 I7buuIcAT7ye9aWf/wojzGgCDW7dtVg4GjYOILT9p1Q/SxSN4IZYvBgwFKYP4eVmEXZA
 vU+MWxd9zk2jt96C8DSlpg7Y06c5IXiDHUm1ACM8XDQAyuf9/Em8X5QKmUE3IjU5gsmX
 XJHa/tV1vFac2SF6pPXss2VljXulJp95fFzfeHl1zlxFOBuYBs8KQQKOT0/ubxPubP3t
 MSGMVgzrB60QBPplaSOwzaJRaTgC9zuyVpBd4RP4DJvaxGgFEVsBWzvK+blKC7cRqyb4
 H4qQ==
X-Gm-Message-State: AOJu0YyylJcBzBdtg0Bic3hapWsI5j21uG27y1AWylN4eWKnJEcS71fu
 3WjFhRiMKbP2UJMuC2e7f69t5A==
X-Google-Smtp-Source: AGHT+IGyV5a6m/bLlMjkns8z0OuBuO1LpgpZglh3wmdFgx/McZmQ+EkeqLykyYe3DPX/mNuqCeTkMg==
X-Received: by 2002:a1c:ed04:0:b0:3fa:9823:407 with SMTP id
 l4-20020a1ced04000000b003fa98230407mr21573134wmh.18.1693307617171; 
 Tue, 29 Aug 2023 04:13:37 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 21-20020a05600c231500b003fed4fa0c19sm16904145wmo.5.2023.08.29.04.13.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 04:13:36 -0700 (PDT)
Message-ID: <eb24f7da-19f7-a63d-7f15-c184f14f446f@linaro.org>
Date: Tue, 29 Aug 2023 13:13:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] igb: Add a VF reset handler
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-2-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230829090529.184438-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
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

On 29/8/23 11:05, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> Export the igb_vf_reset() helper routine from the PF model to let the

Preferably splitting in 2 patches to KISS,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> IGBVF model implement its own device reset.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_common.h |  1 +
>   hw/net/igb_core.h   |  3 +++
>   hw/net/igb.c        |  6 ++++++
>   hw/net/igb_core.c   |  6 ++++--
>   hw/net/igbvf.c      | 10 ++++++++++
>   hw/net/trace-events |  1 +
>   6 files changed, 25 insertions(+), 2 deletions(-)


