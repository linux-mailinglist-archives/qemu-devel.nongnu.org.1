Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EA4780DA9
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 16:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX05j-0004tl-Aj; Fri, 18 Aug 2023 10:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwqN-0006gA-4q
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:36:39 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWwqK-0003mY-DF
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 06:36:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e57d2so7055625e9.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692354995; x=1692959795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/m1z8u7hn0Xny6I8sBqk2rlhCQnNskXNQf5IG8jlDU8=;
 b=GMzDlKEP5dFUacuN0NESmcEFeoVn0byYWQkKz0NDw3wXTvx+2IBJ5JL0BpHFiMreLj
 sG4c8//OCd+Qe6e1npS90Rv0LFGr81VfAl8JThFJK7WpsFESYOzyrXekSLBZU7qebK3U
 /UFZh0Mp8X0qEZA/RRNvHp7KdnX/fm/MlRqpzUoeswfuGktZCb6IbPTC+fHR5AlFNXGt
 xXSM3wEw86uN//eKimQ6DSQvDsoiijScOkodc89dBpvNU7uDHtw9+Oj7Ysx+uzmcDWk0
 TiEbvs0YNk6VKIw0KN+hMRrd3kSAAwS+3TPOa9Iu2hA4nJfj+GfvBfLUT29F28yd4j9I
 LPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692354995; x=1692959795;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/m1z8u7hn0Xny6I8sBqk2rlhCQnNskXNQf5IG8jlDU8=;
 b=bP5fHbsV6dwSteU1yN5FL04aY1sQOQW9tcxWsZdptTwO0jI12RLzqv9QCHSSq8+wz9
 TI43C7vhUZgYqFHjoqnsMtJULKIipFK8n1lnKedy00eVAZeWVxaGJ3NFbwvyYMM7ZRxk
 Ru6W9B3JgfRy/Ow5r2yNUQ1L7y9gShYICcafOcODKfmcMwrY87hrxsdUvewMNFim0Cm4
 /aQmtOfgirms025Q/HfQXWvjpyuD8pfxRTlUXlpP+fgKUr6dqUYb0u0IEvLTPXNVzdPi
 1pi9t+AeBPpYE3kGURM9TMG6r0E8Rqo/XrPu6F8GsWg5sTZA3A9Bzv1YY49tYpetPWMS
 Pe1w==
X-Gm-Message-State: AOJu0Yx6MllM9WBUfX8oJKgB6dgus0p2sG9fzFHA5jYno4a9s2ahWwNi
 5X8sW48mdPKearW9m+3iappmZuQSLQYZ/S99HmA=
X-Google-Smtp-Source: AGHT+IEcdoOVXH5jVNwm992Br9KCy67ZZ+z+5ft/2OkQ/r1drkAEeJ6BJaUjJFpVwfOZYBrxDExw4g==
X-Received: by 2002:a7b:cbc5:0:b0:3fb:b890:128e with SMTP id
 n5-20020a7bcbc5000000b003fbb890128emr1797483wmi.33.1692354994778; 
 Fri, 18 Aug 2023 03:36:34 -0700 (PDT)
Received: from [192.168.24.175] ([92.88.170.41])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a7bc391000000b003fd2e89620asm5869953wmj.40.2023.08.18.03.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 03:36:34 -0700 (PDT)
Message-ID: <6cf07996-59f9-43dd-9740-5894af2dda70@linaro.org>
Date: Fri, 18 Aug 2023 12:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 10/18] target/loongarch: Fix loongarch_la464_initfn()
 misses setting LSPW.
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, c@jia.je, maobibo@loongson.cn,
 yangxiaojuan@loongson.cn, yijun@loongson.cn, shenjinyang@loongson.cn
References: <20230817093121.1053890-1-gaosong@loongson.cn>
 <20230817093121.1053890-11-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230817093121.1053890-11-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

On 17/8/23 11:31, Song Gao wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/cpu.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



