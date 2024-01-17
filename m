Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46B830992
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:18:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7fc-00055T-5N; Wed, 17 Jan 2024 10:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7fW-0004zD-Iq
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:17:30 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7fU-0006Wq-Em
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:17:30 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ccb4adbffbso125845551fa.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504646; x=1706109446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hq9SvzA1v0FIrwLAytgxBPM3JH/nfntP0j6WEA8Bu0Q=;
 b=qeOSulgOgoLTbTcAz83Qbrzsm3I00SwjFE8WBl4WidRooRgJXf3euWjoFwzNiI4NIx
 h/+TQA3h0yl/UoWRvX5tmqt5rRG0CUYV/KbkkGx245Jn3y3dsf3WrjGSRl8fsHJIYY97
 NyVOomEDRKgHQxPKC9PUvohulHAHzNj0FNjJv6GjV8NVrBm3wlDGHCRjXQvBseYquLWu
 IzuenAoRCWx3ay1rDFuorbBpAH+od1wCkW3Jpm2etDD9jsK59bSzLPAG2DlUke34Xz/O
 v+5nbp+4bK7HKsbckyAozDf5gazl/4f4zSYHypXmZ0ArN7sZ+z8RNauC45ykuuDe1g3M
 KMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504646; x=1706109446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hq9SvzA1v0FIrwLAytgxBPM3JH/nfntP0j6WEA8Bu0Q=;
 b=VIpAFmDfa8QivcLFLxKw3qaTcEgLI1wb57LX2Jmp8ewCt/J9lftScFKd9C2AySnds4
 8yVeL3bPkUyrTCrNkAl0xj2ltcEw+rqk0XNUlo/qE/vaQQLvPMlzvmYO+wkPIQRAthol
 l3Hm1nqMOvtet2g2veIg0hSwmOaaKxxvy+olmwklAHsT2Xcu7m62AZkdQIi3qMuXYeuk
 1nkjOBU6jASj+wtu9TycWonOcdUwAOWNz2IGQO3ZfQdxC4Sbb8b4Mg3cNCcfnwG4DFtr
 EtjmavcaAgXNwT0zMC03Oj7RckrzMAwSxQtRnYJcy4T0g6m1SyeLmhEqP0tA+aUYgerH
 5jYA==
X-Gm-Message-State: AOJu0YwJIQsSK/UAvd4ds5ViXYPYrfBNAOmg6r7SC0h/yNl9O+U670Cz
 eNr8mTVduq34gfYkVMiwdSwUqjfCTulbOA==
X-Google-Smtp-Source: AGHT+IGzeS4kxdJIaHkcKAKOi2nigsSkn/F6SuSaQMq9COznZZY0tw8FEeJCT0sLRDVE0k/iOLLrYQ==
X-Received: by 2002:a2e:9545:0:b0:2cd:8ee6:b558 with SMTP id
 t5-20020a2e9545000000b002cd8ee6b558mr4324619ljh.94.1705504646243; 
 Wed, 17 Jan 2024 07:17:26 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 ef5-20020a05640228c500b00557d839727esm8230579edb.7.2024.01.17.07.17.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 07:17:25 -0800 (PST)
Message-ID: <a61fe722-299a-4743-87e6-2904d96ee863@linaro.org>
Date: Wed, 17 Jan 2024 16:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com>
 <7f24e391-e3ba-462c-ba30-2ea7ddb62795@linaro.org>
 <fdbe4b2d-b63a-4fcd-9747-08d713e17d22@redhat.com>
 <CAFEAcA-9EnvXKcrECsAKCMHPobLch4mKU0Yvb2+ZKALcFSiqaQ@mail.gmail.com>
 <ZaV0QxdfQJDnICdF@redhat.com> <87y1cp94j9.fsf@pond.sub.org>
 <7ac1ae78-dca4-4fda-a5e9-32b3a332f80e@linaro.org>
 <690cc02f-381f-46ed-a352-c148b1b02af8@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <690cc02f-381f-46ed-a352-c148b1b02af8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 16/1/24 10:52, Thomas Huth wrote:
> On 16/01/2024 10.46, Philippe Mathieu-Daudé wrote:

>> Thomas, are you OK to post a v2 with the changes I suggested
>> or do you want me to do it?
> 
> Since your changes were bigger than mine, I think it's just fair if you 
> take credit for the patch. So yes, please go ahead and assemble it as a 
> v2! Thanks!

Sent only respin of this patch based on first 4 (untouched):
https://lore.kernel.org/qemu-devel/20240117151430.29235-1-philmd@linaro.org/
(neglected to name it v2)

