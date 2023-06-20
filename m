Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4E27368B5
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:04:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYDc-0007pF-HY; Tue, 20 Jun 2023 06:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYDS-0007ns-Ir
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:04:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYDR-0004Vy-1I
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:04:02 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so4389862a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687255439; x=1689847439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1v4aMTKBcTyECKlrIWabDnM7kStIlUV8VzZY6ikQBOM=;
 b=MQYLVDJl+1gphClrOCdnDX2oE0rOEgCyDXKDaJ4VwyzoQYojWcGGIdZQVQNuHqFzut
 x73YATKRdu1HF+CpHsZS4+gWDwNaQLop9vDoluP7JPdTEjiLz86g2uc2sP7PSBXo6iBn
 aGLkZ+8tw7Mo4byxjAT8f7E+QSTVjGw0akG7U/K7XeYwiCLpVMnM+1mDG9/0x1wGpzjZ
 eqR59aCiR3N9hpw1OM5EG6BB/dVzZCkLfNywBINnB55hSbcnF0EC+D+lXKkbA2zZ/Lra
 xLHE+diZhUtCse2hOsrlAd8EA7Ha1qILBP5On+6Ctx8CwftQ1ymaODG8pSGkaZql/+O4
 B6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255439; x=1689847439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1v4aMTKBcTyECKlrIWabDnM7kStIlUV8VzZY6ikQBOM=;
 b=E03sCifD1ZjA5ZXLAaTeLHK0kvXxabFJY7dIfb+WxA4h/bdVKXQxawtxsrHS/djZB+
 zL+mV4ofdumojcl4ZI62arFOfAqoOMedlsUv0/T4wur7MZETz6CsyNap0laXGoNEYHf1
 LrpRsKN0/uVd0Aj7wWQCiq/hcZk9itAL2Y/gwg4gWzCyqAYgmLqwlyObl0NaycnogES+
 W9LH9Q+R0HvdPE8yHGXJfNk9d3+Tsxa0dSO7jXhwQEa7Ia7mjB8joAn68iISa3QBMaiO
 RMlFkvQ3qs6E43iX5L+SSkBukqe3rbrPnwGCx4RoA3IPplXxZ3wJh7FRPfY4e2GSAvfl
 wAJw==
X-Gm-Message-State: AC+VfDxPw57tRZAbiA8dygkWaVQlAX8MI5m7HSdPH+ZA32OpLmYtVpv/
 VdBED1h/AyZjk1eSoS/TjWnWkQ==
X-Google-Smtp-Source: ACHHUZ6f3gmC6RjfFCF/U1wUmZfLzjkGMJmQDJPSDooXSusl1aQiZYrS2XIVO0iCkJBiiU/lhLO0FQ==
X-Received: by 2002:aa7:df82:0:b0:51a:4b44:e500 with SMTP id
 b2-20020aa7df82000000b0051a4b44e500mr7764581edy.0.1687255439364; 
 Tue, 20 Jun 2023 03:03:59 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 z26-20020aa7c65a000000b0050bc4600d38sm884227edr.79.2023.06.20.03.03.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:03:59 -0700 (PDT)
Message-ID: <ab98c168-2ba0-111f-a3aa-f277dff6ed53@linaro.org>
Date: Tue, 20 Jun 2023 12:03:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 4/5] docs/devel: split qom-api reference into new file
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
References: <20230619171437.357374-1-alex.bennee@linaro.org>
 <20230619171437.357374-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619171437.357374-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/19/23 19:14, Alex Bennée wrote:
> +We don't currently generate the API documentation for QDEV due to QEMU
> +macros confusing the kerneldoc tool. For now see the headers in
> +``include/hw/qdev-core.h``
> +
> +..
> +  kernel-doc:: include/hw/qdev-core.h

I'm confused.  Isn't that exactly what you're doing here?


r~

