Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7431A81ED7A
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 10:02:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIPo8-0006Yn-1Y; Wed, 27 Dec 2023 04:02:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPo6-0006YR-JS
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:02:30 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIPo4-00054q-Ur
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 04:02:30 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d5ae89c72so10831555e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 01:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703667747; x=1704272547; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aORoeZ8YpZY/mnGKGGbH+M3Gm0GJqOQ87HM4l57zbec=;
 b=Q7qJMGt2HUizogjv0p+Db77WKiSb7hCWs7NCS9iPUk/sMNzLZbSCpwmcwJQaYI5lDT
 lYtakKJBsoR2Ik1LI38ExcVJlJIl29KgPjSzoongGmDpqalzBSXcDKtK/LWjaAYjinP+
 nelqEQAo9eMw1sdBxEYojSmzaN5Rt452ijHzASfEyBwjgyJSjbRjHDb54rTNXCXWT0cA
 bmVFKFMYMcsH1Z1fK4/WMzF3le3+A8ljoyo23/TaPJJLlrKiL9p2S4gXj1Zu+PyXHa0J
 RyhNYXKQAsvK26w9bJuoIJ+AFnLlPh2fwbMMxksJBKs7BK438R5cdECDxVi8CfJfhX0j
 keKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703667747; x=1704272547;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aORoeZ8YpZY/mnGKGGbH+M3Gm0GJqOQ87HM4l57zbec=;
 b=WRNeT6LU7wv9ra0jTFCB425MsxYUE1o88Jj+obQqR5CrWC+XORz3t3uikcozYcD2id
 nkxlKk5p1ErxmW4UPlFMrOQ2DZGTBbVEUOP04Gz74g7kUI1gR2NZ66QESURV0tXcqXrG
 EL0R+HZm5Qjhd2gYo7K+B5cbNDVjI43T1U5W88M6PFoxW0V0YR/ZA5B55l2caR6ESuaQ
 cIO65HMOZTcmYW34xeym6AeVdxkfinxfwIPllgR5til87qy/ms4mFvhQiERNASM3bo6w
 z/i7BETfV5RZ0HsPrWJ679PChhN3/GMuxP9SaUjaKt/N7xxOnEHbfIVHCLJLUIs5C+S4
 IbMw==
X-Gm-Message-State: AOJu0YxJGtXagvp8cbr+0+rktHGVpipCph1qKgIDfTFpyj/T9/40c7Uz
 OrDDVu8ui5VlOh7yRdvb+CPiLOVwreyDmQ==
X-Google-Smtp-Source: AGHT+IFcWR5NoW5f67nUl4pOyGtgtZVr0v9DqH8LLTaVEVkw/Z3Ab85h2WlV3IX8cuVaxW2UsxBt4w==
X-Received: by 2002:a05:600c:1d8c:b0:40d:5b97:a227 with SMTP id
 p12-20020a05600c1d8c00b0040d5b97a227mr588999wms.269.1703667747534; 
 Wed, 27 Dec 2023 01:02:27 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b0040d5fcaefcesm668549wmo.19.2023.12.27.01.02.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 01:02:27 -0800 (PST)
Message-ID: <dc0bc5ee-621a-462f-bb02-265105ee3c5a@linaro.org>
Date: Wed, 27 Dec 2023 10:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/17] hw/loongarch: fdt adds Extend I/O Interrupt
 Controller
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org, maobibo@loongson.cn
References: <20231227080821.3216113-1-gaosong@loongson.cn>
 <20231227080821.3216113-12-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231227080821.3216113-12-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Hi,

On 27/12/23 09:08, Song Gao wrote:
> fdt adds Extend I/O Interrupt Controller,
> we use 'loongson,ls2k2000-eiointc'.
> 
> See:
>    drivers/irqchip/irq-loongson-eiointc.c

Better reference a fixed commit/tag, and mention Linux project.
Suggestion:

'See 
https://github.com/torvalds/linux/blob/v6.6/drivers/irqchip/irq-loongson-eiointc.c'.

> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c                | 30 +++++++++++++++++++++++++++++-
>   include/hw/intc/loongarch_extioi.h |  1 +
>   2 files changed, 30 insertions(+), 1 deletion(-)


