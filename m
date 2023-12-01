Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C3A800BC6
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 14:24:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r93Tz-0003Fe-Md; Fri, 01 Dec 2023 08:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r93Tx-0003FK-Iw
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:23:01 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r93Tv-00046q-Cf
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 08:23:00 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a02cc476581so308024366b.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701436975; x=1702041775; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDzgw0j2ieqF7WeN0XsF3Hhb7PjtVQk/oV1FS05l49E=;
 b=ffzNil0XC2xcgPu+KuSf7i0cslX5Yz5j9MCUXoHKEy/FYPeijBJH+7ndfC6cQWHmiZ
 k2fWRa5yXSKiIWaMDL+nSp2ofg2bsUsf2GepsxPOTObq+f4T9ImQD1v34kBq7qxEgdIA
 wZY/0SS/z0t6ftB2ddsGdXJ6zwrx4Jg32QiOGQmRGmeC1yYtqb0JC0cDAfRHSBxZY+Wh
 99ddRbUwh26rWIH4DauRY7yDKBv+pxxdo6Spd4AylATePgXyWA9TKB8J2izEkM5Xjrwg
 pNxTFr6bzizZXkqtOId+MOG2DqAeZbzX2aUbdoa8VKfPxLtCZ9t3dCLijRVlIZ/fVWyq
 zj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701436975; x=1702041775;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDzgw0j2ieqF7WeN0XsF3Hhb7PjtVQk/oV1FS05l49E=;
 b=MbVlmBjsgvGDov3cORTrZsXwkNkB0iY9n6gguuUMVq0QJGfpSbmS1b3cSMNMWka//o
 Xk5o7fkvjaqHguNKMp1cJtfyKCAdgKlOEDvBP/fu5avmAUeMXjT+q2+dAxOX58vsrdcB
 X6qwCVHA+DSgXbuQKer32r8+gRxCFyvXzFXvaA0WoOzGlbaB5o20p2fQN4QNHkEblxrK
 yppS6onUjuf1QEC99mFxzNWE/48vig4qoooNwbJ9SvaKIYia5IqKsFBN0jcupephZoVI
 pB0tlkSXWOwEKufmFRqGRE9FvUvnyw0K6hbfG/t3poNYXXX/xSWuIuVUjeDW5vpq0t2z
 /kzA==
X-Gm-Message-State: AOJu0YwsLxmgTBUt/0tcvADlkbZleajkDh5gm9GHBhmNf7IUQckfS3EB
 pXakZGWiz0E9KW6Bdp8/Qr82ng==
X-Google-Smtp-Source: AGHT+IHVI7JYrojw9sIMg+Tp6pTuaLL9Wy+ZTtntBTDr8IlR3PdphG53O4TSPsayIps7CVPcEw1WtA==
X-Received: by 2002:a17:907:5095:b0:9f3:18f8:475b with SMTP id
 fv21-20020a170907509500b009f318f8475bmr682651ejc.62.1701436975267; 
 Fri, 01 Dec 2023 05:22:55 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 cf6-20020a170906b2c600b00a1937153bddsm1360721ejb.20.2023.12.01.05.22.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 05:22:54 -0800 (PST)
Message-ID: <72ae8131-9cd3-4180-bcbb-d69f113211ac@linaro.org>
Date: Fri, 1 Dec 2023 14:22:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/avocado: drop malta yamon tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-5-alex.bennee@linaro.org>
 <45077c53-ed18-4821-bfbe-6dba3ca994d4@linaro.org>
 <87ttp25bqh.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ttp25bqh.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

Hi Alex,

On 1/12/23 13:49, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> Hi Alex,
>>
>> On 1/12/23 10:36, Alex Bennée wrote:
>>> The assets are no longer available on the website so these are
>>> blocking CI.
>>>
>>
>> How are these "blocking CI"? Missing artifact wasn't be fatal,
>> is it now? Also, did the artifact cache got flushed? These tests
>> pass locally, I disagree with removing them.
>>
>> I can send a patch using YAMON_PATH like we have with RESCUE_YL_PATH,
>> but I still consider missing artifact shouldn't be an issue. We are
>> missing the point of the Avocado cache and the possibility to manually
>> add artifacts.
> 
> Sure but in this case the binaries are gone, you can't share them and no
> one else can ever run the test. At that point it just becomes dead
> weight in the repository. This doesn't stop you keeping your own branch
> where old tests live on while close to a warm cache but it does somewhat
> limit the use of the test to the wider community.

No, I still disagree. The tests/avocado/ directory started as a place
to share tests, not to add CI gating tests. That was discussed again
2 or 3 years ago, we even recommended to change from the "opt-out on CI"
policy to the "opt-in for Gating CI". Daniel suggested the Tiers
approach, having only Tier-1 gating.

I think the mistake is to consider all tests as gating.

Why don't you want to share QEMU tests in the QEMU repository?

We might have some misunderstanding on what tests/ is for, so let's
discuss...

Regards,

Phil.

