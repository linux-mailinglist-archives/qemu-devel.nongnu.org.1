Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3374823399
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 18:41:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL5Ef-0003vT-LK; Wed, 03 Jan 2024 12:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5EP-0002V9-84
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rL5EM-0001aV-Gz
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 12:40:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40d5a41143fso67918655e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704303636; x=1704908436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIHFlhhFim1PtGeG0Zm6sx8pmWIRl7Sld9fdmoYExt4=;
 b=i3pTbdr6OE5VxxBKUT3cMszRfXjCgM8PKc8BwxdpbRY6Ju1AmzqIs/XL/LUpmnFZow
 keExv5bOv2Kx5ewqJKl3VnI446by3uEP3QIE/3zvxO991PP1lbtg5BgjmDQOfiAYhZkO
 J6A76Oqea0en2cnCsBmiH3SayErjYdjx0uYJS2bdf72ek7sR0l5AX7PaspHqnAhR7fuk
 rElyFdj6LJ4EeGC13YZ4ANFNqQBKysZx6UEngtsMM3QiaZ1k7+8vJJ5Lksgk0nJ594VK
 DmU6OrBvGlxtzBPzwWedIxvjgq4u2bJ6wJY2cFN0CyV/mDj0UM4aOTPoys3wU/JJ5wSs
 WuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704303636; x=1704908436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dIHFlhhFim1PtGeG0Zm6sx8pmWIRl7Sld9fdmoYExt4=;
 b=qqKogl4oWDwdJ/wvgp0wodEMv1tHQKWXTyb64IEJKaHUjBZZ5dESoJFz4y/AzK+Q1U
 yvRAVHsxg42bzMORLBdL0d6gMreAcDvv+qlPAipZw6vKcDoB+kxprXBp6XbiP1zWCWiB
 RCEL43BTVz9a2b5/mWFyZ7Yc+qrAAUqu2Nywm5BQM8vUKDNlUsn6X1uE9XHmTkDAVVLr
 VZ/g2mZOxIkviaIljPlVkxpS4OjhA6MbG9Q8aiU0PPd9BaV2qqPHx58ws104tEHnFdHD
 O26p2PQnp/PhgSVxZWi9Cw5jgHOmfbRYIVofmkiaGrRvlQUCV1wHQVQgYOgCTAR2xT0V
 kNXw==
X-Gm-Message-State: AOJu0Yw2oR60frO0XWIswwwVvqJTcuzDASX1R1IolSaTENKiKO5DYwAb
 rPKL5ZlHt+TRek9TzwOf4sWweGljIBWy6Q==
X-Google-Smtp-Source: AGHT+IHw8JLMQzv6qvy0MGZez2fPXn9kO2VaZ99bo/3mKuKZa50Y5vQTqY/gwP/E+CV4Edxm+vZCgA==
X-Received: by 2002:a05:600c:2284:b0:40d:88b8:1bda with SMTP id
 4-20020a05600c228400b0040d88b81bdamr2621257wmf.116.1704303636291; 
 Wed, 03 Jan 2024 09:40:36 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 k39-20020a05600c1ca700b0040d8af75e19sm2963165wms.24.2024.01.03.09.40.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 09:40:35 -0800 (PST)
Message-ID: <084d127e-1d77-4c45-b8e9-fe3d867e7755@linaro.org>
Date: Wed, 3 Jan 2024 18:40:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/43] qtest: bump npcm7xx_pwn-test timeout to 5 minutes
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Bin Meng <bin.meng@windriver.com>,
 Laurent Vivier <lvivier@redhat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, David Woodhouse <dwmw2@infradead.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, Paul Durrant <paul@xen.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, John Snow <jsnow@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240103173349.398526-1-alex.bennee@linaro.org>
 <20240103173349.398526-9-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240103173349.398526-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/1/24 18:33, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The npcm7xx_pwn-test takes 3 & 1/2 minutes in a --enable-debug build.
> Bumping to 5 minutes will give more headroom.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20230717182859.707658-5-berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-Id: <20231215070357.10888-5-thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/qtest/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 000ac54b7d6..84cec0a847d 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -1,7 +1,7 @@
>   slow_qtests = {
>     'bios-tables-test' : 120,
>     'migration-test' : 480,
> -  'npcm7xx_pwm-test': 150,
> +  'npcm7xx_pwm-test': 300,

The tests seem parallelizable, maybe this file could be split?

>     'qom-test' : 900,
>     'test-hmp' : 120,
>   }


