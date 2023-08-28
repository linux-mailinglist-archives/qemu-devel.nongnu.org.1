Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 334F578B71F
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagoU-0002tY-4b; Mon, 28 Aug 2023 14:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagoE-0002oL-Ef
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:17:56 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qagoB-0002gl-L1
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:17:54 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso20048375ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246670; x=1693851470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajoirPU+O5gFvBADikOxLmSwmaZAgccLNxDOexeHJFI=;
 b=jiayMnmPuYZOXppqrPAxjYGzF04iHyncMnXD6uqeXVwnKRfBUBa7jrrYtcJPQLKkfe
 YRjTZ9D47HaX2Uy0J+RrXmpk1POu9V1oiD7AF6AZTa/LntYJPcaTn3xl+M4MqRk8x6F6
 FEIk4AT+aWIyf6o8NLDKxTvl7ksu4FH5F9MrGBuNXtL8aTeAU/pQmNQSt9G8VTX/U6F4
 3eLWs3k6lUg6g3kDpVaME3v4Bs/u+nm8iOloI7I4sFwkD1l8Vj3u7JmVwJp9VC9G1SRQ
 +F9lMI6YjzdW+FYYyFIezakJTr4Fq4t2soBNEvbLOgFXqSdgVc4jCg2TyTtbCVBRqVO5
 e0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246670; x=1693851470;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajoirPU+O5gFvBADikOxLmSwmaZAgccLNxDOexeHJFI=;
 b=Drit5MF6S5tUsRaJ3uLdomPA6NFMC2eEHCe2514LnZ60DlYo1yPMRYV6hdI3S/pqQF
 2e2VdiY+KioaXC4VeJo8EClekjoXxV3EkIlAmlDaauF8yq82ctQAsBcJKOAQxMYQxWbS
 48Z7PZD4TZijPv0gjwSl23DYcErMtGyeiUwHACETh/zYJqH6EkO10p1JLBLpA3f3TJ1e
 34AMKYIUqjdQcDj1gxQ7csdneutll7/AZW/ZRrL8jlCV/RrS3OtE0AnQ1mrdDZEhaU0n
 0DY5MdYCDKKrj1dfXL7wT9FxEywMijwZgjVnOCbXCGgdjyJ4pTZmJB+Bto/0nr2Aqce+
 4+ew==
X-Gm-Message-State: AOJu0Yxt+kZN61Z9qjGnQPSmo1IOZXrWzGrOYEKbNF4pwnmqyB1BIKln
 0EA1K2L5Va1aETaqe4OyPCVCbt6l/Nhg2dmhtCw=
X-Google-Smtp-Source: AGHT+IFWrNTu7iC7fPmZPoUJS+59bBvLKDmsBkTvZTBiM8HdTWel89UE2/RR5hG0UYXrXmRWLZedtA==
X-Received: by 2002:a17:903:1c4:b0:1bb:b91b:2b3c with SMTP id
 e4-20020a17090301c400b001bbb91b2b3cmr25634636plh.34.1693246670403; 
 Mon, 28 Aug 2023 11:17:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 12-20020a170902c10c00b001bdc2fdcf7esm7734568pli.129.2023.08.28.11.17.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:17:49 -0700 (PDT)
Message-ID: <8f7851bb-f673-a012-2dff-8fc86ff957f9@linaro.org>
Date: Mon, 28 Aug 2023 11:17:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 09/11] target/tricore: Swap src and dst reg for
 RCRR_INSERT
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-10-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-10-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 8/28/23 04:26, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c          | 8 ++++----
>   tests/tcg/tricore/asm/macros.h      | 9 +++++++++
>   tests/tcg/tricore/asm/test_insert.S | 5 +++++
>   3 files changed, 18 insertions(+), 4 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

