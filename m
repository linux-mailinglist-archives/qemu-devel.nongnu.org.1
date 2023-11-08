Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFC67E5330
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fbJ-0001GX-Sx; Wed, 08 Nov 2023 05:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fbH-0001GC-Cg
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:15:55 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fbE-0005zH-SC
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:15:55 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53e07db272cso11337330a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699438551; x=1700043351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FjuDEx+em/hiEDBICHdsD60/CCoHeYP+hQAVHoWhbNo=;
 b=WiHJXOO4eWW6Uy7itB0QiC27ObHKKuoAlN6cuWYNbvcAJSiOdK8/7/NaweqyMa12bB
 uGpwHouDg3tXOZjzO0bFagvpjgBljALSSL+UgZ72FxdZA8HWFGbTGpolZuJ+nmt6Ju5s
 MHgZb6hdIkjgdgvOCcMCUc+nxoCZRCTc9MSp2G7X8swMsiZUQEvhEfs4LwKL3mKe/l4D
 ZS2l8kOH+T/bB2cAVWJwThKH7FEwliLIc/nAVYAnQt7ybmjwXC4KiTEpW/6Y4VN0qZjY
 oHFtgbidqJpgYHFRltEqIJWvsIqt3qrBJNfcuXT8UwJA1v/+JqP9QEGoOI7Xlx44Uqba
 4B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699438551; x=1700043351;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FjuDEx+em/hiEDBICHdsD60/CCoHeYP+hQAVHoWhbNo=;
 b=g9psrUxw/pdsqvBIgmjpkhhflrk5aCM7t5t85Sh0wUEj6M/jNqXFkx9DEH+uQ9KBDh
 sSG7p6lTiyYDf2+7UL9xK6HzkcC4Bw87W/Z+PHCTq6hX7JjXLRdE6jpr0ROiHqcS9U1l
 1tqYwn/zWMPwPv8LniIF4+ivpfSAoCxu+yOA3U+ZTKRX4AhHxbwNUU8SMR7EoDggz6ZW
 H0XNqMgGShkve2kHk66fJRRKY9NBI+h2Z5Bha9/9bdTNqKf21Ezx5CHYbYhDK+Dgy7X3
 lvTNb8fdT70YfHZc0ZmjnnrwtAnkSbk9GwNsgmUX4h5JtFLIZm8Nca2p0ouu1HF1W3wE
 JTog==
X-Gm-Message-State: AOJu0YyX2LeC6B1ZJ2c7z/l50HDWX65FR8J1k/K8uqNOt3xk9n7bjPDn
 NqW0HXZBXdjK0g2eu4yGs5oYYA==
X-Google-Smtp-Source: AGHT+IF9l5ZsXfJUa1yjoTuPIwTJ4J/nesTCC/iOsV+mi8gzSyccMun8uNW+ja4L3mfZDF5PxN7obg==
X-Received: by 2002:a17:907:3f17:b0:9b3:308:d045 with SMTP id
 hq23-20020a1709073f1700b009b30308d045mr1151825ejc.46.1699438551244; 
 Wed, 08 Nov 2023 02:15:51 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a1709062e8e00b00997cce73cc7sm794992eji.29.2023.11.08.02.15.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:15:50 -0800 (PST)
Message-ID: <3230162d-7e32-4e65-9ef5-338d05934aad@linaro.org>
Date: Wed, 8 Nov 2023 11:15:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/71] targt/arm: Constify hvf/hvf.c
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-4-richard.henderson@linaro.org>
 <003a731c-63d2-92cb-37f8-8f57c1e07ed3@linaro.org>
In-Reply-To: <003a731c-63d2-92cb-37f8-8f57c1e07ed3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 6/11/23 12:54, Philippe Mathieu-Daudé wrote:
> On 6/11/23 07:57, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c | 13 ++++++++-----
>>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Typo "target" in subject.


