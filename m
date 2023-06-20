Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4522D7368B1
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:03:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYBq-0006ux-2L; Tue, 20 Jun 2023 06:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYBk-0006uM-6X
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:02:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYBi-0004Cn-GF
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:02:15 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51a1d539ffaso8574729a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687255333; x=1689847333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c936LieMh+vuW2j5DLlTohojPSPBC96QqqBuoeqzW8M=;
 b=zYEdC9KOlAC71cqRKxfc9mhbc4BDVFzR1WhppZV43sPaTTM34fMfhEOY6JmEJyelP5
 MeMeeB5+51T6gf+OtfndCz6EkF24Rpa7d8R891nGwFvi4uuuMKchHk78zSsouf/dnsYq
 Bak0ZWfFOSiF90xdYu1zO6PgXa6aQdLcICrMS+DSyBqg6p/y3EkjAfpDf7Ealo98Nj9L
 X1U3BrrVB2OYDtnzIwpDOxbZ3d6itmU/rtbw2/+bl37RLbzOUQueRY8hV1LfrXz1qhym
 ApsAwtoI9O12ysAdPnLdYTAb2jwrZ/wnjDCuet42WY4ZGGWYJIdWvqOw9+9AzIRYSO2w
 i2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255333; x=1689847333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c936LieMh+vuW2j5DLlTohojPSPBC96QqqBuoeqzW8M=;
 b=j0uDsrfFHb2ch2e18bILAP47Pw3+6V9gT9uQf2T6RxBWoZUceT/mB4OdgXXpEfzfa+
 +PJkGN3V1bIWNI1LrZE0ecKSv+t8vX7qzDJ3NX/MA41ZVJtWsWmc3IT8UwBc1pCVpowb
 q+F8E4ek0Znlzoj2ISJATqu+HTLS4KhDcQwhBKGPcR6Vn0u7Wb9wmlT7+QcACSfV81l2
 eVJ0pl5wcPSbvqZmkcXMR6w8gCFW7csAc+9gRuK6eVORbUpn1+5xRS5ybmuKIYA/XU+r
 8V8APa+UTepjRGjG4bRg9ZDQnC02gnQIRF6c1INvjyQEet3SZPT2/YutjszPDyAuJkdC
 AWPA==
X-Gm-Message-State: AC+VfDwupnHlVGW6lcr6NahOcJWuDnwBZ+XX4dtS6O0hX0fhxyCXktw4
 O4IB9ncoZcf1klV3EuKR1S05Wg==
X-Google-Smtp-Source: ACHHUZ5x6k09zfLm1AwzYvE8BF6AHiQ7b7Y1+BvErSOWzmKb7UVmZ+L7kggrXBtAYAbzIkKIbFiCzw==
X-Received: by 2002:a05:6402:2683:b0:51a:4c1e:c94a with SMTP id
 w3-20020a056402268300b0051a4c1ec94amr6708312edd.2.1687255332791; 
 Tue, 20 Jun 2023 03:02:12 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 w3-20020a056402128300b005149e012658sm906780edv.34.2023.06.20.03.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:02:12 -0700 (PDT)
Message-ID: <3ac0e48b-9e84-266b-5f5b-27bdce05c785@linaro.org>
Date: Tue, 20 Jun 2023 12:02:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] include/hw/qdev-core: fixup kerneldoc annotations
 (!COMPLETE)
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
 <20230619171437.357374-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619171437.357374-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x529.google.com
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
> Fix up the kerneldoc markup and start documenting the various fields
> in QDEV related structures. Unfortunately this is not enough include
> the documentation because kerneldoc currently chokes on some of our
> macros such as:
> 
>      /**
>       * @gpios: list of named GPIOs the device provides.
>       */
>      QLIST_HEAD(, NamedGPIOList) gpios;
> 
> where it demands we document QLIST_HEAD and NamedGPIOList despite them
> not technically being fields in the structure.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   include/hw/qdev-core.h | 123 ++++++++++++++++++++++++++++++++++-------
>   1 file changed, 102 insertions(+), 21 deletions(-)

I wonder if e.g.

   typedef QLIST_HEAD(, NamedGPIOList) NamedGPIOListHead;

outside of struct DeviceClass would help with those.

Anyway, for this patch,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

