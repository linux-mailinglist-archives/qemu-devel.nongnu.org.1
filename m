Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 043587D208E
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 03:04:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quMsD-0000rv-ER; Sat, 21 Oct 2023 21:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMsA-0000ef-K1
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:18 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quMs8-0006li-2p
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 21:03:17 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso12447665ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 18:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697936594; x=1698541394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjzveHNl+4iP12W87RtgmzneFKAZ4X5/aQ+bp6JxbsE=;
 b=X93q9Jb7rcABJ2yJSFt8tGvmORR4nfnEop3MbC1my35CZwKFHJshUd0qjS83MYueA8
 diGsbEFc5DY4GPChfxnUrRS8vo72WUwp5cVNxnqeM+OSXAU9gVRnVAbgeygLrhOXyhXG
 auJxtMElvJXDcpz2IH44dc0nYzooek/r3Jp7fcDVsww2jPR50MkfztFb8MnXla5jPoEe
 nbKBmVIws/2HwCeKI+uKy7WLIBeWf/SbhRd1wmFf0i+1786USfCsphBKVAy+877qNWn+
 TISNywikLeRciGeVP1O8bsQ7yT6EzplwMyRQtODRg6gVP+TpYsbG0qwFe0xQxJGqjPIV
 cE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697936594; x=1698541394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjzveHNl+4iP12W87RtgmzneFKAZ4X5/aQ+bp6JxbsE=;
 b=qL4+l+XQOUgBmA9mIoUbd6FZXtaXUngIUA0guS6WIdYUEH8Jken0lvo8xA1ZJGDjMD
 aZdZh2vVzekBgWhhurBxhqgCS5s1mNfcaNEqTF+aaI4E/IshXZL5ZJ+lYdrjszQ3bSYf
 NyIMz6Gw9B0KuI85tDCe+ucgdXYH8bsqukWTM7LtPuseWW+1OJeLAbeAgiighoQeqC0E
 z4y8CGo2v6TNZkhlqlNrACeyCwpgsjb+/wsAg5B2r/3at/GuEm4A3BKkpyhRbuoA22b/
 w0qmKzzuJNxi2igCiyGEaFxu6YjTo9yZRBj5wGH8T2Hz9LiCP3/ePC5kPXfd4Ym2wyiS
 BHiA==
X-Gm-Message-State: AOJu0YwSlyDTA4AHKVsZJU+K8081gqaZTfD1xMuFv5A8ur+R3IzgX9M+
 PLP/LDOgcUwLG0kkOD1YYM6ZrQ==
X-Google-Smtp-Source: AGHT+IFURXn3AhP5MukgpQ19sZ3/lLdnSRzgoFL4Z5yB+ptBT6uraMEATH6+a/AhaaJxLiB2r/H/dw==
X-Received: by 2002:a17:903:2115:b0:1b9:e937:9763 with SMTP id
 o21-20020a170903211500b001b9e9379763mr3841341ple.12.1697936594489; 
 Sat, 21 Oct 2023 18:03:14 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 jb14-20020a170903258e00b001bc21222e34sm3704336plb.285.2023.10.21.18.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Oct 2023 18:03:13 -0700 (PDT)
Message-ID: <2654c74f-c65c-449b-8de4-625c5a73d660@linaro.org>
Date: Fri, 20 Oct 2023 14:40:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] hw/m68k: Strengthen QOM/SysBus API uses
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>
References: <20231020150627.56893-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231020150627.56893-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/20/23 08:06, Philippe Mathieu-Daudé wrote:
> Avoid QOM objects poking at each other internals:
> - Pass "link" properties
> - Access MMIO via SysBus API
> - Simplify using sysbus_create_simple()
> 
> Philippe Mathieu-Daudé (6):
>    hw/m68k/irqc: Pass CPU using QOM link property
>    hw/m68k/mcf5206: Pass CPU using QOM link property
>    hw/m68k/mcf_intc: Expose MMIO region via SysBus API
>    hw/m68k/mcf_intc: Pass CPU using QOM link property
>    hw/m68k/next-cube: Do not open-code sysbus_create_simple()
>    hw/m68k/virt: Do not open-code sysbus_create_simple()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

