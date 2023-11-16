Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151987EDBC4
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:06:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WRe-0001za-SX; Thu, 16 Nov 2023 02:05:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WRX-0001xQ-1w
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:05:40 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WRP-0007un-7J
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:05:38 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9d2e7726d5bso61077266b.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118329; x=1700723129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9FuvZSBXwHowC2s9dVef1FnXT9Uzfkoz9uubRwD7bs=;
 b=SeYasKRX6nYRHhBWK6NXBXBkqlkVn0dCTjdQmnDiwsg5o1fiOvh2PgPlqiUBgo5cI0
 EiFOnkumv7sMQ1vVM51k4jaTPlsK3pohpo5RS5eEPJLMgV5Lx21HL/X/xBB1Wy1yrnpH
 afhum5hLEANI23KVX/wddBKLVLtF4wSNVcqxc+U+M0uyIorQsb06/ajsdueaSUakU2Sp
 f1p1y+Ry8Y6Dsc2rLgnbmTWbQno6djr94+4Lf4C3pB/+JKEbzSaTQy8+WV+F2z477/4o
 8CfIkbMnwe0piXkmPdOuhCzh7VNJQAasjrnumKhMDQUkCcgO9A4/7aeby3Fm2q0g2kH4
 1iVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118329; x=1700723129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9FuvZSBXwHowC2s9dVef1FnXT9Uzfkoz9uubRwD7bs=;
 b=ai8VFbUnHw55tTZFu7eb6sHu3cdjnvALiQ9WgJYe9gIX5kvwroXd3bFskIUhk8mYun
 DJnvoj5IZrdIUrZMrktffIPrPLRywruFnWCLE8GvKhwqwif0RN8G9j8L+Ze5LOVpcV3x
 suErzuNvxoQKZHcn7QaVvWbC7SjPT9ol7rvJmR5UigXW/QVCY7Rhmb2DZ5ecQZs2pXV4
 2kKpL10h44LtQzAzbBIMBCoR+9SmfTE9zYHUuYHSGQ7eRpoC0R2vdcNqaLlhsfV9e3aS
 5wi+5B+T/Fv/ZNjuomWQGfrvb1ex0HDhWPQh6kaBurSob7RJtL76Nu9HYh7ZcdfzzpwW
 iqmg==
X-Gm-Message-State: AOJu0Ywd2lU8cLRqiy7qJDJpSya27FUk+bdc0EL5Cs+iEb6NBHhOQf7y
 RnEZmDBEuJCrr+OwUe2U85qIJg==
X-Google-Smtp-Source: AGHT+IGSIF+okuS1ghXcMtG4Ktt+pkuimWJfG9cvznBuVEaQrdNJdEVVBnAE3WwfIAuZvNyhqVPJ0w==
X-Received: by 2002:a17:907:7d8a:b0:9e4:651f:60d0 with SMTP id
 oz10-20020a1709077d8a00b009e4651f60d0mr13760249ejc.9.1700118329286; 
 Wed, 15 Nov 2023 23:05:29 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 ga23-20020a170906b85700b009ae587ce128sm7925364ejb.216.2023.11.15.23.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:05:28 -0800 (PST)
Message-ID: <95e0e8b1-4885-4883-afbd-0b4bbdd34cda@linaro.org>
Date: Thu, 16 Nov 2023 08:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] qapi/schema: assert info is present when necessary
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-10-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231116014350.653792-10-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/11/23 02:43, John Snow wrote:
> QAPISchemaInfo is sometimes defined as an Optional field because
> built-in definitions don't *have* a source definition. As a consequence,
> there are a few places where we need to assert that it's present because
> the root entity definition only suggests it's "Optional".
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   scripts/qapi/schema.py | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


