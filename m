Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579BC739E00
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 12:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCHAZ-0000L2-Vg; Thu, 22 Jun 2023 06:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHAX-0000KH-LB
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:04:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCHAW-0003K9-3k
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 06:04:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so4881275f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 03:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687428238; x=1690020238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7KJBWwm5D1Bhz//8ou852GyUXSF5A+TiwmFDK3nVdUY=;
 b=B3N2cQxlqNghIlAl8psoYsFj+rA99ErtOgxg8ERnTqRvsR8+anNtRVmhRBTqQ+n09X
 hggUPY5ADbg0zpRI4f5E0S/PTR9lksC2jubA67BjQBRktneFcS/f5yKRINuSfRv80s63
 JXc5RDEWxsx6cx68Q4QYix0AoWsh0rfQRsIzGTwvj/Q75B84lGZ3QNlAdz24AQaREJ6c
 +n/p6E10S+t7y8XlqWv1zYBqEnTH/5kYmXU7OSyygfci6sl8kkRtwrHSbXQrUUrCkv2c
 5UMGBWhOr2PFY+I3yKzfZiAkTktK/pVYqqXehE8Y8ntWAGX+ACeVh1Jl9YUoqqCzfOZR
 Rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687428238; x=1690020238;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7KJBWwm5D1Bhz//8ou852GyUXSF5A+TiwmFDK3nVdUY=;
 b=d6VglLKfgd/8Iu/TdWOAN7TqyuaYqRCW7tDD2csYo0SXwfHdXpRr9kkcKkhR2CFdRP
 yXlEX34ajTk9NrVjdlDJWJ2a4A+HlaUArOeHfmvUYaA60fdwFjV3bokvMv6/2PpQ+qCj
 LtbohDaK5rT5S2AWJJfPYG9K/FJdfObiFonzXBOReeRBQHGbTy9zhPtK621wU51nzvlQ
 f3NnPuR+tWuKTTJctO9LwzVQhICCtqD4J4F78A0adgVIfWzThm5wziw3xFdERdnIFase
 CFRKUPZMtgHaG1Pj4wF5/M1oqzB8UdSlcAvq03suFUbBDXJ3pdQ4y43rQTMC747AJrRz
 HEOg==
X-Gm-Message-State: AC+VfDwjaJ5wcUGce2oKu0RuGRjozdZw+jrzLpWBdHhn9wIPYnQEtbVv
 /VHELKsBimYHyiH9wUr7hJsedA==
X-Google-Smtp-Source: ACHHUZ40tQIuUCaAADZxCmCpsXB+K3qPJbOljrpOBEzd6cgLcL0rjCQkClEiksFVUXxTCd7x85i2ZA==
X-Received: by 2002:adf:e581:0:b0:311:1475:328a with SMTP id
 l1-20020adfe581000000b003111475328amr12711722wrm.31.1687428238119; 
 Thu, 22 Jun 2023 03:03:58 -0700 (PDT)
Received: from [192.168.122.175] (127.red-88-28-17.dynamicip.rima-tde.net.
 [88.28.17.127]) by smtp.gmail.com with ESMTPSA id
 w18-20020a5d4b52000000b003127a21e986sm6616090wrs.104.2023.06.22.03.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 03:03:57 -0700 (PDT)
Message-ID: <8b8fac67-011f-1091-5cf3-2f1192a97149@linaro.org>
Date: Thu, 22 Jun 2023 12:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/9] target/arm: Support 32-byte alignment in pow2_align
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230621121902.1392277-1-richard.henderson@linaro.org>
 <20230621121902.1392277-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621121902.1392277-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 21/6/23 14:18, Richard Henderson wrote:
> Now that we have removed TARGET_PAGE_BITS_MIN-6 from
> TLB_FLAGS_MASK, we can test for 32-byte alignment.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


