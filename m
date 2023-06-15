Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D8C730E99
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fNE-0007u5-10; Thu, 15 Jun 2023 01:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9fN8-0007tb-VR
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:18:16 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9fN5-0005nZ-BO
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:18:14 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4f7677a94d1so2135508e87.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686806288; x=1689398288;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tq0dObVm08N0Z4PKBmny38EYOY/HT8V/m/4hsxnRTOE=;
 b=t+LmKHADMGfAh58RJcp7IzNABD4OysJjZGVISuQBg+dD+Nw4XKfMThtgtg/+RN25lu
 y0OznEz9KdvktnlodZvOTDOhqRtQdOryLJPqu5umzQGgO1QbFnapXU8+02cX+lhxl2//
 vnGHyl0KzorNcVzEU6kkkBHrAMG4INbNMQPzfPDArpY6Ujd98u3zojXrp2+IBAl3G+ql
 AnqFMdKWP1SAHFigTq+iLJRpPdBs/6MEhMlJ0MthWX4xw3vAFz9GxKXTKYt6lmYGgoDm
 65V0sgmFJq9p64i7NApxX08qdBRJAM204ULxZ9JrfBUUAXWcgn3nBGv/Fmon5WnlLzBO
 PyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686806288; x=1689398288;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tq0dObVm08N0Z4PKBmny38EYOY/HT8V/m/4hsxnRTOE=;
 b=Jf5gqgO3eLcZAA2/OT2pTjSFeDGaVcwKC4VK8kbpZE7wAHEHwAiDrG3dTHE4q7jV9j
 oFANAFZA1cTSYzBW/thWUdkB3Mp+LkXpN0hvYTLLxOtI2+AC7RYrrvbESCD5YFoC6RRD
 crPHNCo/UEMeOsoFAVhdD9WsurO2ikd6A/kGGBqhTfEOFqlmeNJt/ZJfBVpUlE14RSpd
 eNFaQeSKcUAlTKt/NYi6BZME8OBfnDDIXcJ2ybSktD4lBeOsSUwFVizwlUkdKYYyS3U3
 6UI7d/npKhUmS72yCbm0jEjVEEEJkxAHaM27qF+qTaOtqs0eCmsS5ngv+/bZdKbRFkVu
 OA2g==
X-Gm-Message-State: AC+VfDwoz4uai58pIu13eudj7x88gLKviw9nRbdq17xmxI8wSZSkSrpp
 34uOfik6jHWFnsRnn4brSef8pA==
X-Google-Smtp-Source: ACHHUZ5JMdxfK2MhfhlOTBVEjaQi2LZgTSk+WbMEReZWV0f0/d7LLy3Ts/lvynmmyMGxfa6sWVB8rA==
X-Received: by 2002:a19:da01:0:b0:4f6:198d:2afc with SMTP id
 r1-20020a19da01000000b004f6198d2afcmr4584907lfg.37.1686806287466; 
 Wed, 14 Jun 2023 22:18:07 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a1c721a000000b003f78fd2cf5esm19218576wmc.40.2023.06.14.22.18.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 22:18:07 -0700 (PDT)
Message-ID: <94654301-752b-15cc-06e8-01402858b64f@linaro.org>
Date: Thu, 15 Jun 2023 07:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] target/tricore: Introduce priv tb flag
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614165934.1370440-1-kbastian@mail.uni-paderborn.de>
 <20230614165934.1370440-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614165934.1370440-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 6/14/23 18:59, Bastian Koppelmann wrote:
> +    uint32_t tb_flags = (uint32_t)ctx->base.tb->flags;

No need for the cast.  Otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

