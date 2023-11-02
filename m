Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 881AF7DEC30
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 06:18:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyQ5o-0008L9-CM; Thu, 02 Nov 2023 01:18:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ5T-0008Jo-1R
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:17:49 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyQ5P-0002e8-4z
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 01:17:45 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-58441865ffaso280905eaf.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698902261; x=1699507061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lY2inARoQiZMh3xseW4GS1PQsOQOAUDy5QVZPxkd6eE=;
 b=rJTsc+6XEbE4Dvwww6KcPI/ZjdcrjS+lkAL/lBtXuFMaOrlBoSNFBu5f/5aDtEo7wg
 NgqAk19gDBL3fJe2K7Wn2JcmB/ZuzBtueBNHd5pttdO7hKKwgOMYAzmSCS3MIceVn2Bz
 DxeOccMtqpt1+IQFbY6OsW9VQ7gahv0Cv3ZoFUFetulzlu52BJbR6/raaerEiisvo0Tv
 wl3rf8PAlmw5lzia+dhVOzY6v38IVmyI1mOBgb/Ev55G7x9j2MFHzl4fbBtrl6i/KU//
 LM4aYP7bzlefO6hLDF/kMsW9pU/I3lyq0efD59YrWm+njGMhz5Btfi9rswfUNJDvTZe4
 qxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698902261; x=1699507061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lY2inARoQiZMh3xseW4GS1PQsOQOAUDy5QVZPxkd6eE=;
 b=dgGtFGY9FhkBCbxuwSZYWYDmkodCUmNMvCog2XCL1GRdzqOp398nsQRm8NRpQSG0H4
 4aV1ILAZ4VR0RxnaheTqzaYG93YgARej/loBN499+tsO7IofHuqzzNPMhTSA5a8QAIn8
 9HXAEmmEodaAG5b0LvTTck9c/KAXFajOmhyJzCzbIQVHY9wDFASNWb1WH00WYD7kMViM
 cvmT8hmJWK2XG7yLQO2SOnai2MeJWeOOfqHSlald8wM6FA1mgsO0GIGT4wOchEQbF11S
 XHBGb8rwMAf6Mr/qcwCPG6qipCA3CNYdCeotahNZ2h5G3i/iwppeI311usWX9mcJZ9N9
 E1Zg==
X-Gm-Message-State: AOJu0YxXRrpmG84/lvK+g7slp2G2JAL9zdhNtFJhHsnO7FZHGRI6mAu/
 rHPdr85tufn2EQ/RpTAxR1A+zA==
X-Google-Smtp-Source: AGHT+IHneQB1e8jFA17FHpNq/fgYSRGl/xcYzaBhjrRYb9vTgOv5T/hitXWvSN/wypROAWAfwIvrKQ==
X-Received: by 2002:a05:6358:2812:b0:168:e69b:538c with SMTP id
 k18-20020a056358281200b00168e69b538cmr18241264rwb.3.1698902261307; 
 Wed, 01 Nov 2023 22:17:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a63b744000000b005b93dee7fa4sm551095pgt.50.2023.11.01.22.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 22:17:40 -0700 (PDT)
Message-ID: <8c32c5a2-d07f-46f1-ad51-92dbc1d3785f@linaro.org>
Date: Wed, 1 Nov 2023 22:17:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/33] hw/arm: Check CPU type in
 machine_run_board_init()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org
References: <20231102002500.1750692-1-gshan@redhat.com>
 <20231102002500.1750692-33-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231102002500.1750692-33-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
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

On 11/1/23 17:24, Gavin Shan wrote:
> Set mc->valid_cpu_types so that the user specified CPU type can
> be validated in machine_run_board_init(). We needn't to do it by
> ourselves.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   hw/arm/bananapi_m2u.c   | 12 ++++++------
>   hw/arm/cubieboard.c     | 12 ++++++------
>   hw/arm/mps2-tz.c        | 20 ++++++++++++++------
>   hw/arm/mps2.c           | 25 +++++++++++++++++++------
>   hw/arm/msf2-som.c       | 12 ++++++------
>   hw/arm/musca.c          | 13 ++++++-------
>   hw/arm/npcm7xx_boards.c | 13 ++++++-------
>   hw/arm/orangepi.c       | 12 ++++++------
>   8 files changed, 69 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

