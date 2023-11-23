Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0585F7F5E0A
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:42:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r684j-0005ws-Qe; Thu, 23 Nov 2023 06:40:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r684h-0005wb-GZ
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:51 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r684g-0004JD-1M
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:40:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso423610f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739648; x=1701344448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tg5tEsLSqPL1rKJe9uQFPwG/4KppfiEAqvLyfwo3yMA=;
 b=Td7jeNvHrnUxYkJR/m9cRDMnbfbvR8kiB3XbW8c+y4xwbZsk2nUukw3JApjCGquL3U
 0J6gGUmP7vWBykT9jrfps5chgxqsB3pZ/cGMSgQUrUVLqmY6Nnw4vi0b3fXHEEH9zks2
 lcvddDm7cS4Ahiva6j8zcgQeyL1etZfIxkNaTXD9JJTn5b4aD32+GZVlMYG+OlODdpAV
 tbbRrogqQE5rZHOZk3dfTa56AE6Tzu5CBRmoID850qSLLSsiwbobFrtUN5/E8QJVnggy
 U3HXkOs68Og1TezZvUDbC6r4izt7iVoXIppG9eF9cfYaeip7VJQGRoEgqlBiAL8f6SKV
 zO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739648; x=1701344448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tg5tEsLSqPL1rKJe9uQFPwG/4KppfiEAqvLyfwo3yMA=;
 b=QrJGBu8ul3ZyWxf+xrSZa1X86wdPLXESWEO/zdkkBFwUttqkRuRG6aN34x1ISOCfel
 lyQxFklCJ1aPEj5aPuwg84WTtE3LtmG+3rOjDH4iJR6ok2MphFK9pxnhy1eOvGeyBhjb
 jcKBGi6z4iJzvtyBnD7PuE5nTXvGVSfMYMMXW18cILepmkLyJ0QmnkeFgZg3tzxaPA3i
 XFSdVbEUPS7dUPJL80AMeUnMZZVuJHy696K3Fo58GfZi6GQDfuSfHnP1+y6sy8RYVwAz
 BgabCwi34td2gfTktpHmzXtnmv3ON89+UYF4QzRc9Ay2pSplueFb+YEgEhwOSJ0V1Eim
 oI6Q==
X-Gm-Message-State: AOJu0YxPOD2QJ7fHQKI9mdv/7Yebho5Y+57NegahY7c5FHmF4R9GQda/
 j/OIJtXM3psYsBxOVmrd4vN/v+MWBG0GDtfNPFY=
X-Google-Smtp-Source: AGHT+IG7toCMqZ1Gjg4k7nYGqK1E2zYK69Y4XGUHr5bVVlxAsiRRTAvqJ7XaBppUmZV74odN3r7ywQ==
X-Received: by 2002:adf:eac3:0:b0:332:e3ef:fded with SMTP id
 o3-20020adfeac3000000b00332e3effdedmr1027314wrn.31.1700739648357; 
 Thu, 23 Nov 2023 03:40:48 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm1455905wrb.3.2023.11.23.03.40.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:40:47 -0800 (PST)
Message-ID: <4d96f4cd-8f6f-4ad6-806a-f47e9eea843c@linaro.org>
Date: Thu, 23 Nov 2023 12:40:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] target/arm/kvm: Unexport kvm_arm_{get,
 put}_virtual_time
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 16 ----------------
>   target/arm/kvm.c     | 16 ++++++++++++++--
>   2 files changed, 14 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


