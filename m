Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A9C78243A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 09:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXz6t-0006Mg-EV; Mon, 21 Aug 2023 03:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz6e-0006LP-2L
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:13:46 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXz6a-00005G-G5
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 03:13:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fef2f05356so2931355e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692602018; x=1693206818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FrL8hA4PH4aQxL4r17+rc/n6lVfZ4Z7NfPVQlI1XTpI=;
 b=HJwF2dQsiusZwnZyKQL7Q0G7N6LrZltJmPGjcRNzM6BOY+EW0CqJX6n0DH8Rcr0uI+
 6fqaNLf7L/ukf0HFx9ENw+VpHp2/5I9j5w/E+4Y2Zo28bSYbNrO3rhDRLFJuWGs2Rp55
 TZOqVm2cAg4ANT0dF6Zj/+uLJCAOHlvGKkEtXdi99NcSkB+CDhKZASNpeBM9KQ3Nn8Z0
 uihEf2drLCWAjCEcV0b/n1wmHSRo/50Xu6Jv3lecjUmNyr8vbZXThGbBnqDwAOBACPN8
 ym+Nb1fDkU8sr4vXsAfu1z+4NdqFY3HT7CHBDAnTJJnRlPgjkru3qC2qEKcGityh0hsl
 lm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692602018; x=1693206818;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FrL8hA4PH4aQxL4r17+rc/n6lVfZ4Z7NfPVQlI1XTpI=;
 b=k91qAcIbtcZ+5vacaakV7eWwlhpdVD2JoBv04HZgapysTiyF3R9LN6K2AjInNkRZ5P
 ogS7+tXJ+HopFVMQTUnjWM5qllaUIWavKQ+78p2c5D8i9lYjD/38y2aw7XVh4aU7NXpX
 KWWSp1YHwsHKGWY+vqDLUD7eak/zxwS+MZVV6DPHrjnshC2F/yJzgNYfgwGf3Amkv2uo
 DGOgcEVyQ0zDpsnXZbeaUsD+MLK0AiKAuZBfevfPjXY5KJ4O6hWpsTap/hQD7JCeP420
 F64dNHyac0DTZ1h36GoyBWcIcpH70vYNFqkW0iGIF+ZG82IlevpG1ebPk8zoDOh6VxBz
 ijnQ==
X-Gm-Message-State: AOJu0YwNeczxSfou0zdxyyElSvTTBtMztMrZUu01x7hBTH3fen4Z3uTR
 bug0uZ3YZZ9w0sX0UhheCaw0rA==
X-Google-Smtp-Source: AGHT+IF2iomTVZd/QZFQMkHH5le5htlWqvi/0fyx6sWofCnt3z7APaE00uuttRkXqJRTLAxM2O2E9w==
X-Received: by 2002:a1c:7303:0:b0:3fe:2b60:b24e with SMTP id
 d3-20020a1c7303000000b003fe2b60b24emr4528681wmb.29.1692602018274; 
 Mon, 21 Aug 2023 00:13:38 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b003fe2a40d287sm11695191wml.1.2023.08.21.00.13.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 00:13:37 -0700 (PDT)
Message-ID: <b79651bd-38a5-71e8-48a1-a3e7b6f31af7@linaro.org>
Date: Mon, 21 Aug 2023 09:13:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v2 09/23] target/tricore: Replace gen_cond_w with
 tcg_gen_negsetcond_tl
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
 <20230818221327.150194-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818221327.150194-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 19/8/23 00:13, Richard Henderson wrote:
> Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/tricore/translate.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


