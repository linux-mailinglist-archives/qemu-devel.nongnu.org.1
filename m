Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8C5767749
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPURe-0002Lt-9f; Fri, 28 Jul 2023 16:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPURZ-0002Li-30
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:52:13 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPURK-0003xT-Il
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 16:52:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686f19b6dd2so1719357b3a.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690577507; x=1691182307;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H+U5/odfBci0jKQ+52/X4/F7BJkoJq66wdv4khYU59Y=;
 b=yynO8IpKlabbzoihxW5V1K5J7A+QCwBI0Dy9t0N2Tx7qQxxCLRtH0Yh62tS1ut2j0c
 89afXwLXJvz0Op5luOXKrnmxk02I7VeF2DRoQjDkiWEwcVyolCkF09N0/sQbt1K2dwJr
 FZmZgX/AfOQxkSnExP8zaQhUIS4x+jGwoKlcwqeiL6HQNBKewty5ruS49KZVY1k9WdlV
 rMTMpzsKfOrcfG2yi3pnBwvDgt9pGXyu3T6/WkMgaJZoijqzozF+EhBPv7A71Nb63szG
 71cDeFtjAV8c5BHeXQfJp9cak1h0PpRjsQRUoOx833TIfqBMY8MKtcpKHFG3954j99nb
 +Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690577507; x=1691182307;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H+U5/odfBci0jKQ+52/X4/F7BJkoJq66wdv4khYU59Y=;
 b=kEm1JGKm4f9RbE9zNqoIYpCAI51j4yQYrwEyBj/s2T4zpdxB8XqOTJ3NkTaP2xnC5M
 SpUSh3cHCYo/zR6fEElGNv3bzNNd1lCXAQgzfiXcQHXEpuRhdXuXrZ/NUxYHWNJSZTd3
 z/Jrx8//a7E8Vl6Ef/5nj0euM/+5gsJRVzbPDS3Elf+PoOYsXh6tDMCeQtgx3sizeF+m
 Aq70urOquYIgNcka/XzUIiZVUH1l2uPbDblGPWprxjIJmxGiQWYXdmAJ1jG/lU8KUQFD
 RuPAJgRTQmIYevX2JELPJLxZDm1R2JawvPkLV0xYnRVKXSadmBGd3c2S/6NkGfVMX4X+
 f1dw==
X-Gm-Message-State: ABy/qLa/zIn70mzK1N6Jwv7RrjKTmapRfqXorJekj1eF4WZco8xWToPk
 dY13TeKSjq9UVtqFlr3dVRYj3Q==
X-Google-Smtp-Source: APBJJlH5JjM3OihWLt7nFZ38w78CHQUM6TGOhCG+aoYv0h9+Qhk6/Z8agsTzN4NXv9q5XzrMlv/9Kg==
X-Received: by 2002:a05:6a00:1253:b0:687:1be4:46d9 with SMTP id
 u19-20020a056a00125300b006871be446d9mr535751pfi.1.1690577507641; 
 Fri, 28 Jul 2023 13:51:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 m8-20020aa78a08000000b00686bbf5c573sm408141pfa.119.2023.07.28.13.51.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 13:51:47 -0700 (PDT)
Message-ID: <b3249b9e-d687-68e1-77b6-9c8703644266@linaro.org>
Date: Fri, 28 Jul 2023 13:51:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] linux-user/armeb: Fix __kernel_cmpxchg() for armeb
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 John Reiser <jreiser@bitwagon.com>,
 "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
References: <ZMQVnqY+F+5sTNFd@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMQVnqY+F+5sTNFd@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 12:23, Helge Deller wrote:
> +    /* endianess-swap if emulating armeb */
> +    oldval = tswap64(oldval);
> +    newval = tswap64(newval);

Oh btw, it's not about arm vs armeb, but guest vs host.
This also fixes armel on big-endian hosts.


r~

