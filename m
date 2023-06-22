Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4BE739DF7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCH87-0007EQ-Tw; Thu, 22 Jun 2023 06:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCH83-0007C6-GQ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:01:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCH81-0002oz-VV
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:01:27 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fa71db41b6so5063875e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687428084; x=1690020084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MbEzjD6IbJq2yYB/LZuLB4SgPhw2OUm+1nDOIzi0++M=;
 b=cE4BJqv1yTZ9Staqu/IZTo5QDN+A84epl0MZIfKVgYeMReKl5UuFP0YBA88KWoUP3/
 4IbJ+Fx9LPlvk79tV7CFM7OiukBphQ4Oi/qLG5eBe1HE/jNKdx2LUXV3Mp9Yw/g7fSfq
 iV/TqopAKDX0snD3nVXsn7rtYDTV7Ea1xP5Y98w8WgXBN4x8rt86NdKeRxWCEHdLGi2B
 QDzeXEDzomnz+UmanEwIhtEKZiou5ZZg9HZ+WNqbk3toWp2wDsyug+4Yu47G4gibPFJn
 NKlh62z6Z+3PGqAgiAbw29oOvKTQd7BZSJdJUQpMItiVKhzcgY0UzgI6zA01NtpbvblL
 tYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687428084; x=1690020084;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MbEzjD6IbJq2yYB/LZuLB4SgPhw2OUm+1nDOIzi0++M=;
 b=FNiPBFrhqfAquCoRZRXYzkPzEROn2OOOHnsUjb3ZF7m9wC8G94xDmotTIOjej9Vd1K
 WC8NepliRa+s3jI0qOjvCdwvqg0DmfE8qxnhgK8lyc6fFnTG3FtyLEBq2gwm4WymrMmQ
 6j6wPx/0kx+rrZ3muqMvqkjj0q01c+O3+4cyp+4ZTqfnFjHVWavFEcuDlShlyjQ2Oop/
 jSyyEdejVHu7ke5voJgooXJ//z2CEXXnzYgdHkHuvTEf3Wx+nU907d6UVvK40LAANq6C
 uROsCwzesTQAR+ocACY9TSvbRoR+GKkrTkLL+zsn3LGxo3FiPWD+DnAyF9ipWZBAlS0E
 GlHQ==
X-Gm-Message-State: AC+VfDyiuX3atvEj1AJ1aqd8xSo0LAWBiRX+D+f+6a+YFrnpd0WGaGkM
 HaVKlWhkkLxVj1z7INnxoj0+75Hd+Ax3v5b+UZFUPQ==
X-Google-Smtp-Source: ACHHUZ6ruv40/AhCLdjS0SrQCLzHi7iuL+s+IZQpn8lMCQ88xtTj5eMQ1oiOVx8o+4sv8KUWdL2IlQ==
X-Received: by 2002:a05:600c:202:b0:3fa:7828:df2c with SMTP id
 2-20020a05600c020200b003fa7828df2cmr110126wmi.16.1687428084381; 
 Thu, 22 Jun 2023 03:01:24 -0700 (PDT)
Received: from [192.168.122.175] (127.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.127]) by smtp.gmail.com with ESMTPSA id
 d2-20020adfe842000000b0031274a184d5sm6651529wrn.109.2023.06.22.03.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 03:01:24 -0700 (PDT)
Message-ID: <64b52dc5-b55a-17df-def6-da8af3c291ea@linaro.org>
Date: Thu, 22 Jun 2023 12:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/9] accel/tcg: Add TLB_CHECK_ALIGNED
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621121902.1392277-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 21/6/23 14:19, Richard Henderson wrote:
> This creates a per-page method for checking of alignment.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h |  4 +++-
>   accel/tcg/cputlb.c     | 27 ++++++++++++++++++++++++++-
>   2 files changed, 29 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


