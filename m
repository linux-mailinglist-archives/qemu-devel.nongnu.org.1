Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B61683623D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 12:43:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRshS-0002jY-9F; Mon, 22 Jan 2024 06:42:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRshO-0002j6-Rr
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:42:42 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rRshN-0004L7-0i
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 06:42:42 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50e5a9bcec9so3119821e87.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 03:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705923759; x=1706528559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ET4YoUKutSWLTzQ9liVs6t9DnomuPEvkpod4f0ual2k=;
 b=fPjAAakZrPfBrv4SCWCV4R7jFnrPleNHBc18r0NkPeTbkVrn5M69Js+cqauh3lL546
 Dxjnt1JnVOb8xwxnFclwcdNZsNn9uDtsHTGrx0zN+0NIotexhHfckUx/ywT6E25WF3RD
 AsuV7kJPIsG82z8TiujnyndXBWj28qlSUfqcu324evRLvoi/XBY3kn5aMO8nfvNgk/kf
 R86ZXgnGDfDKLhbLWJtpxdaWIrqIbV9XAXTQNPIXrAQvswrvDIySOprc2ZZc35PXa2s0
 sl4FzHJkianuPseLxETiV/QuyXyZ7JFZ4GejUyvwPGzvCiaPrdzzMvDr2gEMknaNR6wv
 doVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705923759; x=1706528559;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ET4YoUKutSWLTzQ9liVs6t9DnomuPEvkpod4f0ual2k=;
 b=ha4dS+eCLp5Ie/wZNVoQnJqJ2K6ZapJT66ONhAOLdkDz7iWrd6/YWDBkHcA4j6i7x4
 Lr1/1Z28uk/yfwI8adRliBjasNSal/uz7zw3i7zbtJrEFaXvUuAytRXogWcZU43uzsq6
 VthJRhvVR/CAWbhWwhe3uS0gbJy4zDdWaQh0Wz9l2+SfqzTyEAdPKcYKt7jaaTvr6Oil
 SF1U1v7Myy3haQNo2MdQ2mlwoDmzV3Ibcag37CODmusAYfWoWI1QE7/kfkMo+q55gmi8
 mL1FEHtjsjzY8eLZ/9J3shtJ45BZarVSYjg6oFbAXLlEoWP9UEe+Sofujf44p2dnMS0M
 INYw==
X-Gm-Message-State: AOJu0YwMLVdZiLdl2+azcuVuZGMdoS8cZufwRxd/XbAPS/hjbXmE6bgr
 Lc5wtEgdSIPMAbu72OizAPFwVSRDTH9n3xnEQ7d2msorAXnrsTybBnJieqx2GuBDoL1QTXT2CwV
 J8k0=
X-Google-Smtp-Source: AGHT+IEOC/hg+qFfe1lGZqssQtrr+I4e2Qr7WvED1LNHYRsbSb9wJQZ3NmH/p3YlXgVWxEGmNfO3Rw==
X-Received: by 2002:a05:6512:786:b0:50f:d65:895c with SMTP id
 x6-20020a056512078600b0050f0d65895cmr1642931lfr.69.1705923758833; 
 Mon, 22 Jan 2024 03:42:38 -0800 (PST)
Received: from [192.168.149.175] ([92.88.171.62])
 by smtp.gmail.com with ESMTPSA id
 vi11-20020a170907d40b00b00a2cd74b743csm12044122ejc.3.2024.01.22.03.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jan 2024 03:42:38 -0800 (PST)
Message-ID: <acf4d4c3-933e-4ea8-87f9-498cc690efbc@linaro.org>
Date: Mon, 22 Jan 2024 12:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] linux-user/elfload: test return value of getrlimit
Content-Language: en-US
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20240120-qemu-user-dumpable-v3-0-6aa410c933f1@t-8ch.de>
 <20240120-qemu-user-dumpable-v3-1-6aa410c933f1@t-8ch.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240120-qemu-user-dumpable-v3-1-6aa410c933f1@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 20/1/24 22:45, Thomas Weißschuh wrote:
> Should getrlimit() fail the value of dumpsize.rlimit_cur may not be
> initialized. Avoid reading garbage data by checking the return value of
> getrlimit.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
> ---
>   linux-user/elfload.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


