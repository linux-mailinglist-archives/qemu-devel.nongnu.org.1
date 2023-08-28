Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 699F578B63C
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 19:19:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaftF-0002OT-1s; Mon, 28 Aug 2023 13:19:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaftB-0002O8-RK
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:18:58 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaft9-0006Z8-NW
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 13:18:57 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so27345165ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693243134; x=1693847934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=41zxM0ErcsIuWXOMIpaW8mcsqCEx6yxiPdicXcNu094=;
 b=cArqoCvjBXIBiGZUuGRO0JcXtXbq9Xgsv1R8RIFFoyhbEFWp6/8XTxNKYaLSWjVdJY
 6irTjzTcLEfLAYh4jfCyRkt3N05y978zpAuFwMtwp4qj5660OqvsgY74R7j3Sl8BBnfu
 QPVMpbJAvlYkmNw7rJOtEBW/DcBTdqZLiA/LjAfyuMEYT+KgmZi+BfwtIOgd7Jul5efa
 xAnYYnKZfRPS0sAXpE4kGXDQx5PYFHheRrU7VttATG0xQbNpwxpk29I9EeAEBpYjWeu4
 nTt0dO9RBgWBBMBGR1Wp3Uviu0bUJjMo51F9oiPpokcYA+cVnY0fWoWULEC5tQClknAJ
 3xWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693243134; x=1693847934;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=41zxM0ErcsIuWXOMIpaW8mcsqCEx6yxiPdicXcNu094=;
 b=ENGhBGzGxgs/jVh4GOzacF4y3n4sHmx4HohOlejSM0igs8WDPAHuRT6pUj5std1MB0
 PMObi4d4y4aoF/o/G3ZJL6qretpm0QrQaS1pbB0xPKdXfKj1sBo45Gog6P9G2sDzg2In
 wltVaW775j3cWJinGvFnPiWlyTahaaWr3CAEVh/3ikvjS4UYKdDeUjs0D5k/9+jp5NUR
 oCrxOuoFo1yvBPxHCrC59tvDuxTlDsSws3eL32vMMhXRGZ7JJiBotp6zyOxS/LzA/Mk+
 DbxqGtlgn/jNPdlxpj3Mh1ayHU/x6mX1HkLxOY8fSHNl5czWwaYuc4Ed4SbY0Dt+QykN
 mh3w==
X-Gm-Message-State: AOJu0Yzs1HgFdHutXCmErDkFp5kHp1YE99S0hp2Q2hrRSbxho5/TU49s
 yWhw+fArQ8qD3hx9W25NRknnvxwuApSD16F/728=
X-Google-Smtp-Source: AGHT+IHYMWrSs0xnHcu95Fpn+6ykwP0c/NREg4QdS+1UOA5ePXR44GOhVwf+cpmDEK+d48rWFeFEdQ==
X-Received: by 2002:a17:903:2450:b0:1c0:ec66:f2b2 with SMTP id
 l16-20020a170903245000b001c0ec66f2b2mr8087112pls.27.1693243134225; 
 Mon, 28 Aug 2023 10:18:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x2-20020a170902ec8200b001b0358848b0sm7642172plg.161.2023.08.28.10.18.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 10:18:53 -0700 (PDT)
Message-ID: <3ccf8b34-bd07-84f5-0bd8-72a28898d77e@linaro.org>
Date: Mon, 28 Aug 2023 10:18:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 07/11] tcg/loongarch64: Lower mul_vec to vmul
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: gaosong@loongson.cn, WANG Xuerui <git@xen0n.name>
References: <20230828152009.352048-1-c@jia.je>
 <20230828152009.352048-8-c@jia.je>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828152009.352048-8-c@jia.je>
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
> Signed-off-by: Jiajie Chen<c@jia.je>
> ---
>   tcg/loongarch64/tcg-target.c.inc | 8 ++++++++
>   tcg/loongarch64/tcg-target.h     | 2 +-
>   2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

