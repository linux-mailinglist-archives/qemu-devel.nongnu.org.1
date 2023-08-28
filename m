Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260D78B70B
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaghQ-0006r9-Bw; Mon, 28 Aug 2023 14:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaghL-0006qk-4b
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:10:47 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qaghJ-0001ZI-1V
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:10:46 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso27894335ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693246243; x=1693851043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PmsIr75AbwR4DguXGU6uaL1qCk021WKp8l1aog3DuEw=;
 b=Bk2O98aQUkRPMAOvxHVPCY655P0gFY/QeriAoKvhDSKp2w9fAUHd3xrW8LDX3Z4Pv0
 r9FpjDhiUWXSF7c5cj4QP0U1N89EMAvnnRxNo/gfVugM43olEd+PLCdE2JMZDKe6dK+h
 kJdbSszd1h+k5UFHrhv/ix7BjSCOMDxUi/YU5h1ms+RN0m6FwN8nq9qTuwWjcPAoqmpv
 qhj+Yc3wwFjJGC2zhIbc0T69OB79o6102IGW6gEbr/PdEoxlhFqBK8VUp2fCikIhfq59
 2WyYTwTaepHeMazDtUDuxmO1n/Sqrr3JQ8bfP/VApNH0evr6P1S4u37rF63vnT2FJud3
 pjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246243; x=1693851043;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PmsIr75AbwR4DguXGU6uaL1qCk021WKp8l1aog3DuEw=;
 b=ZePZdQgd5TiDKFw8ee5PDipQR8LOJic1WQ933oQoxaX0exHJyYzl1nMvvAn5FE1wdt
 q3vW69xn3ju6SmE+kdW8Dynr9pqHjF9LYPgPZiZYHIo0kXsPlNksE4uBmI7w1mMdRB24
 ul272PhEm+C0EPE+IyN8cTGdiI4LX2a0djFvXKSAxaoDacdto1xnBYoNO8Ss6N3JFGT+
 5wOcMw26pDfwK7eWHpNtsSKFApiRYT1wW+3iddx0rj1ixO3EMNubZZ1JKGpnxeJ+/cj8
 /ahAFpxfiWdxBqRnF24J3Z9x6St1PXgipwIjN56K++emJVxooSFk0FcE/pGQN2PQS62X
 koJg==
X-Gm-Message-State: AOJu0YwnmpxXg3Z74S6GAijtqAUmI3Vq+moKIMjKbj3x+CCxdYF9qYih
 6DBc8NRjFgFum4GKsKIWEURyVQ==
X-Google-Smtp-Source: AGHT+IH2Blftn9qOTVk7uo5i1XRsIw++lRzvAKt/7mzsO9jYfTfJgxV1HGk9BQ2j9xCgtOJWPOvGaw==
X-Received: by 2002:a17:902:c14a:b0:1bf:5df2:8e77 with SMTP id
 10-20020a170902c14a00b001bf5df28e77mr26906678plj.39.1693246243563; 
 Mon, 28 Aug 2023 11:10:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a170902821300b001b9cdf11764sm7653967pln.31.2023.08.28.11.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:10:43 -0700 (PDT)
Message-ID: <325d47fa-7721-47d0-0c64-51f143271160@linaro.org>
Date: Mon, 28 Aug 2023 11:10:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/11] target/tricore: Implement FTOU insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
Cc: anton.kochkov@proton.me
References: <20230828112651.522058-1-kbastian@mail.uni-paderborn.de>
 <20230828112651.522058-5-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230828112651.522058-5-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> v1 -> v2:
>      - Remove special case for NAN input
>      - Clarified, why we need arg < 0.0 special case
> 
>   target/tricore/fpu_helper.c               | 32 +++++++++++++++++++++++
>   target/tricore/helper.h                   |  1 +
>   target/tricore/translate.c                |  3 +++
>   tests/tcg/tricore/Makefile.softmmu-target |  1 +
>   tests/tcg/tricore/asm/test_ftou.S         | 12 +++++++++
>   5 files changed, 49 insertions(+)
>   create mode 100644 tests/tcg/tricore/asm/test_ftou.S

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

