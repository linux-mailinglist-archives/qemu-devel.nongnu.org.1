Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C82F4706888
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGYI-0003ZW-Iw; Wed, 17 May 2023 08:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzGYH-0003ZO-Aq
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:46:45 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzGYF-000308-6c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:46:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1ae4e49727eso8660895ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 05:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684327601; x=1686919601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3c7aK1Fw5whYzSjJDPqoYDDNN2Kume22sEgT1ts836s=;
 b=j5gjWhtcVCkeTUQAbWplyFEHNRB+JZFcmnwtNYUhajGvWdKkB5f0qHjKPVJfPIq7Zs
 ATCk6Roq/TEukw5GaJgFAk9vj+QAr+ylWHarzVZmsc/+ebjrewMJf0wGJiDdFGkTfKcA
 d//Jvh+uD0N9ksgNyfgmoFNzE2F0g62GYlyBhDuZ476oCk6woevs1TQfxiZsV8sf5Dr7
 mCeDCkf+f4f/m1ZtK1bRoxsI9Cv60kQ8GwR9NdztBYbvEzylsfIJbgCQ0L+JeyY3cWlK
 pd1yEHkh/1e5PkPJvnOZmjmC1lPyVjse9Q0L+uNdGvn0ESTxrctsuArOw/llq75gELxo
 Sd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684327601; x=1686919601;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3c7aK1Fw5whYzSjJDPqoYDDNN2Kume22sEgT1ts836s=;
 b=lbm5JU7Okb6DV/U2JP8oAxqVbg696pv7mivuFZaiaYjY8xJObNR0wClTXI/Lahjfot
 kWiDzv5ioilMYCEZ+69kjc8mCDDW6U60iwQ5I9Vx8Y7z0GhxWUmctDAQmjIDLC/uOaot
 qBKydxSTzJ0r2dl8Az6aQ/Bi8xO3J/3BvPzorjYYBHaLeOqMwYZdXCULiK99rVt9njp0
 JudwrENDSd+G2EFsTZutLhqpbpU6K0yqlPibCi/z1IXrjVBTE6l+EVo8pOwszhr9ApRF
 xKvMgsxacHzMzuxegejBfsEW5Rq3RWSla97KAy1f6nOIGg3ckbCHPkfCMHwroVaLMRm3
 MR1g==
X-Gm-Message-State: AC+VfDy7KVmx3RUqytPhmpJB41GtzV0pSzHsxgTb4XKnM2dqHY9TvqA7
 ICK3msNRppjn2ZTzTmIhEydIIoIwdfK5SbyOTWM=
X-Google-Smtp-Source: ACHHUZ4c+SCZADB2T1wnhHzRT9kgmYrIDb0tsitx+oletr8wFcxhviVDjIlyuJMXcPyr1SVC99JfaA==
X-Received: by 2002:a17:902:f7c9:b0:1ad:eb62:f617 with SMTP id
 h9-20020a170902f7c900b001adeb62f617mr19387790plw.45.1684327601688; 
 Wed, 17 May 2023 05:46:41 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a17090a950c00b0024e227828a9sm1480093pjo.24.2023.05.17.05.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 05:46:41 -0700 (PDT)
Message-ID: <57251407-7542-44c0-1752-9ec07a9ecd53@linaro.org>
Date: Wed, 17 May 2023 05:46:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qapi/parser: Drop two bad type hints for now
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, imammedo@redhat.com
References: <20230517061600.1782455-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517061600.1782455-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
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

On 5/16/23 23:16, Markus Armbruster wrote:
> Two type hints fail centos-stream-8-x86_64 CI.  They are actually
> broken.  Changing them to Optional[re.Match[str]] fixes them locally
> for me, but then CI fails differently.  Drop them for now.
> 
> Fixes: 3e32dca3f0d1 (qapi: Rewrite parsing of doc comment section symbols and tags)
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> ---
>   scripts/qapi/parser.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

