Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 561CB739BD5
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:05:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGFC-00019L-4W; Thu, 22 Jun 2023 05:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGF1-00018U-8Y
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:04:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCGEv-0007Hx-8A
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:04:32 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3112902f785so392522f8f.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687424668; x=1690016668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZhN+RdGgL/qIj9q/ijM1Tbr7MrPvr5rA7EXDO9nlWI=;
 b=gqnMjuT67Pe2206GR9bMqzd4mVBJM+ElUfG5wwmFxkmCxmRThg/HsBgOxNVWv780Qp
 xGqasFG8pn0wEriWjGMe9nemELDO2b/kq2RI4cX6+rlOWpsRoJFjJq6ilkBm/IwHOXJp
 a7Q3bx4s75mOaYzdL7HL+lhdDK5z0SqzRdMUvN0q1am9UTH3UYv3psPlPTJimlAMfuyY
 KsTn/Oq1ERl5cNiAqLNNKl3ZthiSl0FWOSncemI1Z5wZkDofmKOkeTC/1m4/jmiJ6kqr
 kMvid54dGC/T3M3ZJtpQ+wFnG+SEK22vscO5leu54KB1xkOhpKjBN3CwVJ8ZnbCSSZlS
 bEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687424668; x=1690016668;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZhN+RdGgL/qIj9q/ijM1Tbr7MrPvr5rA7EXDO9nlWI=;
 b=SBMxPIE/7roMzPaPh8cxxHODPo5FF6DuMQCTHhyR9P7RNK5q9o0Ug1h6cxbJmXs50J
 +duGMUiag6o9LGJrasRbjFhDxxIpNwtH8a4I70Zfru538EF2tf9MSKeSPLarRYwU6+MM
 MGYe+YQbJu8JwQacKyc+9LXPFcB3nR1o7nJYKYize2xa0i/8n6c7+0Sc6QkzE+9+aSj8
 l2NbO/ILvwdMFMkN3u+9NHhUW+HupB8mpHqEAUvt0MNHZ+PP2fgOuXG2zL9D0tXDhB1B
 gXpxbSGYpiGYr3Z3GCYjDBNxq/cEHf8z8BLNknoS6pbiZgNI2pEeto7Cf+R6pyEWA2Vz
 ZtUQ==
X-Gm-Message-State: AC+VfDw+LD/Yfqn2POyehgNT+8fhlcQAj7Fvj76KgdZc8iX7YBwn4woi
 GZjWcc9Wy0RJWZTyKTIdkZI59HptFVVDuSgqCic=
X-Google-Smtp-Source: ACHHUZ5xylOyeaTFJdIDCLZ8uFU0uednvjCY/HIiuoSsmpoCZqXNBTy0UHtL5H9IakLe0xtNUoRUEw==
X-Received: by 2002:a5d:5648:0:b0:311:b18:9ca4 with SMTP id
 j8-20020a5d5648000000b003110b189ca4mr23077375wrw.17.1687424667946; 
 Thu, 22 Jun 2023 02:04:27 -0700 (PDT)
Received: from [192.168.69.115] (che77-h02-176-184-42-18.dsl.sta.abo.bbox.fr.
 [176.184.42.18]) by smtp.gmail.com with ESMTPSA id
 x5-20020adff645000000b0031276f8be22sm6503957wrp.97.2023.06.22.02.04.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 02:04:27 -0700 (PDT)
Message-ID: <e34172c3-cf09-21e5-6ca0-6f16af2f5703@linaro.org>
Date: Thu, 22 Jun 2023 11:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 8/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr for
 v9 WRASI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230621180607.1516336-1-richard.henderson@linaro.org>
 <20230621180607.1516336-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230621180607.1516336-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 21/6/23 20:06, Richard Henderson wrote:
> We incorporate %asi into tb->flags so that we may generate
> inline code for the many ASIs for which it is easy to do so.
> Setting %asi is common for e.g. memcpy and memset performing
> block copy and clear, so it is worth noticing this case.
> 
> We must end the TB but do not need to return to the main loop.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/translate.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



