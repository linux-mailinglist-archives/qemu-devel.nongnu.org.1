Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92E7DA851
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 19:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwnWA-000835-0y; Sat, 28 Oct 2023 13:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwnW7-00082f-L0
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:54:35 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwnW6-0003wV-1N
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 13:54:35 -0400
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b3f6f330d4so1928285b6e.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698515672; x=1699120472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vR5M0m0h/jiGUkx291Zf8e+K4ustSOjpAfq6ie//RW4=;
 b=K3Z73WEMh3fFvSxY3mad9CttXYjvHuHmgfCq39XPR/86Y9bK+1dKxU6NFrfYKXpsxl
 sJCpVV6M9J8mqEpNHKZmVHypxSGutuwYoDHMKRX4xhKcGm3J3cb2V7nA5cw9SyAHrJWl
 o2Pw7mLLpSwtfSlKaHlLpQHIqWQHdjQcd9jgKdVCeOMquaCTPd3GE4LK0dY2xmOZ6fHp
 s1VII4k/U63FHwIL8o7icgf4cGG4JauCFIitnT3SXtI24qdREKYkMMpXpLwPSfR/WIwJ
 lZVr0jOGPQ+nepu6Jtr19T8T7Hs7SoPx0wE/Vp+4cQ+aX+yxU+elNMdgvjVEKTLYog6s
 sx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698515672; x=1699120472;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vR5M0m0h/jiGUkx291Zf8e+K4ustSOjpAfq6ie//RW4=;
 b=vrJ3YKkoYFf2tPd3Sm8CUEvuKZPNoR9YbTd3GZknqsvIZViltVzrQpKfYTb3mVNvNz
 MvHcm0Nh9HWBkajf7NChdTL4pJBYR0ddgwh0J9exzbQO37YDvk8SOrIMN2mD/gUoF2rJ
 Fr6t8FU6bwLpIcSUYbTNmWad6U+fHsqH4LMRci1tS5BnielZPSYIWwWeZ36vqFpVT6Xo
 dJo9Og2UF0rilUH/G08HOimsZTCD/fqwlXU3Ss2kZgxy1qfrPM0ngugoSW4Z/kAw1Fgu
 bPUIm/BhXmViDzePPX3apqxo5xKGPyWafNSGuIlcbRidGYEK8HTuAAD1lYuEKroyWASq
 oCqw==
X-Gm-Message-State: AOJu0YxwnHgb1xVAgixMM2XDGM2eSkAfdhkswenCu2oPVvFMxyd7zZ4Y
 buwBAgFmsl01xZ3mWV8jbxEQ5w==
X-Google-Smtp-Source: AGHT+IHWS/jIIyM3vEJpdsdXyx/cnzryI3XCBHXyAaX0wXxawhMW3jLNL75BLPG6OqCzGkDjNNCvfQ==
X-Received: by 2002:a05:6808:1281:b0:3a8:80ea:f0c6 with SMTP id
 a1-20020a056808128100b003a880eaf0c6mr6716217oiw.29.1698515672632; 
 Sat, 28 Oct 2023 10:54:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 fn4-20020a056a002fc400b006b4ac8885b4sm3328907pfb.14.2023.10.28.10.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Oct 2023 10:54:32 -0700 (PDT)
Message-ID: <6d234b91-ff03-4558-815e-ceb1823957c2@linaro.org>
Date: Sat, 28 Oct 2023 10:54:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] plugins: Remove an extra parameter
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231028103311.347104-1-alex.bennee@linaro.org>
 <20231028103311.347104-17-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231028103311.347104-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/28/23 03:33, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> copy_call() has an unused parameter so remove it.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Message-Id: <20231019101030.128431-7-akihiko.odaki@daynix.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

