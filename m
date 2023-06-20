Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2F37368E7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYK2-0001ex-5J; Tue, 20 Jun 2023 06:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYJv-0001eS-7k
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:10:43 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBYJt-0006G8-Lo
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 06:10:42 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-985b04c47c3so618791666b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687255840; x=1689847840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mVD0uBSjvZ/iWn0rNtVSWoNfudVRsdQwAGNu8rYOCCk=;
 b=NfRnXbOhYtDuqLcCslOg5oXZVJnkTPERfiowoFr8Z6WS8GCsoHhqbHnEWG2KEmW5CZ
 NNzyncxTmQgwAVSNJY5ZG/wP8LLF9B0oedMEgi2aIJuXT5HIvhd81AZWrluqLvCvuTCR
 SCA2plIGnuBpW63LjjuS2HoT8er2UaNgANjDcaykAMFizoFwfVhZwfmE9n8hE5HjEx1z
 ost/hIeZWHuiQ5UnSiGC/z6Sk02UMioG/neHwyr+MTdF5jC49ulOcYG5XZCqoljhxmgJ
 C6G3owt+T0D1IhCvBCliHlMYtLnOaQstbyr6ZbpRjAvpfKw+5N4F3ZHksrms0qIT/qpL
 EVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687255840; x=1689847840;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mVD0uBSjvZ/iWn0rNtVSWoNfudVRsdQwAGNu8rYOCCk=;
 b=MfEVfzUzgnv1PvAcKRy9GPB7ks7RI5T2mlp7app4sugWqCJhuduPwESGoNXasvjpiy
 uQTYah1w2M1IgM9P/KZZAkuYvzGipgZDzbNerVZ4oht0JG4WcQwevpKciYijp6VOENE7
 3JPHItoRfG7Upk13c5YrUVorxEtey5Eii6oq+Acve5qCz5WKYxoHEblvxr4GD5AiphdQ
 3Bf8gLLfV/NZxsQDi8PsZwnYjhabg56Co7c5/FKJvgdUgzK68gBlEA+6ckkd0fkXHBXE
 Nietd5+1TTPvcuZB9lxQKFEh3Ipot/kFufwdzJduhADPiWZt6E0zNRTRtMhfBbMbfetx
 506g==
X-Gm-Message-State: AC+VfDxDDQai8NHEZ9VxtQp3AztOxiuw/jMxSxqNLhBh0tLe6TTdYF5r
 cygkSofP1kcI5p78QJbePptScQ==
X-Google-Smtp-Source: ACHHUZ5akGeegNysSoiTdH86PoZtFUO/0/rqa27aBS8xSyNFdy5nq8qnOPHjf0fqIc6s7vPTqqATiQ==
X-Received: by 2002:a17:907:7b96:b0:969:7739:2eb7 with SMTP id
 ne22-20020a1709077b9600b0096977392eb7mr12265453ejc.4.1687255839817; 
 Tue, 20 Jun 2023 03:10:39 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.183.29])
 by smtp.gmail.com with ESMTPSA id
 si25-20020a170906ced900b009823e0bfb05sm1084582ejb.162.2023.06.20.03.10.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 03:10:39 -0700 (PDT)
Message-ID: <77def85b-1a40-880e-0a54-ba5ae49b8f47@linaro.org>
Date: Tue, 20 Jun 2023 12:10:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] docs/devel: introduce some key concepts for QOM
 development
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
 <20230619171437.357374-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230619171437.357374-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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
> +As class initialisation cannot fail devices have an two additional
> +methods to handle the creation of dynamic devices. The ``realize``

Beginning with "as" feels like a continuation from something that has been omitted. 
You've skipped over describing ``init`` entirely, and then assumed it.

> +The reverse function is ``unrealize`` and should be were clean-up

"and is where clean-up"


r~

