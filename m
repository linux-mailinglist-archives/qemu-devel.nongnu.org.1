Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F1C77A789
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 17:36:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVD7C-0002q4-KT; Sun, 13 Aug 2023 11:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVD7B-0002pq-4k
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:34:49 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qVD79-000882-J2
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 11:34:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso3607136b3a.1
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691940886; x=1692545686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=klvVZCRR02osmZeGh+W3zq9Vs5Zq2JdYFrxPeXGKgnU=;
 b=PsXC3Xhk0MbTyQBd/CBJYUYNCyRJCzwTCWwHBnQP9w8wOBHz1HPp73OBHgUJFj+iGC
 XA1T9DFSZ7XK2d51cCg5lRgnUKWUiPfzzqcgum2YfPv0X1BmUw/b6YBw+UeIwpv2kgTr
 bRNZggvqsgjFI8uMIqw5Z1/htY5ACWNvIVizSun0W9AaQel1bzZmnfemmXE/8Hdmm1eE
 dqYkIdlH+k/hQWOqmFKPRghOO7g1YHXPYAiK8byDpwuw16bjvp0ZGXfE2z57oTrj9jmf
 xe2pebbgAH87USpQY/pg4pFsws0uSJt12psNHHJCmbW2TWkcSBHFSK/qZ3lpGc0JvgDw
 IWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691940886; x=1692545686;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klvVZCRR02osmZeGh+W3zq9Vs5Zq2JdYFrxPeXGKgnU=;
 b=dpS37VMcmPiuFMe+CoUEWR9vu81CVmKFpRMgkrugx9KtM6qA9RTwdv5cCz1L/IG0ka
 Aky3BmbP6dWL6/AydLsUjmyamNEtuLblXnwEwggi+Mvv3QllqkXpp0LPo+qptQhAv5uO
 WQ5GDUUV9vzbAQ9/Nn0gA6xqSOudqTcb923EXcMZk15fHVtxljTvuiWGWdTJ3fz7B2eX
 qiOeC9PSlxPSl5fqIyrXKP3/sm92/MopEFEKbNlWNDvK8CJhwTbfR0lO2pUezguw6/im
 zmOD5AZGfcyNWzF9k0ygkFTmzdnW8q5psEDcbazaIynyQDWELUsEeekyg2iRcEqeTgsi
 HFkw==
X-Gm-Message-State: AOJu0Yz/bAfOitCG2Z+rfyfBKm1HJRjL5sKaujiSia/UVfmSHtogj7c5
 z1C0Jn8Zwpl9fdflPVFM1AnqRg==
X-Google-Smtp-Source: AGHT+IGmG65xyeXUFwRyqP01k+IZ8rHcGdS5J+XiRpMVef+Whj0M66wwv0uThroKAAreAYwXHY8MxA==
X-Received: by 2002:a05:6a21:7189:b0:137:53d1:405 with SMTP id
 wq9-20020a056a21718900b0013753d10405mr8262494pzb.26.1691940885800; 
 Sun, 13 Aug 2023 08:34:45 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:8022:692c:81e3:39db?
 ([2602:47:d483:7301:8022:692c:81e3:39db])
 by smtp.gmail.com with ESMTPSA id
 v11-20020a63b64b000000b00528513c6bbcsm6169542pgt.28.2023.08.13.08.34.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Aug 2023 08:34:45 -0700 (PDT)
Message-ID: <6c447b3b-3103-2f05-6cbd-4fe2ca01c2d6@linaro.org>
Date: Sun, 13 Aug 2023 08:34:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 04/32] Declarations of h2t and t2h conversion functions.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>,
 Michal Meloun <mmel@FreeBSD.org>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
 <20230813031013.1743-5-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230813031013.1743-5-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -64
X-Spam_score: -6.5
X-Spam_bar: ------
X-Spam_report: (-6.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.359,
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

On 8/12/23 20:09, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Declarations of functions that convert between host and target structs.
> 
> Co-authored-by: Michal Meloun<mmel@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/qemu-os.h | 50 ++++++++++++++++++++++++++++++++++++++
>   bsd-user/qemu.h            |  1 +
>   2 files changed, 51 insertions(+)
>   create mode 100644 bsd-user/freebsd/qemu-os.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

