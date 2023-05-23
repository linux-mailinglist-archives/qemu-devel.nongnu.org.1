Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495A170E425
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:13:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WUb-0004Fa-LZ; Tue, 23 May 2023 14:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WUY-0004FC-Iv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:12:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1WUT-0000dO-DD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:12:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so44019325ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684865527; x=1687457527;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qln1teoHSd4iy2eG6ImHB+B1EYGEbeuv8yD8kwymWVk=;
 b=z6b3FPKy5XHvUqOzlf7Y3Kw0Y9t8unesPtobACKwpKluioLkC4MymqCx/iAitqI06t
 0pA/rX7usDUk4iglYvfHdmmssebLvys5tUe+HXfZ6bKLEoLSsgqGgLL1zx3XkBBUR4Pr
 6cwGl2IpWBgTRwXi++gUDd0Vfb2Ubr4oaW+3TFEdW6FwshTYlItIfGS29w/DiQ3qJDRr
 sEUCE+fT7Nn2BgiDYxVmB3OouR2lJ+O4OKYkNTCK3Ho5QRV6G0Qg39POxyDC/zm2U5xC
 sqbXiWB6NthU3rO3uC592o849zF70ZOmKgYcF5lKQ4SZmd3aW8WBpnupFkxd9h3vO5xT
 TigQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684865527; x=1687457527;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qln1teoHSd4iy2eG6ImHB+B1EYGEbeuv8yD8kwymWVk=;
 b=JkJTDj6sKhbCwxzdbtd6rvRBV4J70VrVTTq+FoBCOrADvFNq5dPgLu5Jm7Be5QK1my
 OV3LzzQOPiSLoQAnh7qvdKBPjfMnoc8nlcpirlQZ6wdH7630SvgEwWf2T0KLTCGyUoq2
 m8uq+uIjwygSP8FLlLaHjI5fvQT1VE29OMRRUW3DBwPr3G6oGylrh8tgxN7ppmOC5tAl
 Lk59Zo8ErdYN/yMShb6l4ZPVCpvIhiRya5xjAAJi8NwrQ8GEw/qD/znurw3MRI4JZwRv
 zRaWo+8bfTIg8J1YEjnnOariONRC+86lLPx1dauG8vdx5l0uYBksUbO+ulF50w+QcIGh
 nGVA==
X-Gm-Message-State: AC+VfDw1L/PlIBGhPlGr8b+Xtvb0wT3+5zoPTdBYyiYIMB5fUpcLgzKl
 vVcbkUjw1oauY7/6THzhfZMDwYCvNFvsDoln2y0=
X-Google-Smtp-Source: ACHHUZ5BD5dbiY7NDBL7r3dgFFXzvKryXtdQ9cau0SmU9TYNObQ5z43lc/fuuKPTKmZo6YoU13Qb5Q==
X-Received: by 2002:a17:903:41c4:b0:1af:ccc3:25d1 with SMTP id
 u4-20020a17090341c400b001afccc325d1mr3763038ple.62.1684865527624; 
 Tue, 23 May 2023 11:12:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a170902a38100b001ae6b4b28adsm7180566pla.130.2023.05.23.11.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:12:07 -0700 (PDT)
Message-ID: <bc2a6f9e-954a-6d77-9211-d9fb1cda5b4f@linaro.org>
Date: Tue, 23 May 2023 11:12:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/6] scripts/decodetree: Implement a topological sort
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230523120447.728365-1-peter.maydell@linaro.org>
 <20230523120447.728365-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523120447.728365-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 05:04, Peter Maydell wrote:
> To support named fields, we will need to be able to do a topological
> sort (so that we ensure that we output the assignment to field A
> before the assignment to field B if field B refers to field A by
> name). The good news is that there is a tsort in the python standard
> library; the bad news is that it was only added in Python 3.9.
> 
> To bridge the gap between our current minimum supported Python
> version and 3.9, provide a local implementation that has the
> same API as the stdlib version for the parts we care about.
> In future when QEMU's minimum Python version requirement reaches
> 3.9 we can delete this code and replace it with an 'import' line.
> 
> The core of this implementation is based on
> https://code.activestate.com/recipes/578272-topological-sort/
> which is MIT-licensed.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   scripts/decodetree.py | 74 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 74 insertions(+)

My python fu is not quite up to the constructor (?) forms used here, but

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

