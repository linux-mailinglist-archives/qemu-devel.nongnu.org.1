Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E7281F0B3
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 18:08:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIXNQ-00043b-1u; Wed, 27 Dec 2023 12:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIXNN-00043K-R1
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 12:07:25 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIXNL-00045j-Vj
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 12:07:25 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33678156e27so5000422f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 09:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703696842; x=1704301642; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F2k46Jala0YD5NXcnApjOoFpSTHoD3f87rQws09hLIw=;
 b=o3BmbOkWXYsTTwlhdYfeAYxoVoyc2pjenGc/Y2IYhVUjNa3Z65R9HilKgI5W65zQZ1
 y9wUqQTv9lGMDXzZehYtM58hLOkGWo1xKxOZ1UXcV/LJiwL49YP5XGWfNBOoEl9Bj0ev
 n7zrKAr/8ecCT8ev2yIaoQgpoS56hy8B60OrqnhNRJmO/kTuC8xJ0JjMZnJsJjstcyPX
 UZX2Kedbaf87BrCfiLnZBMyU85wLhr7/a01XqxlTuK/smnkwY68c34+4ZPSg/ZU4Pg24
 Zb9CWOF+hL3J5aovV6sNpzn7oxI2X+Y+VOfIZUZ79sEAGMpKxD22h1pn5hNzgtptAf5V
 29fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703696842; x=1704301642;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F2k46Jala0YD5NXcnApjOoFpSTHoD3f87rQws09hLIw=;
 b=IIHEe0fa250J/P4rZ/KsaeeD14k4CZcbKU1n2rXiiZXOHcu4vYyJgjH3IbdW1oJwEu
 +2NmzmXiyy5QLF1bsUL+AzO8u9HEdvtgSdtCtAlfdZBESkKCfsWi29xGR7//HHT0dDDy
 uigkN7/u0zLMtxqbSXzbgenh3VZbK6t9Dyc08iDt8yD63yZr6t+UQBz76zG99t1foPQs
 h+HENYyn1YdPP79mye1wBihokbQycLlThfYevqZmsE1jg9sTDE9l94BNScZ1DgsAw0W0
 UihfcZAHOs/Y8IyTbJijNeQZ1jR3teZ7u8QwcK3x8QH9TqYIb6GqipucKNwEMDKT7N/1
 uPsQ==
X-Gm-Message-State: AOJu0YxvGTZQIKbeXcTSPYzxs0X4KlpndaY1lXOSKFxj2UGq8o6JVLTq
 DyuJt5ze6DTkoOfinYok65Ce9apjTn7H7Q==
X-Google-Smtp-Source: AGHT+IFvAsevyU4xuTWC10GqCxM3mAuzHSzSaJJOI3RedlJFny8RqTPoHWH6qQLeDHxc9AlBMUNMlw==
X-Received: by 2002:a05:6000:104d:b0:336:70ed:4cc with SMTP id
 c13-20020a056000104d00b0033670ed04ccmr5340760wrx.95.1703696842066; 
 Wed, 27 Dec 2023 09:07:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.122])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a5d4d0a000000b00336a2566aa2sm10819534wrt.61.2023.12.27.09.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 09:07:21 -0800 (PST)
Message-ID: <0ed8e2c6-512e-4f62-b436-2ce1b898549c@linaro.org>
Date: Wed, 27 Dec 2023 18:07:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] firmware: qemu_fw_cfg: Convert to platform remove
 callback returning void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Gabriel Somlo <somlo@cmu.edu>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: kernel@pengutronix.de, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
References: <cover.1703693980.git.u.kleine-koenig@pengutronix.de>
 <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <8d7d86a24ea36985845c17b6da0933fedbf99ad8.1703693980.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 27/12/23 17:26, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>   drivers/firmware/qemu_fw_cfg.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


