Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1645378E2F2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 01:01:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbUAi-0001Et-Uq; Wed, 30 Aug 2023 19:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUAf-0001E6-DX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:00:22 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbUAc-0003nr-5T
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 19:00:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a41031768so150769b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 16:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693436417; x=1694041217; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I7SSduhUWQv7yo8/F0rTBaamEil6mHudIQ5a9xL0saM=;
 b=ltuAJJKFkCHrnibMFOBXkG4y4dzsEvxRE6HYNeFRF1FLnMCwUt6DUv3PaPIZiEXdtg
 dlCotQBtirj6wnQQzuR7ZCTomGpZgpo/t7RJ53MWAghgkWvvdgZWu/5ItlmzJY8THej6
 Gu+FKSR5m85qIag5kbsQ3XlX6CoDeGbmQZlUuCacyfHPPtjoES/VTTBkAvuz8av0A5De
 miHSwZe6DeW5H8E7FUy/cRevhaG/AWyGXruF+MBNyV24pvnAaLlLqLLnt1FkFY1ZdyL5
 rXzyk2iEDAi/daeUWhXs/5iPhv26iPBjBW7VAV5hww1oW+adXtacREodpEZCuPaiiazW
 0Mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693436417; x=1694041217;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I7SSduhUWQv7yo8/F0rTBaamEil6mHudIQ5a9xL0saM=;
 b=Sh0cGGfbvRGhU5RR7eCp2w6lmsMWKgHK/QNYLJZRbmwc7OfKGyO6fD997Kmw73//ph
 N92VSrjWrexvAZ5N9pqMzrCr9aFX1rgG3gSMUIDrHK8UDYG8isC6eaEQZt1zHDKpji3F
 JB6B000D+/ZmDLJ/TcDWmR245hfncl6ZLsWUrXQ3y2YAwrADcKIWesJUGTHDfJhjdbXX
 ncbn4YgmIqdeGqboyeESWyuCZ28OZqkwpemyR8OF+wTFyaQVjMp6qNwQ5wQkz05AYq5P
 PepbnW3bUBaGYyP9N9c8zfi5BRtMq+VEZ8758+zqTcpd+x/H5vxbkyecctF8fo9ux8ua
 Q24w==
X-Gm-Message-State: AOJu0YwBQudauZ+LSgUqHMHV/erIYniBY+Gcgsp3Mhg2E8tByX9rmeP7
 YdZc9S+3Va3yk9wXSasUCe3rJ81wbF6i5rURVG4=
X-Google-Smtp-Source: AGHT+IEyuvp0r1JvnnxgO9BE79vsJqxJFUxO/hUVNuUzCjObuLDJJGj5cGs2k5TLPm4scbJ5Wtr2yg==
X-Received: by 2002:a05:6a20:4290:b0:14d:7130:7bb3 with SMTP id
 o16-20020a056a20429000b0014d71307bb3mr4387305pzj.13.1693436416753; 
 Wed, 30 Aug 2023 16:00:16 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 fm12-20020a056a002f8c00b00686b649cdd0sm95709pfb.86.2023.08.30.16.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 16:00:16 -0700 (PDT)
Message-ID: <42b291ed-487b-e59f-d703-e3c406ab8044@linaro.org>
Date: Wed, 30 Aug 2023 16:00:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 31/48] target/loongarch: Implement xvsrlrn xvsrarn
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230830084902.2113960-1-gaosong@loongson.cn>
 <20230830084902.2113960-32-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230830084902.2113960-32-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/23 01:48, Song Gao wrote:
> This patch includes:
> - XVSRLRN.{B.H/H.W/W.D};
> - XVSRARN.{B.H/H.W/W.D};
> - XVSRLRNI.{B.H/H.W/W.D/D.Q};
> - XVSRARNI.{B.H/H.W/W.D/D.Q}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode                |  16 ++
>   target/loongarch/disas.c                     |  16 ++
>   target/loongarch/vec_helper.c                | 198 +++++++++++--------
>   target/loongarch/insn_trans/trans_lasx.c.inc |  16 ++
>   4 files changed, 161 insertions(+), 85 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

