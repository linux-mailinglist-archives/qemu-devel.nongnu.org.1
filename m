Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B499C8F5F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Nov 2024 17:12:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcOd-0006Cu-Oi; Thu, 14 Nov 2024 11:08:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcOZ-0005zs-2Q
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:08:35 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBcOX-0003Rp-9G
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:08:34 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ff5d2b8f0eso3966811fa.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600511; x=1732205311; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1mq7xSu5zTRM1yvz7hmkNwNqOpZpsyeoT61r+gsmWQ4=;
 b=pP5eI6ctoiwgioBaFqFPTvoeZD2C1r40xSzRCUbDbOfTAJuVYY5XZw8Y3UlSGaelMZ
 iTw+hdPB9VsPwEAy77m6kQhpRh3TbmqDZnFkyDwIXdiHtHXRd3KPnHk7PoylnnbeLjdS
 3C/kx9L3CEQMVR5ozpswfBQKVbsFFx0gLCndRSiWky5RZv2GDW05beexX2dI3uqsJwH3
 4Cvp9ueu+1wDHGx0SCfxlKDkANR4959zVXrZ5YuLxIA2L0BeoQPAJcT3yLWVxWPTwfNT
 zPsZsVmScfIwXGE7ZK0Ma5zaBnEra7W1OK+hbUFc3bLY1bmAFVdYfQls3HJmVZjtxP5J
 uRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600511; x=1732205311;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1mq7xSu5zTRM1yvz7hmkNwNqOpZpsyeoT61r+gsmWQ4=;
 b=ts8+3MPFxuPVrsR963EID0McaRKyD1wa/7lDmMK59XG2jH4sAHhnJOm2GyvD/Z9WR/
 keh5urjPHAwOSn4WVrGOQx3fiD2BRQaVfPGsNN9X/h+pZ/TcnYM03NMEpPhxfnGNXJEP
 Mn9NkMdeQYxXpQFWthOAFM/IyF1DwzALb6ZLk9vUCwl307scYbXHWSqxSwfoDooPhOW8
 ms2147r9pGh4hURv5U5/X0kUYxtH7/EQlS9+zmmjHCvZzLVDQ6xa2GSB6N7O0/iiYN+b
 N135QjiLw37U0tHAa5RDHinnvWvttjFsVxUq6LRhl1+AAbd7lF1Fym/Wsb44qgspKvI8
 fLzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUEpt/XYdXfkzxgg8alPCcS/uJBmB7hQF2PW8QmV9Y2XIatSN2B2UiqLsuY8QO9m6/kqiVYHYSZ5EG@nongnu.org
X-Gm-Message-State: AOJu0YyLVibb1INeWnukRamoaDHA3lDLX+9Ql4o4++tLLZy9ZU12uaC8
 6bbgV6PG1OfWyw65I83H/lsR9mtvFoVls5a7wHpNvr8WIs/v88HoXlp6xCqfRwE=
X-Google-Smtp-Source: AGHT+IEBlC6rqIhjiCU7Fru2UOtM7vOcZxJ+J/ivxblzdvoF85Jn89B54S35QcTtd2/2LqxzLR0D6A==
X-Received: by 2002:a2e:bd02:0:b0:2ef:20ae:d113 with SMTP id
 38308e7fff4ca-2ff4271fec1mr61649311fa.40.1731600511164; 
 Thu, 14 Nov 2024 08:08:31 -0800 (PST)
Received: from [192.168.69.126] ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80a28sm25101255e9.24.2024.11.14.08.08.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 08:08:30 -0800 (PST)
Message-ID: <7f38fbe6-4fc3-4486-be3c-92b7ecaa4f27@linaro.org>
Date: Thu, 14 Nov 2024 17:08:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] linux-user/aarch64: Reduce vdso alignment to 4k
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241112203757.804320-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
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

Preferably adding here and in following patches:

"Reduce vdso alignment to minimum page size."

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

On 12/11/24 20:37, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/aarch64/Makefile.vdso |   5 +++--
>   linux-user/aarch64/vdso-be.so    | Bin 3224 -> 3224 bytes
>   linux-user/aarch64/vdso-le.so    | Bin 3224 -> 3224 bytes
>   3 files changed, 3 insertions(+), 2 deletions(-)


