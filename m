Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC29734739
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 19:32:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAwEZ-0003dB-6D; Sun, 18 Jun 2023 13:30:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwET-0003cz-Mp
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:30:33 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qAwER-0007d3-Sg
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 13:30:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f906d8fca3so11007095e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 10:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687109429; x=1689701429;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVTcwUXKz596o0XCz+4YD+Gvod2kC5JSERFMqUFvFrI=;
 b=c735d7tpCjZbg2iHk8EIxDsuD+Fiu/qQXTkuf9ALDbYa8FVglxboy5p39/kI4bniFh
 4z8OE54rsxVzmiGFq5d7+R7MA7bBviGmtxUIuBHNgD7vrXAfKUj7RgWW9qjVwjPbvyjy
 8s4/f2PiLdW+/bAiTzDT9FdYuRQ7MXFyxa9OqHCz8rjGr/5gt+gX4YeiqxJfwxjReDl7
 p8BepWNQ2rGubaf9uIQvyElLYsx1MMo9XjSJRackcbu5sIPvU+OHLYK31RWvj+9emah+
 fBaVO6cOQALkuB9xqIVtmWQLBQ9dCVERaL3dYD+xcqLm+8zj2v3OECP0aaUqb8nknhxZ
 vd5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687109429; x=1689701429;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVTcwUXKz596o0XCz+4YD+Gvod2kC5JSERFMqUFvFrI=;
 b=FGRQpQKp1iO5TOIStIJ7qW9o9nxBgy3i6A943+t8Ja2zVtYcJaPOvneu1QiX5t0S/B
 uXUVQOreO9UZfS6Xx9u3U1fMGXVzgXOJRa/GVZV7psRWJ1acLWpJRDNuM+hFVs0qwE4w
 r5gzxs7Lzlw3pcLcenwiw34FFL+113ZT4Wz/7KLXhd1gi23xAQaoCB1sgvUYDPkZTQQZ
 I+1cDYhu++Tb9ysPnKxlGLMkd3T49QJjjsv1gIii/PA/YvQtNMvm0B+3TwzJx2V3DT4g
 hgpfooB6I1ROC992+r1FB1PyRtQuRJKcGLeUHT6/gxxI4iKokvTOqig9EDcj+3I1i1u8
 jzng==
X-Gm-Message-State: AC+VfDzD5KHmb7HFrtT+44YEX4JjwUK1c8eC09ULYLOpfDX0wmy589lE
 5pr0lwaPH2TXr3JhW8q4BW6ovQ==
X-Google-Smtp-Source: ACHHUZ7h6IRdr/70zIpSOaQ6wDOyrEoI2XDauuD8QCxVtH5jO4yLlrD/60YqqpLPu7cQFffr22Qkeg==
X-Received: by 2002:a05:600c:2c2:b0:3f7:3699:c294 with SMTP id
 2-20020a05600c02c200b003f73699c294mr5550552wmn.29.1687109429178; 
 Sun, 18 Jun 2023 10:30:29 -0700 (PDT)
Received: from [192.168.69.129] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 u9-20020a05600c00c900b003f9b0cfbe34sm634174wmm.33.2023.06.18.10.30.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 10:30:28 -0700 (PDT)
Message-ID: <fdf7ba8d-efab-cb64-796d-2ca53b8103e4@linaro.org>
Date: Sun, 18 Jun 2023 19:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/8] target/tricore: Fix RR_JLI clobbering reg A[11]
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230616152808.1499082-1-kbastian@mail.uni-paderborn.de>
 <20230616152808.1499082-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152808.1499082-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:28, Bastian Koppelmann wrote:
> if A[r1] == A[11], then we would overwrite the destination address of
> the jump with the return address.
> 
> Reported-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

