Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283EA720DA9
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:40:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5I7T-0004mm-KJ; Fri, 02 Jun 2023 23:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I7R-0004mE-JJ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:39:57 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I7Q-000823-1q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:39:57 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-51b4ef5378bso2586332a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763594; x=1688355594;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NlH9wFa/Tg1NFPvbvul7qqorRkiEXNfgh17a6WJv1eo=;
 b=ozO8dREWKjh9uVtni6gcA3CmBdKACRe/L2fqGAwrY+4NeVwy2WiIQ7cjIcGRR/j7BV
 CSLglzf7Fr0C+NUG/PCAC076yHEMXZyr7KCQh2RbrJar++jhoHOBuagusMWH9wuvoSqK
 pMl66wUh4k+2bUBrGpZAKwvEBZ18wsVT7AHX6hg7vg5968/KZLt35pf+zQTo2Y0UDu0O
 9NOdXpyFWMDxRZ0JlJkM6yqgzN6SJFngZyA/CTEnrk1xdBCGMJeIaG4em80GvKKG/VxC
 hpKg9PrGle2QRsBgRsFLrIEC3dXrHzjgmiMH1hnevQLw2ZPGX8zEk1mUrjowJ7LzrPIb
 8cNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763594; x=1688355594;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlH9wFa/Tg1NFPvbvul7qqorRkiEXNfgh17a6WJv1eo=;
 b=Sp3DxoJIPkT573Q9QRTqhKq7T6s97lcMcOq2t5p3SXba56AglWlOIHt2oZr0JJq8Am
 jaq1t2M/JpnzbaxOR5/hn/UDD6ps/oG/a8f+m+2a6c6Zl84JeW5nc4/CBswN7TBj4Q3U
 SC3xWNd/ycdLo3KMgRLAD4Y1ptJmo1OhLw+lO6qi0Z6PcBT8gFeIvYrg15x1vRUEeDe6
 zSaU4IbDwBv904RLVq5hNcUJuOhcgBtHSjjn7c0sXmwF4j13cRkJa2NUhuaGeqt9GZqZ
 rSL9UAGPSf5wgtWPubO+ZHSL3KMeMZRS0YzqqInIrFybDm0VtHYjiSfqlcF893hFXCXM
 lecA==
X-Gm-Message-State: AC+VfDwTw8aWKF4TM6Xn375SZLx50od+S7QOk5T9oOLWCDQk/1uXXETV
 0BPXmn8OuKq6HAIigZTKlGK0NQ==
X-Google-Smtp-Source: ACHHUZ52OFmmUTGca5Naw2LJuyBMS+8e/32RlO1WyTqWKR5wqIdNinCntEpXBjACp0Zgg9fG4wzpew==
X-Received: by 2002:a17:902:cec9:b0:1ac:84dd:6d1f with SMTP id
 d9-20020a170902cec900b001ac84dd6d1fmr2206498plg.1.1685763594456; 
 Fri, 02 Jun 2023 20:39:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a170902a38400b0019a5aa7eab0sm2123952pla.54.2023.06.02.20.39.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:39:53 -0700 (PDT)
Message-ID: <6d9d948f-6344-227b-aac3-038e7d47b0c4@linaro.org>
Date: Fri, 2 Jun 2023 20:39:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] target/hppa/meson: Only build int_helper.o with system
 emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230602223016.58647-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602223016.58647-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 15:30, Philippe Mathieu-Daudé wrote:
> int_helper.c only contains system emulation code:
> remove the #ifdef'ry and move the file to the meson
> softmmu source set.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/hppa/int_helper.c | 3 ---
>   target/hppa/meson.build  | 2 +-
>   2 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

