Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4310806E11
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:33:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAq9O-0007Mt-JQ; Wed, 06 Dec 2023 06:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq9M-0007Mk-P8
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:33:08 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rAq9L-000460-6k
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:33:08 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a00f67f120aso84808666b.2
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701862385; x=1702467185; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eJT9168d1mJAQZfh7wlXOwW4BaEOhUyx9yIAXHLyjmA=;
 b=QmvTEZj3MijKCdI/eKG/f1y+k9/BXjZ4JUgMMRGDpbVAhf6Gzr8sbT65kgyNMchxXk
 rGrr4mhsmdpWvVB77RE1FWfzN5bXBT1Zk7YN6wYTNfg2ilrAEYsEbvCQGNxlB1GvxxEf
 ExbvKBnjzqo9K3f274IgdgsAeOQK/BrLvJuvvH1pOYMA72L65l7hbY3zhEJupBN+pAe+
 0qxZ5R8HfZPG6U+SVH2hAPUDXMW7Me2BbX3copNtGUnu7PnGxMSoFQgsuniu/O1WwCOF
 a8VuNAUu1ZWODyazOcUxnRqGJyzSKMXjjHML18ZLT8nWEeQ0uVWb8sMKyu74vlYfhR8u
 bMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701862385; x=1702467185;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eJT9168d1mJAQZfh7wlXOwW4BaEOhUyx9yIAXHLyjmA=;
 b=GBmQo+p9cyWQrn7K2zn3mkRuXAcd/zmqPh2y+u00UpYuSod2WrH4S0XKWVQihhFKf3
 MAHDUSBwfMZp1vLspRFnCwyXQw3EgQpIMyQgWsw65S/qTzbWGffaJlV8RsC5k6fnrshE
 ITVTDu4FzBmIzAtyQeeMIzArSOFL9FM6RC8Uz2GWBIH3tDwgDAkQyZPm/Wq+iz6a7btE
 2r7rdQ+C+ou0Vf9oxlAZDB+FNKlq30OHROmNlT6AKTJvyd1mjUAf5u++EVgvSP5/xzF5
 AwO3AeydBkjQH/TuZuTy2rWCAnONe4nVN/AwTAudP/6h7D1Iyv0MucEZtZDotEQ4ck7/
 mFqw==
X-Gm-Message-State: AOJu0YxyvSp5O9vR91apbRBI84pukxDrJJPlRLo1etOV29sPec01e35N
 pEMlEe5KxDZw9ZDhDd1ZD3wKPQ==
X-Google-Smtp-Source: AGHT+IEWfIXQbni3e2fqU0TeC+LCkKxpYaqiDq8O99tF9Bn0Nh0xP2U92mlwj9QW//1IE0b0cUH+iA==
X-Received: by 2002:a17:907:b9c4:b0:a1d:e5a:3045 with SMTP id
 xa4-20020a170907b9c400b00a1d0e5a3045mr508597ejc.145.1701862385201; 
 Wed, 06 Dec 2023 03:33:05 -0800 (PST)
Received: from [192.168.69.100] (tal33-h02-176-184-38-132.dsl.sta.abo.bbox.fr.
 [176.184.38.132]) by smtp.gmail.com with ESMTPSA id
 s22-20020a170906bc5600b00a1e21893a26sm54030ejv.222.2023.12.06.03.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Dec 2023 03:33:04 -0800 (PST)
Message-ID: <c13a95e6-8ef5-4a65-8963-a8935685b4aa@linaro.org>
Date: Wed, 6 Dec 2023 12:33:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] replay: remove host_clock_last
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
 <20231205204106.95531-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231205204106.95531-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

On 5/12/23 21:41, Alex Bennée wrote:
> Fixes: a02fe2ca70 (replay: Remove host_clock_last)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



