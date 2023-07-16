Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB5754F8C
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 18:01:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL4Az-0005QH-O7; Sun, 16 Jul 2023 12:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qL4Ay-0005Px-4C
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:00:48 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qL4Aw-0000Nx-DQ
 for qemu-devel@nongnu.org; Sun, 16 Jul 2023 12:00:47 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57b6so37311935e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Jul 2023 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689523243; x=1692115243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6H2pNLG6LXHPWsxar4rALJ1swhVYjlodetN7nFwSJwM=;
 b=KjVIG8S6Xpg9PNMXOEUGJApd75hxgfBxaDNX7sy+y3TSkJQckQcB79ieWOjSk9ev0V
 qO5waoZpKr52dgBYS0daPYjuHHeAl6hp+ofyT4tEIr9tQG/jKPqmtAqTu9UvVvqRfvCL
 ItTOhGxfo+kJdZjArB0ixscP+NTmoT8G3WrDctKDxNY9m6ajOITQXQpHQJ6GDZBftdLE
 f0fMgy1xOWhZtZtQ2TYDP0vnUKVZJfMcNLg1RstIfweXY+R7s/aoULJWqQ61izdSbOCQ
 qDGo4QwvSoGH9X++A1zAuFjuU2SLEDTVlhkKFHtIjihEMKaTgVaAvABW5/X6T2RVzLyu
 aHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689523243; x=1692115243;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6H2pNLG6LXHPWsxar4rALJ1swhVYjlodetN7nFwSJwM=;
 b=kkMDOhC18nF1ow9y6nUoGDsKigwZL35FgeWi7YRIDFozYpamHt425UQ7mSe09gX0hx
 M68QSkYWE/LjZY/hMLZamxQHhDBRrvAMSOwLqYJWgfJY4M7ID+9mqKUSkkbdAEEwGoc/
 Js1iEqzwl4Men1MjS7o8lRcic/iGvDpM09s4iWf0Hl6SBT3pfNafzs8BnrxiGbZaRu+a
 bpeSoBqzE4s5s7DdezUx9fLri4g24KDLDFpsIJGlAnGMo75IIoFPBntlK3v9S27NbxMn
 YdM1vbitHVOQk8VWk2hkOQr99yaE+LLJHzEZofwHwaX0CPhwpNl/Y42CwHJoKF4QMFuH
 yDIA==
X-Gm-Message-State: ABy/qLaglocQ6RZ3Q7nTt47vQ+kWYHkjO/nQclYZhnC1Vz36VrXh5bX8
 0laTAriHlTMH+eiSm39hPEi4Gg==
X-Google-Smtp-Source: APBJJlHlYnI+NbdmWunihgBNgH3yRUnRS2t41UxsA77UmrOFWdSwc+Ya8XPXJNVTOEDln8MEkG+WKQ==
X-Received: by 2002:adf:ffd2:0:b0:313:eb81:d2f6 with SMTP id
 x18-20020adfffd2000000b00313eb81d2f6mr11045891wrs.4.1689523242915; 
 Sun, 16 Jul 2023 09:00:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.195])
 by smtp.gmail.com with ESMTPSA id
 e22-20020a5d5956000000b0031431fb40fasm6139285wri.89.2023.07.16.09.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jul 2023 09:00:42 -0700 (PDT)
Message-ID: <88eb5dc7-3254-d760-e375-5349c03f15cd@linaro.org>
Date: Sun, 16 Jul 2023 18:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] hw/char/escc: Implement loopback mode
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20230716153519.31722-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230716153519.31722-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/7/23 17:35, Thomas Huth wrote:
> The firmware of the m68k next-cube machine uses the loopback mode
> for self-testing the hardware and currently fails during this step.
> By implementing the loopback mode, we can make the firmware pass
> to the next step.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/char/escc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


