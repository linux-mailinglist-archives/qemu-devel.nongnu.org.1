Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105B720ABC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 23:02:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5BuZ-00076F-Ek; Fri, 02 Jun 2023 17:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BuX-00075n-N4
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:02:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5BuW-00051L-83
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 17:02:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30ae967ef74so2291989f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 14:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685739730; x=1688331730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0epYMF7+A8D7yWaoTohmYO3P+HfcOqN/0j9x1hfTw4=;
 b=PAFxx4uqXkCPiOlxd8vqXawNccRaNnz5oUtYKox9uXpDToAOKL5i5Rxm4/w/pcm40/
 sDbkfjBlnzF+PTPtrX23NP/jDO+f+Tpj3oSR2gvcCiJ+qp5razOfa4jiQyUBOiACypMZ
 3YIIeWsP+vWeSBU/WHSX/GXwTH2+0jEy3y9fVLU0eXCYr2TfzHaFQosMjYDfzZpPzmRV
 RdOIoU9Zxhks9RYziVPJYJ9vX3x40BjGbfGTQI4wCej4AZvfDJJmOVyxA2YlDRY6l61P
 v4PbhOPgEGJnw1UBeL7ZPct98KjDsyxQW508QJ1x7M+fc8zEQCP2fRkUws7qW9pAMh/N
 l8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685739730; x=1688331730;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0epYMF7+A8D7yWaoTohmYO3P+HfcOqN/0j9x1hfTw4=;
 b=dN8QJ4mLGOY8A4+CBzx9/8wVSCcKGySg6h4RsK2wySWnDbs6qZh0VG/dRtLOhDvvsX
 3QHqmIjmRwLeM7IHpkTEtR+VRYsUW1simRAJMKnHeF0suc2XUnV3yV1UDudaauyFaBM+
 RCfd6lhy1Srd7bE092iWMia04je2y4hgnIm/h+7rhCQ/AIwH8TDW3u8XFjUalAlsaVJv
 Ehgp8UTWDqaHrOgU1B6D4mgNh5uuReKEs7SflAh5pzEXZSmdLmMqbS6UmVUJpmUVE6TL
 /qYPOT68UvNymlFXvoBBERdepWY2xpibP/YYUNb00gPRcRR1AGOjQr3uXPRtZcf7+BIY
 mc9g==
X-Gm-Message-State: AC+VfDxjhawGJNsPQk3F9X3pGUbJ3bBb8ltgopAzmgBi4lm10riz7abk
 OrubmZlOCViz3ALiIEzzfRFNPA==
X-Google-Smtp-Source: ACHHUZ5/Sq6ArwOFRQRF6+ZGiq93Q/mzA5EyVyeaeDSHss27L6jEKBcUm6PmdOOU0S+j5Mqt5u2Pdw==
X-Received: by 2002:a5d:6e53:0:b0:2f8:f144:a22c with SMTP id
 j19-20020a5d6e53000000b002f8f144a22cmr815800wrz.62.1685739730506; 
 Fri, 02 Jun 2023 14:02:10 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 m10-20020adfe94a000000b0030c6751a49dsm2603482wrn.115.2023.06.02.14.02.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 14:02:10 -0700 (PDT)
Message-ID: <3342407f-b6ef-b2de-ac1d-bf014e576d51@linaro.org>
Date: Fri, 2 Jun 2023 23:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 40/48] *: Add missing includes of exec/exec-all.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-41-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-41-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 31/5/23 06:03, Richard Henderson wrote:
> This had been pulled in via exec/translator.h,
> but the include of exec-all.h will be removed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


