Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD027720DA8
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 05:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5I6H-0003zt-H2; Fri, 02 Jun 2023 23:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I6F-0003zj-Lm
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:38:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5I6E-0007Up-0J
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 23:38:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-651e298be3fso2369020b3a.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 20:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685763520; x=1688355520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rm4vvghdSeEagckNgEO3tBlMhk823kViO0aE80Kqf30=;
 b=NCaCAtjlCifpdLpz9wp4QI7vuA0rlBewefVeGuWwM5tXjqzJ6v8OJJja8W5aPhcHS8
 FJ0z7gG8EIa3znVM74cLM6dBBqVZUeuliRr4wAs0XPY11SqEf3MRzgtpMtm4dHPtwVVL
 +JaCiGMz8XqTBDSEsotTQc6H/a04hG70iYP+urW2C/Akx5/CyIcEGGlvkyWlzqoqhQTX
 ZKoafIjQK+b10dhFveZt+o/mTC7PzpFYf8nnR1IkznYiMvzPuHxiBHJaFMr2dzLUvRFe
 9GfoHB6veMRJfsE+8RFsYxkq/YNZTApxxaJUV9QzATrdNhU4BFVznu3mbsGL7l+TjKO/
 qfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685763520; x=1688355520;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rm4vvghdSeEagckNgEO3tBlMhk823kViO0aE80Kqf30=;
 b=LG3IdS18U7L6Mkg8y+BYN325dM+aQzKemqVSBBQdXK0qXtLy6Q0FnBpUdAtpspKQF9
 REbSkgXx/lxR8dWhBJbFVrNSnfVud06+P4bF2KA+bCsq/gJRqqzDSKGt8H9ZnfrNy4gP
 EQ8FTuzOo7nySqMQRdjNJGNSb+/9g8HP9kaOwf0QXnCA9GqrY3RuvTXStzPfVHXVqwDK
 UA72nk50LKGrXliG+Zq/Ihb0GAxjl9xpvVErLZV/13RKvShJDLKdMhpGeHxd82+LOvDV
 jmTcTNpFivNTIrZOc7JDdWENrDBZjHh0Z8H7Qe/Y4WzjL4LdC2NbJDtkaEXoDiIjPaKQ
 FzPw==
X-Gm-Message-State: AC+VfDwoAJ1QDKb2IhhtgCjfJkeFxaRQAN1HCWzI5uPuXU7ne326qrce
 7P+zrKZYdzbO/4n4NkK/VsYNvw==
X-Google-Smtp-Source: ACHHUZ5KFOMKgzGQjqvttt3re3ykOYYzWAHWg7kF2eEIxLDtQXy5+1kPcH2cf10+eY7SQeSs7wIZEQ==
X-Received: by 2002:a05:6a00:168f:b0:650:154:8ad with SMTP id
 k15-20020a056a00168f00b00650015408admr18038929pfc.11.1685763520253; 
 Fri, 02 Jun 2023 20:38:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 b7-20020aa78707000000b00642ea56f06dsm1641522pfo.26.2023.06.02.20.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 20:38:39 -0700 (PDT)
Message-ID: <90780176-9d20-890f-616b-6423bbb21a7c@linaro.org>
Date: Fri, 2 Jun 2023 20:38:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3] meson.build: Group some entries in separate summary
 sections
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230602171832.533739-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602171832.533739-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 10:18, Thomas Huth wrote:
> For the average user, it is likely quite difficult which library is
> responsible for different features that QEMU supports. Let's make
> it a little bit easier for them and put some libraries into separate
> groups in the summary output of meson.
> 
> Thomas Huth (3):
>    meson.build: Group the UI entries in a separate summary section
>    meson.build: Group the network backend entries in a separate summary
>      section
>    meson.build: Group the audio backend entries in a separate summary
>      section
> 
>   meson.build | 48 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 31 insertions(+), 17 deletions(-)
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

