Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA60B7F1A64
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:36:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r58AU-0005VH-3M; Mon, 20 Nov 2023 12:34:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r58AR-0005UK-5o
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:34:39 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r58AO-0002BK-GK
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:34:37 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a00191363c1so106061066b.0
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 09:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700501674; x=1701106474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LYfoGZi+/RC6+fhMYN5dUtpaIC0R/6sQGvfFsEn2Yt0=;
 b=VdyX5AacmCNU3QCQuv4K4afZTK6zhtmA17kfFSwa0Qg7qOoDAIoh/S8WvUBGIciYGA
 oPGJ76Wty5RUuMQQGlG3+KlFA7guCkol4PYBRnVXUC4fNyMJsFzrQe5aNmI6SgnOIbID
 ILsoBwpZXSKPBo15PuwASsmZti649gW9bQwEs2f/XBHfLzMZ1EWAtHSyDg9ssKrZRBqT
 zUdZ4ogJdX7Cro9ihkWQH8+RD73e31fzJpfT8IPcigzdATMTj4HYv5gabt3J8Twnyj2Y
 UAs1VM37alv38SIUqgp71nad4QfAX1LbnDoqAQcZ2RZRFN8Gp1NA4stb4pgbnsgqzM10
 5T3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700501674; x=1701106474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LYfoGZi+/RC6+fhMYN5dUtpaIC0R/6sQGvfFsEn2Yt0=;
 b=pLeqrzQfkRaT4HpVWxazVL3EDss2Nh4bVsOHWOhNKXJxuwAiUOBrrKcLesG6xpahDG
 uBLluaAJxtUWG8uSJNS12OxchsicUE6KHasueUD+l7mdzB/48a+00AGVsYM6HeK8qNKx
 ctzHqxbNhlZUn+I1ulEcOlG9wmctNk18Mjo4FEtmitq5gLhd7aiAuv7wPRmKaYa9l8ob
 xn8QXOcC/1CkyhSg6BV8Y8iYpfx6ppRqEUBFfAkrWTf3pJ4/xYLxd+oPx8mJ4NTzmA4X
 H3AvEs3SnpRl2i4aGRk5NENPLWncTPmU4P/egY+CawDzv9RIw6MGdcfUFMnko0ZkdJnO
 NjSA==
X-Gm-Message-State: AOJu0YxyoHrwnqLqcdAoJvQ/wanqtSlaSTd73veDQU6BSKsezLoPtkYZ
 9bcy1dM3tJ1e1ZaikW09bzwWtw==
X-Google-Smtp-Source: AGHT+IG8sTy4WXiLDPvzcyf3cZ2gyX9xcCmpFyb5xnp015IUmXoi4BUkccVgXskQiNaCgAI2PWHUwg==
X-Received: by 2002:a17:906:3986:b0:9d5:ecf9:e6b5 with SMTP id
 h6-20020a170906398600b009d5ecf9e6b5mr5579908eje.59.1700501674562; 
 Mon, 20 Nov 2023 09:34:34 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.190])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a170906a11200b009e50ea0a05asm4128410ejy.99.2023.11.20.09.34.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 09:34:34 -0800 (PST)
Message-ID: <650a781f-0649-4195-9dc9-5fbaa5ad5ee4@linaro.org>
Date: Mon, 20 Nov 2023 18:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 0/2] hw/arm: Add minimal support for the
 B-L475E-IOT01A board
Content-Language: en-US
To: ~inesvarhol <inesvarhol@proton.me>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, peter.maydell@linaro.org,
 ines.varhol@telecom-paris.fr, arnaud.minier@telecom-paris.fr
References: <170049810484.22920.612074576971878323-0@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170049810484.22920.612074576971878323-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 20/11/23 17:35, ~inesvarhol wrote:
> This patch allows to emulate the B-L475E-IOT01A ARM Cortex-M4 board.
> This is RFC since the implementation isn't complete yet, there are no
> implemented
> peripherals, and it's a first contribution to QEMU.
> The changes from v1 follow the reviews from Philippe Mathieu-Daudé.
> We additionally changed the parent of the stm32l4x5 SoC from Device to
> SysBusDevice.
> 
> Details of v2 to v3 changes :
> - moved the initialization of armv7m from the SoC initfn method to the
> SoC realize method
> - embedded the flash sizes of different SoC types in the class_init
> methods (removing macros)
> 
> Details of v1 to v2 changes :
> - replaced 'stm32l475vg' by 'stm32l4x5'

Thanks Inès for the requested changes. This patch set LGTM now!

Looking forward to see device added and firmware running as test :)

Regards,

Phil.

> Inès Varhol (2):
>    hw/arm: Add minimal support for the STM32L4x5 SoC
>    hw/arm: Add minimal support for the B-L475E-IOT01A board



