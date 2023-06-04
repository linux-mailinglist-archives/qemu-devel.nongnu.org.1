Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411247213F9
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 03:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5cfy-0007rP-5g; Sat, 03 Jun 2023 21:36:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5cfw-0007qu-1w
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 21:36:56 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5cfu-0001zf-Ii
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 21:36:55 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-543a6cc5f15so8657a12.2
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685842613; x=1688434613;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQyhYJE5iFDJ/EkCg9l8WzQ21731dpMSG1R6NtCPeM4=;
 b=p4gZ4iEBN8yqMlMjZayYOFINHp3G4ABTIdt5j0O3RfN14cIGKdjOotsJh4juIx8hm+
 Ys6LU69S0mzyGLFCXMEvZ6bn00EO/FMa895aiP+Oz+clJxWiK07wzgBlouYle4CDchhY
 tcRL+h1hNDi0VjLoV8MmfzmEPWBzFWjN2CAUjUktiHhF0TaatO0gMprDa6hHSS6KWOHw
 mQ5LYTK6RuF+q58Y/7dthirmv40JQZ9J+o57t6/XS0Y4lvJa68baC9YO2a4G2xNR90w8
 JE4iSbARCa6CQ7v5Een2OlkXPlOIZH1EUkA72Zu5itaarTV38iiYIcAjUbRyN2os3uC2
 +Wbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685842613; x=1688434613;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQyhYJE5iFDJ/EkCg9l8WzQ21731dpMSG1R6NtCPeM4=;
 b=C3URzkMvYLfSSpLbGS9sfiJduMK7P3PNpEB5xDyJw0vKcosU8d4MRt59piUb/woIzr
 +Ncfav4tFrPWwFCM9AXdSnnWlttz7SL+7gSDQofTJq+aOsIRmCQXWYMLVq6K65JW8tQi
 KFGCByegljskPdzCAJRlxPsVLp8vNShLi4N8fV4o9zlS+rs0AQHyrjJm4Gp30gjQqYne
 hDvzOMH5BkpguL2w7y/fYAPEdu+Sfe2ADwJAABb5chHbY8+gmgxykK93mG18i9mLJO2b
 I7zAlm5+M/8A2EE34hn9z6udINJbf0Gd7buxXZlmE+oxtx9LmDM6ipw+FL+IGKQcs/BU
 75Ew==
X-Gm-Message-State: AC+VfDwxUP3BrzU7eFyxrIO/aLokBGVPymMvxSX/lyUQp29YiHCyoLGb
 5O6ldog0QOHMBJvzseoh2iCTtA==
X-Google-Smtp-Source: ACHHUZ4plutk7HkbaYbbVr2G8VM/I/7RO/OQFcAlg/+lujb671uSFu+KMklIJdgHPosvdskkOmTxVQ==
X-Received: by 2002:a17:902:c410:b0:1ac:a6b0:1c87 with SMTP id
 k16-20020a170902c41000b001aca6b01c87mr6143350plk.48.1685842612964; 
 Sat, 03 Jun 2023 18:36:52 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9a37:84b6:b3f0:f301?
 ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a170902d50f00b001ab25a19cfbsm3798619plg.139.2023.06.03.18.36.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Jun 2023 18:36:52 -0700 (PDT)
Message-ID: <c29e0708-b137-e23f-f510-676411dc3514@linaro.org>
Date: Sat, 3 Jun 2023 18:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 20/20] target/arm: Convert load/store tags insns to
 decodetree
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230602155223.2040685-1-peter.maydell@linaro.org>
 <20230602155223.2040685-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602155223.2040685-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 6/2/23 08:52, Peter Maydell wrote:
> Convert the instructions in the load/store memory tags instruction
> group to decodetree.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode      |  25 +++
>   target/arm/tcg/translate-a64.c | 352 ++++++++++++++++-----------------
>   2 files changed, 195 insertions(+), 182 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

