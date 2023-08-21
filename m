Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E15A78246A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:24:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXzGR-0001kb-34; Mon, 21 Aug 2023 03:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzFj-00019m-A4
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:23:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXzFa-0002LR-Dt
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:23:07 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso563636f8f.3
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692602576; x=1693207376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KSIred4NO+b1reG+cPK7GB1GUoXoWlc5y3RB8JgEC6c=;
 b=SEpyJ7fJXrRxcbee2BS3ks1AMuNHpl+tQjSn+rYgGV6Jw6K/BwItHPlJCJamfvbCW1
 q5mJIZR5nBAcmLglwILPkwCMNxnPNXHKASR6xME0JgA8YGtHX9fhFe5XeBtd3U4WHQqy
 lKZpQ/UGGftJaDtw/w2FMqOSAYAxnQ1uTwa1qCUv28PoOQY8Q6wMl7gsf2hQi1voz6qk
 mZOv6Ou0qZaItwUsUy3Z5QfEN9ql8SyPdF3GG+nVMFDzRcAMOsXxbw3qc3AO13EUtEx1
 /oV6XMt0tMXma+wtVrG101y9LvD/krKY6+d/che+MgnWxDGmjSdtV61Q053Dj0aY9ulF
 J39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692602576; x=1693207376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KSIred4NO+b1reG+cPK7GB1GUoXoWlc5y3RB8JgEC6c=;
 b=KYUMf3Ks4uyf+4mPnibcjFPpyRMFUMm9l+GjnK6S32/SicsS1PoawwLLHhpPUloA8a
 J1JAblVjtr3DEdEoPhGWv1YNc9rhDBRkHaTpA86uIT1B6yLyoQE1HdBWQ7ItsORzzZg+
 1nwSVcNZmruAOWeUUv5K6pu4h8B8OHWjqttTgYAuv02wZWOYoghr8mPgNKOzydfZWkfm
 HXlq6m6AXr4vsK/o+U8KVgaAfwJh298GZiJ05zJVymhHYoMkOSO4v9TPQpcZtRRfvS4y
 2PMCtLzxGrW1FpaAH4y/iWsrW2efm4Lb36iGr9e7dXEoWgUBSA0ph11BBKXrreUW8qo6
 +qfQ==
X-Gm-Message-State: AOJu0YzAUcHNw2v+Bq12KnYKFvFv/GQSTbgJwRtTn98lFL9GbAfqZFBL
 wyQ0aSjSYnX7RbXkdncov6P46A==
X-Google-Smtp-Source: AGHT+IEu2Mg41io+gjLqTnzUH9o9Qs3CahhTbtvoN5O2tT34NCM6HcSOFyjT22plQvEpwp2e7wubUA==
X-Received: by 2002:a05:6000:188:b0:317:ef6:89a7 with SMTP id
 p8-20020a056000018800b003170ef689a7mr3673808wrx.27.1692602575912; 
 Mon, 21 Aug 2023 00:22:55 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 l9-20020a5d4bc9000000b003113ed02080sm11292781wrt.95.2023.08.21.00.22.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:22:55 -0700 (PDT)
Message-ID: <7709ee34-9caf-9251-8f50-45f1d11f9e0b@linaro.org>
Date: Mon, 21 Aug 2023 09:22:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 19/23] tcg/i386: Merge tcg_out_movcond{32,64}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 00:13, Richard Henderson wrote:
> Pass a rexw parameter instead of duplicating the functions.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


