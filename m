Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B50A74595E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGCK-0005QG-8N; Mon, 03 Jul 2023 05:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGGC7-0005Pm-41
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:50:07 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGGC5-0002Xr-Cl
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:50:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbd33a57dcso19291905e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688377803; x=1690969803;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnMlDW76eTu1dIg94Bnl1QoKXxkFgeGjODFn772MHKo=;
 b=rHUdqNfcUfjcK/He0b36qG8rUESJU+YPk2pDbJMc9JB9US+7NkSSdV3IMaorV3K1nm
 Kc3bfpmZoObmYpxjo7Z7lUpAVD/UCOq3VhLlJ9qdk4WfwqFmk6g1/u7a0qGHc1AMsKXt
 2gsjdDKSiJcB6GQ9Uzzj6CsnvyCfHvhOLTU9Kiv4H83OVCekMNEmsM1G+hX6vUbDlIad
 qmGMhXZa85GfmNjSchzJ5a8/oR0rAqJpgQdy5dehUzPtQPnuPPcEF0uZs8ilIJ4l1HSx
 JVhtF82+MnxxeGRJ3m/do0sceaqVXzYjHduyZW7/gIanw7CX6U7/8vKAamdwNyvyEUTN
 vbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688377803; x=1690969803;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnMlDW76eTu1dIg94Bnl1QoKXxkFgeGjODFn772MHKo=;
 b=ZGCcnjrUyUlRaqSEdZSVS+5CqkH8idNAfZxprC0gDfjrdQ/pNmw+269jgL0WwjZc4A
 /+QgbtOTlougx5SDXUmJ/HiCMjSGKlT57nZyxlyOv/3Dn3VbOnm5TPsS/f4hWRqraVGX
 Jh8pzf597zrDqV08t0u59Lnmiu9Vyf2AdBcw5AqS4etttrNdA/mk/36FmcEoeCuOHQQI
 3FKTqqzxbojDyYjqcjFXMAvaGfzPkMitQPeOlL1QTBpbe90/htQv/1Pc+rvSwciUYl7q
 P5A5glWNHqvoStYTt5hL8lNg9xrcEnAORSKUtS8P2y6yXA3o79nEzAnfFeCvcK7PAPut
 YL4A==
X-Gm-Message-State: AC+VfDxhywKZJIe4FjAet3Zd1sgxQSDgCMndngCfxfCrRsq80JdodwaY
 E0hetJBL4YnMyheiNgo6XgxQwA==
X-Google-Smtp-Source: ACHHUZ6hD3S9glo50HhFZYtL4P+juakaDxZr/B8kZ5dHt+b7+YaNjmICMxNQ6yG4rxmo/bAwOgahfw==
X-Received: by 2002:a1c:7705:0:b0:3fb:a9e1:8bf0 with SMTP id
 t5-20020a1c7705000000b003fba9e18bf0mr8093720wmi.39.1688377803284; 
 Mon, 03 Jul 2023 02:50:03 -0700 (PDT)
Received: from [192.168.29.175] (48.red-88-29-180.dynamicip.rima-tde.net.
 [88.29.180.48]) by smtp.gmail.com with ESMTPSA id
 x5-20020a1c7c05000000b003fbcf032c55sm6629224wmc.7.2023.07.03.02.50.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 02:50:02 -0700 (PDT)
Message-ID: <0ae58883-9c39-6756-ac56-c77eb52ca7e0@linaro.org>
Date: Mon, 3 Jul 2023 11:50:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] Fix PSIHB interrupts init PQ state
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230703081215.55252-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230703081215.55252-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 3/7/23 10:12, Frederic Barrat wrote:

> Frederic Barrat (2):
>    pnv/xive: Add property on xive sources to define PQ state on reset
>    pnv/psi: Initialize the PSIHB interrupts to match hardware

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



