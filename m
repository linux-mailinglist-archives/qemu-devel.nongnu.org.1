Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED8D7E205D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:51:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzy7S-0000f4-Nk; Mon, 06 Nov 2023 06:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy7D-0000ck-FW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:50:01 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzy7A-0005e5-0I
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:49:59 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c6ed1b9a1cso58794791fa.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699271394; x=1699876194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2sTs0aEFhTXBpTWitzGlDBc8tcBimvRgf8j+6mQw1c=;
 b=mhTAx6qt2pVItUw7B1nQOGAd5bh2rCfsyGuQjoZ4RZQj4/74qlZS8QKGcMZbgnmq+2
 ksiflASvFrC7fkJAayUfbtZjTeK9nwAmBsPXT5YOiDKiHTIGb2AK9pGj1MpeSh0KN1U+
 VHQ4GBMa/ap4MjN47WCK+Te61/rWx1y6EZQIcodhbyhnhB2JHzdpCgbB6mcuVUjdKLx4
 o0J8CzcIQtp5E2zyjg9bJpg8EwA9FA1VFrVY7f3876QkEqgTWgcsaPjhPXaX/Sy+POWB
 OixE8ZWhhSb9NbgYV5hpWQ8Ut9Yx/1/PMDj5jqG+HPE/Z6M+O9mrj9HutPvsAbYafiyh
 8h3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699271394; x=1699876194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2sTs0aEFhTXBpTWitzGlDBc8tcBimvRgf8j+6mQw1c=;
 b=VP9FPq8SW2JYht/VcGiPaxfc/bSAh39q2UtJXS1aenO7BRD7dZtOtcQSeagrUxtzXM
 Wrq1f21MpyOdvKySOv6CQ8wPb8PZjH2jOIUusg9J3/SCayVoOU2+emhPqF2U520WQtSI
 UPSWMboA0ze6Y0i28fvvn5r8f31g1YHu2NetaybzXnpfrovf4vSU1B54MA+/WPkH2nsY
 9yWRjgIxT08ghM4BnyvHI3MEUuvuLejf8Jys7KwpgyC2JKWUOaMW8q6B0gnHREgTVZqa
 +MqMe+66hv8qlASZcmFBOg+lg5J7VMNJB2wV9ri5mlVDqj3AvzWisbHpQhFjH7Ts19Fu
 NWGQ==
X-Gm-Message-State: AOJu0YwF7A1Sduk55afx0rZWA7gdPG6uY9hxMtktLjZQNIeqEYylbEEI
 I46VayzrqU6OhGjg2rEM3WaW8g==
X-Google-Smtp-Source: AGHT+IHUyYjoUKa7zGlCXe7ER59EA9DIMk9VkO7mZeO9pK988U9SJrsdLTBgsw0m9ohyg2lWf+/gfQ==
X-Received: by 2002:a19:ad44:0:b0:4fb:9f93:365f with SMTP id
 s4-20020a19ad44000000b004fb9f93365fmr22029415lfd.38.1699271393756; 
 Mon, 06 Nov 2023 03:49:53 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 a1-20020a05600c348100b003fe1fe56202sm12239107wmq.33.2023.11.06.03.49.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 03:49:53 -0800 (PST)
Message-ID: <f2686643-4e97-d73d-d387-876e335f5c66@linaro.org>
Date: Mon, 6 Nov 2023 12:49:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 19/71] hw/core: Constify VMState
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-20-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/core/clock-vmstate.c | 6 +++---
>   hw/core/or-irq.c        | 6 +++---
>   hw/core/ptimer.c        | 2 +-
>   3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


