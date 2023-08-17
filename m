Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A40C7800CA
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 00:07:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWl99-00061O-FQ; Thu, 17 Aug 2023 18:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWl98-00061F-4d
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 18:07:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWl95-0001KK-VD
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 18:07:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-688731c6331so237175b3a.3
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692310030; x=1692914830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DpHjtD9XhRUph5algCgZ01moMgZhHyOWLIRi693JPqA=;
 b=xuT04NlONjsuem3RnZC9z/f9C3x2PsnMQi5QEKjCHfDB+o7/pmjZxbcSjQC58/c8yq
 tSSBit140wh02GZXfDh19pjgkvqYqfzS+XbrVdCg+w56ejQDzgIcIrduoIxGhzzf2Ppn
 TVB/f1oMclmnzYo6lICdQ2xIaQGpsS7twhxKRboMWhxP4oLEzEm7dwEBgVdtF1ulecku
 1aCCKuWBxXi02i6/IsO6i9NaUkX9Dx2SxjHUI7pe2RGEdsfUaJWnA+cJMqa1nko+OZq1
 lzniWQJHTg0935hqyZprx3ZXzhL1Vl2NcfbjpjJwWuWiRQwAsA4Hdh6O2adwxj8vdh0d
 qp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692310030; x=1692914830;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DpHjtD9XhRUph5algCgZ01moMgZhHyOWLIRi693JPqA=;
 b=jFhyLp/1KC7qANkcJq+vj6eihIFw5LNNFbqeghQ8iXAYiLJPLAKJJJ2Y/A/r9nQA0A
 XffIMT87YIgiOwScwBTLEqMVmgzpbR0Fi7vzK2VEq0LnpzJ3VZnTCG1zm6BcjHClGgUp
 NcwD091xVx9Xoa2qxnYMNueGObB9i6LW4YYt0hEdlWvWq1J6N9P7c86ayIpz298ILhU7
 KZeCK6ApbNkVKdFjZth2APxmS++9O1wQhOgn9W9RDUEsH8KdQoC5JH6gHT5NPJmV7HmH
 fX3JvgcF3MVV8jFj7KvXQdww3NEW5CWwcvo+uQm9FIo/MEP4BiDmW1JbXrJlP69cOT0c
 tkDA==
X-Gm-Message-State: AOJu0Ywvm3oSPCAJIMqOtS6osn5Pdnny/YVOWPJ7dyTw9ADBl5PsEMeI
 5+YHLpJc1jNT0alHXN2vg7Q/iQ==
X-Google-Smtp-Source: AGHT+IE8uooTpCb1xnLBeS50sgZVrj+vgQwqwlY+s5ie/jSYB6I6q0ow0hQeqctZuEnLJSjFUhGQEw==
X-Received: by 2002:aa7:888f:0:b0:688:4337:3c55 with SMTP id
 z15-20020aa7888f000000b0068843373c55mr947516pfe.6.1692310030518; 
 Thu, 17 Aug 2023 15:07:10 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:12cd:355a:c01e:3596?
 ([2602:47:d483:7301:12cd:355a:c01e:3596])
 by smtp.gmail.com with ESMTPSA id
 m11-20020aa78a0b000000b00659b8313d08sm236113pfa.78.2023.08.17.15.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Aug 2023 15:07:10 -0700 (PDT)
Message-ID: <c03f11e3-847c-a792-51e0-16679485b43e@linaro.org>
Date: Thu, 17 Aug 2023 15:07:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] tcg: Fold deposit with zero to and
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20230816145547.477974-1-richard.henderson@linaro.org>
 <20230816145547.477974-3-richard.henderson@linaro.org>
 <CAFEAcA9WUcJzrfQXnjM0Jw8CjaY6BW9hAKWGDRrMVU3BR2u6Vw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA9WUcJzrfQXnjM0Jw8CjaY6BW9hAKWGDRrMVU3BR2u6Vw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/17/23 08:50, Peter Maydell wrote:
>> +    if (arg_is_const(op->args[1])
>> +        && arg_info(op->args[1])->val == 0
>> +        && op->args[3] == 0) {
>> +        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
> 
> The docs for the TCG deposit op don't say what the restrictions on the
> immediate args are, but this will be UB for QEMU if args[4] is 0.
> Have we already sanitized those somewhere?

tcg_gen_deposit_{i32,i64} do so.


r~

