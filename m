Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84E72FE01
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:12:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PLh-0005vJ-4O; Wed, 14 Jun 2023 08:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9PLf-0005us-0H
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:11:39 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9PLc-0004YV-QU
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:11:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso9935535a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686744695; x=1689336695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUvavaomzbA/XXGVSnoEYirP0oEByWjkElix5W473i8=;
 b=Sq3cd/+2oGVkAW+TuVNhS+MzjdKmNwI7/SaJi3AQ0ylfYYvE5me6VB0LM2E1sUlyUS
 5dwiFkOFWuHutkRbh1kOyJ3RGNj2Cg3cdeOFNUWUAj8gvfglIiwJmQybqBeOXL2pxxYq
 bg3TJ9zKnvArQ5nU9P/6V+dtY4LmXM5YUHttW3JjVUxS2rw7H0T62+N9+jvkjnTj4Zrc
 KTWPZsx/pqTlUf526e+B0GWPZ7BOBwpr6KgV2QIYNnu08+nGItoi/8gzgpjF1TwKase5
 Ut4WiBP7aZwcSnB+bJz3jOSfISLRohfreWKGD6VZkc8App4nk6oYQ9FUwNegY9ebs6gX
 NX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686744695; x=1689336695;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUvavaomzbA/XXGVSnoEYirP0oEByWjkElix5W473i8=;
 b=WUXJt1gkilT8AGl8FbIrZoDLaSXlaD41G6YJYquWoag/HMXGQVHbY+TIlvAMXPXWWw
 3H86QXmaG6eVluLrqcHe/NYrZ6yaA7yg5qLRjzxGOlq4R/VP3bIBTQY/55NKLdG/ffsB
 B88epdHc/x5l+JJtg4cAPprtLIBHqDFpHavvo5YTPT8NVW2w0mw8HUDmZePBXRF9yMay
 dKpNevecQB7Xi1Zq3PDGg++UtCDH0NKnSlpUXw9FgPJsmfTW4lTrYjRlIO+R1cn/t089
 sB7ffXY7DnaBumCLOcDYBmwPqkQqpQCr9yxBLgXYZzoZgjDBkmxlp6FcaCT5aaomC6EU
 QYVQ==
X-Gm-Message-State: AC+VfDx8XDgkFA3YMkMxQMvbAvDb3dvyfKoLl0sNOm6mLR6zf7LJmG59
 ZyvgN677IVWgpyRdbWivkogLSK71RwKyOA18/Tqxcg==
X-Google-Smtp-Source: ACHHUZ7Y4Q+/2OWYPFmJ6an2SyOK0akRnncxI7XxBrDm1hZbxEJXLYvEQyTMXhnY9O6YApDUjt81DA==
X-Received: by 2002:aa7:c047:0:b0:516:7840:3cb6 with SMTP id
 k7-20020aa7c047000000b0051678403cb6mr7621699edo.6.1686744695004; 
 Wed, 14 Jun 2023 05:11:35 -0700 (PDT)
Received: from [10.14.201.121] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 d13-20020aa7d5cd000000b00510d110db58sm7607932eds.80.2023.06.14.05.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:11:34 -0700 (PDT)
Message-ID: <31ae990e-4e79-58ef-7643-a291c16c86cd@linaro.org>
Date: Wed, 14 Jun 2023 14:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 8/8] target/tricore: Add DISABLE insn variant
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230614100039.1337971-1-kbastian@mail.uni-paderborn.de>
 <20230614100039.1337971-9-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230614100039.1337971-9-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x531.google.com
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

On 6/14/23 12:00, Bastian Koppelmann wrote:
> this variant saves the 'IE' bit to a 'd' register. The 'IE' bitfield
> changed from ISA version 1.6.1, so we add icr_ie_offset to DisasContext
> as with the other DISABLE insn.
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c       | 11 ++++++++++-
>   target/tricore/tricore-opcodes.h |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

