Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8F82D81A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:08:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKoj-0006qq-MV; Mon, 15 Jan 2024 06:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKoh-0006q8-3d
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:07:43 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKof-0005QJ-Hy
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:07:42 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-555144cd330so10564951a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705316860; x=1705921660; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u6cH5JI99j+XuD/mPFxR7acGMdS3HNpIdGevZYpWF68=;
 b=IMTgzKNFcof6E5z59ZC14JZW6Jrr4b8u8tkQQaHXY+KBNs8NE0a24hr7fFgLkTUOtT
 OMOsMccutYR32U5cK44/VWagiA1m5OM10C9ZbMn7NXZONRHKJnVN4pBHWV6ndAAxyX2z
 EANadr9LLDO6d/Y7rIOcA0c7WpqjUuG9dhN6jQbvelngguIJ2ANVIqs3zj8vwOaAFHoP
 xTgXfVJwp1jdox9RnksSK+LEVKaXrZ0ITkSXkJqZkixnRbCwcwEYVYJzwubrMDnmupl+
 RcH8hcq9tfkoWmr/agNSQXJG3N3FvKOaoAj06jMhgn8ZpuFv1bdFS5j6lu6PgcmvgG8P
 BzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705316860; x=1705921660;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u6cH5JI99j+XuD/mPFxR7acGMdS3HNpIdGevZYpWF68=;
 b=qUcDcnbP78hafAcGsmD7nC8tD5lKPv7Vujk1uoI/e2vg1hCqtBS8LZY2m95Jvmj+N4
 uGSSR/JgPMVsBUu/tXDCpEIPMvv+hH21LnC9tJTOeLZ6v2IWBkUgxrNEYkX8VWPuVzFO
 ka5Fr6hTOTVfNwEbMKPNVGTsQbtZLZlC3lUt0uCv+rzuLsuL5z8WSuONqKxugOCN5AJ8
 DUjjxhG/DPyHooiPVz1KnzZQ1LuNMBULGLhM0hetGcr7yjbz0s/Kxgt4M41ZdLlNZt38
 oCTLolTVqKTPVQ1bBvKk9jqxapE0GwKydXLFoonWh44QuyShetN/8jLiy8ORfoNWs9rL
 oqXQ==
X-Gm-Message-State: AOJu0Yzk0NYOIDIs64De0qM4UC9w6yJXSthjgvA6mD5/G+Xc/FeobEIc
 21w5eZr5+fTvrSCz7cT+ruYQ7kMko+aiZA==
X-Google-Smtp-Source: AGHT+IEU46PdPs8RAhMAuPBLZqkitvk/GweXBIUmkYnZdNiah7fcPY02FFOldhBMlYxUwGje5ALCzQ==
X-Received: by 2002:a17:907:c71b:b0:a2b:9580:c45d with SMTP id
 ty27-20020a170907c71b00b00a2b9580c45dmr3326110ejc.140.1705316860238; 
 Mon, 15 Jan 2024 03:07:40 -0800 (PST)
Received: from [192.168.1.102] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 vs7-20020a170907a58700b00a2caa85c0c1sm4253888ejc.30.2024.01.15.03.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 03:07:39 -0800 (PST)
Message-ID: <0a9a1ae9-677d-445e-8171-6b3dccb8b25d@linaro.org>
Date: Mon, 15 Jan 2024 12:07:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/qtest/npcm7xx_watchdog_timer: Only test the corner
 cases by default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org
References: <20240115070223.30178-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115070223.30178-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 15/1/24 08:02, Thomas Huth wrote:
> The test_prescaler() part in the npcm7xx_watchdog_timer test is quite
> repetive, testing all possible combinations of the WTCLK and WTIS
> bitfields. Since each test spins up a new instance of QEMU, this is
> rather an expensive test, especially on loaded host systems.
> For the normal quick test mode, it should be sufficient to test the
> corner settings of these fields (i.e. 0 and 3), so we can speed up
> this test in the default mode quite a bit.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/npcm7xx_watchdog_timer-test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Good idea.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



