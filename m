Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FAF7474AA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhVy-0004eI-Eb; Tue, 04 Jul 2023 11:00:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGhVn-0004bO-PF
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:00:15 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qGhVl-0005ET-C5
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:00:15 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f122ff663eso8892647e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482811; x=1691074811;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vsfhz2XcvAmjqaIo2HEYGsXHrqzNSeMe0aXhOL6xXRs=;
 b=GbXTmaEQFm+hg4TvdYDET8kCJ9vrrxVuArwwTAiyX+bpDxqrqzEnyoxhj56O9SssAV
 KPm1JwAoMMkIEweR0wsxg5pOatawiqmMmUDi3D4j15sj8rTLjgs22Jnu2ZPM4JcdUAOV
 LaNAL0An0RLpVcX7FTja0nWZaByETrHcg/vVeDvprPWc3yPaXHTmjlIBoDqXvvvMq4Fk
 dngmOZqY5aknNqvRQZMagd5k83DrSZn2zpG1W5verRRP9UIkkzbERAPBZjExH0UTElbd
 yd+gCIcNtMEQl/gVjnylWqmoUTJ3Cpvs2MU2Lk06SsREDVV0HgpT61L9lCdWXVPtIWvA
 XxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482811; x=1691074811;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vsfhz2XcvAmjqaIo2HEYGsXHrqzNSeMe0aXhOL6xXRs=;
 b=Y1ImwihQLUlHgxc9G93fOPG9JQ021jazJ8BoECY3k2A450hKNbcaBwcOU+5DtgxYiH
 KDcU8vpLtjbK0eVsmO/OvEUe36mTupzKCTGkydkOWMXi4bWenAxRum8R+JEExhuY7hGb
 rAOG+yT95RA8ZajkwkdSGWf8AITB5DQ0XP/FhYzdLtkNtvBFpZT38eLlp+m4PKl16U03
 9T40BAOYJWlucSTOJNq+Ms2P6YydkmiGAWR+Oznn7YKtCXFr9d076gqE8Deiau0URE/u
 Hnc7P7QuQsr4OgzVUSb2ly8aE5GdaDZHwDsHaWtDvt62llox2821k75gE0cK3gJCeH2C
 JSzw==
X-Gm-Message-State: ABy/qLbC8tRTqdfh7qJldNeaK996nXd3CmhFgJwB3ayQwmjZBCBTOgWl
 IJKcH2IaXzmdgBTxRvIz7xjGf2kV1VyKZODG7DM2gA==
X-Google-Smtp-Source: APBJJlGpAcyDK9yxlqw4ow2fSm/VY0+ckiuqK4k21HvFEt+NNtLKnefxAtx7V2INI9lVy1uL5HygPg==
X-Received: by 2002:a05:6512:10c9:b0:4fb:89cd:9616 with SMTP id
 k9-20020a05651210c900b004fb89cd9616mr10288436lfg.0.1688482810812; 
 Tue, 04 Jul 2023 08:00:10 -0700 (PDT)
Received: from [192.168.200.206] (83.21.151.197.ipv4.supernova.orange.pl.
 [83.21.151.197]) by smtp.gmail.com with ESMTPSA id
 d26-20020ac2545a000000b004efe73ee01fsm5119878lfn.306.2023.07.04.08.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:00:10 -0700 (PDT)
Message-ID: <2182ab07-ca32-22ae-8c5a-5d23bfcec5cb@linaro.org>
Date: Tue, 4 Jul 2023 17:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] target/arm: Implement Cortex Neoverse-V1
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <81e6bf97-b6c6-e09d-51b5-445bdc3a47bb@linaro.org>
 <488ca2a9-8e1a-3a62-8487-fefaed69ca8b@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <488ca2a9-8e1a-3a62-8487-fefaed69ca8b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x136.google.com
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

W dniu 4.07.2023 o 16:54, Philippe Mathieu-Daudé pisze:
> On 4/7/23 15:35, Marcin Juszkiewicz wrote:
>> W dniu 4.07.2023 o 15:06, Peter Maydell pisze:
>>
>>> This patchset implements the Cortex Neoverse-V1 CPU type, as a
>>> representative Armv8.3 (+ some extras from 8.4) CPU matching real
>>> hardware.  The main thing we were waiting for to be able to define
>>> this was FEAT_LSE2, and that is now supported.
>>
>> Now I can add "reach SBSA level 4" to todo list as it requires v8.3 
>> cpu (I do not count 'max' cpu type).
> 
> Do we need to introduce machine variants, such sbsa-lvl3-ref and
> sbsa-lvl4-ref? Or simply sbsa-level3/sbsa-level4?

No such combinations. The plan for sbsa-ref is to have only one platform.

Version of platform is exported in DeviceTree already. TF-A reads it and 
exports via SMC call to EDK2. What changes between versions is present 
in documentation.



