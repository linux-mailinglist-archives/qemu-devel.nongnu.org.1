Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 120FB7ED775
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 23:43:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Oa7-0004Xh-2X; Wed, 15 Nov 2023 17:41:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Oa5-0004Ve-5Y
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:41:57 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Oa2-0001ZW-WA
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 17:41:56 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9d216597f64so26910866b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700088113; x=1700692913; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b+UnXhKnws6ugFoCSiNu4WShyOgi+X5yc/tmfC/jB1o=;
 b=v6+fE40v98L7ThkToU8CSKlLbhezQvqIDA326swBVCiaSvA2hCsM4u2KA2EEMrhW3l
 RplgPYY0ekYzywKItbo1AzkIN9c6L1h3jMO41eLaSnWuLhQqf92ARvq1GfnbYdKrDF/h
 y7RnAyuHDdddgR0zpKYRVVA2oDOQqDYj+AjR/ghj4SIarttiuX8zd5V5cxbgEcViDJWC
 Cnm34TQ6C0sx3fgzPecHXFnf9VGtvf0Dl/YTVraXsWtc/ta87ZB51jBZEogF40duSShz
 2+ATfbpMtk502gP7F2h2fZ8YAkIN8fvXr0aOc6v77/bj4dc7TFIZqcTTksh6Tgqegnv3
 3dNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700088113; x=1700692913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b+UnXhKnws6ugFoCSiNu4WShyOgi+X5yc/tmfC/jB1o=;
 b=GODqa1ClEAIAlEWgBcFQYpfHR3Esnl8+LEmHEXeEosfG4GL26ddlUO5cF+sGjoNFwo
 pJ6UO5hLX9w2xkjjURL3fslR8dntTrGODApAUmZWkke0xQ3NSy4miOtKKDfZfCekHTK3
 KDDOb9QtbbmkMG0jI8oWrx7Nh+oEqYS7u3/L+gD+3fDHfphUy7aXVW+xeL3f/U6yrk+9
 QD0KnFiiC3veLW1eis9g8OMSyhK/woBCbJqo7p2gZ0T+Ng64Cotrc0jMOF2V9MK5JAbg
 xjxVe7nm7VeVOBMcJ3B9B0VYUh7eeUU26DpoYSmNRea1puQWBac0V6I/b96cnHl+3rbU
 pmzA==
X-Gm-Message-State: AOJu0YyKCHixsulkBfDNFlJB0g4thmY112+M1dFCPZ9aen4Q0hgkIrQk
 K329gyQiv5ChRzvWb9P3R6E9Vw==
X-Google-Smtp-Source: AGHT+IF3/AuK46/Cbi9ClzQfr2z0OX8xHHE0oWAuIM5xT4oaa7sBvmgzSIch5GRY6cEyqXjc1Gv7+w==
X-Received: by 2002:a17:906:5385:b0:9b2:765b:273b with SMTP id
 g5-20020a170906538500b009b2765b273bmr10375391ejo.70.1700088113246; 
 Wed, 15 Nov 2023 14:41:53 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 dx9-20020a170906a84900b009c3828fec06sm7550338ejb.81.2023.11.15.14.41.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 14:41:52 -0800 (PST)
Message-ID: <1292144c-49a7-42e2-be73-a655485a620c@linaro.org>
Date: Wed, 15 Nov 2023 23:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/core: skip loading debug on all failures
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20231115205542.3092038-1-alex.bennee@linaro.org>
 <20231115205542.3092038-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115205542.3092038-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 15/11/23 21:55, Alex Bennée wrote:
> ELF_LOAD_FAILED is one of many negative return codes we can have. Lets
> treat any positive size_t as a success for loading.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/core/loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


