Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF87E5321
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:14:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fYp-0006gD-Ql; Wed, 08 Nov 2023 05:13:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fYl-0006dp-Fx
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:20 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fYi-00058V-R7
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:13:19 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9df8d0c556eso522577866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438394; x=1700043194; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0oXrS8ogUqqgjBnuM3BH/Oi1BzsEFVHd1XxA2N+jgho=;
 b=LINX0lib3BgIt5mwm28hn9xNRQ64aUgyj9Xq8E9N9tnYu2+kfh/SrH2cHMF+X5M2I4
 RPsL606nzlfCHGmHovcVYwq0YVihC7Kvibngv6Kybm5MI23aNNSOszVtVY1NvWJxnX1G
 RLlG10gCWIYTYqyl6+MCXe9YYRW/M1h9YcUgNb8TIqE/b5KJgbziTNNQ0aeGALizWK6r
 ch/QywA6+XDnuUrLNEGqRQVdvUb7uV4sHFnlKdPhOpdUvTGcnQlRcgxMsCDO1fNlbL+z
 YcHD0mL+CMeEb+P1D+KNwP+tIkxKJfDE+0wre8gSrruvoJUgdtfxWGmFdVI9GPxf3AB+
 lb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438394; x=1700043194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0oXrS8ogUqqgjBnuM3BH/Oi1BzsEFVHd1XxA2N+jgho=;
 b=X1Q8eCMMWsjsn3aubrR+INdXFi25hjol+4qTDfIgMd97f+820El06r+YYtL3SL+eth
 Hjql+7oNKv65ssQWW4SkRqyQ3bvMRUTX2mTWXvaKj1IBjOXYGLH7EHOUMHWIWZpOyoaQ
 MJMi7S+MUvTS3I82ekVqEJPmzAc9SOuKlVK9weH7use7jD/WPHVrYukAQjhq1fKMg47v
 UZfj0/DBJUN7cUXr+33rSlRron+Rj9ePsbDPcRwtCo6D1sVAPayOPWYGvCWSMUNYegKA
 ECXfRSJyuYPhel2NeK8/ajiTEgUVZDMnWzuKTTbh2gKvZ/QKGSUFws/fpUfGI95KH8mI
 3sDw==
X-Gm-Message-State: AOJu0YzE0RonWoUO7GTxasTwkPWh5ArVcUcG2Lur2MKfP/X6IQ0bkAN9
 MA46BZf3M8MzkxDWqgED3W15kg==
X-Google-Smtp-Source: AGHT+IHmxMytngrxo2Ytl26dOksQwxipxirMcbWEKM1cO6wuXBWRJfQzLh2UJIiSHmJNIDbqrOVF1A==
X-Received: by 2002:a17:907:7ba5:b0:9df:bc8d:fbc8 with SMTP id
 ne37-20020a1709077ba500b009dfbc8dfbc8mr1173764ejc.37.1699438394602; 
 Wed, 08 Nov 2023 02:13:14 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:13:14 -0800 (PST)
Message-ID: <06f4aaf3-2a32-4cbe-bcce-aa1ea7e98761@linaro.org>
Date: Wed, 8 Nov 2023 11:13:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/71] target/hppa: Constify VMState in machine.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-8-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106065827.543129-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 6/11/23 07:57, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/machine.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


