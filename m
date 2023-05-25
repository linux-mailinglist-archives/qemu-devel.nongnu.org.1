Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2337106E0
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:09:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2612-0005rv-VW; Thu, 25 May 2023 04:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q2610-0005rR-RF
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:08:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q260z-0000xp-Ci
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:08:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f6d7abe9a4so1558685e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685002084; x=1687594084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e0lxhtVcOr0iSjQ0l8mVLQKiQ3E1oG7TsUUiKH39Cvw=;
 b=NTDad6oNlSfesWz+tK2Nmn9Z+yIlvGZFu+aZf00SpPYjqsf9B3SW4tEu/nzPraUqRr
 HoSEf/Sgr9sPPQ1r74rZ05W6273mWpT0OQp2ZpdHsmbIrYEr+pTEODUD1joO119o49PP
 A3GqmYPMeZjNgizyuGiGWUn01Ni+H4+YHD6Mu6UYgel6WA2qBnfHNvP1slnyDFto4V7K
 1yuek4gwYG0MRwmVq9ApLVz4/CO+HB5dAphYgS/wQY/8nmPW140Ezt9NmajhIQIU/SAC
 FvtKjj9PwjUWyrGurMUZMowz20mq5wbnlwcCJXykYpDp9c5fLPLYoOLi8I16BaKWTwRf
 0rTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685002084; x=1687594084;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e0lxhtVcOr0iSjQ0l8mVLQKiQ3E1oG7TsUUiKH39Cvw=;
 b=P/ld2PsfT0KKB0Qth7sDRVSTDKQhFGRzZTG5OBVC8D8Y6BtRiPvMMw/XaDP7Z+eCMy
 wFSKoBxiTZeu6T7/a/VYVH8Ukjs1l9qWH1b34olMsUDRMPYFaPldhIUpQa1oWwHgd65T
 eg4W8UPZ1GWszYG9I5JVG97XEX7hLTbCjpTc3U+IVxLVVeO3l2rYIk5rs78i2lRBSbDp
 oSlvTkNOayX6iEhnS5E9n2cRij/ZdPNwli6M1ZHDMw1IghxM2fZM22nnzXzIKH5Ajrkx
 oqUXMe0bkBNf23Am/kbAhNqZ6OzNUEB2Wp8x67nCncJJGnU8qwGobL3WymMCRPlaELxo
 uCVg==
X-Gm-Message-State: AC+VfDzhsrgmyv04T94trr7GZL5kkSXqmYec0L8iKQxrzZx3P7zZAt0M
 c7f9Yfq/eZhPvr8QCVSmQuwifg==
X-Google-Smtp-Source: ACHHUZ6qsQR3VVbV27f/8bRfl0N668yQ4T85UeL4KqR+QhlywwAd8EH37tP7wDIp1NHce5H6fJDeLQ==
X-Received: by 2002:a05:600c:2104:b0:3f6:675:3219 with SMTP id
 u4-20020a05600c210400b003f606753219mr1587753wml.40.1685002083951; 
 Thu, 25 May 2023 01:08:03 -0700 (PDT)
Received: from [192.168.69.115] (cor91-h02-176-184-30-254.dsl.sta.abo.bbox.fr.
 [176.184.30.254]) by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c364600b003f420667807sm4789820wmq.11.2023.05.25.01.08.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 01:08:03 -0700 (PDT)
Message-ID: <d19426d5-4a63-0990-a2fd-7368ee23c172@linaro.org>
Date: Thu, 25 May 2023 10:08:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 05/30] q800: move ROM memory region to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230524211104.686087-1-mark.cave-ayland@ilande.co.uk>
 <20230524211104.686087-6-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230524211104.686087-6-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 24/5/23 23:10, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 13 +++++--------
>   include/hw/m68k/q800.h |  1 +
>   2 files changed, 6 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


