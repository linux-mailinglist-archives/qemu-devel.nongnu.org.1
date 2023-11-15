Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D226C7EC788
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:39:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Hxq-0000ry-PI; Wed, 15 Nov 2023 10:38:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hxm-0000q6-8f
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:37:58 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hxb-0008LG-M0
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:37:58 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32fb1d757f7so4440988f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 07:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700062666; x=1700667466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hp0ePYjVfv8qFEdajxC7G38B5GXYMt0s1JTnPG3UsL0=;
 b=hG9muC7TaBrdaoZoPJFx7C9KsKfqRX0aEAKyWFhk4OOwOX5ySFmOROSefIOVkzgRLh
 a7lnfAYffmuR+NYDW8I58nYTElm/7lXA0rMMAZVJleoihianZAQ6D/lMFNFHN1rXDxEK
 B+51XydMKEYVolq2JWFt5Q+YueOw5rTWzr60gG6psgJBTWHKb3uqTgBNLa8tUjwipDxL
 v4HsoHX4AOV+vMybzqWnxNWMPuiwOTWgGFXviq2azqHg8OZy7G4jBoUG+4WQAWt7BYil
 ct/TccpFNewVoLTNZa81no9Aaw9n8X5DbUpie0s3vvP/V0w+khMMi2Ko6CH8HUN2Iuyk
 wGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700062666; x=1700667466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hp0ePYjVfv8qFEdajxC7G38B5GXYMt0s1JTnPG3UsL0=;
 b=sYxxqWjK4s+YHaiQX4N+xk4gGqgdNm9EW9JIpfleEOM6DeJsmSiS6W9i7Ri652mCFw
 B1nfwGAh3OZXGLLvhOhjaPt0ljKFuqkpA/NTQqtFoZ91dtlVArgXiWXAV7lAW4idTnji
 MJf8vcJrClQXiRJOP0nKSEHstgjRT1fioB6savG1yC2YaPCW1gPtN0qL6V45K+e0T7ac
 f46tf+mhbHNgpSlUtwsunTNCY8SoZ74NztQ8Yl7hj4CCPfJtJA0E9CigLDs/H9zPS1X5
 hZyZVAi4SXlvDjyzfEQ1DMxudnvK4SvBCJjUVL8mzxHyHEA6qvNyq1j+8Rs2sfp+wDWk
 33vQ==
X-Gm-Message-State: AOJu0Ywuunf8Hxl9tLRKN6WssEz64uua1Ltmhn0+vvNZqQFKXptkXrmU
 O0LmeFo1wV3C/99mZJQZUFRckCafoiFvcs2jHfc=
X-Google-Smtp-Source: AGHT+IGa2aDjWASToSnszdp+gF2f0oZC/6DIKbr5NeTaHUdh/hjAFHL9jMuHbi4X5cB0UrYwOKnktg==
X-Received: by 2002:a05:6000:1845:b0:32f:7fb0:de13 with SMTP id
 c5-20020a056000184500b0032f7fb0de13mr9566563wri.5.1700062665731; 
 Wed, 15 Nov 2023 07:37:45 -0800 (PST)
Received: from [192.168.69.100] ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600000cc00b0032db4e660d9sm10858749wrx.56.2023.11.15.07.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 07:37:45 -0800 (PST)
Message-ID: <7caeba1d-9e1b-4fe3-b193-c105d2e8386b@linaro.org>
Date: Wed, 15 Nov 2023 16:37:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-8.2?] tests/avocado: Make fetch_asset()
 inconditionally require a crypto hash
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231115153247.89486-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231115153247.89486-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/11/23 16:32, Philippe Mathieu-Daudé wrote:
> In a perfect world we'd have reproducible tests,
> but then we'd be sure we run the same binaries.
> If a binary artifact isn't hashed, we have no idea
> what we are running. Therefore enforce hashing for
> all our artifacts.
> 
> With this change, unhashed artifacts produce:
> 
>    $ avocado run tests/avocado/multiprocess.py
>     (1/2) tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64:
>     ERROR: QemuBaseTest.fetch_asset() missing 1 required positional argument: 'asset_hash' (0.19 s)
> 
> Inspired-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20231115145852.494052-1-thuth@redhat.com>
>    "tests/avocado/multiprocess: Add asset hashes to silence warnings"

and:

Based-on: <20231114143531.291820-1-thuth@redhat.com>
     "tests/avocado/intel_iommu: Add asset hashes to avoid warnings"

> ---
>   tests/avocado/avocado_qemu/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
> index d71e989db6..304c428168 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -254,7 +254,7 @@ def setUp(self, bin_prefix):
>               self.cancel("No QEMU binary defined or found in the build tree")
>   
>       def fetch_asset(self, name,
> -                    asset_hash=None, algorithm=None,
> +                    asset_hash, algorithm=None,
>                       locations=None, expire=None,
>                       find_only=False, cancel_on_missing=True):
>           return super().fetch_asset(name,


