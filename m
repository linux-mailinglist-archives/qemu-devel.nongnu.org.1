Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1656370B4D7
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 08:07:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0yh9-0000UH-Cw; Mon, 22 May 2023 02:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0yh2-0000Pr-Uv
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:06:55 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q0yh0-0002EP-66
 for qemu-devel@nongnu.org; Mon, 22 May 2023 02:06:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f41d087a84so21013125e9.1
 for <qemu-devel@nongnu.org>; Sun, 21 May 2023 23:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684735608; x=1687327608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=42PH/00QoWmPwyG5RAq9Du9zwqNWKsNLPesCLbcp4J0=;
 b=f900Q2VuftbThemhFu2SJgpGaRXrk29p3nbGjjoxRtPJc7gkBnCt8X4DFRy4zf12w0
 AeOEm9A78B9jIGgZdtCFPdWQie0jojHPZNjDudu6Er/d4YMioQ88SpwXV+wd0bj92Uj3
 kDJm8KOfId4K19A3QDD0cgJCi5A2q57SA0IA4+lgxLNPojX7XhfNl19v5MWrwgZtWRLT
 U03lXfGdWVINB0tN+5aNHBIEvSqfzybguZwguI+vmwjh+W61NHVl55D5uN7d16gJiJT/
 omqP2gwZIYPqXePD94/0WAdFlry3dHzMnCudz8aUngWczXH+2WFZ06Cz063i9UMKg+oZ
 scmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684735608; x=1687327608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=42PH/00QoWmPwyG5RAq9Du9zwqNWKsNLPesCLbcp4J0=;
 b=OKMZUQrBJN7wqIpzBLZELXc5yDGLzyWxjHkqMyuXKLOYJTEf+WJM6HhO/pPX0a+AfM
 SYJh7YegNUxOjrQdr/3xXxemYNM9sXkYpLDRI+POXcJ4uSm5eV6tWmNiptiY7h/D9LhN
 zvmRiGRVflnamZbhVPYVunA3Z5a/GEJz8/6P4eolF9qXICuO0iArtrUfAeVeZAbEQB87
 Hse5nZKrVpdPVfubvc6TtEaEp0W9xLbUgo5Fu4NPwxabwBXxsd3833Wn6TgBJYlJeaE0
 mXNnRX+CJF9putmhFIvKgpkwk5SE56pjMvZ8eEsCwGa0vlhiY3SI7ts2WImVHhmrIxId
 uPUA==
X-Gm-Message-State: AC+VfDyBwQu2nFX+bujYeOOWeTCqHgtLzulq4VAk5K4CPrOlDAYxPf/s
 yAiAM588Ow4PBnCYdAq2AW1diQ==
X-Google-Smtp-Source: ACHHUZ7RtomUNjN4IxHCiR3WVGfn2PmHnVOl/V8h+pRFjo8RgIKioENpg/4+S4s4Mtvu6+UZYz+R7A==
X-Received: by 2002:a05:600c:1e01:b0:3f5:6e6:4285 with SMTP id
 ay1-20020a05600c1e0100b003f506e64285mr6600095wmb.11.1684735608023; 
 Sun, 21 May 2023 23:06:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 n10-20020adfe78a000000b0030796e103a1sm6586280wrm.5.2023.05.21.23.06.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 May 2023 23:06:47 -0700 (PDT)
Message-ID: <f5a97618-fde2-b4a4-f926-ab619b1fd1e0@linaro.org>
Date: Mon, 22 May 2023 08:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 6/6] hw/char/parallel: Replace string literals by
 TYPE_ISA_PARALLEL macro
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-trivial@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230521123049.312349-1-shentey@gmail.com>
 <20230521123049.312349-7-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230521123049.312349-7-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 21/5/23 14:30, Bernhard Beschow wrote:
> Rather than using a string literal which is prone to typos let's use a macro
> instead which is caught by the compiler if mistyped.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   hw/char/parallel-isa.c | 3 ++-
>   hw/isa/isa-superio.c   | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


