Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA1970FE51
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:14:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1tvI-0006uo-Lu; Wed, 24 May 2023 15:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tvG-0006tv-IJ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:13:22 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1tvF-0000FW-2d
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:13:22 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-51b0f9d7d70so628406a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684955600; x=1687547600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qHfEp2klZmBb7PNsQG4JzgBLwI/EcNiBY2ath1Mdl9Y=;
 b=Bw8avlx1CVD20RKHfLNEaTxlX1YXsXIH+7m5YHZQeiM0JUR2HAYYV5+vjttozfzLqZ
 TxXtxs8MOcxQxY3+6nsGFm3FwgNe0TDOZL1xG7yD3EkNItw4zsGts77s0YWy1DiPoCIa
 y0PWU4G4gZPm3zYY3t8VHZftVeywJlwx7iM9//3LocJtLww+ltyHMWVs3homW5Q365Cu
 bIlgshzZSkxoN7poBSjrGJoRnxfXBGcNeYHi7UIMVfCS5f+PHVkPxoA2nnWAJvSP7VR9
 YmiFT8KDYptuWklnay8lfNkZVfcxcPoeNXN/louVj79DHl0xMRjuWG4ILtd1BGAE6Yuj
 hgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684955600; x=1687547600;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qHfEp2klZmBb7PNsQG4JzgBLwI/EcNiBY2ath1Mdl9Y=;
 b=Q40JaP3w3RFmL29GOKbnzZz9fZpGyyDTEG8kJrpywnYLx8okF4y1rzIfhhvE38BtLi
 4Ss12Y9LQfI9kSZ8lcFZc+cl6pIPTiytGX/LDy7lUre3rQT/8cgOdXf3Ljitc/06b46k
 IXBm614/EZHldoGNyh8lUKFYIOhLW7GznK7BXyJ36kESiDx4MR39EpOeGcxKUsSNGOQo
 0Cs1ky3OXUEGNrARB87iCKvIl7jaoA3QV/org9N/e9Y+hQ+4YGvI3KXAeg3XWZpT9pWf
 MyO3+AUZHCPlgMUPVJsWqiiFFNel4aZXRn+1K43W6lTLS1KbQPet9FMZGifesZArGAao
 SRvw==
X-Gm-Message-State: AC+VfDwUtubhp9Sk0QjAioXW5XjLs1qhLPGBEvLd15egfKQVfSkmXJF0
 fRIzQL+VMLYIGRbnp8jj+zwsqw==
X-Google-Smtp-Source: ACHHUZ7iccO8GOy3+xts3AQ36V5iVF8w7ceZo6HlTeP+8cAqQIGNgyQiHeyLb1NNOHqh/ydVl//h7w==
X-Received: by 2002:a17:902:da8b:b0:1af:a3d4:26e2 with SMTP id
 j11-20020a170902da8b00b001afa3d426e2mr15669061plx.54.1684955599814; 
 Wed, 24 May 2023 12:13:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 jh9-20020a170903328900b001a6f7744a27sm9144101plb.87.2023.05.24.12.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 12:13:19 -0700 (PDT)
Message-ID: <af1257b7-336a-20ba-9456-b11c36754f59@linaro.org>
Date: Wed, 24 May 2023 12:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 10/10] hw/arm/realview: Set MachineClass::default_nic in
 machine_class_init()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20230524145906.33156-1-philmd@linaro.org>
 <20230524145906.33156-11-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230524145906.33156-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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

On 5/24/23 07:59, Philippe Mathieu-Daudé wrote:
> Mark the default NIC via the new MachineClass->default_nic setting
> so that the machine-defaults code in vl.c can decide whether the
> default NIC is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
> 
> Inspired-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/realview.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

