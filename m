Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B71AC72B622
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 05:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8YNW-0001PR-4n; Sun, 11 Jun 2023 23:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8YNU-0001PG-CN
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 23:38:00 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q8YNS-0000Ut-Mj
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 23:38:00 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-56d378b75f0so1618517b3.1
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 20:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686541077; x=1689133077;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rYgpKcqeeoTDjU/YajnODdpDXrLGq5FvtBUI7cyASIM=;
 b=hPutQ5lz8OqmYVJ03Q3YuhUBXuR3L46+FLzANFUBHqz3s172A0AFaZhAwzMshv3XWF
 eMLkgOfhCNG1muexnopiYLKqbDNcMCitKq4ENqV8tWunSzzHfeaZkmwnqD2ue+Oq83xw
 90/Mpp/4Cn0WymWaMCeV9Dso6ad2baOXo9HhohtYglrFOt1emPkrxkEV5Ec5DfvKxM6c
 BqsVVAFxPhmeH+P3+JdoI5MdN0KhYv36cymdSuGyOkSS8W8kpt7aXcWzbiKjzmAEJDM1
 lhArW11cScEmrK9W52NBUyqBdmvuiJGlwRGpBCcmUrsk47PDXoCuj8bF0ZRBxjevvk3n
 Z7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686541077; x=1689133077;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rYgpKcqeeoTDjU/YajnODdpDXrLGq5FvtBUI7cyASIM=;
 b=WbH7KLLjtozuUXqISwc8Aomg9vRQKdE0GsZJJUkmkBGWrM0xib8EBYz3hI1JT6EUZE
 pq3tAEO24nIN6nQpH6GLL2PMn/FEM3WdJJRz+G9vJ3aFSXhJFm5omA6TAeikJgnLFAoY
 Wkqr1n2spgJsf7qkSLh6ZQBcOWZijcDzKzGlkdwwykw18bB8rh6fdWBPxCWMzciOTw3x
 YtQshsLD1qXQ1pD6GlmpQqRIjiSKjxIyR3+B8N/65oMkn9oS7zqG6ZtkDQdNhdxgvrPL
 fycdEFUnAbisXHSJeC4q867WArKIK+KlaMx9fIWhoX+UPA0QT05PWaEOGIaS5sHHbPd8
 d6Fg==
X-Gm-Message-State: AC+VfDwMiAAetauemNfkwJWqLZMI7sxsWoMXrgRbs85uOkkcZEQkM6xG
 bUOSaYyYOfTKrgOnziTou9CqGA==
X-Google-Smtp-Source: ACHHUZ4dXKTcAdA7IXK7zTycftq1o8tzO+9QdmuIM7UNgc4x8Ig5YPnAnRXWwx4vllE9lTL8vbGeGw==
X-Received: by 2002:a81:72d4:0:b0:561:9d66:e1a with SMTP id
 n203-20020a8172d4000000b005619d660e1amr8739276ywc.34.1686541077019; 
 Sun, 11 Jun 2023 20:37:57 -0700 (PDT)
Received: from [192.168.85.227] ([172.58.160.5])
 by smtp.gmail.com with ESMTPSA id
 m198-20020a0dcacf000000b0056974f4019esm1146866ywd.6.2023.06.11.20.37.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Jun 2023 20:37:56 -0700 (PDT)
Message-ID: <ad33ffa4-6360-f7b2-936f-4f0d39f49e4f@linaro.org>
Date: Sun, 11 Jun 2023 19:51:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] target/tricore: Add shuffle insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230611185213.51345-1-kbastian@mail.uni-paderborn.de>
 <20230611185213.51345-7-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611185213.51345-7-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1132.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/11/23 11:52, Bastian Koppelmann wrote:
> this is based on code by volumit (https://github.com/volumit/qemu/)
> 
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
> v1 -> v2:
>      - Shuffle now uses shifts, instead of a buffer
>      - Shuffle now does rev8 for all bytes in parallel
> 
>   target/tricore/helper.h          |  1 +
>   target/tricore/op_helper.c       | 36 ++++++++++++++++++++++++++++++++
>   target/tricore/translate.c       |  8 +++++++
>   target/tricore/tricore-opcodes.h |  1 +
>   4 files changed, 46 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

