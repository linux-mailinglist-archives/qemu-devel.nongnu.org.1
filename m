Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE3478B64C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qafvV-0004Ol-Tq; Mon, 28 Aug 2023 13:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafvP-0004O5-Cf
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:15 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qafvN-0007Em-4l
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:21:15 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso27470805ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243272; x=1693848072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K3APTdMaqzSbHUJbvR2TksG+wdRmwUir070tqdw+y7I=;
 b=ZU2k5A+lK/s+T99NSYvF6kuvjqioOIfjiyX06yJhCBrSiX9XzxaIphzbDxr2t5dbtC
 won44NUWtKOt5zPos9Sy99tmUa5xyIfW6WBS7tGCkG/sQR4jSk/sCgpkDNT9GZ5UQNfb
 eLsRhSMQQ23nkWSO9uVYnLU4zznj30TesX5OG4U0zddHTRgYny7r+3yEYh7GObblBpfr
 UJR6WHeydb4vTMgssLzqMMDcklRvje2VOhLr5WA7Ksk0TpqapEtsR60nuwWsUH/tIgpd
 vdhPGVIpSh0TIdYelmOMuCvpcmLNbAn2SDSogD/f4QC332dB4/66yWJ1zsOAi8w2yGn8
 LGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243272; x=1693848072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K3APTdMaqzSbHUJbvR2TksG+wdRmwUir070tqdw+y7I=;
 b=VannBKAwRQvBlY9sbXEW/K7MrU/HidwXA89rC9nNtv/Khq5aWWLxPEZ7MfPDZk8aGX
 /AWEvO/7qZwdk77FUSFBLpAaS/SgpaZtpEbqvKqRoW8oDtmz1GVC3piMAMLiJptBWFR/
 f855e7CixTXkWvyNCMwsq8SHbL/T59jtmJ0V5/NH/OZU1+qjrDCe7iAZElHdAOnrZEjs
 PrGPv/1RSRMfsxBOOaXqb1LyE3U2eBow8lL4D9GxFvtcSE79XrdJHkFYUVlu5rSe53XI
 kVdudfznvF+w15/X5ew5o4ZRrk0KN4jiuCTKQcvl1Z0IElMfPfzwP7OD3YhNSlB4O8Gx
 wpDQ==
X-Gm-Message-State: AOJu0YyNJCKUjhg3jMiou0YrUtZ8GUO68g2OMSb9hhHDf7CgbYT6KJsr
 6UPD1YWGMH/fdvVxvl0e1WMOYw==
X-Google-Smtp-Source: AGHT+IFH0mFo6I3FNka5SyBIaNtCIUX+U6W75pLcXomQo0TsWVMWDDFlrOmFJHhqGy+F/srRZxKlwg==
X-Received: by 2002:a17:903:234d:b0:1c0:7e86:4f6 with SMTP id
 c13-20020a170903234d00b001c07e8604f6mr29434993plh.14.1693243271677; 
 Mon, 28 Aug 2023 10:21:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 c5-20020a170902d90500b001b9df8f14d7sm7575071plz.267.2023.08.28.10.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:21:11 -0700 (PDT)
Message-ID: <4ee47d4a-28ab-1383-da79-c7f513d1efff@linaro.org>
Date: Mon, 28 Aug 2023 10:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/11] tcg/loongarch64: Lower vector shift vector ops
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-11-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-11-c@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 8/28/23 08:19, Jiajie Chen wrote:
> Lower the following ops:
> 
> - shlv_vec
> - shrv_vec
> - sarv_vec
> 
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 24 ++++++++++++++++++++++++
>   tcg/loongarch64/tcg-target.h     |  2 +-
>   2 files changed, 25 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

