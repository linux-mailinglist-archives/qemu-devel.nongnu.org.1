Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA767F3239
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:21:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SXl-00063k-6H; Tue, 21 Nov 2023 10:20:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5SXi-000636-TB
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:20:03 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5SXg-0001A4-Am
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:20:02 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b26d6f7dbso9574145e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700579998; x=1701184798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=plXSaAJeCcI2SIfP89xH8yGBgIsf5mBO0zaRCC1psVs=;
 b=RLuBZfhbQuJAQq3azLJdKC+Mo1IWDhu8mlC+pZoq1Pbzhii+kWxujrhaF8+K11Nn06
 9u5x5akaR+N+NJU25NFhPB16Gu3dobJiZjXgnfO7nFFPfditR8faiHCYnvnqPZyuAzYU
 Uo8w1vkDFjlm9OwVGdlDCvk4P6Bkp6pQbCD+XIMALRoSr71Zcab9ZyGWEP4WOg/9s47a
 ViuBi2ipBkyOz9sM5ozO1RBoFe2kZ67tizdfmmwYlzSZrpF4vnm98gvLYbrQN8KTDOen
 02sZIRPrBRLbua85Ftsgi6DOeif9tcH9wSiNu3vr61naZQunCI/fvEhc7tvWq2fKgftr
 wbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700579998; x=1701184798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=plXSaAJeCcI2SIfP89xH8yGBgIsf5mBO0zaRCC1psVs=;
 b=ZPZYSJzS/WOlQxGfW6fabjAM8T9nLGgJlNYOxtpvvI34lXsop+VYTHj/i/0HN/XtC3
 0ZhADv+Ap9zfYlHrEl8cyRqIMxvp3m+D7MAOMjGFlsuojstovT3oGyvd00wn7oMtaWmP
 7KWB4xZrQJQvopqpvP2zs2tjBqeohKKOWvlqzbPT4b6WPS2jDKaAiNiW1eKpI/5O3hx0
 JEnIsgThMbOsHbVeok9NH9usd3LB5cEA9zYRK1XMymNwoNgRQj4i5223lFEP7gsHgYa7
 I33yoPFk3VxkGG2IG7DJ1NmtOdFZAYib0jlTXjkWFdXqIxm0vW3yNDt2jyZei8m9pyzS
 azzg==
X-Gm-Message-State: AOJu0Yxhrq0vqjrqv8b2QY3BlJB1OAz7RQctjyBOhVpfNJuCDNuemNGh
 GJ/ZAvhbxc1i48FQbx6XYhJeTQ==
X-Google-Smtp-Source: AGHT+IE/5EnWy1OuXQ+YWwd5Ua8LmOC4F32lKjnDYtBTihgscrKsiqgcMbVBSG3wc+YNqHAds6IDdg==
X-Received: by 2002:a05:600c:548c:b0:409:325:e499 with SMTP id
 iv12-20020a05600c548c00b004090325e499mr9116633wmb.32.1700579998285; 
 Tue, 21 Nov 2023 07:19:58 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-219.dsl.sta.abo.bbox.fr.
 [176.184.8.219]) by smtp.gmail.com with ESMTPSA id
 n21-20020a7bc5d5000000b003fbe4cecc3bsm21246474wmk.16.2023.11.21.07.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Nov 2023 07:19:57 -0800 (PST)
Message-ID: <db7080bf-1530-4515-b23b-78863efcda06@linaro.org>
Date: Tue, 21 Nov 2023 16:19:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu 0/1] Implement the STM32L4x5 EXTI device
Content-Language: en-US
To: ~aminier <arnaud.minier@telecom-paris.fr>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alistair@alistair23.me, peter.maydell@linaro.org,
 ines.varhol@telecom-paris.fr
References: <170057856467.12935.6421900912319796560-0@git.sr.ht>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <170057856467.12935.6421900912319796560-0@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Arnaud,

On 21/11/23 15:56, ~aminier wrote:
> This patch allows to emulate the STM32L4x5 EXTI device.
> It implements register access and software interruptions.


> Based-on: <170049810484.22920.612074576971878323-0@git.sr.ht>
> ([RFC v3 2/2] hw/arm: Add minimal support for the B-L475E-IOT01A board)
> 
> (We got the message id from
> https://patchew.org/QEMU/170047309499.17129.4986209009679789101-0@git.sr.ht/
> but don't really the standard procedure to get it. Sorry if this is
> incorrect.)

This is the correct tag and msg-id :)

> Arnaud Minier (1):
>    Implement STM32L4x5 EXTI


