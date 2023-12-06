Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4968075AE
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:49:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAv49-0005BO-8F; Wed, 06 Dec 2023 11:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv47-0005A3-Pn
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:48:04 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rAv46-0005Kx-76
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:48:03 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ce52d796d2so9981b3a.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701881279; x=1702486079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vJC9dQfa6mPnWnS1mLaOmWNzRmZtUlZk0LU8nPhF95E=;
 b=hS7jO3b/C9zys4lXbi52DvfarzkTnuNnFcsu3EiDWm9Bjf5dqsDIhENKl813U9K8ZS
 jB1jTzu4EWMDWRFrs3yptsa8JkdNmzWmEzSQbLg9ai6246GmmPfsoATskNJEJ1vlSFOs
 X1NLAIZZh2sV9V4C8HzWdhhA9oEQeJUA4FDJmsy9hdt93glZBBpoqYNSghz2Tq+7x2lN
 LM3occDT11vf1BdIE4AUNkON4rRBz4uBElw52AYatsgtTgfU7JpZHKRPyJdYRlAcNskw
 yYA9HTRdU3tR8pl3U40+pE3lau+yU0WEZAzH5cU495zW7bZIPgkDP9jLzG2nqygisWyo
 R7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701881279; x=1702486079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vJC9dQfa6mPnWnS1mLaOmWNzRmZtUlZk0LU8nPhF95E=;
 b=IAlLbfOyqhjIahP+TvXlSFcsSmMfqLi8/GBAmjWqiWN7UQ9fgHpPUhCYUyaVBttz+G
 2INm/01FC/iA6HeR1wWJngMfj3YWKuOzBKE70VAMXct33kVsPAwggTWK3c/QufBB0pbG
 IFk79wFA+8b/+03Xm9Fwcc9yfst0h/sTboBhpaYYE4tZMcLBzjkePvdhxlA/BjNJqnRF
 fcrlqi9KLRM84bkqC9ftZP/Mgwvkn5ke/SHcpOAN956XycO+Rtt2RX7b0V0JwQpv3fMo
 CNBOpkj2WsZSo62o5OjBgWNYEt1umpoKg/J7BL/8GF5xMzXjuPLegT29xU+Hx4rebv0G
 fjJQ==
X-Gm-Message-State: AOJu0YxIhkUbiiCIZy797MnuNqqoU5FgmYHTLL6k3BQ/p3qR70xJiLKL
 Z1ZdApEdTrbSE2JHWMwzoP+doQ==
X-Google-Smtp-Source: AGHT+IEhh50sLMzuDwWRY4atRE8E7urzpQp11N6HrCNXbpmLDF420c17lc3qqHyTDYeeroz2h7oS6w==
X-Received: by 2002:a05:6a00:2d89:b0:6be:130a:22a0 with SMTP id
 fb9-20020a056a002d8900b006be130a22a0mr1288159pfb.14.1701881279139; 
 Wed, 06 Dec 2023 08:47:59 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 n33-20020a056a000d6100b006ce65bf5376sm208446pfv.75.2023.12.06.08.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 08:47:58 -0800 (PST)
Message-ID: <251a05e9-243a-40cd-b7ec-6ef2bc57527c@linaro.org>
Date: Wed, 6 Dec 2023 08:47:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] replay: introduce a central report point for sync
 errors
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-9-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231205204106.95531-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 12/5/23 12:41, Alex Bennée wrote:
> Figuring out why replay has failed is tricky at the best of times.
> Lets centralise the reporting of a replay sync error and add a little
> bit of extra information to help with debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 12 ++++++++++++
>   replay/replay-char.c     |  6 ++----
>   replay/replay-internal.c |  1 +
>   replay/replay.c          |  9 +++++++++
>   4 files changed, 24 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

