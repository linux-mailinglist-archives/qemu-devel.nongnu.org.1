Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F37345D3
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 12:28:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qApdH-0002O6-RI; Sun, 18 Jun 2023 06:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qApd4-0002LP-JO
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 06:27:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qApd3-0002Xc-3E
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 06:27:30 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9881b9d8cbdso150989566b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 03:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687084047; x=1689676047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7VfXhzk0ZVhtU4tQtcFHxFoxaWut3gHqGCduTsP5158=;
 b=pXs3iZE80Ttjr3xlMu62FQPhy3bfFuXV7j5vIFdxYyD2VEAr04NMZcI/JbEDmQa2hF
 FBTgjLpNfbT8iwk7PVd95dBQgoOAB1BgL7uAgP1YqWc4SnC1IdNJHE7BoN25ZlWygnZK
 gfbWu8cMEqMcJIAGyN1X+E4n06HEXCk9Z9jb7755ZqZpCmhHE7DIhPQgWdHRXaJFTJpX
 0hTYdN5OZo8RceVMP5J+oCrh/0zOWjPfsLdlDM0JkPwryAQMvMVzCHsNWzycA/3MaIne
 PJy7y6VxfXoRvqVFiFHetV1/h8iAYqJTv584IUtxxwiV26km1HurodXvU1u4tGt9DNnE
 uPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687084047; x=1689676047;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7VfXhzk0ZVhtU4tQtcFHxFoxaWut3gHqGCduTsP5158=;
 b=MxVrZjDEARWio6s2HUiadfbDn33bJZOlnQDv8AJGYIVBzrPpvG7lSdu4J84tApiYZf
 AkbQDwwzofpH6C2g3qBHmfnNTh0eamIMddQ9TGitPGBsuU6n81+Qc+E4S0oyDwsQOcqw
 2Ayo9I77h4tz6EAdxKsiffDTDeFe/jhh59UE0qy4edezGgRSf7BByFAqNYCEJL1Am4fm
 Zo61dotacFJ6oDs6IeeieHCb5VFBtL5uuySUeGaaAKzt0quWrPZ/warE/cvk7C7TxEY3
 u3h6+5mPfUrIXrdc9+f49qwEO1xmCKn3oSljiKamCpthfEvssRPEXNRGHRhIAbEc0IP0
 NvBA==
X-Gm-Message-State: AC+VfDxxK1CFqrZKxsxRwFGKORrxWzHpx98pZ60P56sMzv8xrCk2Plwq
 2kDnBqIqyFIGCdTVvl1acrj3Lg==
X-Google-Smtp-Source: ACHHUZ4LFfKzHHGJov2dqvQamWbLgoD02aU9C/jarRPLsYLBbfE8llSv37wO+awvC++SRCwYBxWVNw==
X-Received: by 2002:a17:907:3d93:b0:988:6f63:e7c1 with SMTP id
 he19-20020a1709073d9300b009886f63e7c1mr1143482ejc.22.1687084047530; 
 Sun, 18 Jun 2023 03:27:27 -0700 (PDT)
Received: from [192.168.69.115] (mon75-h03-176-184-51-101.dsl.sta.abo.bbox.fr.
 [176.184.51.101]) by smtp.gmail.com with ESMTPSA id
 kf12-20020a17090776cc00b009888eda6b0asm342881ejc.170.2023.06.18.03.27.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 03:27:27 -0700 (PDT)
Message-ID: <45815e53-2e60-74a7-6399-a4334628193b@linaro.org>
Date: Sun, 18 Jun 2023 12:27:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] Fix handling of AVR interrupts above 33.
To: Michael Tokarev <mjt@tls.msk.ru>, Lucas Dietrich <ld.adecy@gmail.com>
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org
References: <20230614140748.3584-1-ld.adecy@gmail.com>
 <41fa564a-6164-23c6-58e4-3d5d4854e5ce@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <41fa564a-6164-23c6-58e4-3d5d4854e5ce@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 18/6/23 08:56, Michael Tokarev wrote:
> Applied to the trivial tree, thank you!

Thanks. Do you mind updating the patch subject to:
"target/avr: Fix handling of interrupts above 33"?

