Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3423174FF15
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:13:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJT6G-0003nX-WD; Wed, 12 Jul 2023 02:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJT65-0003lo-Go
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:13:10 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJT63-0000K6-4Q
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:13:09 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so66904195e9.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689142385; x=1691734385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8oXP2QO2NI4ks4QrqYzVvkBjZsjxQAgyRoP3fWCADqA=;
 b=DSzOjOHuLz/K4x7Tau4drE1JnAzgFVzeK4+74tTwdquarclZm3lHu1g1wAjxTaYT8e
 C7LSPZy6pXDEw2+46DSnQGBK9Q39yIpLHf24D7f4Gw4z36tDDecetgzvxvm5J38qBNrU
 WgK+/rPgjEj8JXsUNBKECEdmShdWzvOObhD0EUN0xpBztGHVRjnHztPXAyIQjWQ1hGJz
 BC9qKf9uQ9YMIYAopWtlcdsWzXCrB8A/uBDG7x69qL4K6t2mbhvQEAlLOT8Z73sR7+js
 xJDVa3OHYVY1xUdB2ALRF118hpLtU/2C7VowC3MD5sB/Z8X14zR8l7qT8DV5gKorNrv5
 p1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689142385; x=1691734385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oXP2QO2NI4ks4QrqYzVvkBjZsjxQAgyRoP3fWCADqA=;
 b=VcQDWxIXSUPfXuRY89sfYaVJVSFghxlremug3FP+I2q5+g+VqQ/BptN2mNGtZb3oRO
 jiL8m9yYNqGTt54XVwfqj6812q/afAheERAUDXQBSUG0k9BtoLZ8VWiU2s6YPG56hGSz
 q/ICI51UOJ6Cs5Sul4NiNnk8GS5/Y61wUkS9EK1qYVeMw51Y/vUI0nPDjXmL0WeH3g57
 Am7bLdFh03SEaBwcZSLwUhGuC5rzlev6BXu2wceSJNqcokC5Eg87QV2gmK7E3ooobi45
 nopGze7gUhwbi39i3QBJBvKoF1qgiuixewyErufm52owofVu8KcuwzVsrBhqxyvjVLhr
 WfMg==
X-Gm-Message-State: ABy/qLZgh0ZluYGWY97qHqg/x9gSaq55Dl0UYnsI5dICn8DiQJuvHXNI
 fnWUfaPItf/sYTzzxGDShiEfWw==
X-Google-Smtp-Source: APBJJlGTaYKjPKJ/5MllkiVLBikQEqLuwl7W9zAvm31wkzdaOtpiNp4TbCIBq1QsEKnhISLIQKP8YQ==
X-Received: by 2002:a05:600c:2943:b0:3fc:21:2c43 with SMTP id
 n3-20020a05600c294300b003fc00212c43mr13336702wmd.13.1689142385487; 
 Tue, 11 Jul 2023 23:13:05 -0700 (PDT)
Received: from [192.168.11.252] ([185.65.165.31])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a05600c11c700b003fc015ae1e1sm4215658wmi.3.2023.07.11.23.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 23:13:05 -0700 (PDT)
Message-ID: <bd5ed1d6-4d32-f858-9749-efb4e5185937@linaro.org>
Date: Wed, 12 Jul 2023 07:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH-for-8.1 0/3] target/mips/mxu: Fix overruns
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>,
 Craig Janeczek <jancraig@amazon.com>
References: <20230712060806.82323-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230712060806.82323-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/12/23 07:08, Philippe Mathieu-Daudé wrote:
> Fix overruns mxu_gpr[XRb - 1] reported by Coverity.
> 
> Philippe Mathieu-Daudé (3):
>    target/mips/mxu: Replace magic array size by its definition
>    target/mips/mxu: Avoid overrun in gen_mxu_S32SLT()
>    target/mips/mxu: Avoid overrun in gen_mxu_q8adde()

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

