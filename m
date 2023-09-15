Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E9E7A1A3E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 11:19:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh4yg-0005hu-QN; Fri, 15 Sep 2023 05:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4yS-0005gz-SU
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:18:54 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qh4yP-0003aX-Qr
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 05:18:52 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ad810be221so248122266b.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 02:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694769527; x=1695374327; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23uIT8W8uz5jxSR0khjdYCUNZy/RMRiv3Wkg9Mr5TZU=;
 b=w8E18M1v322rIq1VpLS3Tgkdrf5aw1E/V2dxpu2le4yRJPCevjrfyOoI3OIvJ5hL2w
 vHDdwhEHH1DO7Gu1noX8hlQXLQ3bGOBMh3J19AsaDWlNmGuX2yBnAZgkh87zOCOgPYQ8
 qIsBX3Yqudn/WE+31B8ICVnimCa8kIwVe4BEghyRfcEdSFSzrmnlfttnxmElywAozZh5
 g/Xp6Z4CUkZFgOGCtjSOidagcmaCA7aXJZFRD+mL4WpV2vGWDoLs2Q9Dj/n0I4ZGXBDO
 qwjzFqtm3NN+zNMNP3RVf1f9PYGnre9ZmfT5LImw3GdjokP59WDJpdb/lRnlXWe3zjsF
 JlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694769527; x=1695374327;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=23uIT8W8uz5jxSR0khjdYCUNZy/RMRiv3Wkg9Mr5TZU=;
 b=f4t2N02lfeRbev2AaQVIAnq78HbB6XgEt8vC51Jy8zLWE0oWnVqtBbnat3WP4Kf4GZ
 L5gmZY0v045abK2/1yZ/+CJiDhIpDWhZm78l5MobnbW5QPmwjkOkPThJCsa/GOR5Vpzm
 KqhONsuRV+b2Sq5Ouv4S2x1jVWpnEuPFUcM/IaiKRGdXl+nEVFybRM3rpT2YoM484HkF
 RJFNFnlgUaibCQRXpolXPkh1y9o0exa1rNGdRn63Y7x+yGBoU0Vjcsk9K6C1hJj3hN1T
 ZpwpZXfSs01wivI2cwMfJ6va+oDSHszTR+tZioZvJc6qM27dOqZ0wKoFLUwS/0mecSru
 1C2A==
X-Gm-Message-State: AOJu0YwQOr0slzIXquJo+XD99bUwHQnwnOQ8X2DJdKqn1AYFP1JsVwm7
 w5/EgXtdb9I0W3p1PIHvxnh6AQ==
X-Google-Smtp-Source: AGHT+IFSpfNOukyLFgAUTdF79yBuXLFCtOK9mSF6vHYGWb8n8YmkxuFdgEH3v5OVNE1DTldR0/5LXA==
X-Received: by 2002:a17:906:329a:b0:9a5:ceab:f496 with SMTP id
 26-20020a170906329a00b009a5ceabf496mr959382ejw.58.1694769527698; 
 Fri, 15 Sep 2023 02:18:47 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 bj26-20020a170906b05a00b00997e99a662bsm2108518ejb.20.2023.09.15.02.18.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 02:18:47 -0700 (PDT)
Message-ID: <8b0686f0-9f36-1647-ec6a-e65a4389a852@linaro.org>
Date: Fri, 15 Sep 2023 11:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/9] tests/avocado: Fix console data loss
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914155422.426639-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/9/23 17:54, Alex Bennée wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Occasionally some avocado tests will fail waiting for console line
> despite the machine running correctly. Console data goes missing, as can
> be seen in the console log. This is due to _console_interaction calling
> makefile() on the console socket each time it is invoked, which must be
> losing old buffer contents when going out of scope.
> 
> It is not enough to makefile() with buffered=0. That helps significantly
> but data loss is still possible. My guess is that readline() has a line
> buffer even when the file is in unbuffered mode, that can eat data.
> 
> Fix this by providing a console file that persists for the life of the
> console.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
> Message-Id: <20230912131340.405619-1-npiggin@gmail.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   python/qemu/machine/machine.py         | 19 +++++++++++++++++++
>   tests/avocado/avocado_qemu/__init__.py |  2 +-
>   2 files changed, 20 insertions(+), 1 deletion(-)

Nice.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(this patch also had)
Acked-by: John Snow <jsnow@redhat.com>


