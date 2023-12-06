Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F2B806DDD
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:27:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAq39-0004gI-0N; Wed, 06 Dec 2023 06:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq2M-0004Kj-8O
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:25:56 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq2J-0002qV-Uc
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:25:53 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50be3eed85aso6029973e87.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701861948; x=1702466748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APMx+WBrnAyWryP7PvmdjWa+xVGmqloHKsaF7VSyiII=;
 b=Rom9JLoeoutRmYo9tY3riz12mHdGoX0pq3ds62D1t9xOQiWxL0DnvBTwEIKTTlXI52
 mbQVRn8uGuel9zhHrwsn8p0IT8VV+Y/AHfSiQ/Gairc9HuQIi+R5grZbhVfjSb5UIIb5
 noClwrYZ2yXZlgWVVSGjOkm/w+dVWAAhh1b1QC/bMv8+2Jrcg7luOmlQjKG6UGybwuxt
 wSX6g7ByxLBFNs18DyMF+IRnzCuO2ugqmS6P4RxAF30qR4uIcx+C8E3I5QJKwvGiZbq1
 eBzUC+f02Wyok5zgMyJ6LgfXgGR1xg+fqOt3P0wkkOiXfffPt0fMYQzrCwFv6zPZU0T0
 /mFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701861948; x=1702466748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APMx+WBrnAyWryP7PvmdjWa+xVGmqloHKsaF7VSyiII=;
 b=wxt2OMdFyeoDkTX2EQYp7Pbv6ajODNBiIHrc1Xza9gv/nMJyg0aBNt6ZAm7NNytJBA
 bqwF7w2ZBCB+BtpcATLsrq/mMZm2Xmg4r5P4yZy4G39JAdASx/kKC8bRsmQPqGr0poJn
 5TW+VUZD+UgbtLWTGPJJOwPr7C4GKu4DbcevYLzUFdWJKxDrlcIXK9czLv8LjFCcW4hR
 uLykIxkx3fH8mj0bTfd9yas+EvvL9jwDYKcuLOQWXz6AoMItHROGMrrKujyyW+mXIJUs
 aWPvNozFduYvhkkUGtZgeEipa0oNAszcXoBwGX0CF3tLGPZAwtpgbuOlLayGIWbLhd9D
 ON7g==
X-Gm-Message-State: AOJu0Yx4x+zIctI0f4OUxQ2pNaZC2Bv/mCZW8jUSzUR1HqD5MseJ1aQK
 31A8hVmdUYp71gIJB4s6ronufQ==
X-Google-Smtp-Source: AGHT+IGvve6hYYP1D+swRYsw3YrTa2Y4X7jR/MMulFP7pI0mSHnRXdj+jz6FnYGvUx7EBf/QxI9QDg==
X-Received: by 2002:a05:6512:2316:b0:50b:fadf:9758 with SMTP id
 o22-20020a056512231600b0050bfadf9758mr656650lfu.115.1701861948171; 
 Wed, 06 Dec 2023 03:25:48 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1709062a9100b00a1bec12448csm2792866eje.150.2023.12.06.03.25.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:25:47 -0800 (PST)
Message-ID: <6ad5160e-3708-4f69-a7f1-62d592309a46@linaro.org>
Date: Wed, 6 Dec 2023 12:25:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] scripts/replay_dump: track total number of
 instructions
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 5/12/23 21:40, Alex Bennée wrote:
> This will help in tracking where we are in the stream when debugging.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   scripts/replay-dump.py | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



