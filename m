Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F82D718358
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 15:50:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4MDE-0004YR-TA; Wed, 31 May 2023 09:50:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MDD-0004V3-3D
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:50:03 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q4MDB-0001XT-FX
 for qemu-devel@nongnu.org; Wed, 31 May 2023 09:50:02 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so44612215e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 06:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685540999; x=1688132999;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zJxvqFE371REx8p0w/yEU1TPufkGacYhcl59Qzw60LE=;
 b=Eq21RGnsCHC6FhofVz3SndoomUk625nXOu3G78MLoe/BHb5sngA+wH2Swce2zNPPHT
 4cSu8VSbMPczbItAl4YkuU/fsDy6PrnCQKdwjnAPTPQmvl0bzKCjLV6hQSn75MGGcgtQ
 0IMOMthElBq2pR7CTajp1AUCl4yJx/ta07q4Bn11erhu017futYBYwRy53CWUdRFyrd+
 bmJ8u6cZ3fbLXpsOi2NpVwnKccOFDzT032oxPs5YEdnkN6bZjnyfPYhB05voHcAzmDwJ
 wB12aBiMGSK0aizHnq6E47RaPUfB4WdMeq4vrdC0VDwAwgsF6AiHiZLuEpfMEuP8RMeR
 eOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685540999; x=1688132999;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJxvqFE371REx8p0w/yEU1TPufkGacYhcl59Qzw60LE=;
 b=SZ0s/jwXQRTp5zFwEc42arrmS1s5XUIRJFYnki0AGRPzwAqmXbUtnMIzHcAH1LQh4F
 +fSggwzjseIUMnXnxr7H8V6Ywlh/uFVnHEarzeCV4Vssy0fn1RH3w4pUlj3Q2y7zbVxV
 Zsfn0kmrvytmVkpa/94buq+BMfqdGfXbpQspUT501UkPnf6LJGF86xWqtkf7RPZF+iTo
 iMG2AzmizRoo63Rtf3rpWl0NYu1vCwQt0GWKMf3PTrHUFJJz3bpjVIO2CwX2CWinMWTv
 t8PbwlGecxehZwnj0+kfNLlFiKqKyRJ+6nrgU0DGX56gAQ4MsJcVl3sy5Z/OxyzuL7Tu
 m4Sw==
X-Gm-Message-State: AC+VfDxnw3UlyHxPe9Irdb5tjcIEm+1mruygVuqu7TsQqKXWYfYjJw/+
 kQI20o7+6GFSFJA41TUsKbFeEA==
X-Google-Smtp-Source: ACHHUZ6Mc94/jufVIOAUOKtiRxFnlVSRaGochNorkVPOH9MLIZTklNKaBgLiW2zhOQNtpi0v3Ybjrg==
X-Received: by 2002:a1c:7307:0:b0:3f6:38f:aa07 with SMTP id
 d7-20020a1c7307000000b003f6038faa07mr4443588wmb.24.1685540999533; 
 Wed, 31 May 2023 06:49:59 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.146.12])
 by smtp.gmail.com with ESMTPSA id
 m10-20020a7bca4a000000b003f70a7b4537sm6633549wml.36.2023.05.31.06.49.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 May 2023 06:49:59 -0700 (PDT)
Message-ID: <016440be-2a9c-b949-69d1-346975f048ac@linaro.org>
Date: Wed, 31 May 2023 15:49:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 15/23] q800: move ESCC device to Q800MachineState
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, laurent@vivier.eu,
 qemu-devel@nongnu.org
References: <20230531125400.288917-1-mark.cave-ayland@ilande.co.uk>
 <20230531125400.288917-16-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531125400.288917-16-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 31/5/23 14:53, Mark Cave-Ayland wrote:
> Also change the instantiation of the ESCC device to use object_initialize_child().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/q800.c         | 6 ++++--
>   include/hw/m68k/q800.h | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


